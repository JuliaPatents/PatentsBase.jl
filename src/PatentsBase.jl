module PatentsBase

using Dates
using StructTypes

### Basic patent information types

export AbstractApplication, AbstractFamily, AbstractPortfolio # Publication, LegalEvent

export AbstractParty, AbstractApplicant, AbstractInventor

export AbstractContent, AbstractTitle, AbstractShortDescription, AbstractClaim, AbstractClaims,
    AbstractFulltext

export AbstractClassificationSystem, IPCLikeSystem, CPC, IPC,
    AbstractClassificationSymbol, IPCLikeSymbol, CPCSymbol, IPCSymbol,
    AbstractClassificationLevel, AbstractIPCLikeClassificationLevel,
    Section, Class, Subclass, Maingroup, Subgroup

export AbstractCitation, AbstractPatentCitation, AbstractNPLCitation, AbstractCitationType,
    PatentCitation, NPLCitation

export AbstractDataSource, AbstractApplicationReference, AbstractApplicationID

### Interface functions

# parties
export applicants, inventors, name, names

# document identifiers and base information
export sourceid, id, jurisdiction, doc_number, kind

# content
export title, abstract, claims, fulltext, text

# citations
export citations, patent_citations, npl_citations, citedby, phase, application, doi, bibentry

# application history
export filingdate, publicationdate

# technology classification
export classification, symbol

# family-specific functions
export families, applications, siblings

# portfolio-specific functions
export owner

# data sources and lookup
export refers_to, find_application

# data levels
export DataLevel, ApplicationLevel, FamilyLevel

# data filters
export AbstractFilter, ClassificationFilter, ContentFilter, UnionFilter, IntersectionFilter,
    AllFilter

# full-text search
export SearchableContentField, TitleSearch, AbstractSearch, ClaimsSearch, FulltextSearch

# computations
export aggregate_families, citationgraph

### documentation templates
include("docs/templates.jl")

### Interface definitions

include("datasources.jl")
include("levels.jl")
include("filters.jl")
include("applications.jl")
include("contents.jl")
include("families.jl")
include("classifications.jl")
include("citations.jl")
include("parties.jl")
include("portfolios.jl")

end
