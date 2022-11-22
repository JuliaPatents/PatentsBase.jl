
"""
    AbstractApplication

An abstract type representing an interface for a patent application. Concrete
implementations, such as `PatentsLens.LensApplication`, should subtype this.

`PatentsLens.jl` includes a general interface for working with different types of patent
data, which should also be implemented by the concrete subtypes, as permitted by the
respective data source.
"""
abstract type AbstractApplication end

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
    jurisdiction(a::AbstractApplication)
    jurisdiction(a::AbstractApplicationID)

Return a `String` with the country code of the filing jurisdiction for the application `a`.
"""
function jurisdiction end

function jurisdiction(a::AbstractApplication)::String
    throw(ArgumentError("$(typeof(a)) does not contain jurisdiction information"))
end

function jurisdiction(a::AbstractApplicationID)::String
    throw(ArgumentError("$(typeof(a)) does not contain jurisdiction information"))
end

"""
    doc_number(a::AbstractApplication)
    doc_number(a::AbstractApplicationID)

Return a `String` with the jurisdiction-specific document number of the application `a`.
"""
function doc_number end

function doc_number(a::AbstractApplication)::String
    throw(ArgumentError("$(typeof(a)) does not contain document number information"))
end

function doc_number(a::AbstractApplicationID)::String
    throw(ArgumentError("$(typeof(a)) does not contain document number information"))
end

"""
    kind(a::AbstractApplication)
    kind(a::AbstractApplicationID)

Return a `String` with the kind code of the application `a`.
"""
function kind end

function kind(a::AbstractApplicationID)::String
    throw(ArgumentError("$(typeof(a)) does not contain kind information"))
end

function kind(a::AbstractApplication)::String
    throw(ArgumentError("$(typeof(a)) does not contain kind information"))
end

"""
    refers_to(ref::AbstractApplicationReference, app::AbstractApplication)

Return `true` if `app` is the application referenced by `ref`, and false otherwise.
In cases where identity cannot be checked due to incompatible types, implementations should
default to `false`. The abstract reference implementation always returns `false`.
"""
function refers_to(ref::AbstractApplicationReference, app::AbstractApplication)::Bool
    return false
end

function refers_to(ref::AbstractApplicationID, app::AbstractApplication)
    try
        return jurisdiction(app) == jurisdiction(ref) &&
            doc_number(app) == doc_number(ref) &&
            kind(app) == kind(ref)
    catch ex
        isa(ex, ArgumentError) ? false : throw(ex)
    end
end

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
function applications(ds::AbstractDataSource, filter::AbstractFilter = AllFilter();
    ignore_fulltext::Bool = false)::Vector{<:AbstractApplication}

    throw(ArgumentError("$(typeof(ds)) does not allow retrieval of all applications"))
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
