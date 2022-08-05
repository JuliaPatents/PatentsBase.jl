
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
    names(a::AbstractApplicant)

return a `Vector{String}` of all names under which applicant `a` is known to appear.
"""
function names(a::AbstractApplicant)::Vector{String}
    throw(ArgumentError("$(typeof(a)) does not contain name information."))
end

name(a::AbstractApplicant) = first(names(a))

"""
    country(p::AbstractParty)

return the country code of the country of residence of party `p`.
"""
function country(p::AbstractParty)::String
    throw(ArgumentError("$(typeof(p)) does not contain country of residence information."))
end

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
function applicants(f::AbstractFamily)::Vector{<:AbstractApplicant}
    reduce(vcat, applicants.(applications(f)))
end
