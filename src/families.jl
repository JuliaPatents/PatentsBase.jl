
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
applicants(f::AbstractFamily)

return a `Vector{<:AbstractApplicant}` with the unique set of 
applicants from all the applications in family `f`.
"""
function applicants(f::AbstractFamily)::Vector{<:AbstractApplicant} 
    reduce(vcat, applicants.(applications(f)))
end
