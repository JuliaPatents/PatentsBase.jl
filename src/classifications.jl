"""
    AbstractClassificationSystem

Abstract type representing a system for technology classification of patents,
such as the Cooperative Patent Classification (CPC).
"""
abstract type AbstractClassificationSystem end
abstract type IPCLikeSystem <: AbstractClassificationSystem end

struct CPC <: IPCLikeSystem end
struct IPC <: IPCLikeSystem end

"""
    AbstractClassificationSymbol

Abstract type representing a patent classification entry.
"""
abstract type AbstractClassificationSymbol end
abstract type IPCLikeSymbol <: AbstractClassificationSymbol end

"""
    CPCSymbol

Struct representing a technology classification entry according to the CPC.
"""
struct CPCSymbol <: IPCLikeSymbol
    symbol::String
end

"""
    IPCSymbol

Struct representing a technology classification entry according to the IPC.
"""
struct IPCSymbol <: IPCLikeSymbol
    symbol::String
end

"""
    AbstractClassificationLevel

Abstract type representing a level in a hierarchical technology classification system.
"""
abstract type AbstractClassificationLevel end

struct Section <: AbstractClassificationLevel end
struct Class <: AbstractClassificationLevel end
struct Subclass <: AbstractClassificationLevel end
struct Maingroup <: AbstractClassificationLevel end
struct Subgroup <: AbstractClassificationLevel end

"""
    classification(c::AbstractClassificationSystem, a::AbstractApplication)

Obtain a vector of technology classification entries for application `a` according to classification system `c`.
"""
function classification(c::AbstractClassificationSystem, a::AbstractApplication)::Vector{AbstractClassificationSymbol}
    throw(ArgumentError("$(typeof(a)) does not contain classification information for classification system $(typeof(c))"))
end

classification(a::AbstractApplication) = classification(CPC(), a)


function symbol(l::AbstractClassificationLevel, c::AbstractClassificationSymbol)
    throw(ArgumentError("level $l not available for $(typeof(c))"))
end

symbol(c::IPCLikeSymbol) = c.symbol
symbol(::Section, c::IPCLikeSymbol) = first(symbol(c), 1)
symbol(::Class, c::IPCLikeSymbol) = first(symbol(c), 3)
symbol(::Subclass, c::IPCLikeSymbol) = first(symbol(c), 4)
symbol(::Maingroup, c::IPCLikeSymbol) = first(symbol(c), 8)
symbol(::Subgroup, c::IPCLikeSymbol) = symbol(c)


function title(::AbstractClassificationLevel, c::AbstractClassificationSymbol)
    throw(ArgumentError("No title information available for $(typeof(c))"))
end


# """
#     name(c::AbstractClassification)

# Return the name of the classification system followed by classification `c`.
# """
# function name(c::AbstractClassification)::String
#     throw(ArgumentError("$(typeof(c)) does not specify a name."))
# end

# """
#     shortname(c::AbstractClassification)

# Return the abbreviated name of the classification system followed by classification `c`.
# Concrete implementations of this should never return "all", as it is a reserved
# value in related functions.
# """
# function shortname(c::AbstractClassification)::String
#     throw(ArgumentError("$(typeof(c)) does not specify a short name."))
# end


# """
#     symbol(c::AbstractClassification)

# Return a `String` representation of the classification.
# This should always return the full hierarchical classification.
# """
# function symbol(c::AbstractClassification)::String
#     throw(ArgumentError("$(typeof(c)) does not implement symbol output."))
# end

# """
#     symbol(c::AbstractClassification)

# Return a `Vector{Tuple{String, String}}` containing the name and symbol for each 
# level of the classification hierarchy.
# This should always return the full hierarchical classification. The vector 
# should be ordered hierarchically from general to specific.
# """
# function hierarchy(c::AbstractClassification)::Vector{Tuple{String,String}}
#     throw(ArgumentError("$(typeof(c)) does not include hierarchical information."))
# end

# """
#     CPCClassification

# A concrete immutable composite type representing a CPC patent classification.
# """
# struct CPCClassification <: AbstractClassification
#     section::Char
#     class::String
#     subclass::Char
#     group::String
#     subgroup::String

#     CPCClassification(symbol::AbstractString) = new(
#         symbol[1],
#         symbol[2:3],
#         symbol[4],
#         split(symbol, '/')[1][5:end],
#         split(symbol, '/')[2]
#     )
# end

# name(c::CPCClassification) = "Cooperative Patent Classification"
# shortname(c::CPCClassification) = "CPC"

# symbol(c::CPCClassification) =
#     "$(c.section)$(c.class)$(c.subclass)$(c.group)/$(c.subgroup)"

# hierarchy(c::CPCClassification) = [
#     ("section", string(c.section)),
#     ("class", c.class),
#     ("subclass", string(c.subclass)),
#     ("group", c.group),
#     ("subgroup", c.subgroup)
# ]

