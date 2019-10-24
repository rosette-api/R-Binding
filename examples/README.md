## Endpoint Examples

Each example file demonstrates one of the capabilities of the Rosette Platform.

## Running Examples In Docker Environment

You will need an API key to pass as a parameter to the example file.  See the [README](../README.md) section on *Rosette API Access
* for details.

```
git clone git@github.com:rosette-api/R-Binding.git
docker run -v $(pwd)/R-Binding:/R-Binding -it --entrypoint bash r-base
cd /R-Binding/examples/
apt-get update
apt-get install -y libcurl4-openssl-dev libssl-dev
Rscript -e "install.packages('httr')" -e "install.packages('optparse')"
Rscript ping.R --key 0123456789abcdef
```
