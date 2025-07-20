from transformers import AutoModelForCausalLM, AutoTokenizer, TextStreamer

# Model selection
model_id = "LiquidAI/LFM2-350M"

# Load model
model = AutoModelForCausalLM.from_pretrained(
    model_id,
    device_map="auto",
    torch_dtype="bfloat16",
    trust_remote_code=True,
    # attn_implementation="flash_attention_2"  # Uncomment if supported
)

# Load tokenizer
tokenizer = AutoTokenizer.from_pretrained(model_id)

# Optional streamer (for future streaming API)
streamer = TextStreamer(tokenizer, skip_prompt=True, skip_special_tokens=True)
