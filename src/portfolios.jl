
"""
An abstract type representing an interface for a party's patent portfolio.
"""
abstract type AbstractPortfolio end

"""
    portfolio(owner::Union{AbstractParty, String}, ds::Vector{<:AbstractApplication})
    portfolio(owner::Union{AbstractParty, String}, ds::Vector{<:AbstractFamily})
    portfolio(owner::Union{AbstractParty, String}, ds::AbstractDataSource)

return an [`AbstractPortfolio`](@ref) of the `owner`, containing all families or
applications filed in that owner's name from a data source `ds`.
If `owner` is given as a `String`, it is assumed to be the name of an `AbstractApplicant`.
"""
function portfolio(
    owner::Union{AbstractParty, String},
    ds::Union{AbstractDataSource, Vector{<:AbstractApplication}, Vector{<:AbstractFamily}})
    throw(ArgumentError("Cannot derive portfolio for $(typeof(owner)) from $(typeof(ds))"))
end

"""
    owner(p::AbstractPortfolio)

return an [`AbstractParty`](@ref) representing the owner of portfolio `p`.
"""
function owner(p::AbstractPortfolio)::(<:AbstractParty)
    throw(ArgumentError("$(typeof(p)) does not contain owner information."))
end

"""
    applications(p::AbstractPortfolio)

return a `Vector{<:`[`AbstractApplication`](@ref)`}` with all applications in portfolio `p`.
"""
function applications(p::AbstractPortfolio)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(p)) does not allow retrieval of individual applications."))
end

"""
    families(p::AbstractPortfolio)

return a `Vector{<:`[`AbstractFamily`](@ref)`}` with all patent families in portfolio `p`.
"""
function families(p::AbstractPortfolio)::Vector{<:AbstractFamily}
    throw(ArgumentError("$(typeof(p)) does not allow retrieval of patent families."))
end
