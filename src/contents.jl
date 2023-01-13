"""
An abstract type representing an interface for content fields of a patent application.
There are five abstract content fields that are subtypes of this type:
`AbstractTitle`, `AbstractDescription`, `AbstractClaim`, `AbstractClaims`,
`AbstractFulltext`.
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
An abstract type representing an interface for the claims associated with a patent application.
"""
abstract type AbstractClaims  <: AbstractContent end

"""
An abstract type representing an interface for the full text of a patent application.
"""
abstract type AbstractFulltext  <: AbstractContent end

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
    ContentFilter(search_query::String, field::SearchableContentField[, languages::Vector{String}])
    ContentFilter(search_query::String, fields::Vector{<:SearchableContentField}[, languages::Vector{String}])

Struct representing a database filter using full-text search on various content fields.

Parameters:

* `search_query`: The keyword(s), phrase(s) or complex query to be used for the search.
    Query syntax may vary across data sources, but should be broadly similar to
    https://www.sqlite.org/fts5.html#full_text_query_syntax.

* `field` / `fields`: Specifies which `SearchableContentField`(s) is/are used for the search.
    Possible values are `TitleSearch()`, `AbstractSearch()`, `ClaimsSearch()`, or `FulltextSearch()`.
    A vector can be passed, in which case the constructor actually creates a `UnionFilter`.

* `languages` (optional): A vector of two-character language codes specifying the languages for which matches are included.
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

function ContentFilter(search_query::String, fields::Vector{<:SearchableContentField}, languages::Vector{String})
    foldl(|, (f -> ContentFilter(search_query, f, languages)).(fields))
end

function ContentFilter(search_query::String, fields::Vector{<:SearchableContentField})
    foldl(|, (f -> ContentFilter(search_query, f)).(fields))
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
    claims(a::AbstractApplication)

return information on patent claims contained in application `a`.
"""
function claims(a::AbstractApplication)
    throw(ArgumentError("$(typeof(a)) does not contain claims information."))
end

"""
    description(a::AbstractApplication)

return the description (or abstract) for application a.
"""
function description(a::AbstractApplication)
    throw(ArgumentError("$(typeof(a)) does not contain a description."))
end

"""
    fulltext(a::AbstractApplication)

return the fulltext for application a.
"""
function fulltext(a::AbstractApplication)
    throw(ArgumentError("$(typeof(a)) does not contain fulltext information."))
end
