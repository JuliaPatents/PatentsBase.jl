
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

""" An abstract type representing a type of citation, e.g. patent or NPL. """
abstract type AbstractCitationType end

""" Dispatch type for selecting patent citations. """
struct PatentCitation <: AbstractCitationType end

""" Dispatch type for selecting NPL citations. """
struct NPLCitation <: AbstractCitationType end

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

Return an [`AbstractApplicationReference`](@ref) for the application cited in `c`.
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
    bibentry(c::AbstractNPLCitation)

Returns a `String` with the bibliography entry of the NPL citation `c`.
"""
function bibentry(c::AbstractNPLCitation)::String
    throw(ArgumentError("$(typeof(c)) does not contain bibliographic information."))
end

"""
    external_ids(c::AbstractNPLCitation)

Returns a `Vector{String}` with the external database IDs recorded for the NPL citation `c`.
"""
function external_ids(c::AbstractNPLCitation)::Vector{String}
    throw(ArgumentError("$(typeof(c)) does not contain external ID information."))
end

"""
    doi(c::AbstractNPLCitation)

Returns a `String` with the Digital Object Identifier (DOI) for NPL citation `c`.
If multiple IDs matching the DOI format are found, the first is returned.
Returns `nothing` if no ID field matches the DOI format.
"""
function doi(c::AbstractNPLCitation)::Union{String, Nothing}
    matching = filter(id -> match(r"10\.[\d\.]*\/.*", id) !== nothing, external_ids(c))
    isempty(matching) ? nothing : first(matching)
end

"""
    citations(a::AbstractApplication[, type::AbstractCitationType])
    citations(f::AbstractFamily[, type::AbstractCitationType])

Return a `Vector{<:`[`AbstractCitation`](@ref)`}` with all citations of the given `type`
from a patent application `a` or family `f`.

`type` can either be [`PatentCitation`](@ref)`()` (default) or [`NPLCitation`](@ref)`()`.
"""
function citations end

function citations(a::AbstractApplication, type::AbstractCitationType = PatentCitation())::Vector{<:AbstractCitation}
    throw(ArgumentError("$(typeof(a)) does not contain citation information."))
end

function citations(f::AbstractFamily, type::AbstractCitationType = PatentCitation())::Vector{<:AbstractCitation}
    return reduce(vcat, (a -> citations(a, type)).(applications(f)))
end

"""
    forwardcitations(a::AbstractApplication)
    forwardcitations(f::AbstractFamily)

Return a `Vector{<:`[`AbstractPatentCitation`](@ref)`}` with citations of all patent applications known
to cite a patent application or patent family.
Note that even though these are represented by the [`AbstractPatentCitation`](@ref) interface, they
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
    citationgraph(applications::Vector{<:AbstractApplication})
    citationgraph(families::Vector{<:AbstractFamily})

Return a `SimpleDiGraph` representing the network of citations among `families` or
`applications`.

Node numbers in the graph correspond to indices in the input array.
An edge from node i to node j indicates that j cited i and will be included in the
output graph if the publication date of j is after that of i.
"""
function citationgraph end

function citationgraph(applications::Vector{<:AbstractApplication})
    graph = SimpleDiGraph(length(applications))
    id2idx = Dict{String, Int}()
    for i in 1:length(applications)
        push!(id2idx, sourceid(applications[i]) => i)
    end
    for i_citing in 1:length(applications)
        citing = applications[i_citing]
        for cited in sourceid.(reference.(citations(citing)))
            haskey(id2idx, cited) || continue
            i_cited = id2idx[cited]
            date_published(citing) > date_published(applications[i_cited]) || continue
            add_edge!(graph, i_cited, i_citing)
        end
    end
    return graph
end

function citationgraph(families::Vector{<:AbstractFamily})
    graph = SimpleDiGraph(length(families))
    id2idx = Dict{String, Int}()
    for i in 1:length(families)
        for app in applications(families[i])
            push!(id2idx, sourceid(app) => i)
        end
    end
    for i_citing in 1:length(families)
        citing = families[i_citing]
        for cited in sourceid.(reference.(citations(citing)))
            haskey(id2idx, cited) || continue
            i_cited = id2idx[cited]
            i_cited != i_citing || continue
            date_published(citing) > date_published(families[i_cited]) || continue
            has_edge(graph, i_cited, i_citing) && continue
            add_edge!(graph, i_cited, i_citing)
        end
    end
    return graph
end

"""
    citationgraph(ds::AbstractDataSource, level::DataLevel[, filter::AbstractFilter])

Compute a citation graph based on the data in an [`AbstractDataSource`](@ref).

Parameters:

- `ds`: An [`AbstractDataSource`](@ref) containing patent data.
- `level`: The [`DataLevel`](@ref) on which to operate: ([`ApplicationLevel`](@ref)`()` or [`FamilyLevel`](@ref)`()`).
- `filter`: Optional. An [`AbstractFilter`](@ref) to apply to the dataset before computing the graph.
"""
function citationgraph(ds::AbstractDataSource, level::DataLevel, filter::AbstractFilter)
    throw(ArgumentError("Cannot compute citation graph from $(typeof(ds))."))
end

citationgraph(ds::AbstractDataSource, level::DataLevel) = citationgraph(ds, level, AllFilter())
