
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


"""
    applicants(f::AbstractFamily)

return a `Vector{<:AbstractApplicant}` with the unique set of 
applicants from all the applications in family `f`.
"""
function applicants(f::AbstractFamily)::Vector{<:AbstractApplicant} 
    reduce(vcat, applicants.(applications(f)))
end

"""
    classifications(a::AbstractApplication, system::String = "all")

Return a `Vector{<:AbstractClassification}` with all classifications listed for 
a patent family `f`. The `system` parameter can either be the abbreviated name 
of a classification system, such as "CPC", or "all" to access classifications 
of any system.
"""
function classifications(f::AbstractFamily, system::String = "all")::Vector{<:AbstractClassification}
    reduce(vcat, (a -> classifications(a, system)).(applications(f)))
end
