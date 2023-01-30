var documenterSearchIndex = {"docs":
[{"location":"guide/#User-Guide-1","page":"User Guide","title":"User Guide","text":"","category":"section"},{"location":"guide/#","page":"User Guide","title":"User Guide","text":"Pages = [\"guide.md\"]","category":"page"},{"location":"guide/#","page":"User Guide","title":"User Guide","text":"(Under construction)","category":"page"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"CurrentModule = PatentsBase","category":"page"},{"location":"ref/#Interface-Reference-1","page":"Interface Reference","title":"Interface Reference","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"The reference is structured by topics. Each topic is subdivided into two sections: types and functions. An alphabetical Index is located at the bottom of the page.","category":"page"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"Pages = [\"ref.md\"]\nDepth = 3","category":"page"},{"location":"ref/#Documents-and-document-references-1","page":"Interface Reference","title":"Documents and document references","text":"","category":"section"},{"location":"ref/#Types-1","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractApplication\nPatentsBase.AbstractApplicationReference\nPatentsBase.AbstractApplicationID","category":"page"},{"location":"ref/#PatentsBase.AbstractApplication","page":"Interface Reference","title":"PatentsBase.AbstractApplication","text":"abstract type AbstractApplication\n\nAn abstract type representing an interface for a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractApplicationReference","page":"Interface Reference","title":"PatentsBase.AbstractApplicationReference","text":"abstract type AbstractApplicationReference\n\nAn abstract type representing a reference to a patent application. Implementations should be coupled with an implementation of  AbstractDataSource to allow lookup of the referenced application in the data source, using the find_application function.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractApplicationID","page":"Interface Reference","title":"PatentsBase.AbstractApplicationID","text":"abstract type AbstractApplicationID <: AbstractApplicationReference\n\nAn abstract type representing an interface for an application reference by jurisdiction, document number, and (optionally) kind. This is the preferred reference type to allow cross-referencing of applications across different data sources and formats.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-1","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.jurisdiction\nPatentsBase.doc_number\nPatentsBase.kind\nPatentsBase.id\nPatentsBase.sourceid\nPatentsBase.refers_to","category":"page"},{"location":"ref/#PatentsBase.jurisdiction","page":"Interface Reference","title":"PatentsBase.jurisdiction","text":"jurisdiction(a::AbstractApplication)\njurisdiction(a::AbstractApplicationID)\n\nReturn a String with the country code of the filing jurisdiction for the application a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.doc_number","page":"Interface Reference","title":"PatentsBase.doc_number","text":"doc_number(a::AbstractApplication)\ndoc_number(a::AbstractApplicationID)\n\nReturn a String with the jurisdiction-specific document number of the application a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.kind","page":"Interface Reference","title":"PatentsBase.kind","text":"kind(a::AbstractApplication)\nkind(a::AbstractApplicationID)\n\nReturn a String with the kind code of the application a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.id","page":"Interface Reference","title":"PatentsBase.id","text":"id(a::AbstractApplication)\nid(a::AbstractApplicationID)\n\nReturn a String with the original application ID, consisting of country code, document number and kind identifier.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.sourceid","page":"Interface Reference","title":"PatentsBase.sourceid","text":"sourceid(a::AbstractApplication)\nsourceid(a::AbstractApplicationID)\n\nReturn the id used in the data source, e.g. the lens_id for data obtained from Lens.org.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.refers_to","page":"Interface Reference","title":"PatentsBase.refers_to","text":"refers_to(ref::AbstractApplicationReference, app::AbstractApplication)\n\nReturn true if app is the application referenced by ref, and false otherwise. In cases where identity cannot be checked due to incompatible types, implementations should default to false. The abstract reference implementation always returns false.\n\nImplementation advice: There is no need to implement this for every possible combination of application and reference type. Usually, it will be enough to provide implementations for the application and reference types used by the same implementation package, and a generic implementation for AbstractApplicationID references.\n\n\n\n\n\n","category":"function"},{"location":"ref/#Document-contents-1","page":"Interface Reference","title":"Document contents","text":"","category":"section"},{"location":"ref/#Types-2","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractContent\nPatentsBase.AbstractTitle\nPatentsBase.AbstractShortDescription\nPatentsBase.AbstractClaim\nPatentsBase.AbstractClaims\nPatentsBase.AbstractFulltext","category":"page"},{"location":"ref/#PatentsBase.AbstractContent","page":"Interface Reference","title":"PatentsBase.AbstractContent","text":"abstract type AbstractContent\n\nAn abstract type representing an interface for content fields of a patent application. There are five abstract content fields that are subtypes of this type: AbstractTitle, AbstractShortDescription, AbstractClaim, AbstractClaims, and AbstractFulltext.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractTitle","page":"Interface Reference","title":"PatentsBase.AbstractTitle","text":"abstract type AbstractTitle <: AbstractContent\n\nAn abstract type representing an interface for the title(s) of a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractShortDescription","page":"Interface Reference","title":"PatentsBase.AbstractShortDescription","text":"abstract type AbstractShortDescription <: AbstractContent\n\nAn abstract type representing an interface for the abstract or short description of a patent. The type is deliberately not named \"AbstractAbstract\" to avoid confusion.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractClaim","page":"Interface Reference","title":"PatentsBase.AbstractClaim","text":"abstract type AbstractClaim <: AbstractContent\n\nAn abstract type representing an interface for a single claim associated with a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractFulltext","page":"Interface Reference","title":"PatentsBase.AbstractFulltext","text":"abstract type AbstractFulltext <: AbstractContent\n\nAn abstract type representing an interface for the full text of a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-2","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.languages\nPatentsBase.text\nPatentsBase.title(::AbstractApplication)\nPatentsBase.title(::AbstractApplication, ::String)\nPatentsBase.claims\nPatentsBase.abstract\nPatentsBase.fulltext","category":"page"},{"location":"ref/#PatentsBase.languages","page":"Interface Reference","title":"PatentsBase.languages","text":"languages(c::AbstractContent)\n\nReturns a Vector{String} with all languages for which a version of the content field c is available.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.text","page":"Interface Reference","title":"PatentsBase.text","text":"text(c::AbstractContent, lang::String)\n\nReturns a String with the localized version of the text of content field c for language lang. Concrete implementations should throw a Base.KeyError if there is no title for that locale.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.title-Tuple{AbstractApplication}","page":"Interface Reference","title":"PatentsBase.title","text":"title(a::AbstractApplication)\n\nReturn an AbstractTitle with information about the title of application a.\n\n\n\n\n\n","category":"method"},{"location":"ref/#PatentsBase.title-Tuple{AbstractApplication, String}","page":"Interface Reference","title":"PatentsBase.title","text":"title(a::AbstractApplication, lang::String)\n\nReturn a String with the localized title of application a for language lang.\n\n\n\n\n\n","category":"method"},{"location":"ref/#PatentsBase.claims","page":"Interface Reference","title":"PatentsBase.claims","text":"claims(a::AbstractApplication)\n\nReturn a Vector{<:AbstractClaim} with information on patent claims contained in application a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.abstract","page":"Interface Reference","title":"PatentsBase.abstract","text":"abstract(a::AbstractApplication)\n\nReturn an AbstractShortDescription with the abstract of application a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.fulltext","page":"Interface Reference","title":"PatentsBase.fulltext","text":"fulltext(a::AbstractApplication)\n\nReturn an AbstractFulltext with the full text of application a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#Citations-1","page":"Interface Reference","title":"Citations","text":"","category":"section"},{"location":"ref/#Types-3","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractCitation\nPatentsBase.AbstractPatentCitation\nPatentsBase.AbstractNPLCitation","category":"page"},{"location":"ref/#PatentsBase.AbstractCitation","page":"Interface Reference","title":"PatentsBase.AbstractCitation","text":"abstract type AbstractCitation\n\nAn abstract type representing an interface for a citation in a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractPatentCitation","page":"Interface Reference","title":"PatentsBase.AbstractPatentCitation","text":"abstract type AbstractPatentCitation <: AbstractCitation\n\nAn abstract type representing an interface for a citation of another patent document (NPL) in a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractNPLCitation","page":"Interface Reference","title":"PatentsBase.AbstractNPLCitation","text":"abstract type AbstractNPLCitation <: AbstractCitation\n\nAn abstract type representing an interface for a citation of non-patent literature (NPL) in a patent application.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-3","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.phase\nPatentsBase.reference\nPatentsBase.bibentry\nPatentsBase.external_ids\nPatentsBase.doi\nPatentsBase.citations\nPatentsBase.forwardcitations\nPatentsBase.citationgraph","category":"page"},{"location":"ref/#PatentsBase.phase","page":"Interface Reference","title":"PatentsBase.phase","text":"phase(c::AbstractCitation)\n\nReturn a String specifying the phase in the patent process during which the citation c occured.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.reference","page":"Interface Reference","title":"PatentsBase.reference","text":"reference(c::AbstractPatentCitation)\n\nReturn an AbstractApplicationReference for the application cited in c.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.bibentry","page":"Interface Reference","title":"PatentsBase.bibentry","text":"bibentry(c::AbstractNPLCitation)\n\nReturns a String with the bibliography entry of the NPL citation c.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.external_ids","page":"Interface Reference","title":"PatentsBase.external_ids","text":"external_ids(c::AbstractNPLCitation)\n\nReturns a Vector{String} with the external database IDs recorded for the NPL citation c.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.doi","page":"Interface Reference","title":"PatentsBase.doi","text":"doi(c::AbstractNPLCitation)\n\nReturns a String with the Digital Object Identifier (DOI) for NPL citation c. If multiple IDs matching the DOI format are found, the first is returned. Returns nothing if no ID field matches the DOI format.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.citations","page":"Interface Reference","title":"PatentsBase.citations","text":"citations(a::AbstractApplication[, type::AbstractCitationType])\ncitations(f::AbstractFamily[, type::AbstractCitationType])\n\nReturn a Vector{<:AbstractCitation} with all citations of the given type from a patent application a or family f.\n\ntype can either be PatentCitation() (default) or NPLCitation().\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.forwardcitations","page":"Interface Reference","title":"PatentsBase.forwardcitations","text":"forwardcitations(a::AbstractApplication)\nforwardcitations(f::AbstractFamily)\n\nReturn a Vector{<:AbstractPatentCitation} with citations of all patent applications known to cite a patent application or patent family. Note that even though these are represented by the AbstractPatentCitation interface, they are conceptually not citations in a strict sense.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.citationgraph","page":"Interface Reference","title":"PatentsBase.citationgraph","text":"citationgraph(applications::Vector{<:AbstractApplication})\ncitationgraph(families::Vector{<:AbstractFamily})\n\nReturn a SimpleDiGraph representing the network of citations among families or applications.\n\nNode numbers in the graph correspond to indices in the input array. An edge from node i to node j indicates that j cited i and will be included in the output graph if the publication date of j is after that of i.\n\n\n\n\n\n","category":"function"},{"location":"ref/#Parties-1","page":"Interface Reference","title":"Parties","text":"","category":"section"},{"location":"ref/#Types-4","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractParty\nPatentsBase.AbstractInventor\nPatentsBase.AbstractApplicant","category":"page"},{"location":"ref/#PatentsBase.AbstractParty","page":"Interface Reference","title":"PatentsBase.AbstractParty","text":"abstract type AbstractParty\n\nAn abstract type representing an interface for a patent application party. The two types of parties are applicants and inventors, represented by the types AbstractApplicant and AbstractInventor, respectively.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractInventor","page":"Interface Reference","title":"PatentsBase.AbstractInventor","text":"abstract type AbstractInventor <: AbstractParty\n\nAn abstract type representing an interface for an inventor.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractApplicant","page":"Interface Reference","title":"PatentsBase.AbstractApplicant","text":"abstract type AbstractApplicant <: AbstractParty\n\nAn abstract type representing an interface for a patent applicant.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-4","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.name\nPatentsBase.names\nPatentsBase.country\nPatentsBase.applicants\nPatentsBase.inventors","category":"page"},{"location":"ref/#PatentsBase.name","page":"Interface Reference","title":"PatentsBase.name","text":"name(p::AbstractParty)\n\nreturn the name of the party p.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.names","page":"Interface Reference","title":"PatentsBase.names","text":"names(a::AbstractParty)\n\nreturn a Vector{String} of all names under which party p is known to appear.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.country","page":"Interface Reference","title":"PatentsBase.country","text":"country(p::AbstractParty)\n\nreturn the country code of the country of residence of party p.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.applicants","page":"Interface Reference","title":"PatentsBase.applicants","text":"applicants(a::AbstractApplication)\n\nreturn a Vector{<:AbstractApplicant} with information about the applicant(s) of application a.\n\n\n\n\n\napplicants(f::AbstractFamily)\n\nreturn a Vector{<:AbstractApplicant} with the unique set of applicants from all the applications in family f.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.inventors","page":"Interface Reference","title":"PatentsBase.inventors","text":"inventors(a::AbstractApplication)\n\nreturn a Vector{<:AbstractInventor} with information about the inventor(s) of application a.\n\n\n\n\n\ninventors(f::AbstractFamily)\n\nreturn a Vector{<:AbstractInventor} with the unique set of inventors from all the applications in family f.\n\n\n\n\n\n","category":"function"},{"location":"ref/#Document-classifications-1","page":"Interface Reference","title":"Document classifications","text":"","category":"section"},{"location":"ref/#Types-5","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractClassificationSystem\nPatentsBase.IPCLikeSystem\nPatentsBase.CPC\nPatentsBase.IPC\nPatentsBase.AbstractClassificationSymbol\nPatentsBase.IPCLikeSymbol\nPatentsBase.CPCSymbol\nPatentsBase.IPCSymbol\nPatentsBase.AbstractClassificationLevel\nPatentsBase.AbstractIPCLikeClassificationLevel\nPatentsBase.Section\nPatentsBase.Class\nPatentsBase.Subclass\nPatentsBase.Maingroup\nPatentsBase.Subgroup","category":"page"},{"location":"ref/#PatentsBase.AbstractClassificationSystem","page":"Interface Reference","title":"PatentsBase.AbstractClassificationSystem","text":"abstract type AbstractClassificationSystem\n\nAbstract type representing a system for technology classification of patents.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.IPCLikeSystem","page":"Interface Reference","title":"PatentsBase.IPCLikeSystem","text":"abstract type IPCLikeSystem <: AbstractClassificationSystem\n\nAbstract type representing a system for technology classification of patents that follows a structure similar to that of the International Patent Classification (IPC) or Cooperative Patent Classification (CPC).\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.CPC","page":"Interface Reference","title":"PatentsBase.CPC","text":"struct CPC <: IPCLikeSystem\n\nDispatch type referring to the Cooperative Patent Classification (CPC) classification system.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.IPC","page":"Interface Reference","title":"PatentsBase.IPC","text":"struct IPC <: IPCLikeSystem\n\nDispatch type referring to the International Patent Classification (IPC) classification system.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractClassificationSymbol","page":"Interface Reference","title":"PatentsBase.AbstractClassificationSymbol","text":"abstract type AbstractClassificationSymbol\n\nAbstract type representing a patent classification entry. Specific implementations should at least implement symbol.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.IPCLikeSymbol","page":"Interface Reference","title":"PatentsBase.IPCLikeSymbol","text":"abstract type IPCLikeSymbol <: AbstractClassificationSymbol\n\nAbstract type representing a patent classification entry following an IPCLikeSystem. In addition to the interface for any AbstractClassificationSymbol, implementations should implement symbol(l, c) and title(l, c) for all levels of the classification.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.CPCSymbol","page":"Interface Reference","title":"PatentsBase.CPCSymbol","text":"struct CPCSymbol <: IPCLikeSymbol\n\nCPCSymbol(symbol::String)\n\nStruct representing a minimal technology classification entry according to the CPC.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.IPCSymbol","page":"Interface Reference","title":"PatentsBase.IPCSymbol","text":"struct IPCSymbol <: IPCLikeSymbol\n\nIPCSymbol(symbol::String)\n\nStruct representing a minimal technology classification entry according to the IPC.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractClassificationLevel","page":"Interface Reference","title":"PatentsBase.AbstractClassificationLevel","text":"abstract type AbstractClassificationLevel\n\nAbstract type representing a level in a hierarchical technology classification system.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractIPCLikeClassificationLevel","page":"Interface Reference","title":"PatentsBase.AbstractIPCLikeClassificationLevel","text":"abstract type AbstractIPCLikeClassificationLevel <: AbstractClassificationLevel\n\nAbstract type representing a level in an IPC-like technology classification system.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.Section","page":"Interface Reference","title":"PatentsBase.Section","text":"struct Section <: AbstractIPCLikeClassificationLevel\n\nDispatch type referring to the section level of an IPC-like technology classification.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.Class","page":"Interface Reference","title":"PatentsBase.Class","text":"struct Class <: AbstractIPCLikeClassificationLevel\n\nDispatch type referring to the class level of an IPC-like technology classification.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.Subclass","page":"Interface Reference","title":"PatentsBase.Subclass","text":"struct Subclass <: AbstractIPCLikeClassificationLevel\n\nDispatch type referring to the subclass level of an IPC-like technology classification.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.Maingroup","page":"Interface Reference","title":"PatentsBase.Maingroup","text":"struct Maingroup <: AbstractIPCLikeClassificationLevel\n\nDispatch type referring to the group level of an IPC-like technology classification.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.Subgroup","page":"Interface Reference","title":"PatentsBase.Subgroup","text":"struct Subgroup <: AbstractIPCLikeClassificationLevel\n\nDispatch type referring to the subgroup level of an IPC-like technology classification.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-5","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.classification\nPatentsBase.symbol\nPatentsBase.title(::AbstractClassificationLevel, c::AbstractClassificationSymbol)","category":"page"},{"location":"ref/#PatentsBase.classification","page":"Interface Reference","title":"PatentsBase.classification","text":"classification(a::AbstractApplication)\nclassification(f::AbstractFamily)\nclassification(c::AbstractClassificationSystem, a::AbstractApplication)\nclassification(c::AbstractClassificationSystem, f::AbstractFamily)\n\nObtain a Vector{<:AbstractClassificationSymbol} with all classifications for application a or family f according to classification system c. Defaults to CPC if no system is specified.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.symbol","page":"Interface Reference","title":"PatentsBase.symbol","text":"symbol(c::AbstractClassificationSymbol)\nsymbol(l::AbstractClassificationLevel, c::AbstractClassificationSymbol)\n\nReturn a String representation of a classification symbol c down to a specified level l. If no level is specified, the complete symbol is returned.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.title-Tuple{AbstractClassificationLevel, AbstractClassificationSymbol}","page":"Interface Reference","title":"PatentsBase.title","text":"title(l::AbstractClassificationLevel, c::AbstractClassificationSymbol)\n\nReturn a String containing the full title of a classification c down to a specified level l.\n\n\n\n\n\n","category":"method"},{"location":"ref/#Document-collections-and-groups-1","page":"Interface Reference","title":"Document collections and groups","text":"","category":"section"},{"location":"ref/#Types-6","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractFamily\nPatentsBase.AbstractPortfolio","category":"page"},{"location":"ref/#PatentsBase.AbstractFamily","page":"Interface Reference","title":"PatentsBase.AbstractFamily","text":"abstract type AbstractFamily\n\nAn abstract type representing an interface for a patent family.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractPortfolio","page":"Interface Reference","title":"PatentsBase.AbstractPortfolio","text":"abstract type AbstractPortfolio\n\nAn abstract type representing an interface for an entity's patent portfolio.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-6","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.aggregate_families\nPatentsBase.applications(::AbstractFamily)\nPatentsBase.applications(::AbstractPortfolio)\nPatentsBase.siblings\nPatentsBase.owner","category":"page"},{"location":"ref/#PatentsBase.aggregate_families","page":"Interface Reference","title":"PatentsBase.aggregate_families","text":"aggregate_families(apps::Vector{<:AbstractApplication})\n\nAggregate the applications apps into an array of patent families.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.applications-Tuple{AbstractFamily}","page":"Interface Reference","title":"PatentsBase.applications","text":"applications(f::AbstractFamily)\n\nreturn a Vector{<:AbstractApplication} with all applications in family f.\n\n\n\n\n\n","category":"method"},{"location":"ref/#PatentsBase.applications-Tuple{AbstractPortfolio}","page":"Interface Reference","title":"PatentsBase.applications","text":"applications(p::AbstractPortfolio)\n\nreturn a Vector{<:AbstractApplication} with all applications in portfolio p.\n\n\n\n\n\n","category":"method"},{"location":"ref/#PatentsBase.siblings","page":"Interface Reference","title":"PatentsBase.siblings","text":"siblings(a::AbstractApplication)\n\nreturn a Vector{<:AbstractApplication} with references to all applications that are in the same family as a.\n\n\n\n\n\nsiblings(a::AbstractApplication, ds::AbstractDataSource)\n\nreturn a Vector{<:AbstractApplication} with all applications from the data source ds that are in the same family as a.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.owner","page":"Interface Reference","title":"PatentsBase.owner","text":"owner(p::AbstractPortfolio)\n\nreturn an AbstractApplicant representing the owner of portfolio p.\n\n\n\n\n\n","category":"function"},{"location":"ref/#Data-sources-and-document-lookup-1","page":"Interface Reference","title":"Data sources and document lookup","text":"","category":"section"},{"location":"ref/#Types-7","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractDataSource","category":"page"},{"location":"ref/#PatentsBase.AbstractDataSource","page":"Interface Reference","title":"PatentsBase.AbstractDataSource","text":"abstract type AbstractDataSource\n\nAn abstract type representing an interface for a patent data source. Data sources can be in-memory data structures, wrappers around databases or API consumers.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Functions-7","page":"Interface Reference","title":"Functions","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.applications(::AbstractDataSource)\nPatentsBase.families\nPatentsBase.find_application","category":"page"},{"location":"ref/#PatentsBase.applications-Tuple{AbstractDataSource}","page":"Interface Reference","title":"PatentsBase.applications","text":"applications(ds::AbstractDataSource[, filter::AbstractFilter], kwargs...)\n\nReturn a Vector{<:AbstractApplication} with all applications contained in ds. May take a long time and/or cause memory overflow for large out-of-memory data sources. If a filter is specified, only applications matching the filter are returned.\n\nOptional keyword arguments:\n\nignore_fulltext: If true, full text information will not be retrieved.   This may be used to improve runtime and memory footprint for large datasets.\n\n\n\n\n\n","category":"method"},{"location":"ref/#PatentsBase.families","page":"Interface Reference","title":"PatentsBase.families","text":"families(ds::AbstractDataSource[, filter::AbstractFilter], kwargs...)\n\nReturn a Vector{<:AbstractFamily} with all patent families contained in ds. May take a long time and/or cause memory overflow for large out-of-memory data sources. If a filter is specified, only families matching the filter are returned.\n\nOptional keyword arguments:\n\nignore_fulltext: If true, full text information will not be retrieved.   This may be used to improve runtime and memory footprint for large datasets.\n\n\n\n\n\n","category":"function"},{"location":"ref/#PatentsBase.find_application","page":"Interface Reference","title":"PatentsBase.find_application","text":"find_application(ref::AbstractApplicationReference, ds::AbstractDataSource)\n\nReturn the application referenced by ref if it is contained in the data source ds, otherwise return nothing.\n\n\n\n\n\nfind_application(c::AbstractPatentCitation, ds::AbstractDataSource)\n\nAttempt to retrieve the patent application referenced by the citation c from the data source ds and return it, or return nothing if it cannot be found.\n\n\n\n\n\n","category":"function"},{"location":"ref/#Database-filters-1","page":"Interface Reference","title":"Database filters","text":"","category":"section"},{"location":"ref/#Types-8","page":"Interface Reference","title":"Types","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"PatentsBase.AbstractFilter\nPatentsBase.AllFilter\nPatentsBase.IntersectionFilter\nPatentsBase.UnionFilter\nPatentsBase.ClassificationFilter\nPatentsBase.ContentFilter\nPatentsBase.SearchableContentField\nPatentsBase.TitleSearch\nPatentsBase.AbstractSearch\nPatentsBase.ClaimsSearch\nPatentsBase.FulltextSearch","category":"page"},{"location":"ref/#PatentsBase.AbstractFilter","page":"Interface Reference","title":"PatentsBase.AbstractFilter","text":"abstract type AbstractFilter\n\nAbstract type representing a filter that can be applied to an AbstractDataSource. In principle, any predicate that can apply to an application or patent family can be a filter. However, some filter options may not be implemented for all data sources. Filters are composable using the UnionFilter and IntersectionFilter structs and the corresponding | and & infix operators.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AllFilter","page":"Interface Reference","title":"PatentsBase.AllFilter","text":"struct AllFilter <: AbstractFilter\n\nPseudo-filter that matches all applications or families in a database.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.IntersectionFilter","page":"Interface Reference","title":"PatentsBase.IntersectionFilter","text":"struct IntersectionFilter <: AbstractFilter\n\nIntersectionFilter(a::AbstractFilter, b::AbstractFilter)\n\nStruct representing the intersection or conjunction of two AbstractFilters. As a shorthand syntax for this composition, the '&' operator may be used:\n\nfilter3 = filter1 & filter2 # intersection of filter1 and filter2\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.UnionFilter","page":"Interface Reference","title":"PatentsBase.UnionFilter","text":"struct UnionFilter <: AbstractFilter\n\nUnionFilter(a::AbstractFilter, b::AbstractFilter)\n\nStruct representing the union or disjunction of two AbstractFilters. As a shorthand syntax for this composition, the '|' operator may be used:\n\nfilter3 = filter1 | filter2 # union of filter1 and filter2\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.ClassificationFilter","page":"Interface Reference","title":"PatentsBase.ClassificationFilter","text":"struct ClassificationFilter <: AbstractFilter\n\nClassificationFilter(\n    system::IPCLikeSystem,\n    level::AbstractIPCLikeClassificationLevel,\n    symbols::Vector{<:IPCLikeSymbol}\n)\n\nStruct representing a database filter by IPC-like classification.\n\nParameters:\n\nsystem: The IPCLikeSystem system used, such as  IPC or CPC.\nlevel: The AbstractIPCLikeClassificationLevel at which to filter (Section, Class, Subclass etc.)\nsymbols: A Vector{<:IPCLikeSymbol} of all classifications included. The filter will match any application classified by at least one of these.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.ContentFilter","page":"Interface Reference","title":"PatentsBase.ContentFilter","text":"struct ContentFilter <: AbstractFilter\n\nContentFilter(\n    search_query::String,\n    field::Union{SearchableContentField, Vector{<:SearchableContentField},\n    [languages::Vector{String}]\n)\n\nStruct representing a database filter using full-text search on various content fields.\n\nParameters:\n\nsearch_query: The keyword(s), phrase(s) or complex query to be used for the search.   Query syntax may vary across data sources, but should be broadly similar to   https://www.sqlite.org/fts5.html#fulltextquery_syntax.\nfield: Specifies which SearchableContentField(s) is/are used for the search.   Possible values are TitleSearch(), AbstractSearch(), ClaimsSearch(), or FulltextSearch().   A vector can be passed, in which case the constructor actually creates a UnionFilter.\nlanguages: Optional. A vector of two-character language codes specifying the languages for which matches are included.   If an empty vector is passed (as by default), all available languages are included.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.SearchableContentField","page":"Interface Reference","title":"PatentsBase.SearchableContentField","text":"abstract type SearchableContentField\n\nAbstract type representing a fulltext-searchable application content field.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.TitleSearch","page":"Interface Reference","title":"PatentsBase.TitleSearch","text":"struct TitleSearch <: SearchableContentField\n\nDispatch type referring to a search in the titles of documents.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.AbstractSearch","page":"Interface Reference","title":"PatentsBase.AbstractSearch","text":"struct AbstractSearch <: SearchableContentField\n\nDispatch type referring to a search in the abstract descriptions of documents.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.ClaimsSearch","page":"Interface Reference","title":"PatentsBase.ClaimsSearch","text":"struct ClaimsSearch <: SearchableContentField\n\nDispatch type referring to a search in the claims section of documents.\n\n\n\n\n\n","category":"type"},{"location":"ref/#PatentsBase.FulltextSearch","page":"Interface Reference","title":"PatentsBase.FulltextSearch","text":"struct FulltextSearch <: SearchableContentField\n\nDispatch type referring to a search in the full text of documents.\n\n\n\n\n\n","category":"type"},{"location":"ref/#Index-1","page":"Interface Reference","title":"Index","text":"","category":"section"},{"location":"ref/#","page":"Interface Reference","title":"Interface Reference","text":"","category":"page"},{"location":"#","page":"Home","title":"Home","text":"CurrentModule = PatentsBase","category":"page"},{"location":"#PatentsBase.jl-1","page":"Home","title":"PatentsBase.jl","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Abstract API for handling patent data.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"This site contains general, implementation-agnostic documentation for the abstract API that  forms the base of the JuliaPatents ecosystem.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"You may instead be looking for:","category":"page"},{"location":"#","page":"Home","title":"Home","text":"PatentsLandscapes.jl documentation\nPatentsLens.jl documentation","category":"page"},{"location":"#Table-of-Contents-1","page":"Home","title":"Table of Contents","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Pages = [\"guide.md\", \"ref.md\"]\nDepth = 2","category":"page"}]
}