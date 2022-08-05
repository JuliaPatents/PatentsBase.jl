
"""
    AbstractApplication

An abstract type representing an interface for a patent application. Concrete
implementations, such as `PatentsLens.LensApplication`, should subtype this.

`PatentsLens.jl` includes a general interface for working with different types of patent
data, which should also be implemented by the concrete subtypes, as permitted by the
respective data source.
"""
abstract type AbstractApplication end
