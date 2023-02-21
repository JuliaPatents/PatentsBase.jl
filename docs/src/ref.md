```@meta
CurrentModule = PatentsBase
```

# Interface Reference

The reference is structured by topics.
Each topic is subdivided into two sections: types and functions.
An alphabetical [Index](@ref) is located at the bottom of the page.

```@contents
Pages = ["ref.md"]
Depth = 3
```

## Documents and document references

### Types

```@docs
PatentsBase.AbstractApplication
PatentsBase.AbstractApplicationReference
PatentsBase.AbstractApplicationID
```

### Functions

```@docs
PatentsBase.date_published
PatentsBase.jurisdiction
PatentsBase.doc_number
PatentsBase.kind
PatentsBase.id
PatentsBase.sourceid
PatentsBase.refers_to
```

## Document contents

### Types

```@docs
PatentsBase.AbstractContent
PatentsBase.AbstractTitle
PatentsBase.AbstractShortDescription
PatentsBase.AbstractClaim
PatentsBase.AbstractFulltext
```

### Functions

```@docs
PatentsBase.languages
PatentsBase.text
PatentsBase.title(::AbstractApplication)
PatentsBase.title(::AbstractApplication, ::String)
PatentsBase.claims
PatentsBase.abstract
PatentsBase.fulltext
```

## Citations

### Types

```@docs
PatentsBase.AbstractCitation
PatentsBase.AbstractPatentCitation
PatentsBase.AbstractNPLCitation
PatentsBase.AbstractCitationType
PatentsBase.PatentCitation
PatentsBase.NPLCitation
```

### Functions

```@docs
PatentsBase.phase
PatentsBase.reference
PatentsBase.bibentry
PatentsBase.external_ids
PatentsBase.doi
PatentsBase.citations
PatentsBase.forwardcitations
PatentsBase.citationgraph
```

## Parties

### Types

```@docs
PatentsBase.AbstractParty
PatentsBase.AbstractInventor
PatentsBase.AbstractApplicant
```

### Functions

```@docs
PatentsBase.name
PatentsBase.known_names
PatentsBase.country
PatentsBase.applicants
PatentsBase.inventors
```

## Document classifications

### Types

```@docs
PatentsBase.AbstractClassificationSystem
PatentsBase.IPCLikeSystem
PatentsBase.CPC
PatentsBase.IPC
PatentsBase.AbstractClassificationSymbol
PatentsBase.IPCLikeSymbol
PatentsBase.CPCSymbol
PatentsBase.IPCSymbol
PatentsBase.AbstractClassificationLevel
PatentsBase.AbstractIPCLikeClassificationLevel
PatentsBase.Section
PatentsBase.Class
PatentsBase.Subclass
PatentsBase.Maingroup
PatentsBase.Subgroup
```

### Functions

```@docs
PatentsBase.classification
PatentsBase.symbol
PatentsBase.title(::AbstractClassificationLevel, c::AbstractClassificationSymbol)
```

## Document collections and groups

### Types

```@docs
PatentsBase.AbstractFamily
PatentsBase.AbstractPortfolio
```

### Functions

```@docs
PatentsBase.aggregate_families
PatentsBase.applications(::AbstractFamily)
PatentsBase.applications(::AbstractPortfolio)
PatentsBase.families(::AbstractPortfolio)
PatentsBase.portfolio
PatentsBase.siblings
PatentsBase.owner
```

## Data sources and document lookup

### Types

```@docs
PatentsBase.AbstractDataSource
PatentsBase.DataLevel
PatentsBase.ApplicationLevel
PatentsBase.FamilyLevel
```

### Functions

```@docs
PatentsBase.applications(::AbstractDataSource)
PatentsBase.families(::AbstractDataSource)
PatentsBase.find_application
```

## Database filters

### Types

```@docs
PatentsBase.AbstractFilter
PatentsBase.AllFilter
PatentsBase.IntersectionFilter
PatentsBase.UnionFilter
PatentsBase.ClassificationFilter
PatentsBase.ContentFilter
PatentsBase.SearchableContentField
PatentsBase.TitleSearch
PatentsBase.AbstractSearch
PatentsBase.ClaimsSearch
PatentsBase.FulltextSearch
```

## Index

```@index
```