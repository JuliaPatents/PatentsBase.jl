"""
    AbstractTitle

An abstract type representing an interface for the title(s) of a patent application. 
Concrete implementations, such as `PatentsLens.LensTitle`, should subtype this.
"""
abstract type AbstractTitle end


"""
    text(lang::String)

Returns a `String` with the localized version of the title `t` for language `lang`.
Concrete implementations should throw a `Base.KeyError` if there is no title for that locale.
"""
function text(t::AbstractTitle, lang::String)::String
throw(ArgumentError("$(typeof(t)) does not contain localized information."))
end

abstract type AbstractDescriptions end

abstract type AbstractClaims end

abstract type AbstractFulltext end
