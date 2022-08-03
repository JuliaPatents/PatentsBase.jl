module PatentsBase

using Dates


### Basic patent information types

export AbstractApplication, AbstractFamily, AbstractPortfolio # Publication, LegalEvent

export AbstractParty, AbstractApplicant, AbstractInventor, AbstractJurisdiction

export AbstractContent, AbstractTitle, AbstractDescription, AbstractClaim, 
       AbstractClaims, AbstractFulltext

export AbstractClassification, CPCClassification

### Interface functions

# parties
export applicants, inventors, name, names, referencename

# filing authority
export jurisdiction

# content
export title, description, claims, fulltext, text

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

include("applications.jl")
include("families.jl")
include("contents.jl")
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
