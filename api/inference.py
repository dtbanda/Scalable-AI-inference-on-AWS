import torch
from model_loader import model, tokenizer, streamer

def generate_response(prompt: str) -> str:
    # Tokenize prompt for chat template
    input_ids = tokenizer.apply_chat_template(
        [{"role": "user", "content": prompt}],
        add_generation_prompt=True,
        return_tensors="pt",
        tokenize=True,
    ).to(model.device)

    # Generate response
    output_ids = model.generate(
        input_ids,
        do_sample=True,
        temperature=0.3,
        min_p=0.15,
        repetition_penalty=1.05,
        max_new_tokens=512,
    )

    # Decode and return text
    decoded = tokenizer.decode(output_ids[0], skip_special_tokens=True)
    return decoded.split(prompt)[-1].strip()  # Strip prompt part from response
