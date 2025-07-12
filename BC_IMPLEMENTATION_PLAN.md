# British Columbia Implementation Plan

## Overview

This plan outlines the step-by-step process to add British Columbia (BC) support to the Canada Spends application, following the existing Ontario implementation pattern.

## Current Architecture Analysis

### Data Structure Requirements

Based on the Ontario implementation, BC will need the following data files:

1. **`data/british-columbia/summary.json`** - Jurisdiction metadata
2. **`data/british-columbia/sankey.json`** - Sankey diagram data
3. **`data/british-columbia/departments/`** - Individual ministry data files

### Data Schema

#### Summary.json Structure
```json
{
  "name": "British Columbia",
  "financialYear": "2024",
  "source": "https://www2.gov.bc.ca/gov/content/governments/reports/estimates",
  "totalProvincialSpending": 0.0,
  "totalProvincialSpendingFormatted": "$0.0B",
  "totalEmployees": 0,
  "ministries": [
    {
      "name": "Ministry Name",
      "slug": "ministry-slug",
      "totalSpending": 0.0,
      "totalSpendingFormatted": "$0.0B",
      "percentage": 0.0,
      "percentageFormatted": "0.0%"
    }
  ]
}
```

#### Department.json Structure
```json
{
  "name": "Ministry Name",
  "totalSpendingFormatted": "$0.0B",
  "percentage": 0.0,
  "percentageFormatted": "0.0%",
  "categories": [
    {
      "name": "Program Name",
      "amount": 0.0
    }
  ],
  "spending_data": {
    "name": "Ministry Name",
    "children": [
      {
        "name": "Program Name",
        "amount": 0.0
      }
    ]
  },
  "generatedAt": "2024-01-01T00:00:00.000Z"
}
```

#### Sankey.json Structure
```json
{
  "total": 0.0,
  "spending": 0.0,
  "revenue": 0.0,
  "spending_data": {
    "name": "Spending",
    "children": [
      {
        "name": "Ministry Name",
        "children": [
          {
            "name": "Program Name",
            "amount": 0.0
          }
        ]
      }
    ]
  },
  "revenue_data": {
    "name": "Revenue",
    "children": []
  }
}
```

## Implementation Steps

### Phase 1: Data Collection & Processing

#### Step 1: Research BC Public Accounts
- [ ] Identify BC's public accounts source (likely https://www2.gov.bc.ca/gov/content/governments/finances/public-accounts)
- [ ] Download latest BC public accounts PDFs (typically 2023-24 or 2024-25)
- [ ] Analyze BC's ministry structure and spending categories
- [ ] Map BC ministries to the application's data model

#### Step 2: Create BC Data Processing Scripts
- [ ] Create `scrapers/public_accounts/british-columbia/` directory
- [ ] Develop PDF extraction scripts for BC public accounts
- [ ] Create data transformation scripts to convert BC data to required JSON format
- [ ] Implement BC-specific data cleaning and normalization

#### Step 3: Generate BC Data Files
- [ ] Extract ministry spending data from BC public accounts
- [ ] Generate `data/british-columbia/summary.json`
- [ ] Generate `data/british-columbia/sankey.json`
- [ ] Generate individual ministry files in `data/british-columbia/departments/`

### Phase 2: Application Updates

#### Step 4: Update Jurisdiction Configuration
- [ ] Verify `src/lib/jurisdictions.ts` automatically detects BC data directory
- [ ] Test jurisdiction slug generation for "british-columbia"
- [ ] Ensure BC appears in jurisdiction list

#### Step 5: Update Financial Position Data
- [ ] Research BC's financial position data (net debt, total debt, interest on debt)
- [ ] Update `src/app/[lang]/(main)/[jurisdiction]/page.tsx` to include BC-specific financial data
- [ ] Add BC-specific financial position calculations

#### Step 6: Update Department Page Content
- [ ] Review `src/app/[lang]/(main)/[jurisdiction]/[department]/page.tsx`
- [ ] Update hardcoded "Ontario" references to be jurisdiction-agnostic
- [ ] Test department page generation for BC ministries

### Phase 3: Content & Localization

#### Step 7: Update Text Content
- [ ] Review all hardcoded "Ontario" references in components
- [ ] Update jurisdiction-specific text to be dynamic
- [ ] Ensure proper localization for BC content

#### Step 8: Update Financial Year References
- [ ] Update financial year references to use BC's fiscal year
- [ ] Ensure proper date formatting for BC

### Phase 4: Testing & Validation

#### Step 9: Data Validation
- [ ] Verify BC data totals match official sources
- [ ] Test Sankey diagram rendering with BC data
- [ ] Validate ministry spending percentages
- [ ] Check department page functionality

#### Step 10: UI/UX Testing
- [ ] Test BC jurisdiction page at `/en/british-columbia` and `/fr/british-columbia`
- [ ] Test BC department pages
- [ ] Verify responsive design works with BC data
- [ ] Test navigation between BC pages

### Phase 5: Documentation & Deployment

#### Step 11: Update Documentation
- [ ] Update README.md to include BC in supported jurisdictions
- [ ] Document BC data sources and processing
- [ ] Update roadmap to mark BC as completed

#### Step 12: Deployment
- [ ] Deploy BC data files
- [ ] Test production deployment
- [ ] Monitor for any issues

## Technical Considerations

### Data Processing Challenges
1. **BC Ministry Structure**: BC may have different ministry names and structures than Ontario
2. **Spending Categories**: BC's spending categories may differ from Ontario's
3. **Data Format**: BC public accounts may be in different format than Ontario's

### Application Updates Required
1. **Hardcoded References**: Remove any hardcoded "Ontario" references
2. **Financial Data**: Update financial position calculations for BC
3. **Content**: Ensure all text is jurisdiction-agnostic

### Testing Strategy
1. **Data Validation**: Compare extracted data with official BC sources
2. **Visual Testing**: Verify Sankey diagrams render correctly
3. **Navigation Testing**: Test all BC-specific routes
4. **Performance Testing**: Ensure BC data doesn't impact performance

## Success Criteria

- [ ] BC jurisdiction page accessible at `/en/british-columbia` and `/fr/british-columbia`
- [ ] All BC ministries have individual department pages
- [ ] Sankey diagram renders BC spending data correctly
- [ ] Financial position data displays BC-specific information
- [ ] No hardcoded "Ontario" references remain
- [ ] BC data totals match official BC public accounts
- [ ] All pages work in both English and French

## Timeline Estimate

- **Phase 1**: 2-3 weeks (data collection and processing)
- **Phase 2**: 1 week (application updates)
- **Phase 3**: 1 week (content updates)
- **Phase 4**: 1 week (testing)
- **Phase 5**: 1 week (documentation and deployment)

**Total Estimated Time**: 6-7 weeks

## Dependencies

1. Access to BC public accounts data
2. Understanding of BC's ministry structure
3. BC financial position data
4. Development environment setup
5. Testing environment

## Risk Mitigation

1. **Data Quality**: Validate extracted data against official sources
2. **Performance**: Monitor application performance with BC data
3. **Content Accuracy**: Review all jurisdiction-specific content
4. **User Experience**: Test with BC users if possible