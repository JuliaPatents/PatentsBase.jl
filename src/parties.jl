
"""
An abstract type representing an interface for a patent application party.
The two types of parties are applicants and inventors, represented by the types
[`AbstractApplicant`](@ref) and [`AbstractInventor`](@ref), respectively.
"""
abstract type AbstractParty end

"""
An abstract type representing an interface for an inventor.
"""
abstract type AbstractInventor <: AbstractParty end

"""
An abstract type representing an interface for a patent applicant.
"""
abstract type AbstractApplicant <: AbstractParty end

"""
    name(p::AbstractParty)

return the name of the party `p`.
"""
function name(p::AbstractParty)::String
    throw(ArgumentError("$(typeof(p)) does not contain name information."))
end

name(a::AbstractApplicant) = first(names(a))

"""
    names(a::AbstractParty)

return a `Vector{String}` of all names under which party `p` is known to appear.
"""
function names(p::AbstractParty)::Vector{String}
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
    applicants(a::AbstractApplication)

return a `Vector{<:`[`AbstractApplicant`](@ref)`}` with information about the applicant(s) of application `a`.
"""
function applicants(a::AbstractApplication)::Vector{<:AbstractApplicant}
    throw(ArgumentError("$(typeof(a)) does not contain applicant information."))
end

"""
    applicants(f::AbstractFamily)

return a `Vector{<:`[`AbstractApplicant`](@ref)`}` with the unique set of applicants from all the
applications in family `f`.
"""
function applicants(f::AbstractFamily)::Vector{<:AbstractApplicant}
    unique(reduce(vcat, applicants.(applications(f))))
end

"""
    inventors(a::AbstractApplication)

return a `Vector{<:`[`AbstractInventor`](@ref)`}` with information about the inventor(s) of application `a`.
"""
function inventors(a::AbstractApplication)::Vector{<:AbstractInventor}
    throw(ArgumentError("$(typeof(a)) does not contain inventor information."))
end

"""
    inventors(f::AbstractFamily)

return a `Vector{<:`[`AbstractInventor`](@ref)`}` with the unique set of inventors from all the
applications in family `f`.
"""
function inventors(f::AbstractFamily)::Vector{<:AbstractInventor}
    unique(reduce(vcat, applicants.(applications(f))))
end
