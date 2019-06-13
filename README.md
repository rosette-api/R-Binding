[![Build Status](https://travis-ci.org/rosette-api/R-Binding.svg?branch=develop)](https://travis-ci.org/rosette-api/R-Binding) ![](https://img.shields.io/cran/v/rosetteApi.svg?colorB=bright%20green&style=flat)

# R client Binding for Rosette API #

## Rosette API
The Rosette Text Analytics Platform uses natural language processing, statistical modeling, and machine learning to
analyze unstructured and semi-structured text across 364 language-encoding-script combinations, revealing valuable
information and actionable data. Rosette provides endpoints for extracting entities and relationships, translating and
comparing the similarity of names, categorizing and adding linguistic tags to text and more.

## Rosette API Access
- Rosette Cloud [Sign Up](https://developer.rosette.com/signup)
- Rosette Enterprise [Evaluation](https://www.rosette.com/product-eval/)

## Quick Start ##

### Installation ###
Install the module thru CRAN:
```
install.packages('rosetteAPI')
```

There may be times when the latest version is not yet available on CRAN.  In that case you can install from GitHub:
```
install_github("rosette-api/r-binding")
```

To check your installed version:

`> packageVersion("rosetteAPI")`


#### Examples
View small example programs for each Rosette endpoint
in the [examples](https://github.com/rosette-api/R-Binding/tree/develop/examples) directory.

#### Documentation & Support
- [Binding API](https://rosette-api.github.io/R-Binding/)
- [Rosette Platform API](https://developer.rosette.com/features-and-functions)
- [Binding Release Notes](https://github.com/rosette-api/R-Binding/wiki/Release-Notes)
- [Rosette Platform Release Notes](https://support.rosette.com/hc/en-us/articles/360018354971-Release-Notes)
- [Binding/Rosette Platform Compatibility](https://developer.rosette.com/features-and-functions?r#)
- [Support](https://support.rosette.com)
- [Binding License: Apache 2.0](https://github.com/rosette-api/R-Binding/blob/develop/LICENSE.txt)

## Binding Developer Information
If you are modifying the binding code, please refer to the [developer README](https://github.com/rosette-api/R-Binding/tree/develop/DEVELOPER.md) file.
