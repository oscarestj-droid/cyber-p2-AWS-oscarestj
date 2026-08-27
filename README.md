# AWS Cloud Security Portfolio (Weeks 5-10)
A comprehensive repository housing a structured, project-based collection of enterprise cloud security and automation configurations developed during the Innovation Fellowship in Cybersecurity at The Knowledge House. This portfolio tracks the progressive engineering of hardened architectures, automated logging pipelines, and infrastructure guardrails on Amazon Web Services (AWS) using Infrastructure as Code (IaC).

## Portfolio Structure & Milestones
The environment is organized chronologically by week to showcase a clear progression from basic cloud resource configuration to advanced corporate cloud governance:

*   **Week 5: Budgetary Guardrails & IAM Governance**
    *   *Labs:* Budget Setup, Setting up AWS budgets, managing permissions (IAM), and tracking state files.
*   **Week 6: Network Monitored Fortress**
    *   *Labs:* Secure VPC Architecture, Inline Wiretap Traffic Mirroring, Zero-Trust network segmentation, and perimeter defense configurations.
*   **Week 7: The Forge Integration & Secure Delivery Pipelines**
    *   *Labs:* CI/CD Security Pipeline building, Code Quality gates, and automated infrastructure delivery checks.
*   **Week 8: Fleet Management & Manifest Scans**
    *   *Labs:* Secure container orchestration,scanning software for known vulnerabilities, and active cloud fleet isolation.
*   **Week 9: Threat Radar & War Room Incident Response**
    *   *Labs:* AWS GuardDuty/CloudTrail integration, Athena forensic logging searches, and rapid threat mitigation playbooks.
*   **Week 10: Governance, Continuous Auditing & Compliance**
    *   *Labs:* AWS Config compliance engines, continuous configuration drift tracking, and NIST framework alignment.

## Core Technologies & Tooling
*   **Cloud Platform:** Amazon Web Services (AWS - IAM, VPC, EC2, S3, CloudTrail, GuardDuty, AWS Config, Athena)
*   **Infrastructure as Code (IaC):** Terraform (HashiCorp Configuration Language - HCL)
*   **DevSecOps & Automation:** GitHub Actions, Static Application Security Testing (SAST - tfsec / Trivy)
*   **Security & Monitoring:** Splunk Enterprise SIEM, Docker container environments, Bash Scripting

## Governance & Framework Alignment
Every architectural blueprint and automated script contained within this repository is mapped directly against the **NIST Cybersecurity Framework (CSF)** to demonstrate practical compliance engineering:
1.  **Identify / Protect:** Enforcing fine-grained IAM policies, resource isolation tags, and complete storage block public access rules.
2.  **Detect:** Deploying active configuration drift sensors, behavior tracking loops, and centralized logs.
3.  **Respond:** Executing automated firewall overrides and fast instance isolation routines during active-breach scenarios.

