module PatentsBase

using Dates

# basic patent information types
export AbstractApplication, AbstractFamily, AbstractPortfolio # Publication, LegalEvent

export AbstractApplicant, AbstractInventor, AbstractJurisdiction

export AbstractTitle, AbstractDescription, AbstractClaims, AbstractFulltext


# parties
export applicants, inventors

# filing authority
export jurisdiction

# content
export title, description, claims, fulltext

# application history
export filingdate, publicationdate

# technology classification
export classification

# family-specific functions
export applications, siblings

# computations
export aggregate_families, citationgraph, cooccurrence




"""
    AbstractApplication

An abstract type representing an interface for a patent application. Concrete implementations, 
such as `PatentsLens.LensApplication`, should subtype this.

`PatentsLens.jl` includes a general interface for working with different types of patent data, 
which should also be implemented by the concrete subtypes, as permitted by the respective data source.
"""
abstract type AbstractApplication end


"""
    applicants(a::AbstractApplication)

return a `Vector{<:AbstractApplicant}` with information about the applicant(s) of application `a`.
"""
function applicants(a::AbstractApplication)::Vector{<:AbstractApplicant} 
    throw(ArgumentError("$(typeof(a)) does not contain applicant information."))
end


"""
    applicants(f::AbstractFamily)

return a `Vector{<:AbstractApplicant}` with the unique set of 
applicants from all the applications in family `f`.
"""
function applicants(a::AbstractApplication)::Vector{<:AbstractApplicant} 
    throw(ArgumentError("$(typeof(a)) does not contain applicant information."))
end

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
