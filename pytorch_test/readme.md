# Basic setup of pytorch environment

## Setup  

First let's create our environment and install the required packages.  

Option 1 (doing it from scratch):  
```bash
$ conda create -n pytorchenv
$ conda activate pytorchenv
$ conda install pip
$ pip install -r requirements.txt
```  

Option 2 (importing an existing environment setup)  
```bash  
$ conda env create -f environment.yml # remember to append the path to the yml file if necessary
```

* Note that doing this from scratch might allow you to get updated packages. Importing existing environments will always created fixed versions, which can be helpful for version control.


## Creating our Bash file

Update the bash.sh file (or create a new one) with the correct paths and user email.

```bash
#!/usr/bin/env bash
#SBATCH --job-name=py_torch_test
#SBATCH --output=py_torch_test%j.log
#SBATCH --error=py_torch_test%j.err
#SBATCH --mail-user=REPLACE_USER_NAME@uni-hildesheim.de
#SBATCH --partition=STUD
#SBATCH --gres=gpu:1

cd ~/pytorch-test          # navigate to the directory if necessary
source activate pytorchenv
srun python main.py        # python jobs require the srun command to work

```  

## Downloading the data

Since our cluster nodes do not have internet connection, you need to run this script to download the data first. (Or download and upload to your folder). Make sure to use the same environment we just created and run the `downlaoddata.py` script.  

```bash
conda activate pytorchenv
python downaloddata.py

```  
This will create a folder called `data`. Make sure it is inside the `pytorch-test` folder. If you ran this on your local machine, do not forget to upload it first.

## Test it and run it

First we can do a test on our TEST partition:  
```
sbatch --partition=TEST ~/pytorch-test/bash.sh
```  

Check the error logs, if it runs fine just run it normally:  

```
sbatch ~/pytorch-test/bash.sh
```

## Hints: 

Remember to append `export PATH="/home/<USERNAME>/anaconda3/bin:$PATH"` to your `.bashrc`. If not, you can replace  
```bash
source activate pytorchenv
srun python main.py
```  
with
```bash
srun /home/<USERNAME>/anaconda3/envs/pytorchenv/bin/python main.py
```