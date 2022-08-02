module PatentsBase

using Dates


### Basic patent information types

export AbstractApplication, AbstractFamily, AbstractPortfolio # Publication, LegalEvent

export AbstractApplicant, AbstractInventor, AbstractJurisdiction

export AbstractTitle, AbstractDescription, AbstractClaims, AbstractFulltext


### Interface functions

# parties
export applicants, inventors

# filing authority
export jurisdiction

# content
export title, description, claims, fulltext, text

# application history
export filingdate, publicationdate

# technology classification
export classification

# family-specific functions
export applications, siblings

# computations
export aggregate_families, citationgraph, cooccurrence

# names
export name, names, referencename

# locations
export residence, ccode


### Interface definitions

include("applicants.jl")
include("applications.jl")
include("claims.jl")
include("descriptions.jl")
include("families.jl")
include("fulltexts.jl")
include("inventors.jl")
include("jurisdictions.jl")
include("portfolios.jl")
include("titles.jl")


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
