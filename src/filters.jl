"""
Abstract type representing a filter that can be applied to an `AbstractDataSource`.
In principle, any predicate that can apply to an application or patent family can be a filter.
However, some filter options may not be implemented for all data sources.
Filters are composable using the `UnionFilter` and `IntersectionFilter` structs and the corresponding `|` and `&` infix operators.
"""
abstract type AbstractFilter end

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
