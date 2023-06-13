#!/usr/bin/env bash
#SBATCH --job-name=py_torch_test
#SBATCH --output=py_torch_test%j.log
#SBATCH --error=py_torch_test%j.err
#SBATCH --mail-user=bakhshaliyev@uni-hildesheim.de
#SBATCH --partition=STUD
#SBATCH --gres=gpu:1

cd ~/pytorch_test          # navigate to the directory if necessary
source activate pytorchenv
srun python main.py        # python jobs require the srun command to work

