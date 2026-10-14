# Land Market Analysis: Anonymized Case Study

A public summary of a professional land-market analysis project by Shun-Min Tang. It demonstrates transaction screening, reconciliation of parcel-detail records, and the effect of potentially related transactions on comparable-price summaries.

## Business question
How can a small, heterogeneous set of land transactions support an initial comparable-price review, and where is the evidence insufficient for a property-specific valuation?

## Evidence and method
The supplied workbook combines transaction records and parcel-detail records, classification rules, grouped statistics, and document-check notes. Transactions were screened for mixed zoning, special conditions, partial-interest transfers, and other comparability concerns. A 250-ping threshold separated core from secondary industrial comparables; it is a project rule rather than an industry standard.

Potentially related sales were retained as individual records and also summarized in analytical groups. Grouping is an inference, not confirmation that multiple records are a single independent transaction. Area reconciliation retains repeated parcel-detail rows where they represent additional transferred area rather than duplicate data.

## Results
See `screening_summary.csv` for aggregate screening counts. The core sample contains eight transactions but only six analytical groups, illustrating how record counts can overstate the amount of independent evidence. The source workbook reports no eligible industrial observations in 2024–2025. This sparse coverage limits conclusions about annual price trends.

## Decision implications
The analysis supports further due diligence and a disciplined comparable-selection process. The subject's zoning verification, rights and encumbrances, and differences in site size remain material limitations. Sample quartiles describe observed comparables; they are not a valuation confidence interval. A mechanically scaled price range is not a final valuation.

## Public scope and verification
This package contains only an anonymized narrative and aggregate counts, not a reproducible transaction dataset. Exact site identifiers, parcel numbers, ownership names, rights records, financing amounts, and subject-specific price estimates are omitted. Aggregate counts were checked against the supplied workbook.

No Python/SQL scripts or computational GIS files were supplied with this workbook, so this public package does not claim to demonstrate those implementations. Spatial evidence in the supplied method notes consists of document/map review rather than verified geocoding of all transactions.

## Files
- `screening_summary.csv`: aggregate screening categories
- `methodology.md`: data preparation and evidence limits

The original workbook is intentionally excluded from the public portfolio.
