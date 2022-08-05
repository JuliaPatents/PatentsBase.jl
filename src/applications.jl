
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

Return a `Vector{<:AbstractCitation}` with all citations from the patent 
application `a`. 
"""
function citations(a::AbstractApplication)::Vector{<:AbstractCitation}
    throw(ArgumentError("$(typeof(a)) does not contain citation information."))
end


"""
    patent_citations(a::AbstractApplication)

Return a `Vector{<:AbstractPatentCitation}` with all patent citations from the 
patent application `a`. 
"""
function patent_citations(a::AbstractApplication)::Vector{<:AbstractPatentCitation}
    throw(ArgumentError("$(typeof(a)) does not contain patent citation information."))
end


"""
    patent_citations(a::AbstractApplication)

Return a `Vector{<:AbstractNPLCitation}` with all NPL citations from the patent 
application `a`. 
"""
function npl_citations(a::AbstractApplication)::Vector{<:AbstractNPLCitation}
    throw(ArgumentError("$(typeof(a)) does not contain NPL citation information."))
end


"""
    citedby(a::AbstractApplication)

Return a `Vector{<:AbstractPatentCitation}` with citations of all patent 
applications known to cite the patent application `a`.
Note that even though these are represented by the AbstractPatentCitation 
interface, they are conceptually not citations in a strict sense.
"""
function citedby(a::AbstractApplication)::Vector{<:AbstractPatentCitation}
    throw(ArgumentError("$(typeof(a)) does not contain forward citation information."))
end
