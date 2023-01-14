
"""
An abstract type representing an interface for an entity's patent portfolio.
"""
abstract type AbstractPortfolio end

"""
    owner(p::AbstractPortfolio)

return an [`AbstractApplicant`](@ref) representing the owner of portfolio `p`.
"""
function owner(p::AbstractPortfolio)::(<:AbstractApplicant)
    throw(ArgumentError("$(typeof(p)) does not contain owner information."))
end

"""
    applications(p::AbstractPortfolio)

return a `Vector{<:`[`AbstractApplication`](@ref)`}` with all applications in portfolio `p`.
"""
function applications(p::AbstractPortfolio)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(p)) does not allow retrieval of individual applications."))
end
