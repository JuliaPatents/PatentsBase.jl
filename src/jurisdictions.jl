
"""
AbstractJurisdiction

An abstract type representing an interface for a patent jurisdiction. 
Concrete implementations, such as `PatentsLens.LensJurisdiction`, should subtype this.
"""
abstract type AbstractJurisdiction end


"""
ccode(j::AbstractJurisdiction)

return the country code of the jurisdiction `j`.
"""
function ccode(j::AbstractJurisdiction)::String
    throw(ArgumentError("$(typeof(j)) does not contain country information."))
end
