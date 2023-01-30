# PatentsBase

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliapatents.github.io/PatentsBase.jl/dev/)

Abstract API for handling patent data.

## Purpose and scope of this package

This package defines an abstract interface for patent data analysis in Julia.
To that end, the package contains an abstract type hierarchy modelling the kinds 
of information usually contained in patent applications, as well as a set of
interface functions for interacting with that information.

Note that this package only defines an interface, but does not implement it.
Implementations should be hosted in separate packages and be specific to the
data source or format to be used. They should aim to implement as fully as
possible the interface defined herein.

Additional, task-specific extension packages may refer to and extend the PatentsBase 
interface. Implementation packages may choose which task-specific interfaces they
implement in addition to the base interface.

## Known implementations

- [PatentsLens](https://github.com/JuliaPatents/PatentsLens.jl): Reference implementation for using [lens.org](https://lens.org) data.

## Known extension packages

- [PatentsLandscapes](https://github.com/JuliaPatents/PatentsLandscapes.jl): Functions for taxonomy and statistical analysis of patent datasets.
