# How to use our cluster

Our cluster uses a scheduling system called SLURM. To submit jobs and monitor them, you will need to follow a few steps.

## How to run a job

We have the following python script (for Tensorflow 1.15) we wish to run on our cluster:

```python
# Import `tensorflow` 
import tensorflow as tf

# Initialize two constants
x1 = tf.constant([1,2,3,4])
x2 = tf.constant([5,6,7,8])

# Multiply
result = tf.multiply(x1, x2)

# Intialize the Session
sess = tf.Session()

# Print the result
print(sess.run(result))

# Close the session
sess.close()

```

We save this file at ```/home/<USERNAME>/``` as ```test.py```.

To send this code as a job to our cluster, we need to give the instructions using a specific bash file.
Here's an example of how to specify it.

```bash
#!/usr/bin/env bash
#SBATCH --job-name=test
#SBATCH --output=test%j.log
#SBATCH --error=test%j.err
#SBATCH --mail-user=<user>@ismll.de
#SBATCH --partition=STUD
#SBATCH --gres=gpu:1

echo "This is a test echo"
cd                         # navigate to the directory if necessary
srun python test.py        # python jobs require the srun command to work
```  

This will define the sequence of commands to run your task.  

We save this as ```test.sh```.  

This file specifies the instructions necessary to run your code. Your logs will be saved in the ```#SBATCH --output``` variable. ```%j``` will be replaced with your job id. You will receive notifications of this job in the email defined at ```#SBATCH --mail-user```. ```#SBATCH --gres=gpu:1``` means that one GPU will be allocated for your job.

After we created the bash file we can submit this job with:  
```
$ sbatch test.sh  
```  
You should receive a job id. This id is essential to locate your job.  

### How to run on CPU nodes?

In case you do not need GPU processing, you can use the CPU-only nodes.
To do so, make sure to remove the line: ```#SBATCH --gres=gpu:1``` and call the bash script like this:  
```
$ sbatch --exclude=gpu-[001-004] test.sh
```  


### Hints:  
If you have a specific environment, you might either add a command to activate it as in:  

```bash
source activate VIRTUALENV    
srun python test.py        # python jobs require the srun command to work
```
Or point to the python executable. For example, if you have a conda environment called TESTENV, you may call:
```bash
srun /path/to/anaconda/folder/envs/TESTENV/bin/python test.py
```
  
You can also set arguments to your bash by adding as a placeholder as such: ```srun python ${1}```  
Then we call it like this:  ```$ sbatch test.sh test.py ```



## Monitoring your Jobs

There a couple of slurm commands that will help you monitor your jobs:

### squeue
- This command displays the jobs in the queue and also the runtime of current jobs. Some variations might help further:  
```
$ squeue -u USER_NAME # filter jobs for a specific user
$ squeue -p STUD      # filter jobs for the student partition.
```  
- The NODELIST column will display which node is taking care of your job (after it has started). If it says "Resources," it means it is next to be assigned in its current partition.


### scancel
- This command cancels a job from the queue. Once a job is canceled, you will have to re-submit it.
```
$ scancel JOBID                      # cancels a job with a specified ID
$ scancel -u YOUR_USER_NAME          # cancels all jobs from your user
$ scancel -u YOUR_USER_NAME -p TEST  # cancels all jobs from your user in partition TEST
$ scancel -u YOUR_USER_NAME -p STUD  # cancels all jobs from your user in partition STUD
```

Check Slurm's documentation to customize these functions better.


## Fair Share

Our cluster always tracks how much you have used the cluster resources in the last two weeks.
The more you use, the less priority your jobs have. This means, if you used the resources for a long time, other students would be able to submit jobs ahead of you in the queue even if they scheduled them later.

To check your cluster-usage, use the command ```sshare``` to view your fair share (Higher is better) and usage (lower is better).
You can also add the ```-a``` option to compare with other users.