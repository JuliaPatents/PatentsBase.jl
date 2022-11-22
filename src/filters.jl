"""
Abstract type representing a filter that can be applied to an `AbstractDataSource`.
In principle, any predicate that can apply to an application or patent family can be a filter.
However, some filter options may not be implemented for all data sources.
Filters are composable using the `UnionFilter` and `IntersectionFilter` structs and the corresponding `|` and `&` infix operators.
"""
abstract type AbstractFilter end

"""
Struct representing a database filter by IPC-like classification.
* `system`: The classification system used. Can be either `IPC()` or `CPC()`.
* `level`: The `AbstractIPCLikeClassificationLevel` at which to filter (`Section()`, `Class()`, `Subclass()` etc.)
* `symbols`: A `Vector{IPCLikeSymbol}` of all classifications included. The filter will match any application classified by at least one of these.
"""
struct ClassificationFilter <: AbstractFilter
    system::IPCLikeSystem
    level::AbstractIPCLikeClassificationLevel
    symbols::Vector{<:IPCLikeSymbol}
end

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

"Struct representing the intersection or conjunction of two `AbstractFilter`s."
struct IntersectionFilter <: AbstractFilter
    a::AbstractFilter
    b::AbstractFilter
end

Base.:&(a::AbstractFilter, b::AbstractFilter) = IntersectionFilter(a, b)

"Struct representing the union or disjunction of two `AbstractFilter`s."
struct UnionFilter <: AbstractFilter
    a::AbstractFilter
    b::AbstractFilter
end

Base.:|(a::AbstractFilter, b::AbstractFilter) = UnionFilter(a, b)

"Pseudo-filter that matches all applications or families in a database."
struct AllFilter <: AbstractFilter end
