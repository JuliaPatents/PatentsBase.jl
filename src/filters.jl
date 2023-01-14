"""
Abstract type representing a filter that can be applied to an [`AbstractDataSource`](@ref).
In principle, any predicate that can apply to an application or patent family can be a filter.
However, some filter options may not be implemented for all data sources.
Filters are composable using the `UnionFilter` and `IntersectionFilter` structs and the corresponding `|` and `&` infix operators.
"""
abstract type AbstractFilter end

"""
    IntersectionFilter(a::AbstractFilter, b::AbstractFilter)

Struct representing the intersection or conjunction of two [`AbstractFilter`](@ref)s.
As a shorthand syntax for this composition, the '&' operator may be used:

    filter3 = filter1 & filter2 # intersection of filter1 and filter2

"""
struct IntersectionFilter <: AbstractFilter
    a::AbstractFilter
    b::AbstractFilter
end

Base.:&(a::AbstractFilter, b::AbstractFilter) = IntersectionFilter(a, b)

"""
    UnionFilter(a::AbstractFilter, b::AbstractFilter)

Struct representing the union or disjunction of two [`AbstractFilter`](@ref)s.
As a shorthand syntax for this composition, the '|' operator may be used:

    filter3 = filter1 | filter2 # union of filter1 and filter2

"""
struct UnionFilter <: AbstractFilter
    a::AbstractFilter
    b::AbstractFilter
end

Base.:|(a::AbstractFilter, b::AbstractFilter) = UnionFilter(a, b)

"Pseudo-filter that matches all applications or families in a database."
struct AllFilter <: AbstractFilter end
