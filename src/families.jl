
"""
An abstract type representing an interface for a patent family.
"""
abstract type AbstractFamily end

"""
    applications(f::AbstractFamily)

return a `Vector{<:`[`AbstractApplication`](@ref)`}` with all applications in family `f`.
"""
function applications(f::AbstractFamily)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(f)) does not allow retrieval of individual applications."))
end

"""
    date_published(f::AbstractFamily)

Return the `Date` of publication of the earliest-published application in a family `f`.
"""
function date_published(f::AbstractFamily)::Date
    minimum(date_published, applications(f))
end

"""
    siblings(a::AbstractApplicationReference)

return a `Vector{<:`[`AbstractApplicationReference`](@ref)`}` with references to all
applications that are in the same family as `a`.
"""
function siblings(a::AbstractApplication)::Vector{<:AbstractApplicationReference}
    throw(ArgumentError("$(typeof(a)) does not allow retrieval of sibling applications."))
end

"""
    siblings(a::AbstractApplication, ds::AbstractDataSource)

return a `Vector{<:`[`AbstractApplication`](@ref)`}` with all applications from the data source `ds`
that are in the same family as `a`.
"""
function siblings(a::AbstractApplication, ds::AbstractDataSource)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(a)) does not allow retrieval of sibling applications from $(typeof(ds))."))
end

"""
    families(ds::AbstractDataSource[, filter::AbstractFilter], kwargs...)

Return a `Vector{<:`[`AbstractFamily`](@ref)`}` with all patent families contained in `ds`.
May take a long time and/or cause memory overflow for large out-of-memory data sources.
If a `filter` is specified, only families matching the filter are returned.

Optional keyword arguments:
* `ignore_fulltext`: If true, full text information will not be retrieved.
    This may be used to improve runtime and memory footprint for large datasets.
"""
function families(ds::AbstractDataSource, filter::AbstractFilter = AllFilter();
    ignore_fulltext::Bool = false)::Vector{<:AbstractFamily}

    throw(ArgumentError("$(typeof(ds)) does not allow retrieval of all families"))
end

"""
    aggregate_families(apps::Vector{<:AbstractApplication})

Aggregate the applications `apps` into an array of patent families.
"""
function aggregate_families end
