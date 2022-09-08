
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
