
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

return a `Vector{<:AbstractApplication}` with all applications that are in the same family as `a`.
"""
function siblings(a::AbstractApplication)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(a)) does not allow retrieval of sibling applications."))
end
