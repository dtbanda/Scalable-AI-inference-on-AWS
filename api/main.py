# main.py
from fastapi import FastAPI, HTTPException
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
from run_model import generate_response

app = FastAPI()

# Input schema for POST
class PromptRequest(BaseModel):
    prompt: str

# POST endpoint to generate a response from the model
@app.post("/generate")
async def generate(prompt_request: PromptRequest):
    try:
        response = generate_response(prompt_request.prompt)
        return {"response": response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# GET endpoint to serve HTML page
@app.get("/")
async def serve_home():
    with open ("index.html", "r") as f:
        html = f.read()
    return HTMLResponse(content=html)
