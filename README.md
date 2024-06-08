# PearlThoughts Interview Assessment
# Scalable Notification Service Deployment on AWS

## Introduction

This project focuses on deploying a scalable, reliable, and maintainable notification system on AWS. The system consists of two primary microservices:
- **Notification API**: Receives notification requests and queues them.
- **Email Sender**: Processes messages from the queue and sends emails.

### Infrastructure as Code (IaC) Tools
We've used the following tools to provision infrastructure:
- Terraform

### Deployment:
- **Services**: Deploy the **Notification API** and **Email Sender** using AWS ECS Fargate.
- **Service Mesh**: Use AWS App Mesh for service mesh capabilities and AWS Cloud Map for service discovery.
- **Message Queue**: Use Amazon SQS to queue messages between services.
- **Docker Images**: Create and manage Docker images.

### Scalability and Reliability:
- Implement auto-scaling strategies based on CPU usage (70% threshold).
- Ensure system resilience and automatic recovery from failures.

### Observability:
- Set up monitoring and logging using AWS CloudWatch.
- Track key metrics such as queue length, processing times, and error rates.

### Security:
- Implement least-privilege IAM roles.
- Securely store sensitive information using AWS Secrets Manager or Parameter Store.

## Architecture

The architecture consists of:
- **Notification API** (ECS/Fargate): Receives requests and queues them.
- **Email Sender** (ECS/Fargate): Processes queued messages and sends emails.
- **AWS App Mesh**: Provides service mesh capabilities.
- **AWS Cloud Map**: Facilitates service discovery.
- **Amazon SQS**: Queues messages between the Notification API and Email Sender.
- **Amazon CloudWatch**: Monitors the system.

## Infrastructure as Code (IaC)
Provision the infrastructure using:
- **Terraform**

Ensure the IaC code adheres to best practices, is well-documented, and structured properly.

## Deployment Process
1. **Review Microservices**: Understand the provided Notification API and Email Sender microservices.
2. **Design Deployment**: Plan the deployment strategy considering scalability, reliability, and security.
3. **Create Dockerfiles**: 
   - Have created a Base docker image with dependencies
   - Build Notification service docker image: docker build . -f /apps/pt-notification-service/Dockerfile -t notification-api .
   - Build Email sender docker image: docker build . -f /apps/pt-notification-service/Dockerfile -t email-sender .
4. **Push to Amazon ECR**:
   - Login to ECR
   - Push the Docker images to the respective ECR repositories:
      docker tag notification-api:latest <account_id>.dkr.ecr.us-west-2.amazonaws.com/pt-notification-api:latest
      docker push <account_id>.dkr.ecr.us-west-2.amazonaws.com/notification-api:latest
      docker tag email-sender:latest <account_id>.dkr.ecr.us-west-2.amazonaws.com/pt-email-sender:latest
      docker push <account_id>.dkr.ecr.us-west-2.amazonaws.com/email-sender:latest
5. **Provision Infrastructure**: Use terraform to provision necessary AWS services.
      - terraform init
      - terraform fmt
      - terraform plan
      - terraform apply
6. **Deploy Services**: Deploy the microservices using AWS ECS Fargate.
7. **Implement Logging**: Ensure ECS tasks log application output to CloudWatch.
      - Cloudwatch log group created for both ECS services
8. **Auto-Scaling Configuration**: Implement auto-scaling based on 70% CPU usage threshold.
      - ECS AutoScaling policies set for the target value of 70% CPU usage.
9. **Health Check**: 
   - Health checks identified.
      /api for Notification-service
      /api/notification/send-email for Email-sender
   - Configure ECS health check paths using the identified endpoints.
10. **Test and Verify**: All services have been tested and verified

---

# NotificationWorkspace2

<a alt="Nx logo" href="https://nx.dev" target="_blank" rel="noreferrer"><img src="https://raw.githubusercontent.com/nrwl/nx/master/images/nx-logo.png" width="45"></a>

✨ **This workspace has been generated by [Nx, Smart Monorepos · Fast CI.](https://nx.dev)** ✨

## Integrate with editors

Enhance your Nx experience by installing [Nx Console](https://nx.dev/nx-console) for your favorite editor. Nx Console
provides an interactive UI to view your projects, run tasks, generate code, and more! Available for VSCode, IntelliJ and
comes with a LSP for Vim users.

## Start the application
Run `npm install` and 
Run `npx nx serve pt-notification-service` to start the development server. Happy coding!

## Build for production

Run `npx nx build pt-notification-service` to build the application. The build artifacts are stored in the output directory (e.g. `dist/` or `build/`), ready to be deployed.

## Running tasks

To execute tasks with Nx use the following syntax:

```
npx nx <target> <project> <...options>
```

You can also run multiple targets:

```
npx nx run-many -t <target1> <target2>
```

..or add `-p` to filter specific projects

```
npx nx run-many -t <target1> <target2> -p <proj1> <proj2>
```

Targets can be defined in the `package.json` or `projects.json`. Learn more [in the docs](https://nx.dev/features/run-tasks).

## Set up CI!

Nx comes with local caching already built-in (check your `nx.json`). On CI you might want to go a step further.

- [Set up remote caching](https://nx.dev/features/share-your-cache)
- [Set up task distribution across multiple machines](https://nx.dev/nx-cloud/features/distribute-task-execution)
- [Learn more how to setup CI](https://nx.dev/recipes/ci)

## Explore the project graph

Run `npx nx graph` to show the graph of the workspace.
It will show tasks that you can run with Nx.

- [Learn more about Exploring the Project Graph](https://nx.dev/core-features/explore-graph)

## Connect with us!

- [Join the community](https://nx.dev/community)
- [Subscribe to the Nx Youtube Channel](https://www.youtube.com/@nxdevtools)
- [Follow us on Twitter](https://twitter.com/nxdevtools)
