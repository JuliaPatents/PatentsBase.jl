
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

