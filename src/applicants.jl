
"""
AbstractApplicant

An abstract type representing an interface for a patent applicant. Concrete implementations, 
such as `PatentsLens.LensApplicant`, should subtype this.
"""
abstract type AbstractApplicant end


"""
name(a::AbstractApplicant)

return a `Vector{String}` of all names under which applicant `a` is known to appear.
"""
function names(a::AbstractApplicant)::Vector{String}
    throw(ArgumentError("$(typeof(a)) does not contain name information."))
end


"""
referencename(a::AbstractApplicant)

return the main name under which applicant `a` is known to appear.
Base implementation simply returns the first element of `names(a::AbstractApplicant)`.
"""
function referencename(a::AbstractApplicant)::String
    isempty(names(a)) ? first(names(a)) : Error("Applicant has no known names.")
end


"""
residence(a::AbstractApplicant)

return the country code of the country of residence  of applicant `a`.
"""
function residence(a::AbstractApplicant)::String
    throw(ArgumentError("$(typeof(a)) does not contain residence information."))
end
