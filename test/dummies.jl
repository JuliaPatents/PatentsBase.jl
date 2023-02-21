
struct DummyID <: AbstractApplicationID
    id::String
end

PatentsBase.id(i::DummyID) = i.id
PatentsBase.sourceid(i::DummyID) = PatentsBase.id(i)

struct DummyCitation <: AbstractPatentCitation
    id::DummyID
end

DummyCitation(id::String) = DummyCitation(DummyID(id))
PatentsBase.reference(c::DummyCitation) = c.id

struct DummyApplication <: AbstractApplication
    id::DummyID
    date_published::Date
    citations::Vector{DummyCitation}
end

PatentsBase.id(a::DummyApplication) = id(a.id)
PatentsBase.sourceid(a::DummyApplication) = id(a)
PatentsBase.citations(a::DummyApplication, ::PatentCitation) = a.citations
PatentsBase.date_published(a::DummyApplication) = a.date_published

struct DummyFamily <: AbstractFamily
    apps::Vector{DummyApplication}
end

PatentsBase.applications(f::DummyFamily) = f.apps
