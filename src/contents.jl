"""
    AbstractContent

An abstract type representing an interface for content fields of a patent application.
There are five abstract content fields that are subtypes of this type:
`AbstractTitle`, `AbstractDescription`, `AbstractClaim`, `AbstractClaims`,
`AbstractFulltext`.
"""
abstract type AbstractContent end

"""
    AbstractTitle

An abstract type representing an interface for the title(s) of a patent application.
Concrete implementations, such as `PatentsLens.LensTitle`, should subtype this.
"""
abstract type AbstractTitle <: AbstractContent end

"""
    AbstractDescription

An abstract type representing an interface for the abstract or short description of a patent.
The type is deliberately not named "AbstractAbstract" to avoid confusion.
Concrete implementations, such as `PatentsLens.LensAbstract`, should subtype this.
"""
abstract type AbstractDescription  <: AbstractContent end

"""
    AbstractClaim

An abstract type representing an interface for a single claim associated with a patent application.
Concrete implementations, such as `PatentsLens.LensClaim`, should subtype this.
"""
abstract type AbstractClaim  <: AbstractContent end

"""
    AbstractClaims

An abstract type representing an interface for the claims associated with a patent application.
Concrete implementations, such as `PatentsLens.LensClaims`, should subtype this.
"""
abstract type AbstractClaims  <: AbstractContent end

"""
    AbstractFulltext

An abstract type representing an interface for the full text of a patent application.
Concrete implementations, such as `PatentsLens.LensFulltext`, should subtype this.
"""
abstract type AbstractFulltext  <: AbstractContent end

"Abstract type representing a fulltext-searchable application content field."
abstract type SearchableContentField end

struct TitleSearch <: SearchableContentField end
struct AbstractSearch <: SearchableContentField end
struct ClaimsSearch <: SearchableContentField end
struct FulltextSearch <: SearchableContentField end

"""
Struct representing a database filter using full-text search on various content fields.
* `search_query`: The keyword(s), phrase(s) or complex query to be used for the search.
    Query syntax may vary across data sources, but should be broadly similar to
    https://www.sqlite.org/fts5.html#full_text_query_syntax.
* `field`: Specifies which `SearchableContentField` is used for the search.
    Possible values are `TitleSearch()`, `AbstractSearch()`, `ClaimsSearch()`, or `FulltextSearch()`
* `languages`: A vector of two-character language codes specifying the languages for which matches are included.
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
    all(c::AbstractClaims)

Returns a `Vector{<:AbstractClaim}` with the individual claims of the claims field `c`.
"""
function all(c::AbstractClaims)::Vector{<:AbstractClaim}
    throw(ArgumentError("$(typeof(c)) does not allow retrieval of individual claims."))
end
