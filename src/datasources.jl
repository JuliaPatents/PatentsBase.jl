
"""
    AbstractDataSource

An abstract type representing an interface for a patent data source.
Data sources can be in-memory data structures, wrappers around databases or
API consumers.
"""
abstract type AbstractDataSource end

"""
    applications(ds::AbstractDataSource)

Return a `Vector{<:AbstractApplication}` with all applications contained in `ds`.
This may take a long time and/or cause memory overflow for large out-of-memory data sources.
"""
function applications(ds::AbstractDataSource)::Vector{<:AbstractApplication}
    throw(ArgumentError("$(typeof(ds)) does not allow retrieval of all applications"))
end

"""
    families(ds::AbstractDataSource)

Return a `Vector{<:AbstractFamily}` with all application families contained in `ds`.
This may take a long time and/or cause memory overflow for large out-of-memory data sources.
"""
function families(ds::AbstractDataSource)::Vector{<:AbstractFamily}
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
