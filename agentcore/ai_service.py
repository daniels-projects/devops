# agent_service.py
from bedrock_agentcore import BedrockAgentCoreApp
from strands import Agent
from strands_tools import http_request


MODEL_NAME = "global.anthropic.claude-haiku-4-5-20251001-v1:0"z
AGENT_SYSTEM_PROMPT = """
You can make HTTP requests to fetch weather, news, or other info.
Responses should be human-readable.
"""

class AIService:
    def __init__(self):
        self.app = BedrockAgentCoreApp()
        self.agent = Agent(
            system_prompt=AGENT_SYSTEM_PROMPT,
            model=MODEL_NAME,
            tools=[http_request]
        )

    def run(self, prompt: str):
        result = self.agent(prompt)
        return result.message

# Singleton instance (initialized once per container cold start)
ai_service = AIService()