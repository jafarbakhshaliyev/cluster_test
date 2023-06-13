# Cluster Etiquette

## Using our cluster has some specific rules to guarantee a healthy usage of our resources. Here are our 8 golden rules.

1. Unless you need to move files or update your environment, **never run scripts directly on the master node**.  
2. **Mind your space usage**. Your files share the same storage as other users. If you need more than 100 GB, please contact your advisor.  
3. **Make sure not to run each of your jobs for more than 24 hours**. Remember to add checkpointing to your code to avoid losing your experiment.  
4. Make sure to **monitor your jobs correctly and not to submit CPU jobs to our GPU nodes**. If you do not need GPUs, use the CPU nodes.  
5. If you need a specific package, install it locally on your home folder.  
6. You are allowed to test your code on the TEST partition, but **remember not to abuse of TEST submissions**.  
7. NEVER run malicious/ill-intended code or any software that might damage our cluster.
8. **NEVER share your password/login information with others**. Your user is attached to you, and anything that runs with your credentials will be your responsibility.

- Failure to follow these rules might get your access to our resources suspended or revoked.
