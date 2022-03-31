

# George Papadopoulos - gip200@nyu.edu

LAB 3, Part 1
-------------


## Part 1: Remediate Security Review Findings

The security team at your organization assessed the application deployment against a subset of security baselines and found that it failed most controls. Unfortunately for you, this applicaiton is a high priority, and you have been charged with remediating all the hits of the security review before deployment of the applicaiton. The  [`SecurityReview`](https://github.com/NYUJRA/AppSec3/tree/master/SecurityReview)  directory contains the controls, control number, results and remediation for each control. Additional information, and audit methods are available in the corresponding CIS Benchmarks in the  [`Benchmarks`](https://github.com/NYUJRA/AppSec3/tree/master/Benchmarks)  directory. It is important to research source documentation on proper implementation of the security controls, and perform testing to ensure the proper functionality of the application. Careful documentation of all modifications to the application and configurations in order to implement each control is critical for maintainability of the application and is requried for full credit.

### Task 1) Validate findings (1 pt each)

The security team has done their best to review the application and provide guidance on how to meet the security controls. They do not have a comprehensive knowledge of the application and could have made some mistakes in their review. For each control use the audit guide in the  [`Benchmarks`](https://github.com/NYUJRA/AppSec3/tree/master/Benchmarks)  directory to validate the findings of the security team. Take a screenshot of the result and document the steps you took

![enter image description here](https://github.com/gip200/gip200-appsec1/blob/main/Reports/Artifacts/gip200-lab3task1a.jpg?raw=true)

### Task 2) Remediate (1 pt each)

The security team gave remediation guidance for each failing control. Its your job to implement the remediation. This will requrie you to understand the controls intention as well as the technology used to implement the control. Document the steps you took to implement the control. Use  `git`  to ensure that the changes you make to any files are reflected in you repository

### Task 3) Verify finding resolution (1 pt each)

After each remediation, rebuild the affected container or reapply the affected kubernetes configuration and verify that the control is now passing per the audit guide. Take a screenshot of the result and document as necessary.



## END OF LAB 3, Part 1 SUBMISSION






