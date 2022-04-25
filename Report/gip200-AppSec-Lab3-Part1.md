

  

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


***Control # 5.2.1 - Minimize the admission of privileged containers***

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


***Control # 5.2.2 - Minimize the admission of containers wishing to share the host process ID namespace***

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

***Control # 5.2.3 - Minimize the admission of containers wishing to share the host IPC namespace***

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


***Control # 5.2.4 - Minimize the admission of containers wishing to share the host network namespace***

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

***Control # 5.2.5 - Minimize the admission of containers with allowPrivilegeEscalation***

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


 ***Control # 5.2.6 - Minimize the admission of root containers***

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


***Control # 5.2.7 - Minimize the admission of containers with the NET_RAW capability***

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

***Control # 5.4.1 - Prefer using secrets as files over secrets as environment variables***	


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












## END OF LAB 3, Part 1 SUBMISSION



