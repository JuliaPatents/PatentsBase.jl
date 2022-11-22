
"""
    AbstractDataSource

An abstract type representing an interface for a patent data source.
Data sources can be in-memory data structures, wrappers around databases or
API consumers.
"""
abstract type AbstractDataSource end

"""
    applications(ds::AbstractDataSource, kwargs...)
    applications(ds::AbstractDataSource, filter::AbstractFilter, kwargs...)

Return a `Vector{<:AbstractApplication}` with all applications contained in `ds`.
May take a long time and/or cause memory overflow for large out-of-memory data sources.
If a `filter` is specified, only applications matching the filter are returned.

Optional keyword arguments:
* `ignore_fulltext`: If true, full text information will not be retrieved.
    This may be used to improve runtime and memory footprint for large datasets.
"""
function applications(ds::AbstractDataSource, filter::AbstractFilter = LensAllFilter();
    ignore_fulltext::Bool = false)::Vector{<:AbstractApplication}

    throw(ArgumentError("$(typeof(ds)) does not allow retrieval of all applications"))
end

"""
    families(ds::AbstractDataSource, kwargs...)
    families(ds::AbstractDataSource, filter::AbstractFilter, kwargs...)

Return a `Vector{<:AbstractFamily}` with all patent families contained in `ds`.
May take a long time and/or cause memory overflow for large out-of-memory data sources.
If a `filter` is specified, only families matching the filter are returned.

Optional keyword arguments:
* `ignore_fulltext`: If true, full text information will not be retrieved.
    This may be used to improve runtime and memory footprint for large datasets.
"""
function families(ds::AbstractDataSource, filter::AbstractFilter = LensAllFilter();
    ignore_fulltext::Bool = false)::Vector{<:AbstractFamily}

    throw(ArgumentError("$(typeof(ds)) does not allow retrieval of all families"))
end

"""
    find_application(ref::AbstractApplicationReference, ds::AbstractDataSource)

Return the application referenced by `ref` if it is contained in the data source
`ds`, otherwise return nothing.
"""
function find_application(
    ref::AbstractApplicationReference,
    ds::AbstractDataSource
)::Union{Nothing, <:AbstractApplication}
    apps = applications(ds)
    index = findfirst(app -> refers_to(ref, app), apps)
    isnothing(index) ? nothing : apps(index)
end
