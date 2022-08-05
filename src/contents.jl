"""
    AbstractContent

An abstract type representing an interface for content fields of a patent application.
There are five abstract content fields that are subtypes of this type:
`AbstractTitle`, `AbstractDescription`, `AbstractClaim`, `AbstractClaims`, 
`AbstractFulltext`.
"""
abstract type AbstractContent end

"""
    languages(c::AbstractContent)

Returns a `Vector{String}` with all languages for which a version of the content
field `c` is available.
"""
function languages(c::AbstractContent)::Vector{String}
    throw(ArgumentError("$(typeof(c)) does not contain language information."))
end

"""
    text(c::AbstractContent, lang::String)

Returns a `String` with the localized version of the text of content field `c`
for language `lang`. Concrete implementations should throw a `Base.KeyError`
if there is no title for that locale.
"""
function text(c::AbstractContent, lang::String)::String
    throw(ArgumentError("$(typeof(c)) does not contain localized information."))
end

"""
    AbstractTitle

An abstract type representing an interface for the title(s) of a patent application. 
Concrete implementations, such as `PatentsLens.LensTitle`, should subtype this.
"""
abstract type AbstractTitle <: AbstractContent end

"""
    AbstractTitle

An abstract type representing an interface for the abstract or short description of a patent.
The type is deliberately not named "AbstractAbstract" to avoid confusion.
Concrete implementations, such as `PatentsLens.LensAbstract`, should subtype this.
"""
abstract type AbstractDescription  <: AbstractContent end

"""
    AbstractClaim

An abstract type representing an interface for a single claim associated with a patent application.
Concrete implementations, such as `PatentsLens.LensClaim`, should subtype this.
"""
abstract type AbstractClaim  <: AbstractContent end

"""
    AbstractClaims

An abstract type representing an interface for the claims associated with a patent application.
Concrete implementations, such as `PatentsLens.LensClaims`, should subtype this.
"""
abstract type AbstractClaims  <: AbstractContent end

"""
    all(c::AbstractClaims)

Returns a `Vector{<:AbstractClaim}` with the individual claims of the claims field `c`.
"""
function all(c::AbstractClaims)::Vector{<:AbstractClaim}
    throw(ArgumentError("$(typeof(c)) does not allow retrieval of individual claims."))
end

"""
    AbstractFulltext

An abstract type representing an interface for the full text of a patent application.
Concrete implementations, such as `PatentsLens.LensFulltext`, should subtype this.
"""
abstract type AbstractFulltext  <: AbstractContent end
