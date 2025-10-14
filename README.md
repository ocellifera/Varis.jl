# Varis

[![CI](https://github.com/DisorderlyFields/Varis.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/DisorderlyFields/Varis.jl/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/DisorderlyFields/Varis.jl/graph/badge.svg?token=kyALKIpQ4P)](https://codecov.io/gh/DisorderlyFields/Varis.jl)
[![Format Check](https://github.com/DisorderlyFields/Varis.jl/actions/workflows/format.yml/badge.svg)](https://github.com/DisorderlyFields/Varis.jl/actions/workflows/format.yml)


varis is a symbolic math software that takes phase-field PDEs and discretizes them for FEM software.

## Motivation

A difficult and tedious problem in phase-field models is the coupling of physics, especially when using complex time-integration schemes. This turns derivations and implementations into several page ordeals, which introduces room for error. Additionally, changing the time-integration scheme often necessitates the rederivation of the PDEs and much more work.

The goal of varis is to eliminate manual discretization derivations and assist in the code generation for these PDEs, eliminating transcription errors and saving time.

## Installation

## Usage