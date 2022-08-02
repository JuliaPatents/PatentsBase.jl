
"""
    AbstractParty

An abstract type representing an interface for a patent application party.
The two types of parties are applicants and inventors, represented by the types
`AbstractApplicant` and `AbstractInventor`, respectively.

"""
abstract type AbstractParty end


"""
    AbstractInventor

An abstract type representing an interface for an inventor. 
Concrete implementations, such as `PatentsLens.LensInventor`, should subtype this.
"""
abstract type AbstractInventor <: AbstractParty end


"""
    AbstractApplicant

An abstract type representing an interface for a patent applicant. 
Concrete implementations, such as `PatentsLens.LensApplicant`, should subtype this.
"""
abstract type AbstractApplicant <: AbstractParty end


"""
    name(p::AbstractParty)

return the name of the party `p`.
"""
function name(p::AbstractParty)::String
    throw(ArgumentError("$(typeof(p)) does not contain name information."))
end


"""
    country(p::AbstractParty)

return the country code of the country of residence of party `p`.
"""
function country(p::AbstractParty)::String
    throw(ArgumentError("$(typeof(p)) does not contain country of residence information."))
end


"""
    names(a::AbstractApplicant)

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

name(a::AbstractApplicant) = referencename(a)
