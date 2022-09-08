
"""
    AbstractFamily

An abstract type representing an interface for a patent family.
Concrete implementations, such as `PatentsLens.LensFamily`, should subtype this.
"""
abstract type AbstractFamily end

"""
    applications(f::AbstractFamily)

return a `Vector{<:AbstractApplication}` with all applications in family `f`.
"""
function applications(f::AbstractFamily)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(f)) does not allow retrieval of individual applications."))
end

"""
    siblings(a::AbstractApplication)

return a `Vector{<:AbstractApplicationReference}` with references to all applications that
are in the same family as `a`.
"""
function siblings(a::AbstractApplication)::Vector{<:AbstractApplicationReference}
    throw(ArgumentError("$(typeof(a)) does not allow retrieval of sibling applications."))
end

"""
    siblings(a::AbstractApplication, ds::AbstractDataSource)

return a `Vector{<:AbstractApplication}` with all applications from the data source `ds`
that are in the same family as `a`.
"""
function siblings(a::AbstractApplication, ds::AbstractDataSource)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(a)) does not allow retrieval of sibling applications from $(typeof(ds))."))
end
