
"""
    AbstractJurisdiction

An abstract type representing an interface for a patent jurisdiction. 
Concrete implementations, such as `PatentsLens.LensJurisdiction`, should subtype this.
"""
abstract type AbstractJurisdiction end

function jurisdiction(a::AbstractApplication)::AbstractJurisdiction
    throw(ArgumentError("$(typeof(a)) does not contain jurisdiction information."))
end


# """
#     country(j::AbstractJurisdiction)

# return the country code of the jurisdiction `j`.
# """
# function country(j::AbstractJurisdiction)::String
#     throw(ArgumentError("$(typeof(j)) does not contain country information."))
# end
