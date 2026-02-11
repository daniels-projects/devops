# Use AWS Lambda Python 3.11 base image
FROM public.ecr.aws/lambda/python:3.11

# Copy and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy Lambda handler and AIService
COPY agentcore/ai_service.py ./
