#!/bin/bash

echo "Setting environment variables for CCPP-SCM on Hera with icc/ifort"

#load the modules in order to compile the CCPP SCM
echo "Loading intel and netcdf modules..."
module purge
module use /apps/contrib/NCEP/libs/hpc-stack/modulefiles/stack
module load hpc/1.1.0
module load hpc-intel/2018.4
module load hpc-impi/2018.4
module load netcdf/4.6.1

echo "Setting CC/CXX/FC environment variables"
export CC=icc
export CXX=icpc
export FC=ifort

echo "Setting NCEPLIBS environment variables"
module load bacio/2.4.1
module load sp/2.3.3
module load w3nco/2.4.1

echo "Loading cmake"
module load cmake/3.18.1
export CMAKE_C_COMPILER=icc
export CMAKE_CXX_COMPILER=icpc
export CMAKE_Fortran_COMPILER=ifort
export CMAKE_Platform=orion.intel

echo "Loading the python distribution"
module load python/3.7.5

#install f90nml for the local user

#check to see if f90nml is installed locally
echo "Checking if f90nml python module is installed"
python -c "import f90nml"

if [ $? -ne 0 ]; then
	echo "Not found; installing f90nml"
	pip install -e git://github.com/marshallward/f90nml.git@v0.19#egg=f90nml --user
else
	echo "f90nml is installed"
fi

#install shapely for the local user

#check to see if shapely is installed locally
echo "Checking if shapely python module is installed"
python -c "import shapely"

if [ $? -ne 0 ]; then
	echo "Not found; installing shapely"
	pip install --index-url http://anaconda.rdhpcs.noaa.gov/simple --trusted-host anaconda.rdhpcs.noaa.gov shapely --user
else
	echo "shapely is installed"
fi

#check to see if configobj is installed locally
echo "Checking if configobj python module is installed"
python -c "import configobj"

if [ $? -ne 0 ]; then
	echo "Not found; installing configobj"
	pip install --index-url http://anaconda.rdhpcs.noaa.gov/simple --trusted-host anaconda.rdhpcs.noaa.gov configobj --user
else
	echo "configobj is installed"
fi

#check to see if netCDF4 is installed locally
echo "Checking if netCDF4 python module is installed"
python -c "import netCDF4"

if [ $? -ne 0 ]; then
	echo "Not found; installing netCDF4"
	pip install --index-url http://anaconda.rdhpcs.noaa.gov/simple --trusted-host anaconda.rdhpcs.noaa.gov netCDF4 --user
else
	echo "netCDF4 is installed"
fi
