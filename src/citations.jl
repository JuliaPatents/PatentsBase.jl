
"""
    AbstractCitation

An abstract type representing an interface for a citation in a patent application.
"""
abstract type AbstractCitation end

"""
    phase(c::AbstractCitation)

Return a `String` specifying the phase in the patent process during which the
citation `c` occured.
"""
function phase(c::AbstractCitation)::String
    throw(ArgumentError("$(typeof(c)) does not contain phase information"))
end

"""
    AbstractPatentCitation

An abstract type representing an interface for a citation of another patent document
(NPL) in a patent application.
"""
abstract type AbstractPatentCitation <: AbstractCitation end

"""
    application(c::AbstractPatentCitation, ds::AbstractDataSource)

Attempt to retrieve the patent application referenced by the citation `c` from
the data source `ds` and return it. Concrete implementations should throw a 
`Base.KeyError` if the document is not available. 
"""
function application(c::AbstractPatentCitation, ds::AbstractDataSource)::(<:AbstractApplication)
    throw(ArgumentError("$(typeof(ds)) does not allow lookup of $(typeof(c))"))
end

"""
AbstractNPLCitation

An abstract type representing an interface for a citation of non-patent literature
(NPL) in a patent application.
"""
abstract type AbstractNPLCitation <: AbstractCitation end

"""
    text(c::AbstractNPLCitation, lang::String)

Returns a `String` with the text representation of the NPL citation `c`.
"""
function text(c::AbstractNPLCitation)::String
    throw(ArgumentError("$(typeof(c)) does not contain text information."))
end

"""
    external_ids(c::AbstractNPLCitation, lang::String)

Returns a `Vector{String}` with the external database IDs recorded for the 
NPL citation `c`.
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
