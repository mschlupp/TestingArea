# Setting up R evironment in conda. 
Run
`conda install -c r r`

## Learn R on Kaggle Titanic competition
Documented in the `Titanic - Getting started with R` notebook.

## Getting the R Kernel for the notebooks
I'll use Ubuntu 16.04 for this setup. 

- Follow [Instructions](http://irkernel.github.io/installation/#linux-panel). 
- However, don't use the R terminal command 
`install.packages(c(...))` 
- Instead use e.g. `conda install -c r r-rzmq` (equivalent commands for the other required packages).
- Install IRkernel with 
```
R
> IRkernel::installspec()
```

## Install helpful packages
- `conda install -c r r-stringr` reg expressions and strings
- `conda install -c r r-lubridate` helpful with dates
- `conda install -c r r-ggplot2` some plotting libs

In order to install googleVis run:
```
[] R
> install.packages('googleVis')
```

- `conda install -c r r-devtools`
- `conda install -c r r-jsonlite`
- `conda install -c r r-knitr`
- `conda install -c r r-shiny`
- `conda install -c r r-httpuv` (required by shiny, but check)

After this running the demo of googleVis didn't work...
So I tried:
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
```
This didn't work.
When running 
```
[] R
> library(googleVis)
> demo(googleVis)
```
I got the error: 
> /anaconda3/lib/libstdc++.so.6: version `GLIBCXX_3.4.21' not found

Fortunately, my system's library had the necessary version:
> strings /usr/lib/x86_64-linux-gnu/libstdc++.so.6 | grep LIBC

I removed the anaconda lib and set a symbolic link to the system library:
```
rm ~/anaconda3/lib/libstdc++.so.6
ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ~/anaconda3/lib/libstdc++.so.6
```
Voilà, it worked...