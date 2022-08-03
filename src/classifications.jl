"""
    AbstractClassification

An abstract type representing a (hierarchical) patent classification.
Concrete implementations should each represent a single classification system.
"""
abstract type AbstractClassification end

"""
    name(c::AbstractClassification)

Return the name of the classification system followed by classification `c`.
"""
function name(c::AbstractClassification)::String
    throw(ArgumentError("$(typeof(c)) does not specify a name."))
end

"""
    shortname(c::AbstractClassification)

Return the abbreviated name of the classification system followed by classification `c`.
"""
function shortname(c::AbstractClassification)::String
    throw(ArgumentError("$(typeof(c)) does not specify a short name."))
end


"""
    symbol(c::AbstractClassification)

Return a `String` representation of the classification.
This should always return the full hierarchical classification.
"""
function symbol(c::AbstractClassification)::String
    throw(ArgumentError("$(typeof(c)) does not implement symbol output."))
end

"""
    symbol(c::AbstractClassification)

Return a `Vector{Tuple{String, String}}` containing the name and symbol for each 
level of the classification hierarchy.
This should always return the full hierarchical classification. The vector 
should be ordered hierarchically from general to specific.
"""
function hierarchy(c::AbstractClassification)::Vector{Tuple{String, String}}
    throw(ArgumentError("$(typeof(c)) does not include hierarchical information."))
end

"""
    CPCClassification

A concrete immutable composite type representing a CPC patent classification.
"""
struct CPCClassification <: AbstractClassification
    section::Char
    class::String
    subclass::Char
    group::String
    subgroup::String

    CPCClassification(symbol::AbstractString) = new(
        symbol[1],
        symbol[2:3],
        symbol[4],
        split(symbol, '/')[1][5:end],
        split(symbol, '/')[2]
    )
end

name(c::CPCClassification) = "Cooperative Patent Classification"
shortname(c::CPCClassification) = "CPC"

symbol(c::CPCClassification) =
    "$(c.section)$(c.class)$(c.subclass)$(c.group)/$(c.subgroup)"

hierarchy(c::CPCClassification) = [
    ("section", string(c.section)),
    ("class", c.class),
    ("subclass", string(c.subclass)),
    ("group", c.group),
    ("subgroup", c.subgroup)
]

