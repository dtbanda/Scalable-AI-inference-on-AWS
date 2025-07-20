from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from model_loader import model, tokenizer, streamer
from inference import generate_response

app = FastAPI(
    title="Liquid AI SLM API",
    description="A FastAPI service for generating responses using Liquid AI's LFM2 model.",
    version="1.0.0"
)

# Define request body
class PromptRequest(BaseModel):
    prompt: str

# Define response body
class PromptResponse(BaseModel):
    response: str

@app.post("/generate", response_model=PromptResponse)
async def generate(prompt_request: PromptRequest):
    try:
        response = generate_response(prompt_request.prompt)
        return {"response": response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
