
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
    classifications(f::AbstractFamily, system::String = "all")

Return a `Vector{<:AbstractClassification}` with all classifications listed for 
a patent family `f`. The `system` parameter can either be the abbreviated name 
of a classification system, such as "CPC", or "all" to access classifications 
of any system.
"""
function classifications(f::AbstractFamily, system::String = "all")::Vector{<:AbstractClassification}
    reduce(vcat, (a -> classifications(a, system)).(applications(f)))
end

"""
    citations(f::AbstractFamily)

Return a `Vector{<:AbstractCitation}` with the aggregated citations from all 
patent applications in the patent family `f`.
"""
function citations(f::AbstractFamily)::Vector{<:AbstractCitation}
    reduce(vcat, citations.(applications(f)))
end

"""
    patent_citations(f::AbstractFamily)

Return a `Vector{<:AbstractPatentCitation}` with the aggregated patent citations 
from all patent applications in the patent family `f`.
"""
function patent_citations(f::AbstractFamily)::Vector{<:AbstractPatentCitation}
    reduce(vcat, patent_citations.(applications(f)))
end

"""
    npl_citations(f::AbstractFamily)

Return a `Vector{<:AbstractNPLCitation}` with the aggregated NPL citations from 
all patent applications in the patent family `f`.
"""
function npl_citations(f::AbstractFamily)::Vector{<:AbstractNPLCitation}
    reduce(vcat, patent_citations.(applications(f)))
end

"""
    citedby(f::AbstractFamily)

Return a `Vector{<:AbstractPatentCitation}` with citations of all patent 
applications known to cite any of the patent applications in the family `f`.
Note that even though these are represented by the AbstractPatentCitation 
interface, they are conceptually not citations in a strict sense.
"""
function citedby(f::AbstractFamily)::Vector{<:AbstractPatentCitation}
    reduce(vcat, citedby.(applications(f)))
end
