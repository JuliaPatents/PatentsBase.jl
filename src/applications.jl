
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


"""
    title(a::AbstractApplication)

return a `AbstractTitle` with information about the title of application `a`.
"""
function title(a::AbstractApplication)::(<:AbstractTitle)
    throw(ArgumentError("$(typeof(a)) does not contain title information."))
end


"""
    title(a::AbstractApplication, lang::String)

return a `String` with the localized title of application `a` for language `lang`.
"""
function title(a::AbstractApplication, lang::String)::String
    text(title(a), lang)
end


"""
    classifications(a::AbstractApplication, system::String = "all")

Return a `Vector{<:AbstractClassification}` with all classifications listed for 
a patent application `a`. The `system` parameter can either be the abbreviated 
name of a classification system, such as "CPC", or "all" to access classifications 
of any system.
"""
function classifications(a::AbstractApplication, system::String = "all")::Vector{<:AbstractClassification}
    throw(ArgumentError("$(typeof(a)) does not contain classification information."))
end


"""
    citations(a::AbstractApplication)

Return a `Vector{<:AbstractCitation}` with all works cited by the patent application `a`. 
"""
function citations(a::AbstractApplication)::Vector{<:AbstractCitation}
    throw(ArgumentError("$(typeof(a)) does not contain citation information."))
end
