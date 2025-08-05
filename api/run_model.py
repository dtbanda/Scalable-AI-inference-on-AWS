# model.py
from transformers import AutoModelForCausalLM, AutoTokenizer, TextStreamer
import torch

model_id = "LiquidAI/LFM2-350M"

# Load model and tokenizer
model = AutoModelForCausalLM.from_pretrained(
    model_id,
    device_map="auto",
    torch_dtype=torch.bfloat16,
    trust_remote_code=True,
)

tokenizer = AutoTokenizer.from_pretrained(model_id)
streamer = TextStreamer(tokenizer, skip_prompt=True, skip_special_tokens=True)

def generate_response(prompt: str) -> str:
    messages = [{"role": "user", "content": prompt}]
    input_ids = tokenizer.apply_chat_template(
        messages,
        add_generation_prompt=True,
        return_tensors="pt",
        tokenize=True,
    ).to(model.device)

    output_ids = model.generate(
        input_ids,
        do_sample=True,
        temperature=0.3,
        min_p=0.15,
        repetition_penalty=1.05,
        max_new_tokens=256,
    )

    output_text = tokenizer.decode(output_ids[0], skip_special_tokens=True)
    return output_text.split(prompt, 1)[-1].strip()

