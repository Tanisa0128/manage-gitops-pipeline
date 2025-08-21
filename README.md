#  Manage & Deploy with GitOps

This repository demonstrates a **GitOps-based Continuous Delivery pipeline** that automates the process of building, pushing, and deploying containerized applications onto Kubernetes clusters.  

The workflow integrates **Docker Hub, Jenkins, GitHub Actions, kind, and Flux**, ensuring **end-to-end automation** from image build → cluster provisioning → GitOps bootstrap.

---

##  Key Highlights
- **Docker Image Build & Push**  
  - Uses a `Dockerfile` to create a lightweight container image.  
  - Images are pushed to **Docker Hub** for centralized storage.  

- **CI/CD Automation**  
  - **GitHub Actions** handles automated builds on commits.  
  - **Jenkins** pulls the latest Docker image and triggers deployment steps.  

- **Cluster Provisioning with kind**  
  - Local Kubernetes cluster is created using [kind](https://kind.sigs.k8s.io/).  
  - Configurations are templated using `kind-config-template.yaml`.  

- **GitOps with Flux**  
  - `bootstrap.sh` script installs **Flux** and bootstraps the GitOps workflow.  
  - Flux syncs this repository with the cluster (`clusters/$CLUSTER_NAME`) for **continuous delivery**.  

---
## 🔗 Integration with Deploy-with-GitOps
As part of the Jenkins pipeline, users can trigger a build with parameters to create a **new GitHub repository** for Flux configuration.  

- Flux YAML manifests are auto-generated during bootstrap.  
- These manifests are stored and managed in a separate repository: [deploy-with-gitops](https://github.com/Tanisa0128/deploy-with-gitops).  
- This separation of concerns (app repo vs GitOps config repo) ensures a **clean GitOps workflow** aligned with industry practices.

---

## 🛠 Tech Stack
- **Docker** – Containerization  
- **GitHub Actions & Jenkins** – CI/CD pipelines  
- **Kubernetes (kind)** – Local cluster provisioning  
- **Flux** – GitOps operator for continuous delivery  
- **Bash scripting** – Automation via `bootstrap.sh`  

---

## ⚙️ How It Works
1. **Build Phase**  
   - `Dockerfile` builds a container image with required DevOps tools (kubectl, Docker CLI, kind, flux).  
   - Image is pushed to **Docker Hub**.  

2. **Deploy Phase**  
   - **Jenkins** pulls the latest Docker image.  
   - Executes `bootstrap.sh`:
     - Creates a Kubernetes cluster with kind  
     - Installs Flux  
     - Bootstraps Flux with this GitHub repo for GitOps sync  

3. **GitOps in Action**  
   - Any updates to Kubernetes manifests in this repo are automatically deployed to the cluster.  
   - Flux ensures the cluster state matches Git state, enabling rollback & version control.  

---


