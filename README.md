<a href="https://www.rosette.com"><img src="https://s3.amazonaws.com/styleguide.basistech.com/logos/rosette-logo.png" width="181" height="47" /></a>

---

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
Command line example:

```
$ R -e 'install.packages("devtools")
$ cat > installrosette.R << EOF
> library(devtools)
> install_github("rosette-api/r-binding")
> q()
> EOF
$ R --no-save < installrosettte.R
```

If the version you are using is not [the latest from CRAN](https://cran.r-project.org/package=rosetteApi)
or [GitHub](https://github.com/rosette-api/R-Binding/releases),
you can verify the [**compatibilty with api.rosette.com**](https://developer.rosette.com/features-and-functions?r).
If you have an on-premise version of Rosette API server, please contact support for
binding compatibility with your installation.

To check your installed version:

`> packageVersion("rosetteAPI")`


#### Examples
View small example programs for each Rosette endpoint
in the [examples](https://github.com/rosette-api/R-Binding/tree/develop/examples) directory.

#### Documentation & Support
- [Binding API](https://cran.r-project.org/web/packages/rosetteApi/rosetteApi.pdf)
- [Rosette Platform API](https://developer.rosette.com/features-and-functions)
- [Binding Release Notes](https://github.com/rosette-api/R-Binding/wiki/Release-Notes)
- [Rosette Platform Release Notes](https://support.rosette.com/hc/en-us/articles/360018354971-Release-Notes)
- [Binding/Rosette Platform Compatibility](https://developer.rosette.com/features-and-functions?r#)
- [Support](https://support.rosette.com)
- [Binding License: Apache 2.0](https://github.com/rosette-api/R-Binding/blob/develop/LICENSE)

## Binding Developer Information
If you are modifying the binding code, please refer to the [developer README](https://github.com/rosette-api/R-Binding/tree/develop/DEVELOPER.md) file.
