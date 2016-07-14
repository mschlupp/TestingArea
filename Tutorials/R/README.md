# Setting up R evironment in conda. 
Run
`conda install -c r r`

## Getting the R Kernel for the notebookds
I'll use Ubuntu 16.04 for this setup. 

- Follow [Instructions](http://irkernel.github.io/installation/#linux-panel). 
- However, don't use the R terminal command 
`install.packages(c(...))` 
- Instead use e.g. `conda install -c r r-rzmq` (equivalent commands for the other requisites).
- Install IRkernel with 
```
R
> IRkernel::installspec()
```