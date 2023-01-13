"""
Abstract type representing a system for technology classification of patents.
"""
abstract type AbstractClassificationSystem end

"""
Abstract type representing a system for technology classification of patents that follows a
structure similar to that of the International Patent Classification (IPC) or
Cooperative Patent Classification (CPC).
"""
abstract type IPCLikeSystem <: AbstractClassificationSystem end

"""
Dispatch type referring to the Cooperative Patent Classification (CPC) classification system.
"""
struct CPC <: IPCLikeSystem end

"""
Dispatch type referring to the International Patent Classification (IPC) classification system.
"""
struct IPC <: IPCLikeSystem end

"""
Abstract type representing a patent classification entry.
Specific implementations should at least implement `symbol(c::AbstractClassificationSymbol)`
and, if possible, also `title`.
"""
abstract type AbstractClassificationSymbol end

"""
Abstract type representing a patent classification entry following an `IPCLikeSystem`.
In addition to the interface for any `AbstractClassificationSymbol`, implementations should
implement `symbol(level, c)` for all levels of the classification.
"""
abstract type IPCLikeSymbol <: AbstractClassificationSymbol end

"""
Struct representing a minimal technology classification entry according to the CPC.
"""
struct CPCSymbol <: IPCLikeSymbol
    symbol::String
end
StructTypes.StructType(::Type{CPCSymbol}) = StructTypes.Struct()

"""
Struct representing a minimal technology classification entry according to the IPC.
"""
struct IPCSymbol <: IPCLikeSymbol
    symbol::String
end
StructTypes.StructType(::Type{IPCSymbol}) = StructTypes.Struct()

"""
Abstract type representing a level in a hierarchical technology classification system.
"""
abstract type AbstractClassificationLevel end

"""
Abstract type representing a level in an IPC-like technology classification system.
"""
abstract type AbstractIPCLikeClassificationLevel <: AbstractClassificationLevel end

"""Dispatch type referring to the section level of an IPC-like technology classification."""
struct Section <: AbstractIPCLikeClassificationLevel end

"""Dispatch type referring to the class level of an IPC-like technology classification."""
struct Class <: AbstractIPCLikeClassificationLevel end

"""Dispatch type referring to the subclass level of an IPC-like technology classification."""
struct Subclass <: AbstractIPCLikeClassificationLevel end

"""Dispatch type referring to the group level of an IPC-like technology classification."""
struct Maingroup <: AbstractIPCLikeClassificationLevel end

"""Dispatch type referring to the subgroup level of an IPC-like technology classification."""
struct Subgroup <: AbstractIPCLikeClassificationLevel end

"""
Struct representing a database filter by IPC-like classification.

Parameters:

* `system::IPCLikeSystem`: The classification system used. Can be either `IPC()` or `CPC()`.
* `level::AbstractIPCLikeClassificationLevel`: The level at which to filter (`Section()`, `Class()`, `Subclass()` etc.)
* `symbols::Vector{<:IPCLikeSymbol}`: An array of all classifications included. The filter will match any application classified by at least one of these.
"""
struct ClassificationFilter <: AbstractFilter
    system::IPCLikeSystem
    level::AbstractIPCLikeClassificationLevel
    symbols::Vector{<:IPCLikeSymbol}
end

"""
    classification(a::AbstractApplication)
    classification(f::AbstractFamily)
    classification(c::AbstractClassificationSystem, a::AbstractApplication)
    classification(c::AbstractClassificationSystem, f::AbstractFamily)

Obtain a vector of technology classification entries for application `a` or family `f`
according to classification system `c`. Defaults to CPC if no system is specified.
"""
function classification end

function classification(
    c::AbstractClassificationSystem,
    a::AbstractApplication
)::Vector{<:AbstractClassificationSymbol}
    throw(ArgumentError("$(typeof(a)) does not contain classification information for classification system $(typeof(c))"))
end

function classification(
    c::AbstractClassificationSystem,
    f::AbstractFamily
)::Vector{<:AbstractClassificationSymbol}
    reduce(vcat, classification.(Ref(c), applications(f))) |> unique
end

classification(a::AbstractApplication) = classification(CPC(), a)
classification(f::AbstractFamily) = classification(CPC(), f)

"""
    symbol(c::AbstractClassificationSymbol)
    symbol(::AbstractClassificationLevel, c::AbstractClassificationSymbol)

Return a `String` representation of a classification symbol `c` down to a specified level `l`.
If no level is specified, the complete symbol is returned.
"""
function symbol end

function symbol(c::AbstractClassificationSymbol)
    throw(ArgumentError("No symbol information available for instances of $(typeof(c))"))
end

symbol(c::IPCLikeSymbol) = c.symbol
symbol(::Section, c::IPCLikeSymbol) = first(symbol(c), 1)
symbol(::Class, c::IPCLikeSymbol) = first(symbol(c), 3)
symbol(::Subclass, c::IPCLikeSymbol) = first(symbol(c), 4)
symbol(::Maingroup, c::IPCLikeSymbol) = first(split(symbol(c), "/"))
symbol(::Subgroup, c::IPCLikeSymbol) = symbol(c)

"""
    title(::AbstractClassificationLevel, c::AbstractClassificationSymbol)

Return a `String` containing the full title of a classification `c` down to a specified
level `l`.
"""
function title(::AbstractClassificationLevel, c::AbstractClassificationSymbol)
    throw(ArgumentError("No title information available for $(typeof(c))"))
end
