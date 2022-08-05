module PatentsBase

using Dates

### Basic patent information types

export AbstractApplication, AbstractFamily, AbstractPortfolio # Publication, LegalEvent

export AbstractParty, AbstractApplicant, AbstractInventor, AbstractJurisdiction

export AbstractContent, AbstractTitle, AbstractDescription, AbstractClaim, AbstractClaims,
    AbstractFulltext

export AbstractClassification, CPCClassification

export AbstractCitation, AbstractPatentCitation, AbstractNPLCitation

export AbstractDataSource

### Interface functions

# parties
export applicants, inventors, name, names, referencename

# filing authority
export jurisdiction

# content
export title, description, claims, fulltext, text

# citations
export citations, patent_citations, npl_citations, citedby, phase, application, doi, bibentry

# application history
export filingdate, publicationdate

# technology classification
export classifications, shortname, symbol, hierarchy

# family-specific functions
export applications, siblings

# portfolio-specific functions
export owner

# computations
export aggregate_families, citationgraph, cooccurrence

### Interface definitions

include("datasources.jl")
include("applications.jl")
include("contents.jl")
include("families.jl")
include("citations.jl")
include("jurisdictions.jl")
include("parties.jl")
include("portfolios.jl")

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
