import json
import time
import urllib.error
import urllib.request


OLLAMA_URL = "http://localhost:11434/api/generate"
DEFAULT_MODEL = "llama3.2"


def generate_with_ollama(model_name, prompt):
    payload = json.dumps({
        "model": model_name,
        "prompt": prompt,
        "stream": False,
    }).encode("utf-8")

    request = urllib.request.Request(
        OLLAMA_URL,
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    with urllib.request.urlopen(request, timeout=300) as response:
        return json.loads(response.read().decode("utf-8"))


def benchmark_model(model_name, prompt):
    print(f"--- Benchmarking {model_name} ---")

    start_time = time.time()
    response = generate_with_ollama(model_name, prompt)
    end_time = time.time()

    # Calculate metrics
    duration = end_time - start_time
    # Note: 'eval_count' is the number of tokens in the response
    tokens = response.get('eval_count', 0)
    tps = tokens / duration if duration > 0 else 0

    print(f"Response: {response['response'][:100]}...") # Print first 100 chars
    print(f"\nTotal Tokens: {tokens}")
    print(f"Total Time: {duration:.2f}s")
    print(f"Speed: {tps:.2f} tokens/sec")
    print("-" * 30)

# Make sure you have run 'ollama pull llama3.2' first
if __name__ == "__main__":
    try:
        test_prompt = "Write a comprehensive Python script for testing a REST API using the Requests library."
        benchmark_model(DEFAULT_MODEL, test_prompt)
    except urllib.error.HTTPError as e:
        error_body = e.read().decode("utf-8", errors="replace")
        print("Error: Ollama returned an HTTP error.")
        print(f"Status: {e.code}")
        print(error_body)
        if e.code == 404 and "model" in error_body.lower():
            print(f"Run this first: ollama pull {DEFAULT_MODEL}")
    except urllib.error.URLError as e:
        print(f"Error: Cannot connect to Ollama at {OLLAMA_URL}. Make sure Ollama is running.")
        print(f"Details: {e}")
    except KeyError as e:
        print(f"Error: Ollama response was missing expected field: {e}")
