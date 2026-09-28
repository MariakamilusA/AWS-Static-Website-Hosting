# AWS Static Website Hosting - Internship Project

This repository contains the deliverables for the **AWS Static Website Hosting** task for the Codtech Cloud Computing Internship.

## Project Overview
This project demonstrates how to host a static website (HTML, CSS, JS) on Amazon Web Services (AWS) using Amazon S3. It showcases two distinct approaches to meet the project requirements:
1. **Manual Deployment (Basic Level):** Using the AWS Management Console to set up the infrastructure.
2. **Infrastructure as Code (Advanced Level):** Using Terraform to automate the provisioning and deployment.

## Files Included
- `index.html`, `styles.css`, `script.js`: The source code for the premium, modern static landing page.
- `main.tf`: The Terraform configuration file to automatically provision the AWS infrastructure.
- `README.md`: Project documentation and deployment instructions.

---

## Approach 1: Manual Deployment (AWS Console)
*This is the basic approach to deploy the website without any external tools.*

1. **Create an S3 Bucket:**
   - Go to the Amazon S3 console.
   - Click "Create bucket". Give it a globally unique name (e.g., `codtech-static-web-yourname`).
   - Scroll down to "Block Public Access settings for this bucket". **Uncheck "Block all public access"** and acknowledge the warning.
   - Click "Create bucket".

2. **Enable Static Website Hosting:**
   - Open your newly created bucket.
   - Go to the **Properties** tab.
   - Scroll down to **Static website hosting** at the bottom and click "Edit".
   - Select "Enable".
   - Enter `index.html` as the Index document.
   - Save changes.

3. **Upload Files:**
   - Go to the **Objects** tab.
   - Upload the `index.html`, `styles.css`, and `script.js` files provided in this repository.

4. **Add Bucket Policy (Make it public):**
   - Go to the **Permissions** tab.
   - Edit the **Bucket policy** and paste the following JSON (be sure to replace `YOUR-BUCKET-NAME` with your actual bucket name):
     ```json
     {
         "Version": "2012-10-17",
         "Statement": [
             {
                 "Sid": "PublicReadGetObject",
                 "Effect": "Allow",
                 "Principal": "*",
                 "Action": "s3:GetObject",
                 "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
             }
         ]
     }
     ```
5. **View Website:**
   - Go back to the **Properties** tab, scroll to the bottom, and click your **Bucket website endpoint** link to view your live site!

---

## Approach 2: Automated Deployment (Terraform)
*This is the advanced approach using Infrastructure as Code (IaC) to automatically set everything up.*

### Prerequisites
- Install [Terraform](https://developer.hashicorp.com/terraform/downloads).
- Install the [AWS CLI](https://aws.amazon.com/cli/) and configure it (`aws configure`) with your IAM user credentials.

### Steps
1. Open a terminal or command prompt in this project folder.
2. Initialize Terraform (this downloads the AWS provider):
   ```bash
   terraform init
   ```
3. Preview the infrastructure changes that Terraform will make:
   ```bash
   terraform plan
   ```
4. Deploy the infrastructure to AWS:
   ```bash
   terraform apply
   ```
   *Type `yes` when prompted to confirm.*
5. Once complete, Terraform will output a variable called `website_endpoint` in the terminal. Open that link in your browser to see your site!

### Cleanup
To avoid any unexpected AWS charges, destroy the resources when you are done testing:
```bash
terraform destroy
```
*(Type `yes` to confirm)*
