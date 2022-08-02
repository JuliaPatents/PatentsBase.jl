
"""
AbstractInventor

An abstract type representing an interface for an inventor. 
Concrete implementations, such as `PatentsLens.LensInventor`, should subtype this.
"""
abstract type AbstractInventor end


"""
name(i::AbstractInventor, lang::String)

return the full name of the inventor.
"""
function name(i::AbstractInventor)::String
    throw(ArgumentError("$(typeof(i)) does not contain name information."))
end


"""
residence(i::AbstractInventor)

return the country code of the country of residence  of inventor `i`.
"""
function residence(i::AbstractInventor)::String
    throw(ArgumentError("$(typeof(i)) does not contain residence information."))
end
