module PatentsBase

using Dates
using StructTypes

### Basic patent information types

export AbstractApplication, AbstractFamily, AbstractPortfolio # Publication, LegalEvent

export AbstractParty, AbstractApplicant, AbstractInventor

export AbstractContent, AbstractTitle, AbstractDescription, AbstractClaim, AbstractClaims,
    AbstractFulltext

export AbstractClassificationSystem, IPCLikeSystem, CPC, IPC,
    AbstractClassificationSymbol, IPCLikeSymbol, CPCSymbol, IPCSymbol,
    AbstractClassificationLevel, AbstractIPCLikeClassificationLevel,
    Section, Class, Subclass, Maingroup, Subgroup

export AbstractCitation, AbstractPatentCitation, AbstractNPLCitation

export AbstractDataSource, AbstractApplicationReference, AbstractApplicationID

### Interface functions

# parties
export applicants, inventors, name, names, referencename

# document identifiers and base information
export jurisdiction, doc_number, kind

# content
export title, description, claims, fulltext, text

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

# data filters
export AbstractFilter, ClassificationFilter, ContentFilter, UnionFilter, IntersectionFilter,
    AllFilter

# full-text search
export SearchableContentField, TitleSearch, AbstractSearch, ClaimsSearch, FulltextSearch

# computations
export aggregate_families, citationgraph, cooccurrence

### Interface definitions

include("applications.jl")
include("datasources.jl")
include("contents.jl")
include("families.jl")
include("classifications.jl")
include("citations.jl")
include("parties.jl")
include("portfolios.jl")
include("filters.jl")

# Trait-based interface to indicate available information at data source level?

# abstract type AbstractDataSource end

# struct LensData end <: AbstractDataSource
# struct LensApplication <: AbstractApplication end

# struct HasApplicants end
# struct NoApplicants end

# datasource(::LensApplication) = LensData()
# hasapplicants(::LensData) = HasApplicants()

# applicants(::HasApplicants, a::AbstractApplication) = a.applicants
# applicants(::NoApplicants, a::AbstractApplication) = error("$(typeof(a)) does not contain applicant information.")

# applicants(a::AbstractApplication) = applicants(hasapplicants(datasource(a)), a)

end
