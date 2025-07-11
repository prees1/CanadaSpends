# British Columbia Data Structure

This directory contains example data files for British Columbia government spending. These files serve as templates and placeholders for the actual BC implementation.

## File Structure

```
data/british-columbia/
├── summary.json              # Jurisdiction metadata and ministry list
├── sankey.json              # Sankey diagram data for visualization
├── departments/             # Individual ministry data files
│   ├── health.json
│   ├── education-and-child-care.json
│   ├── transportation-and-infrastructure.json
│   └── [other ministries...]
└── README.md               # This file
```

## Data Sources

The actual BC data should be sourced from:
- **BC Public Accounts**: https://www2.gov.bc.ca/gov/content/governments/reports/estimates
- **BC Budget Documents**: Available on the BC government website
- **BC Ministry Annual Reports**: Individual ministry reports

## Data Requirements

### summary.json
Contains jurisdiction-level metadata:
- `name`: "British Columbia"
- `financialYear`: Fiscal year (e.g., "2024")
- `source`: URL to official BC public accounts
- `totalProvincialSpending`: Total spending in billions
- `totalEmployees`: Estimated public service employees
- `ministries`: Array of ministry objects with spending data

### sankey.json
Contains hierarchical spending data for the Sankey diagram:
- `total`: Total spending amount
- `spending`: Spending data with nested structure
- `revenue`: Revenue data (if available)
- `spending_data.children`: Array of ministries with nested spending categories

### Department Files
Each ministry has its own JSON file in the `departments/` directory:
- `name`: Ministry name
- `totalSpendingFormatted`: Formatted spending amount
- `percentage`: Percentage of total provincial spending
- `categories`: Flat list of spending categories
- `spending_data`: Hierarchical structure for mini-Sankey diagrams

## BC Ministry Structure

Based on BC government structure, the main ministries include:

1. **Health** - Healthcare services and programs
2. **Education and Child Care** - K-12, post-secondary, and child care
3. **Social Development and Poverty Reduction** - Income assistance and social programs
4. **Transportation and Infrastructure** - Highways, transit, and infrastructure
5. **Finance** - Financial management and debt servicing
6. **Public Safety and Solicitor General** - Policing, corrections, emergency management
7. **Environment and Climate Change Strategy** - Environmental protection and climate action
8. **Jobs, Economic Development and Innovation** - Economic development programs
9. **Forests** - Forest management and wildfire response
10. **Agriculture and Food** - Agricultural programs and food safety
11. **Energy, Mines and Low Carbon Innovation** - Energy and mining regulation

## Data Collection Process

1. **Download BC Public Accounts PDFs** from the official website
2. **Extract spending data** using PDF parsing tools
3. **Normalize ministry names** to match the application's structure
4. **Calculate percentages** based on total provincial spending
5. **Generate JSON files** in the required format
6. **Validate data** against official BC sources

## Example Data

The files in this directory contain example data that demonstrates the required structure. The actual amounts and categories should be replaced with real BC government spending data.

## Validation

Before using real data, ensure:
- [ ] All ministry names match official BC government structure
- [ ] Spending amounts match official BC public accounts
- [ ] Percentages sum to approximately 100%
- [ ] All required fields are present in each file
- [ ] JSON files are valid and properly formatted

## Next Steps

1. Replace example data with real BC government spending data
2. Update ministry names and categories to match actual BC structure
3. Validate all amounts against official BC sources
4. Test the application with real BC data
5. Update any hardcoded references in the application code