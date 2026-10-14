-- SQLite SQL. These views support review, not final valuation or automatic eligibility.
-- Preserve every parcel-detail row; repeated parcel identifiers are not necessarily duplicates.
CREATE VIEW parcel_rollup AS
SELECT case_id,
       COUNT(*) AS detail_row_count,
       COUNT(DISTINCT parcel_identifier) AS distinct_parcel_count,
       SUM(transferred_area_ping) AS detail_area_ping,
       COUNT(DISTINCT zoning) AS zone_label_count,
       MAX(CASE WHEN zoning = '都市：工業區' THEN 1 ELSE 0 END) AS has_industrial_zone,
       MIN(CASE WHEN zoning = '都市：工業區' THEN 1 ELSE 0 END) AS all_rows_industrial
FROM parcel_details
GROUP BY case_id;

CREATE VIEW area_reconciliation AS
SELECT t.case_id, t.area_ping AS transaction_area_ping,
       p.detail_area_ping, p.detail_row_count, p.distinct_parcel_count,
       p.detail_area_ping - t.area_ping AS area_difference_ping,
       (p.detail_row_count + 1) * 0.005 AS rounding_tolerance_ping,
       CASE WHEN p.case_id IS NULL THEN 1
            WHEN ABS(p.detail_area_ping - t.area_ping) > (p.detail_row_count + 1) * 0.005 + 0.00000001
            THEN 1 ELSE 0 END AS outside_rounding_tolerance
FROM transactions t
LEFT JOIN parcel_rollup p ON t.case_id = p.case_id;

CREATE VIEW screening_flags AS
SELECT t.case_id, p.detail_row_count, p.zone_label_count,
       p.has_industrial_zone, p.all_rows_industrial,
       CASE WHEN p.zone_label_count > 1 THEN 1 ELSE 0 END AS multiple_zone_labels,
       CASE WHEN TRIM(t.source_note) <> '' THEN 1 ELSE 0 END AS has_note_for_manual_review,
       CASE WHEN t.area_ping >= 250 THEN 1 ELSE 0 END AS meets_project_area_threshold,
       a.outside_rounding_tolerance
FROM transactions t
LEFT JOIN parcel_rollup p ON t.case_id = p.case_id
LEFT JOIN area_reconciliation a ON t.case_id = a.case_id;

-- All flags require manual interpretation. No claim is made that unflagged sales
-- are arm's length, have complete title, or are appropriate valuation comparables.
