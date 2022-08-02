
"""
applicants(f::AbstractFamily)

return a `Vector{<:AbstractApplicant}` with the unique set of 
applicants from all the applications in family `f`.
"""
function applicants(f::AbstractFamily)::Vector{<:AbstractApplicant} 
    reduce(vcat, applicants.(applications(f)))
end
