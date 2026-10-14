# Land Market Analysis: Case Study and Python/SQL Pipeline

A public land-market case study with a Python/SQLite data-preparation extension. The original case summary documents transaction screening and comparable-selection reasoning. The executable extension was created on October 15, 2026, from the supplied source workbook during portfolio preparation; it is not evidence that the same code was used in the earlier workplace analysis.

## Business question
How can transaction-level sales and parcel-detail records be reconciled before assessing industrial-land comparables?

## Executable Python and SQL workflow
- Read the source Excel export with Python and `openpyxl`.
- Convert ROC dates to Gregorian ISO dates, parse numeric strings, and standardize area and price units.
- Load transactions and parcel details into separate SQLite tables with primary keys, foreign keys, and an index.
- Use SQL joins, aggregation, conditional expressions, and views to reconcile transferred areas and flag records for manual review.
- Preserve repeated parcel identifiers when their detail rows represent additional transferred area.

## Verified execution
The supplied source workbook produced:
| Check | Result |
| --- | --- |
| Transactions | 53 |
| Parcel-detail rows | 87 |
| Distinct parcel identifiers | 71 |
| Orphan parcel-detail records | 0 |
| Transactions with a nonzero area difference | 4 |
| Transactions outside the rounding tolerance | 0 |

The tolerance is 0.005 ping per detail row plus 0.005 ping for the transaction total, assuming rounding to two decimals. It is a reconciliation assumption, not a guarantee that source areas are accurate. Record counts, unit conversion, date conversion, repeated-parcel handling, and the SQL review views were checked.

## Files
- `land_pipeline.py`: Excel import, SQLite creation, SQL execution, and local exports
- `analysis_queries.sql`: parcel aggregation, area reconciliation, and screening-flag views
- `requirements.txt`: Python dependency
- `validation_summary.json`: aggregate results from the source workbook
- `screening_summary.csv`: previously reviewed screening categories, totaling 53 transactions
- `methodology.md`: case-study methodology and evidence limits

The category summary reflects the earlier manual review. It is not automatically reproduced by the new script. The script's flags do not establish eligibility or prove normal-market transactions.

## Reproduce locally
Requires Python 3.10+ and the original Excel export containing the sheets `案件列表` and `土地`. The original source workbook is not distributed here.

```bash
python3 -m pip install -r requirements.txt
python3 land_pipeline.py "/path/to/source.xlsx" --out work_results
```

Use a new output directory for each run. The program refuses to overwrite an existing database. It generates a local SQLite database, row-level reconciliation and screening CSVs, annual record counts, and an aggregate validation summary. Without the source workbook, this public repository is not independently executable end to end.

## Case-study context
The original manual screening separated 8 core industrial transactions, 7 secondary industrial transactions, 15 agricultural/other-zone comparisons, and 23 excluded special-condition transactions. Core transactions were summarized as six analytical groups to account for potentially related sales. The absence of eligible industrial observations in 2024–2025 limits annual-trend interpretation. A 250-ping core threshold is a project rule, not an industry standard.

## Spatial work and limitations
The earlier case involved review of the Ministry of the Interior's web-based transaction map, cadastral maps, and ownership documents. This Python/SQL extension contains no geocoding, QGIS processing, or spatial joins. It does not establish a final valuation. Comparable selection still needs manual review of zoning, transaction conditions, possible relationships, site differences, and documentary evidence.

## Public and private files
Only code, methodology, and aggregate results are included. Source parcel identifiers are imported into the local database for reconciliation but are not bundled in this public package. Generated SQLite files and row-level exports must remain private; `.gitignore` helps prevent accidental inclusion through Git, but browser uploads must be reviewed separately.

## Author and preparation
Shun-Min Tang. Original workbook supplied by the author. 
