import boto3
import json
import os

agent_arn = os.environ.get("AGENT_ARN")
client = boto3.client('bedrock-agentcore', region_name='us-west-2')

# TODO
# Add AGENT ARN MAP
# MODE_AGENT_ARN_MAP = {
#     "finance": "",
#     "health": "",
#     "mentor": "",
#     "realtor": "",
# }

def lambda_handler(event, context):
    if not agent_arn:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Agent ARN not configured"})
        }

    # Convert body dict to JSON string, then to bytes for HTTP request
    payload = json.dumps(event["body"]).encode('utf-8')
    # strand = payload.get("strand", "default")
    # agent_arn = MODE_AGENT_ARN_MAP.get(strand)

    try:
        # Invoke agent runtime - this returns a streaming response
        response = client.invoke_agent_runtime(
            agentRuntimeArn=agent_arn,
            payload=payload
        )
        
        response_body = response['response'].read()
        response_data = json.loads(response_body)
        print("Agent Response:", response_data)
        
        return {
            "statusCode": 200,
            "body": json.dumps({"result": response_data["result"]["content"]})
        }
    except Exception as e:
        error_msg = str(e)
        print(f"Error invoking agent: {error_msg}")
        import traceback
        print(traceback.format_exc())
        
        return {
            "statusCode": 500,
            "body": json.dumps({"error": error_msg})
        }
