"""
An abstract type representing an interface for content fields of a patent application.
There are five abstract content fields that are subtypes of this type:
[`AbstractTitle`](@ref), [`AbstractDescription`](@ref), [`AbstractClaim`](@ref),
[`AbstractClaims`](@ref), and [`AbstractFulltext`](@ref).
"""
abstract type AbstractContent end

"""
An abstract type representing an interface for the title(s) of a patent application.
"""
abstract type AbstractTitle <: AbstractContent end

"""
An abstract type representing an interface for the abstract or short description of a patent.
The type is deliberately not named "AbstractAbstract" to avoid confusion.
"""
abstract type AbstractDescription  <: AbstractContent end

"""
An abstract type representing an interface for a single claim associated with a patent application.
"""
abstract type AbstractClaim  <: AbstractContent end

"""
An abstract type representing an interface for the full text of a patent application.
"""
abstract type AbstractFulltext <: AbstractContent end

"Abstract type representing a fulltext-searchable application content field."
abstract type SearchableContentField end

"Dispatch type referring to a search in the titles of documents."
struct TitleSearch <: SearchableContentField end

"Dispatch type referring to a search in the abstract descriptions of documents."
struct AbstractSearch <: SearchableContentField end

"Dispatch type referring to a search in the claims section of documents."
struct ClaimsSearch <: SearchableContentField end

"Dispatch type referring to a search in the full text of documents."
struct FulltextSearch <: SearchableContentField end

"""
    ContentFilter(
        search_query::String,
        field::Union{SearchableContentField, Vector{<:SearchableContentField},
        [languages::Vector{String}]
    )

Struct representing a database filter using full-text search on various content fields.

Parameters:

* `search_query`: The keyword(s), phrase(s) or complex query to be used for the search.
    Query syntax may vary across data sources, but should be broadly similar to
    https://www.sqlite.org/fts5.html#full_text_query_syntax.

* `field`: Specifies which [`SearchableContentField`](@ref)(s) is/are used for the search.
    Possible values are [`TitleSearch`](@ref)`()`, [`AbstractSearch`](@ref)`()`, [`ClaimsSearch`](@ref)`()`, or [`FulltextSearch`](@ref)`()`.
    A vector can be passed, in which case the constructor actually creates a [`UnionFilter`](@ref).

* `languages`: Optional. A vector of two-character language codes specifying the languages for which matches are included.
    If an empty vector is passed (as by default), all available languages are included.
"""
Base.@kwdef struct ContentFilter <: AbstractFilter
    search_query::String
    field::SearchableContentField
    languages::Vector{String} = []
end

function ContentFilter(search_query::String, field::SearchableContentField)
    ContentFilter(search_query, field, Vector{String}())
end

function ContentFilter(search_query::String, field::Vector{<:SearchableContentField}, languages::Vector{String})
    foldl(|, (f -> ContentFilter(search_query, f, languages)).(field))
end

function ContentFilter(search_query::String, field::Vector{<:SearchableContentField})
    foldl(|, (f -> ContentFilter(search_query, f)).(field))
end

"""
    languages(c::AbstractContent)

Returns a `Vector{String}` with all languages for which a version of the content field `c`
is available.
"""
function languages(c::AbstractContent)::Vector{String}
    throw(ArgumentError("$(typeof(c)) does not contain language information."))
end

"""
    text(c::AbstractContent, lang::String)

Returns a `String` with the localized version of the text of content field `c` for language `lang`.
Concrete implementations should throw a `Base.KeyError` if there is no title for that locale.
"""
function text(c::AbstractContent, lang::String)::String
    throw(ArgumentError("$(typeof(c)) does not contain localized information."))
end

"""
    title(a::AbstractApplication)

Return an [`AbstractTitle`](@ref) with information about the title of application `a`.
"""
function title(a::AbstractApplication)::(<:AbstractTitle)
    throw(ArgumentError("$(typeof(a)) does not contain title information."))
end

"""
    title(a::AbstractApplication, lang::String)

Return a `String` with the localized title of application `a` for language `lang`.
"""
function title(a::AbstractApplication, lang::String)::String
    text(title(a), lang)
end

"""
    claims(a::AbstractApplication)

Return an [`AbstractClaims`](@ref) with information on patent claims contained in application `a`.
"""
function claims(a::AbstractApplication)::(Vector{<:AbstractClaim})
    throw(ArgumentError("$(typeof(a)) does not contain claims information."))
end

"""
    description(a::AbstractApplication)

Return an [`AbstractDescription`](@ref) with the abstract of application a.
"""
function description(a::AbstractApplication)::(<:AbstractDescription)
    throw(ArgumentError("$(typeof(a)) does not contain a description."))
end

"""
    fulltext(a::AbstractApplication)

Return an [`AbstractFulltext`](@ref) with the full text of application a.
"""
function fulltext(a::AbstractApplication)::(<:AbstractFulltext)
    throw(ArgumentError("$(typeof(a)) does not contain fulltext information."))
end
