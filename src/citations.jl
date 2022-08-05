
"""
    AbstractCitation

An abstract type representing an interface for a citation in a patent application.
"""
abstract type AbstractCitation end

"""
    AbstractPatentCitation

An abstract type representing an interface for a citation of another patent document (NPL)
in a patent application.
"""
abstract type AbstractPatentCitation <: AbstractCitation end

"""
AbstractNPLCitation

An abstract type representing an interface for a citation of non-patent literature (NPL) in
a patent application.
"""
abstract type AbstractNPLCitation <: AbstractCitation end

"""
    phase(c::AbstractCitation)

Return a `String` specifying the phase in the patent process during which the citation `c`
occured.
"""
function phase(c::AbstractCitation)::String
    throw(ArgumentError("$(typeof(c)) does not contain phase information"))
end

"""
    application(c::AbstractPatentCitation, ds::AbstractDataSource)

Attempt to retrieve the patent application referenced by the citation `c` from the data
source `ds` and return it. Concrete implementations should throw a `Base.KeyError` if the
document is not available.
"""
function application(c::AbstractPatentCitation, ds::AbstractDataSource)::(<:AbstractApplication)
    throw(ArgumentError("$(typeof(ds)) does not allow lookup of $(typeof(c))"))
end

"""
    bibentry(c::AbstractNPLCitation, lang::String)

Returns a `String` with the bibliography entry of the NPL citation `c`.
"""
function bibentry(c::AbstractNPLCitation)::String
    throw(ArgumentError("$(typeof(c)) does not contain bibliographic information."))
end

"""
    external_ids(c::AbstractNPLCitation, lang::String)

Returns a `Vector{String}` with the external database IDs recorded for the NPL citation `c`.
"""
function external_ids(c::AbstractNPLCitation)::Vector{String}
    throw(ArgumentError("$(typeof(c)) does not contain external ID information."))
end

"""
    doi(c::AbstractNPLCitation, lang::String)

Returns a `String` with the Digital Object Identifier (DOI) for NPL citation `c`.
If multiple IDs matching the DOI format are found, the first is returned.
Returns `nothing` if no ID field matches the DOI format.
"""
function doi(c::AbstractNPLCitation)::String
    matching = filter(id -> match(r"10\.[\d\.]*\/.*", id) !== nothing, c.external_ids)
    isempty(matching) ? nothing : first(matching)
end

"""
    citations(a::AbstractApplication)

Return a `Vector{<:AbstractCitation}` with all citations from the patent application `a`.
"""
function citations(a::AbstractApplication)::Vector{<:AbstractCitation}
    throw(ArgumentError("$(typeof(a)) does not contain citation information."))
end

"""
    citations(f::AbstractFamily)

Return a `Vector{<:AbstractCitation}` with the aggregated citations from all patent
applications in the patent family `f`.
"""
function citations(f::AbstractFamily)::Vector{<:AbstractCitation}
    reduce(vcat, citations.(applications(f)))
end

"""
    patent_citations(a::AbstractApplication)

Return a `Vector{<:AbstractPatentCitation}` with all patent citations from the patent
application `a`.
"""
function patent_citations(a::AbstractApplication)::Vector{<:AbstractPatentCitation}
    throw(ArgumentError("$(typeof(a)) does not contain patent citation information."))
end

"""
    patent_citations(f::AbstractFamily)

Return a `Vector{<:AbstractPatentCitation}` with the aggregated patent citations from all
patent applications in the patent family `f`.
"""
function patent_citations(f::AbstractFamily)::Vector{<:AbstractPatentCitation}
    reduce(vcat, patent_citations.(applications(f)))
end

"""
    npl_citations(a::AbstractApplication)

Return a `Vector{<:AbstractNPLCitation}` with all NPL citations from the patent application
`a`.
"""
function npl_citations(a::AbstractApplication)::Vector{<:AbstractNPLCitation}
    throw(ArgumentError("$(typeof(a)) does not contain NPL citation information."))
end

"""
    npl_citations(f::AbstractFamily)

Return a `Vector{<:AbstractNPLCitation}` with the aggregated NPL citations from all patent
applications in the patent family `f`.
"""
function npl_citations(f::AbstractFamily)::Vector{<:AbstractNPLCitation}
    reduce(vcat, patent_citations.(applications(f)))
end

"""
    citedby(a::AbstractApplication)

Return a `Vector{<:AbstractPatentCitation}` with citations of all patent applications known
to cite the patent application `a`.
Note that even though these are represented by the AbstractPatentCitation interface, they
are conceptually not citations in a strict sense.
"""
function citedby(a::AbstractApplication)::Vector{<:AbstractPatentCitation}
    throw(ArgumentError("$(typeof(a)) does not contain forward citation information."))
end

"""
    citedby(f::AbstractFamily)

Return a `Vector{<:AbstractPatentCitation}` with citations of all patent applications known
to cite any of the patent applications in the family `f`.
Note that even though these are represented by the AbstractPatentCitation interface, they
are conceptually not citations in a strict sense.
"""
function citedby(f::AbstractFamily)::Vector{<:AbstractPatentCitation}
    reduce(vcat, citedby.(applications(f)))
end
