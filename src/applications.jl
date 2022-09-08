
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
jurisdiction(a::AbstractApplication)

Return a `String` with the country code of the filing jurisdiction for the application `a`.
"""
function jurisdiction(a::AbstractApplication)::String
    throw(ArgumentError("$(typeof(a)) does not contain jurisdiction information"))
end

"""
doc_number(a::AbstractApplication)

Return a `String` with the jurisdiction-specific document number of the application `a`.
"""
function doc_number(a::AbstractApplication)::String
    throw(ArgumentError("$(typeof(a)) does not contain document number information"))
end

"""
kind(a::AbstractApplication)

Return a `String` with the kind code of the application `a`.
"""
function kind(a::AbstractApplication)::String
    throw(ArgumentError("$(typeof(a)) does not contain kind information"))
end
