

# George Papadopoulos - gip200@nyu.edu

LAB 3, Part 2
-------------

**Part 2: (40 pts)**
*Validation of security controls can be a huge overhead to an organization if done manually. Choose two of the controls to check on an hourly basis. One of the controls must check a value in the database (Oracle MySQL 8.0 :: 2.7, 2.9, or 4.2) This automated check should be implemented using Kubernetes Jobs which you can read about  [here](https://kubernetes.io/docs/concepts/workloads/controllers/job/). Again, you must document in your report, take screenshots of your output, and commit all files to your repo for grading.**

---

**Task/Job 1 - Check of Kubernetes Benchmark 5.7.2 - Ensuring that the seccomp profile is applied and not missed**

The goal of the task would be to check the pod for Seccomp profile, periodically using interactive shell to confirm it is responding appropriately. Seccomp is a security mechanism for Linux processes to filter system calls (syscalls) based on a set of defined rules. Applying seccomp profiles to containerized workloads is one of the key tasks when it comes to enhancing the security of the application deployment.

 We know from our remediation that if "Seccomp" is set to 0, then no seccomp profile is set, which would be bad. We can validate the application of seccomp inside the actual pod. We can get an interactive shell by giving the following commands, which then allows us to interrogate the seccomp state of the system.

    / # grep Seccomp /proc/1/status
    Seccomp:	2
    Seccomp_filters:	1
    / # 

So imagine enforcing a job to check containers to make sure someone hasn't forgotten to apply profiles. This is where this would be useful.

Configuration - Cron/Job File -  seccompcheck.yaml 

    apiVersion: batch/v1
    kind: CronJob
    metadata:
      name: seccomp
      namespace: lab3space
    spec:
      schedule: "*/1 * * * *"
      jobTemplate:
        spec:
          template:
            spec:
              containers:
                - name: assignment3-django-deploy
                  image: nyuappsec/assign3:v0
                  imagePullPolicy: IfNotPresent
                  command:
                  - /bin/sh
                  - -c
                  - date; echo "Hello from the Kubernetes cluster"; grep Seccomp /pr
    oc/1/status;
                  - pwd; ls; echo "after check";
                  - sleep 60;
    
              restartPolicy: OnFailure

Application Commands:

    kubectl create -f seccompcheck.yaml
     
    yuappsec@ubuntu:~/Appsec3$ kubectl get pods
    
    NAME                                         READY   STATUS      RESTARTS   AGE
    assignment3-django-deploy-57f56f9dc7-5p5gs   1/1     Running     0          22h
    mysql-container-85f6b9d89b-ll74s             1/1     Running     0          22h
    proxy-85f5bfff6b-6f6pm                       1/1     Running     0          22h
    seccomp-27518475-glvkm                       0/1     Completed   0          8s
    
    nyuappsec@ubuntu:~/Appsec3$ kubectl logs seccomp-27518475-glvkm
    Thu Apr 28 01:15:02 UTC 2022
    Hello from the Kubernetes cluster
    Seccomp:	0
    Seccomp_filters:	0


So we see here how we would be able to run a cron'd job in this case to check for seccomp compliance. In this particular case, perhaps the job could include the release of an email or some other strategic cron task to indicate the problem condition.


`kubectl delete cronjob seccomp` deletes the job(s)


![enter image description here](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-p2.1a.jpg?raw=true)


**Task/Job 2 - MySQL Control # 2.7 - Ensure ‘password_lifetime’ is Less Than or Equal to ‘365’ (or just NOT equal to 0)**

The goal of the task would be to check the MYSQL pod periodically using interactive shell AND SQL Monitor commands and parse the response to confirm the password polify is not set to "0" which would imply no expiration. As per the benchmark, unchanged passwords are a security risk.


 

    mysql> SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.global_variables where VARIABLE_NAME like 'default_password_lifetime';

 We know from our remediation that if default_password_lifetime is set to 0, then no password expiry is set. What is a little more complex here is that not only do we need to do the command in interactive shell, we need to collect it from the output of SQL monitor which must also pass SQL secrets to do the query and then parse/check it again our expectation (Not 0!).
 
    +---------------------------+----------------+
    | VARIABLE_NAME             | VARIABLE_VALUE |
    +---------------------------+----------------+
    | default_password_lifetime | 0              |
    +---------------------------+----------------+
    1 row in set (5.01 sec)

So again, here imagine enforcing a job to check containers to make sure someone hasn't forgotten to change the default password lifetime to something other than 0. This is where this would be useful.


Configuration - Cron/Job File -  seccompcheck.yaml 

    apiVersion: batch/v1
    kind: CronJob
    metadata:
      name: seccomp
      namespace: lab3space
    spec:
      schedule: "*/1 * * * *"
      jobTemplate:
        spec:
          template:
            spec:
              containers:
                - name: assignment3-django-deploy
                  image: nyuappsec/assign3:v0
                  imagePullPolicy: IfNotPresent
                  command:
                  - /bin/sh
                  - -c
                  - date; echo "Hello from the Kubernetes cluster"; grep Seccomp /pr
    oc/1/status;
                  - pwd; ls; echo "after check";
                  - sleep 60;
    
              restartPolicy: OnFailure

Application Commands:

    kubectl create -f seccompcheck.yaml
     
    yuappsec@ubuntu:~/Appsec3$ kubectl get pods
    
    NAME                                         READY   STATUS      RESTARTS   AGE
    assignment3-django-deploy-57f56f9dc7-5p5gs   1/1     Running     0          22h
    mysql-container-85f6b9d89b-ll74s             1/1     Running     0          22h
    proxy-85f5bfff6b-6f6pm                       1/1     Running     0          22h
    seccomp-27518475-glvkm                       0/1     Completed   0          8s
    
    nyuappsec@ubuntu:~/Appsec3$ kubectl logs seccomp-27518475-glvkm
    Thu Apr 28 01:15:02 UTC 2022
    Hello from the Kubernetes cluster
    Seccomp:	0
    Seccomp_filters:	0


So we see here how we would be able to run a cron'd job in this case to check for seccomp compliance. In this particular case, perhaps the job could include the release of an email or some other strategic cron task to indicate the problem condition.


`kubectl delete cronjob seccomp` deletes the job(s)


![enter image description here](https://github.com/gip200/gip200-appsec1/blob/main/Reports/Artifacts/gip200-appsec3-p2.1a.jpg?raw=true)


## END OF LAB 3, Part 2 SUBMISSION


