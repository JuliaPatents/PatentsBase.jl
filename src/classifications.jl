"""
    AbstractClassificationSystem

Abstract type representing a system for technology classification of patents, such as the
Cooperative Patent Classification (CPC).
"""
abstract type AbstractClassificationSystem end
abstract type IPCLikeSystem <: AbstractClassificationSystem end

struct CPC <: IPCLikeSystem end
struct IPC <: IPCLikeSystem end

"""
    AbstractClassificationSymbol

Abstract type representing a patent classification entry.
Specific implementations should at least implement `symbol(c::AbstractClassificationSymbol)`
and, if possible, also `title`.
"""
abstract type AbstractClassificationSymbol end
abstract type IPCLikeSymbol <: AbstractClassificationSymbol end

"""
    CPCSymbol

Struct representing a minimal technology classification entry according to the CPC.
"""
struct CPCSymbol <: IPCLikeSymbol
    symbol::String
end

"""
    IPCSymbol

Struct representing a minimal technology classification entry according to the IPC.
"""
struct IPCSymbol <: IPCLikeSymbol
    symbol::String
end

"""
    AbstractClassificationLevel

Abstract type representing a level in a hierarchical technology classification system.
"""
abstract type AbstractClassificationLevel end
abstract type AbstractIPCLikeClassificationLevel <: AbstractClassificationLevel end

struct Section <: AbstractIPCLikeClassificationLevel end
struct Class <: AbstractIPCLikeClassificationLevel end
struct Subclass <: AbstractIPCLikeClassificationLevel end
struct Maingroup <: AbstractIPCLikeClassificationLevel end
struct Subgroup <: AbstractIPCLikeClassificationLevel end

"""
    classification(c::AbstractClassificationSystem, a::AbstractApplication)

Obtain a vector of technology classification entries for application `a` according to
classification system `c`.
"""
function classification(
    c::AbstractClassificationSystem,
    a::AbstractApplication
)::Vector{AbstractClassificationSymbol}
    throw(ArgumentError("$(typeof(a)) does not contain classification information for classification system $(typeof(c))"))
end

"""
    classifications(c::AbstractClassificationSystem, f::AbstractFamily)

Obtain a vector of technology classification entries for family `f` according to
classification system `c`.
"""
function classification(
    c::AbstractClassificationSystem,
    f::AbstractFamily
)::Vector{<:AbstractClassificationSymbol}
    reduce(vcat, (a -> classification(c, a)).(applications(f)))
end

classification(a::AbstractApplication) = classification(CPC(), a)
classification(f::AbstractFamily) = classification(CPC(), f)

function symbol(c::AbstractClassificationSymbol)
    throw(ArgumentError("No symbol information available for instances of $(typeof(c))"))
end

symbol(c::IPCLikeSymbol) = c.symbol
symbol(::Section, c::IPCLikeSymbol) = first(symbol(c), 1)
symbol(::Class, c::IPCLikeSymbol) = first(symbol(c), 3)
symbol(::Subclass, c::IPCLikeSymbol) = first(symbol(c), 4)
symbol(::Maingroup, c::IPCLikeSymbol) = first(split(symbol(c), "/"))
symbol(::Subgroup, c::IPCLikeSymbol) = symbol(c)

function title(::AbstractClassificationLevel, c::AbstractClassificationSymbol)
    throw(ArgumentError("No title information available for $(typeof(c))"))
end
