## IDE
- RStudio
- VSCode with 'R Tools' extension

## Command Line Testing
```
cd /R-Binding/

$ Install dependencies
apt-get update
apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev
Rscript -e 'install.packages("devtools")' -e 'install.packages("knitr")' -e 'install.packages("lintr")' -e 'install.packages("optparse")'

# Run unit tests
Rscript -e 'devtools::test()'

$ Run CRAN submission checking
Rscript -e 'devtools::check()'

# Run lintr on package
Rscript -e 'lintr::lint_package()'

# Run lintr on example files
for file in $(ls examples/*.R); do echo "Rscript -e \"lintr::lint('$file')\"" >> lint_examples.sh; done
chmod a+x lint_examples.sh
./lint_examples.sh

# Run an example file
 (cd examples/; Rscript transliteration.R --key $API_KEY)
```
