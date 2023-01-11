
"""
An abstract type representing an interface for a citation in a patent application.
"""
abstract type AbstractCitation end

"""
An abstract type representing an interface for a citation of another patent document (NPL)
in a patent application.
"""
abstract type AbstractPatentCitation <: AbstractCitation end

"""
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
    reference(c::AbstractPatentCitation)

Return an `AbstractApplicationReference` for the application cited in `c`.
"""
function reference(c::AbstractPatentCitation)::(<:AbstractApplicationReference)
    throw(ArgumentError("$(typeof(c)) cannot be converted to ApplicationReference"))
end

"""
    find_application(c::AbstractPatentCitation, ds::AbstractDataSource)

Attempt to retrieve the patent application referenced by the citation `c` from the data
source `ds` and return it, or return `nothing` if it cannot be found.
"""
function find_application(c::AbstractPatentCitation, ds::AbstractDataSource)::(<:AbstractApplication)
    find_application(reference(c), ds)
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
function doi(c::AbstractNPLCitation)::Union{String, Nothing}
    matching = filter(id -> match(r"10\.[\d\.]*\/.*", id) !== nothing, external_ids(c))
    isempty(matching) ? nothing : first(matching)
end

"""
    citations(a::AbstractApplication)
    citations(f::AbstractFamily)

Return a `Vector{<:AbstractCitation}` with all citations from a patent application or family.
"""
function citations end

function citations(a::AbstractApplication)::Vector{<:AbstractCitation}
    throw(ArgumentError("$(typeof(a)) does not contain citation information."))
end

function citations(f::AbstractFamily)::Vector{<:AbstractCitation}
    return reduce(vcat, citations.(applications(f)))
end

"""
    patent_citations(a::AbstractApplication)
    patent_citations(f::AbstractFamily)

Return a `Vector{<:AbstractCitation}` with all patent citations from a patent application
or family.
"""
function patent_citations end

function patent_citations(a::AbstractApplication)::Vector{<:AbstractPatentCitation}
    throw(ArgumentError("$(typeof(a)) does not contain patent citation information."))
end

function patent_citations(f::AbstractFamily)::Vector{<:AbstractPatentCitation}
    return reduce(vcat, patent_citations.(applications(f)))
end

"""
    npl_citations(a::AbstractApplication)

Return a `Vector{<:AbstractNPLCitation}` with all NPL citations from a patent application
or family.
"""
function npl_citations end

function npl_citations(a::AbstractApplication)::Vector{<:AbstractNPLCitation}
    throw(ArgumentError("$(typeof(a)) does not contain NPL citation information."))
end

function npl_citations(f::AbstractFamily)::Vector{<:AbstractNPLCitation}
    return reduce(vcat, patent_citations.(applications(f)))
end

"""
    citedby(a::AbstractApplication)
    citedby(f::AbstractFamily)

Return a `Vector{<:AbstractPatentCitation}` with citations of all patent applications known
to cite a patent application or patent family.
Note that even though these are represented by the AbstractPatentCitation interface, they
are conceptually not citations in a strict sense.
"""
function forwardcitations end

function forwardcitations(a::AbstractApplication)::Vector{<:AbstractPatentCitation}
    throw(ArgumentError("$(typeof(a)) does not contain forward citation information."))
end

function forwardcitations(f::AbstractFamily)::Vector{<:AbstractPatentCitation}
    unique(reduce(vcat, forwardcitations.(applications(f))))
end

"""
    citationgraph(families::Vector{<:AbstractFamily})

Compute the graph created by family-to-family citations from `families`.
"""
function citationgraph end