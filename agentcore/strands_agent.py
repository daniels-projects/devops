from bedrock_agentcore import BedrockAgentCoreApp
from strands import Agent
from strands_tools import http_request

AGENT_SYSTEM_PROMPT="""
You can make https request to get weather information from National Weather Service API.

Make repsone human readable.
"""

app = BedrockAgentCoreApp()
agent = Agent(
    system_prompt=AGENT_SYSTEM_PROMPT,
    model="global.anthropic.claude-haiku-4-5-20251001-v1:0",
    tools=[http_request]
    )

@app.entrypoint
def invoke(payload):
    """Your AI agent function"""
    user_message = payload.get("prompt", "Hello! How can I help you today?")
    result = agent(user_message)
    return {"result": result.message}

if __name__ == "__main__":
    app.run()
