#!/bin/bash
data_dir="/workspace/linmaneechot/steam_data"
q3_dir="/workspace/linmaneechot/q3"

tar -xzf python39.tar.gz
tar -xzf packages.tar.gz

#python pip3 install --user pandas
#python import pandas
#curl https://files.pythonhosted.org/packages/71/65/3ab03ef46613e66880dba5b2c2cb5836938f0219389a11c10cfdc617e836/pandas-1.3.3.tar.gz > pandas.tar.gz
#tar -xzvf pandas.tar.gz

#python3 pandas-1.3.3/setup.py.install
#import pandas as pd
tar -xzf packages.tar.gz
export PATH=$PWD/python/bin:$PATH
export PYTHONPATH=$PWD/packages
export HOME=$PWD
module load python

python bagofwords.py  > output.txt
