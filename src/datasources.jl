
"""
    AbstractDataSource

An abstract type representing an interface for a patent data source.
Data sources can be in-memory data structures, wrappers around databases or
API consumers.
"""
abstract type AbstractDataSource end

"""
    AbstractApplicationReference

An abstract type representing a reference to a patent application. Implementations
should be coupled with an implementation of `AbstractDataSource` to allow lookup
of the referenced application in the data source, using the `find_application` function.
"""
abstract type AbstractApplicationReference end

"""
    AbstractApplicationID

An abstract type representing an interface for an application reference by
jurisdiction, document number, and (optionally) kind. This is the preferred
reference type to allow cross-referencing of applications across different
data sources and formats.
"""
abstract type AbstractApplicationID <: AbstractApplicationReference end

"""
jurisdiction(aid::AbstractApplicationID)

Return a `String` with the country code of the filing jurisdiction for the application
referenced by `aid`.
"""
function jurisdiction(aid::AbstractApplicationID)::String
    throw(ArgumentError("$(typeof(aid)) does not contain jurisdiction information"))
end

"""
doc_number(aid::AbstractApplicationID)

Return a `String` with the jurisdiction-specific document number of the application
referenced by `aid`.
"""
function doc_number(aid::AbstractApplicationID)::String
    throw(ArgumentError("$(typeof(aid)) does not contain document number information"))
end

"""
kind(aid::AbstractApplicationID)

Return a `String` with the kind code of the application referenced by `aid`.
"""
function kind(aid::AbstractApplicationID)::String
    throw(ArgumentError("$(typeof(aid)) does not contain kind information"))
end

"""
refers_to(ref::AbstractApplicationReference, app::AbstractApplication)

Return `true` if `app` is the application referenced by `ref`, and false otherwise.
In cases where identity cannot be checked due to incompatible types, implementations should
default to `false`. The abstract reference implementation always returns `false`.
"""
refers_to(ref::AbstractApplicationReference, app::AbstractApplication)::Bool = false

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
