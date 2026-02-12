# devops# AgentCore CI/CD Pipeline

**Automated deployment of Strand Agents to Amazon Bedrock AgentCore Runtime using GitHub Actions**

This repository provides a complete CI/CD solution for deploying AI agents built with the Strands framework to AWS Bedrock AgentCore Runtime using boto3 API calls with enhanced security and container optimization.

## What This Solution Does

### Agent Capabilities
The deployed agent can:
1. **Natural Conversations**: Powered by <model_name>4 model
2. **Mathematical Calculations**: Perform arithmetic operations using calculator tool
3. **Guardrail Protection**: Optional Bedrock guardrails for content filtering - tbd
4. **Tool Integration**: Easily add new tools and capabilities - tbd

## Architecture Overview

### Detailed Steps:
1. A developer commits code changes from their local repository to the GitHub repository. In this solution, the GitHub Action is triggered automatically. 
2. The GitHub Action triggers CodePipeline . 
3. Codepipline triggers build. 
4. CodeBuild invokes the command to build and push the agent container image to Amazon ECR directly from the Dockerfile. 
5. AgentCore Runtime instance will be created using the container image. 
7. The agent can further query the Bedrock Model and invoke tools as per its configuration.

# Project Structure

```
├── agent/                        # Agent implementation
│   ├── Dockerfile                 # Optimized container with security features
│   ├── strands_agent.py           # Main agent code (Claude + calculator tool)
│   └── requirements.txt           # Python dependencies
├── templates/                     # Deployment automation
│   ├── launch_ec2.yml              # AWS OIDC configuration
├── buildspec.yml                  # Codebuild 
└── README.md                      # 
```

helpful articles
https://aws.github.io/bedrock-agentcore-starter-toolkit/user-guide/runtime/quickstart.html#step-1-setup-project-and-install-dependencies