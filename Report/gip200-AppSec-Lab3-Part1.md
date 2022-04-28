
  

# George Papadopoulos - gip200@nyu.edu

LAB 3, Part 1
-------------


## Part 1: Remediate Security Review Findings

The security team at your organization assessed the application deployment against a subset of security baselines and found that it failed most controls. Unfortunately for you, this applicaiton is a high priority, and you have been charged with remediating all the hits of the security review before deployment of the applicaiton. The  [`SecurityReview`](https://github.com/NYUJRA/AppSec3/tree/master/SecurityReview)  directory contains the controls, control number, results and remediation for each control. Additional information, and audit methods are available in the corresponding CIS Benchmarks in the  [`Benchmarks`](https://github.com/NYUJRA/AppSec3/tree/master/Benchmarks)  directory. It is important to research source documentation on proper implementation of the security controls, and perform testing to ensure the proper functionality of the application. Careful documentation of all modifications to the application and configurations in order to implement each control is critical for maintainability of the application and is requried for full credit.

### Task 1) Validate findings (1 pt each)

The security team has done their best to review the application and provide guidance on how to meet the security controls. They do not have a comprehensive knowledge of the application and could have made some mistakes in their review. For each control use the audit guide in the  [`Benchmarks`](https://github.com/NYUJRA/AppSec3/tree/master/Benchmarks)  directory to validate the findings of the security team. Take a screenshot of the result and document the steps you took

### Task 2) Remediate (1 pt each)

The security team gave remediation guidance for each failing control. Its your job to implement the remediation. This will requrie you to understand the controls intention as well as the technology used to implement the control. Document the steps you took to implement the control. Use  `git`  to ensure that the changes you make to any files are reflected in you repository

### Task 3) Verify finding resolution (1 pt each)

After each remediation, rebuild the affected container or reapply the affected kubernetes configuration and verify that the control is now passing per the audit guide. Take a screenshot of the result and document as necessary.

---
***Kubenetes Control # 5.2.1 - Minimize the admission of privileged containers***

A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

      kubectl get psp
      kubectl get psp unrestricted -o=jsonpath='{.spec.privileged}'**


This returns **unrestricted true** which means it permits privileged containers.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.1a.jpg?raw=true)

B) Remediate

To remediate, we will revoke the permission in the PSP and reapply the security policy with kubectl.

    kubectl edit psp unrestricted

We wil need to modify the PSP by setting the 

    privileged: true -> privileged: false

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.1b.jpg?raw=true)


C) Verify finding resolution

After modifying the configuration, we can review and see that the PSP shows there is no longer unrestricted privilege. 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.1c.jpg?raw=true)

---

***Kubenetes Control # 5.2.2 - Minimize the admission of containers wishing to share the host process ID namespace***

A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get psp unrestricted -o=jsonpath='{.spec.hostPID}'

This returns *true* which means sharing the host process ID namespace is permitted.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.2a.jpg?raw=true)

B) Remediate

To remediate, we will modify

    kubectl edit psp unrestricted

 changing the values of 

     hostPID: true -> hostPID: false 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.2b.jpg?raw=true)

C) Verify finding resolution

After changing hostPID configuration, if we run previous commands, we see that the PSP no longer returns true . This means we no longer permit sharing the host process ID namespace.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.2c.jpg?raw=true)
---

***Kubenetes Control # 5.2.3 - Minimize the admission of containers wishing to share the host IPC namespace***

A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get psp unrestricted -o=jsonpath='{.spec.hostIPC}'

This returns *true* which means we permit sharing the host IPC namespace.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.3a.jpg?raw=true)

B) Remediate

To remediate, we will modify

    kubectl edit psp unrestricted

changing  `PSP's hostIPC: true -> hostIPC: false` 
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.3b.jpg?raw=true)

C) Verify finding resolution

After  hostIPC config change, we can run previous command and see that the PSP does not return true any longer for permit sharing of host IPC namespace.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.3c.jpg?raw=true)

---

***Kubenetes Control # 5.2.4 - Minimize the admission of containers wishing to share the host network namespace***

A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get psp unrestricted -o=jsonpath='{.spec.hostNetwork}'

This returns True and so we are permitting sharing the host network namespace.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.4a.jpg?raw=true)

B) Remediate

To remediate, we will modify

    kubectl edit psp unrestricted

changing  `PSP's hostNetwork: true -> hostNetwork: false` 
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.4b.jpg?raw=true)

C) Verify finding resolution

After hostNetwork config change, we can run previous command and see that the PSP does not return true any longer for permit sharing of hostNetwork namespace.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.4c.jpg?raw=true)

---
***Kubenetes Control # 5.2.5 - Minimize the admission of containers with allowPrivilegeEscalation***

A) Validate findings
As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get psp unrestricted -o=jsonpath='{.spec.allowPrivilegeEscalation}'


This returns True and so we are permitting privilege escalation.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.5a.jpg?raw=true)

B) Remediate

To remediate, we will modify

    kubectl edit psp unrestricted

changing  `PSP's allowPrivilegeEscalation: true -> allowPrivilegeEscalation: false` 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.5b.jpg?raw=true)

C) Verify finding resolution

After allowPrivilegeEscalation config change, we can run previous command and see that the PSP clearly returns false, no longer for permit  allowPrivilege Escalation.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.5c.jpg?raw=true)


---
 ***Kubenetes Control # 5.2.6 - Minimize the admission of root containers***

A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get psp unrestricted -o=jsonpath='{.spec.runAsUser.rule}'

This returns RunAsAny and so we are permitting unfettered root elevation.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.6a.jpg?raw=true)

B) Remediate

To remediate, we will modify

    kubectl edit psp unrestricted

changing  `PSP's runAsUser.rule: RunAsAny -> runAsUser.rule: MustRunAsNonRoot` 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.6b.jpg?raw=true)

C) Verify finding resolution

After runAsUser config change, we can run previous command and see that the PSP clearly returns MustRunAsNonRoot, no longer for permitting containers to be run as the root user. 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.6c.jpg?raw=true)


---
***Kubenetes Control # 5.2.7 - Minimize the admission of containers with the NET_RAW capability***

A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get psp unrestricted -o=jsonpath='{.spec.requiredDropCapabilities}'
    
Does not return anything, so we infort that NET_RAW is enabled by default.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.7a.jpg?raw=true)

We can see that this returns nothing and NET_RAW is not disabled.


B) Remediate


To remediate, we will modify

    kubectl edit psp unrestricted

adding the new lines    

    requiredDropCapabilities:
	        - ALL

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.7b.jpg?raw=true)

C) Verify finding resolution

After runAsUser config change, we can run previous command and see that the PSP clearly returns  ["ALL"], meaning containers are not permitted with the NET_RAW capability.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.2.7c.jpg?raw=true)

---
***Kubenetes Control # 5.4.1 - Prefer using secrets as files over secrets as environment variables***	


nyuappsec@ubuntu:~/Appsec3$ kubectl get all -o jsonpath='{range .items[?(@..secretKeyRef)]} {.kind} {.metadata.name} {"\n"}{end}' -A

 Pod assignment3-django-deploy-9fcdf596f-nx8pn 
 Deployment assignment3-django-deploy 
 ReplicaSet assignment3-django-deploy-9fcdf596f 
A) Validate findings

As per the CIS_Kubernetes_V1.20_Benchmark_v1.0.0_PDF, we check using

    kubectl get all -o jsonpath='{range .items[?(@..secretKeyRef)]} {.kind} {.metadata.name} {"\n"}{end}' -A
    
Returns a number of locations of concern using secrets as environmental variables:

     Pod assignment3-django-deploy-9fcdf596f-nx8pn 
     Deployment assignment3-django-deploy 
     ReplicaSet assignment3-django-deploy-9fcdf596f 

We know this infers that files are setting keys. We likely find that exact thing in ~/Appsec3/GiftcardSite/GiftcardSite/ssettings.py
 and views.py set “SECRET_KEY” variable whick we need to move to files.
    
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.4.1a.jpg?raw=true)

B) Remediate

- We take the SECRET_KEY value from file , and make it base 64 as follows:

'echo " kmgysa#fz+9(z1*=c0ydrjizk*7sthm2ga1z4=^61$cxcq8b$l" | base64'
  
Copy the file ~/Appsec3/GiftcardSite/k8/django-admin-pass-secret.yaml to create a new file, such as

cp django-admin-pass-secret.yaml django-secret-key.yaml

Edit to reflect the new base64 key, like so:

    apiVersion: v1
    kind: Secret
    metadata:
    name: secret-key
    type: Opaque
    data:
    secret-key: a21neXNhI2Z6KzkoejEqPWMweWRyaml6ayo3c3RobTJnYTF6ND1eNjEK
  
Rebuild the kubernetes file and confirm the secret is in minikube

    kubectl apply -f django-secret-key.yaml
    kubectl get secret
    kubectl describe secret-key

Add the following to ~/Appsec3/GiftcardSite/k8$/django-deploy.yaml

    - name: SECRET_KEY
    valueFrom:
    secretKeyRef:
    name: secret-key
    key: secret-key

Now we comment out SECRET_KEY in settings.py and restarti minicube allows the change to take place. 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.4.1b.jpg?raw=true)


C) Verify finding resolution

From kubectl get pod, name of pod, as it has changed, and once again check the env, as above. You should discover the SECRET_KEY is in the env, even though you commented/removed in the settings.py file. 

Further, we can confirm the website still works, but you will need to update the URL info as the proxy likely dynamically changed.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.4.1c.jpg?raw=true)

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.4.1d.jpg?raw=true)



---
**Kubenetes Control # 5.7.1 - Create administrative boundaries between resources using namespaces**

A) Validate findings

We confirm there are no working namespaces other than "default" and some administrative ones "kube-". We do this by running the following command. All pods fall into default.


    kubectl get namespaces



![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.7.1a.jpg?raw=true)

B) Remediate
We begin by implementing namespace "lab3space" 

    # lab3space.json file
    lab3space.yaml 
    apiVersion: v1
    kind: Namespace
    metadata:
     name: lab3space


 we then run kubectl create -f lab3space.yaml. We may choose to do this at minikube start for consistency.

   
We can confirm the establishment of the namespace. We then update each of the kubernetes yaml files, for example, on k8/proxy-deploy.yaml, we add the line 'namespace: lab3space'. We do this for all 3 pods (Giftcardsite/k8, proxy/k8 and db/k8)

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: proxy
      namespace: lab3space
      .
      .

We then must delete the deployed pods and redeploy them in the namespace as per the config and requirement and then redeploy the docker deploys, which will this time account for the changes in the yaml to set namespaces.

    minikube delete 
    docker image prune
    docker build -t nyuappsec/assign3:v0 .
    docker build -t nyuappsec/assign3-proxy:v0 proxy/
    docker build -t nyuappsec/assign3-db:v0 db/

After rebuilding, we make sure to create the namespace at startup and as such the pods will start in the correct namespace (in my case lab3space).

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.7.1b.jpg?raw=true)


C) Verify finding resolution

We confirm with "kubectl get namespaces" there is now an additional namespace called "lab3space" and that services and pods are now in that namespace. We need to use new additional command arguments in the form below to now reference pods. 

    kubectl get namespaces
    kubectl get pods -n lab3space 
    
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.7.1c.jpg?raw=true)


---
**Kubenetes Control # 5.7.2 - Ensure that the seccomp profile is set to docker/default in your pod definitions**

A) Validate findings

By default, seccomp profile is set to unconfined which means that no seccomp profiles are  
enabled. We check the pod definition files to look for the following to discover it is NOT in any of the pod definition files.

    securityContext:  
	    seccompProfile:  
		    type: RuntimeDefault

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.7.2a.jpg?raw=true)

B) Remediate

To each deployment file (db, Giftcardsite and proxy yaml deployment files we add the above text, in the containers/name area, as shown.


![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.7.2b.jpg?raw=true)


C) Verify finding resolution

We can validate the application of seccomp inside the actual pod. We can get an interactive shell by giving the following commands, which then allows us to interrogate the seccomp state of the system.


    kubectl exec -it proxy-85f5bfff6b-chm56 /bin/sh
    *kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.*
    
    / # 
    / # 
    / # grep Seccomp /proc/1/status
    Seccomp:	2
    Seccomp_filters:	1
    / # 

As we can see, we see that the Seccomp filter is on inside the docker. If you explicitly tell docker to run without Seccomp profile, you get 0.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-5.7.2c.jpg?raw=true)






---
**Docker Control # 4.1 - Ensure that a user for the container has been created**

A) Validate findings
To validate this matter, we need to check docker containers as per the following to see what containers start as 0, indicating root.

    docker ps --quiet | xargs --max-args=1 -I{} docker exec {} cat /proc/1/status | grep '^Uid:' | awk '{print $3}'
    # once logged in
    id


A cursory check with this command shows 3 of 4 running as 0.

We also can log in locally into the containers to show they are running processes as root, as well as their Dockerfiles

    kubectl exec -it proxy-85f5bfff6b-q9p42 /bin/sh

We note that in the proxy host, there is a user configured in the Dockerfile, but not applied. In the Django host, there is neither a user configured, nor is there a USER applied.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.1a.jpg?raw=true)

B) Remediate

To remediate, in the django host, we must add the following to the Dockerfile:

    RUN adduser -D django-app
    RUN chown -R django-app:django-app /vol
    RUN chmod -R 755 /vol/web
    RUN chown -R django-app:django-app /GiftcardSite
    USER django-app

To remediate, in the proxy host, we only must add the following to the Dockerfile, as the user is established:

    USER nginx

We can then rebuild the docker containers as necessary to apply:
```
docker build -t nyuappsec/assign3:v0 .
docker build -t nyuappsec/assign3-proxy:v0 proxy/
```

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.1b.jpg?raw=true)


C) Verify finding resolution

We can validate again within the docker instance itself that it is running the process as the console of the pod

    docker ps --quiet | xargs --max-args=1 -I{} docker exec {} cat /proc/1/status | grep '^Uid:' | awk '{print $3}'
    # once logged in
    id

This time we see the pod is running as django-user

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.1c.jpg?raw=true)


---
**Docker Control # 4.2 - Ensure that containers use only trusted base images**

A) Validate findings

We can review the existance of docker images by running the following commands to list the images and interrogate them. We find a number of images that are consistent with either standard images

    docker images
    
    docker history <imageName/ID>

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.2a.jpg?raw=true)

B) Remediate & C) Verify finding resolution

No remediation is necessary here as we are simply reviewing the images. In a real organization, we would have been periodically reviewing Docker images to confirm that these images are safe and do not  contain security vulnerabilities or malicious code. These images  
should be reviewed in line with organizational security policy.

---




**Docker Control # 4.3 - Ensure that unnecessary packages are not installed in the container**

A) Validate findings

First we list running instances of containers and their installed packages by executing the commands below:  

    docker ps --quiet  
    docker exec $INSTANCE_ID rpm -qa  
    # in our case, the ubuntu based packaging can be listed like so in minikube:
    docker exec -i <container_id_1>  dpkg -l


![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.3a.jpg?raw=true)


B) Remediate & C) Verify finding resolution

No remediation is necessary here as we are simply reviewing the packages. In a real organization, we would have been periodically reviewing packages to confirm that these images are safe and do not  contain security vulnerabilities or malicious code, and further, that no additional packages are loaded that may not be needed and may be used for exploit. These packages should be reviewed in line with organizational security policy.

---
**Docker Control # 4.9 - Ensure that COPY is used instead of ADD in Dockerfiles**

A) Validate findings

We can review the existance of COPY/ADD use in docker images by running the following commands to list the images and interrogate them. We find a number of images that are consistent with either standard images

    docker images
    docker history <imageName/ID>

Alternatively, given our small setup, we can interrogate our individual Dockerfile configs to see if ADD is used and look to correct. You could script a scrub of this sort for all Dockerfiles:

    more ./Dockerfile | grep ADD
    more proxy/Dockerfile | grep ADD
    more db/Dockerfile | grep ADD

	

In fact, we do find that the image for the db, has at least 3 instances of ADD. 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.9a.jpg?raw=true)

B) Remediate

The correction for this is to replace all ADD instructions with copy, in the db/Dockerfile. 

We can then rebuild the image accordingly

COPY should be used rather than ADD instructions in Dockerfiles.
![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.9b.jpg?raw=true)


C) Verify finding resolution

Using our methodology, we can see there are no active ADD commands in the dockerfiles (in our case, they were commented and replaced by COPY commands).

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.9c.jpg?raw=true)

---
**Docker Control # 4.10 - Ensure secrets are not stored in Dockerfiles**


A) Validate findings

Similar to previous 4.9, we can review the existance of secrets use in dockerfiles by running the following commands to list the images and interrogate them. We find a number of images that are consistent with either standard images

    docker images
    docker history <imageName/ID>

Alternatively, given our small setup, we can interrogate our individual Dockerfile configs to see if some common style of secrets is maintained in the dockerfiles and look to correct. You could script a scrub of this sort for all Dockerfiles:

    more ./Dockerfile | grep secret
    more proxy/Dockerfile | grep ADD
    more db/Dockerfile | grep ADD

Again, we do find that the image for the db, has an exposed credential injected into the environment appearing in the open:

    ENV MYSQL_ROOT_PASSWORD "thisisatestthing."

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.10a.jpg?raw=true)

B) Remediate

The method to correct this is similar to the secrets in Kub 5.4.1, where we want secrets in files, rather than environmental variables, creating a file similar to django-admin-pass-secret.yaml to create a new file, such as

Edit to reflect the new base64 encoded key, like so:

    apiVersion: v1
    kind: Secret
    metadata:
    name: secret-key
    type: Opaque
    data:
    secret-key: a21neXNhI2Z6KzkoejEqPWMweWRyaml6ayo3c3RobTJnYTF6ND1eNjEK
  
Rebuild the kubernetes file and confirm the secret is in minikube

    kubectl apply -f k8-secret-key.yaml
    kubectl get secret
    kubectl describe secret-key

Add the following to ~/Appsec3/db/k8/db-deployment.yaml

          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: k8-secret
                  key: MYSQL_ROOT_PASSWORD

Now we comment out PASSWORD in DB-DEPLOY and restart minicube allows the change to take place. We can then rebuild the image accordingly.


![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.10b.jpg?raw=true)


C) Verify finding resolution

Upon restarting our pods, we can open an interactive shell on the SQL pod. We see clearly that although we commented out the password in the Dockerfile, it is getting the secrets from the secrets keystore, the DB is able to start just fine and issuing and 'env' command clearly shows the password is in the environmental variable, but this time from yaml files.

    nyuappsec@ubuntu:~/Appsec3$ kubectl get pods
    NAME                                         READY   STATUS    RESTARTS   AGE
    assignment3-django-deploy-57f56f9dc7-5p5gs   1/1     Running   0          5m58s
    mysql-container-85f6b9d89b-ll74s             1/1     Running   0          5m59s
    proxy-85f5bfff6b-6f6pm                       1/1     Running   0          5m57s
    nyuappsec@ubuntu:~/Appsec3$ kubectl exec -it mysql-container-85f6b9d89b-ll74s /bin/sh
    kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
    # 
    # env | grep PASSWORD
    MYSQL_ROOT_PASSWORD=thisisatestthing.
    # 

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.10c.jpg?raw=true)

---
**Oracle MySQL 8.0 Control # 1.2 - Use Dedicated Least Privileged Account for MySQL Daemon/Service**

A) Validate findings

We want to establish what user is running the process the mysql and what permissions are available. We jump to the interactive shell on the pod and find that our typical UNIX "ps" is missing. So we must interrogate the matter differently. We do the following to find the process and then, what user owns the files. It is clear that based on the /proc filesystem, only the user mysql can be running this. Further, there is no sudo on the system.



    root@mysql-container-85f6b9d89b-ll74s:/# pidof mysqld | more
    1
    
    root@mysql-container-85f6b9d89b-ll74s:/# ls -al /proc/ | head 
    total 4
    dr-xr-xr-x 434 root  root     0 Apr 27 02:24 .
    drwxr-xr-x   1 root  root  4096 Apr 27 02:24 ..
    dr-xr-xr-x   9 mysql mysql    0 Apr 27 02:24 1
   
    root@mysql-container-85f6b9d89b-ll74s:/# tail /etc/passwd
    mysql:x:999:999::/home/mysql:/bin/sh



![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-1.2a.jpg?raw=true)

B) Remediate & C) Verify finding resolution

So while this is good, we do notice the user does allow interactive shell login, which would be good to remediate. As the user is established in the build, to fix this is quite involved and would require reimaging the docker image to perhaps alter the /etc/password to reflect a shell of /usr/sbin/nologin

    mysql:x:999:999::/home/mysql:/bin/sh
    #change to
    mysql:x:999:999::/home/mysql:/usr/sbin/nologin

---
**Oracle MySQL 8.0 Control # 2.3 - Dedicate the Machine Running MySQL**

A) Validate findings

We can presume based upon how the machine is named and the construct of our pods, that a container is dedicated for MySQL, however we need to look a little closer.  As per the previous problem, we can check that the user is running is mysql, the 'env' environment is also consistent with a database server.

    root@mysql-container-85f6b9d89b-ll74s:/# env | grep SQL
    MYSQL_MAJOR=8.0
    MYSQL_SERVICE_PORT_3306_TCP_ADDR=10.97.205.190
    MYSQL_ROOT_PASSWORD=thisisatestthing.
    MYSQL_SERVICE_SERVICE_HOST=10.97.205.190
    MYSQL_VERSION=8.0.28-1debian10
    MYSQL_SERVICE_PORT=tcp://10.97.205.190:3306
    MYSQL_DATABASE=GiftcardSiteDB
    MYSQL_SERVICE_PORT_3306_TCP=tcp://10.97.205.190:3306
    MYSQL_SERVICE_PORT_3306_TCP_PORT=3306
    MYSQL_SERVICE_SERVICE_PORT=3306
    MYSQL_SERVICE_PORT_3306_TCP_PROTO=tcp


B) Remediate & C) Verify finding resolution

Looking at ls -l /proc, we see mostly well know services that are standard as part of a typical build. We do, however, see a couple of, for whatever reason renamed processes that are showing up as only PID numbers.

    root@mysql-container-85f6b9d89b-ll74s:/# ls -al /proc/
    total 4
    dr-xr-xr-x 435 root  root     0 Apr 27 02:24 .
    drwxr-xr-x   1 root  root  4096 Apr 27 02:24 ..
    dr-xr-xr-x   9 mysql mysql    0 Apr 27 02:24 1
    dr-xr-xr-x   9 root  root     0 Apr 27 12:33 126
    dr-xr-xr-x   9 root  root     0 Apr 27 14:53 180

We know from previous benchmark that 1 is clearly mysqld. For 126 and 180, we are a little unsure. In a real production system, you might know what these are or have access to 'ps' or other tools to do the audit to completely know what these processes are.

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-2.3b.jpg?raw=true)


---
**Oracle MySQL 8.0 Control # 2.7 - Ensure ‘password_lifetime’ is Less Than or Equal to ‘365’**

A) Validate findings
To validate this, we need to connect to the DB, either internally (localhost) or from the django server by IP. Internally, it would look like this.

    root@mysql-container-85f6b9d89b-ll74s:/# mysql --host=localhost --user=root --password=thisisatestthing.
    mysql: [Warning] Using a password on the command line interface can be insecure.
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 8
    Server version: 8.0.28 MySQL Community Server - GPL
    
    mysql> SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.global_variables where VARIABLE_NAME like 'default_password_lifetime';
    +---------------------------+----------------+
    | VARIABLE_NAME             | VARIABLE_VALUE |
    +---------------------------+----------------+
    | default_password_lifetime | 0              |
    +---------------------------+----------------+
    1 row in set (5.01 sec)

We can see a password of 0 means no expiry, which may not be ideal (That said, expiring passwords of this form on real prod systems could be a serious problem causing random failures.


B) Remediate & C) Verify finding resolution

We issue the command `set persist default_password_lifetime = 365;` to the MySQL Monitor. Rechecking with the previous command shows us we now have adjusted password expiry to be more finite (1 year).

    mysql> set persist default_password_lifetime = 365;
    Query OK, 0 rows affected (0.96 sec)
     
    mysql> SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.global_variables where VARIABLE_NAME like 'default_password_lifetime';
    +---------------------------+----------------+
    | VARIABLE_NAME             | VARIABLE_VALUE |
    +---------------------------+----------------+
    | default_password_lifetime | 365            |
    +---------------------------+----------------+
    1 row in set (0.00 sec)

![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-2.7b.jpg?raw=true)




---
**Oracle MySQL 8.0 Control # 2.9 - Ensure Password Resets Require Strong Passwords**


A) Validate findings
To validate this, we need to connect to the DB, either internally (localhost) or from the django server by IP. Internally, it would look like this.

        root@mysql-container-85f6b9d89b-ll74s:/# mysql --host=localhost --user=root --password=thisisatestthing.
        mysql: [Warning] Using a password on the command line interface can be insecure.
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 8
        Server version: 8.0.28 MySQL Community Server - GPL
        
        mysql> SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.global_variables where VARIABLE_NAME in ('password_history', 'password_reuse_interval');
    +-------------------------+----------------+
    | VARIABLE_NAME           | VARIABLE_VALUE |
    +-------------------------+----------------+
    | password_history        | 0              |
    | password_reuse_interval | 0              |
    +-------------------------+----------------+
    2 rows in set (0.17 sec)



We can see a password of 0 means no password history or reuse is enforced, and this may not be ideal (That said, this password enforcement without aux controls on real prod systems could be a serious problem causing random failures.


B) Remediate & C) Verify finding resolution

We issue the command `mysql> SET PERSIST password_history = 5; mysql> SET PERSIST password_reuse_interval = 365;` to the MySQL Monitor. Rechecking with the previous command shows us we now have adjusted password reuse and history.

    mysql> SET PERSIST password_history = 5;
    Query OK, 0 rows affected (0.00 sec)
    
    mysql> SET PERSIST password_reuse_interval = 365;
    Query OK, 0 rows affected (0.00 sec)
    
    mysql> SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.global_variables where VARIABLE_NAME in ('password_history', 'password_reuse_interval');
    +-------------------------+----------------+
    | VARIABLE_NAME           | VARIABLE_VALUE |
    +-------------------------+----------------+
    | password_history        | 5              |
    | password_reuse_interval | 365            |
    +-------------------------+----------------+
    2 rows in set (0.01 sec)


![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-2.9b.jpg?raw=true)



---
**Oracle MySQL 8.0 Control # 4.2 - Ensure Example or Test Databases are Not Installed on Production Servers**



A) Validate findings
To validate this, we need to connect to the DB, either internally (localhost) or from the django server by IP. Internally, it would look like this.

        root@mysql-container-85f6b9d89b-ll74s:/# mysql --host=localhost --user=root --password=thisisatestthing.
        
    mysql> SELECT * FROM information_schema.SCHEMATA where SCHEMA_NAME not in ('mysql','information_schema', 'sys', 'performance_schema');
    +--------------+----------------+----------------------------+------------------------+----------+--------------------+
    | CATALOG_NAME | SCHEMA_NAME    | DEFAULT_CHARACTER_SET_NAME | DEFAULT_COLLATION_NAME | SQL_PATH | DEFAULT_ENCRYPTION |
    +--------------+----------------+----------------------------+------------------------+----------+--------------------+
    | def          | GiftcardSiteDB | utf8mb4                    | utf8mb4_0900_ai_ci     |     NULL | NO                 |
    +--------------+----------------+----------------------------+------------------------+----------+--------------------+
    1 row in set (2.62 sec) 


B) Remediate & C) Verify finding resolution

In our case, we see only one single DB instance, which is consistent. If there were inappropriate databases, we could drop them issue the following SQL statement to drop an example database:  

`DROP DATABASE <database name>;`


![image](https://github.com/gip200/gip200-appsec3/blob/main/Report/Artifacts/gip200-appsec3-4.2b.jpg?raw=true)

---

## END OF LAB 3, Part 1 SUBMISSION, ALL PARTS COMPLETED














