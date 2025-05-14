from flask import Flask, request, jsonify
import google.generativeai as genai
# from dotenv import load_dotenv
# load_dotenv()
import os

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

app = Flask(__name__)

with open("mess.txt", "r") as f:
    personal_info = f.read()

@app.route("/chat", methods=["POST"])
def chat():
    user_input = request.json.get("message")
    prompt = f"{personal_info}\n\nNgười dùng hỏi: {user_input}\nBạn trả lời:"
    model = genai.GenerativeModel("gemini-pro")
    response = model.generate_content(prompt)
    return jsonify({"response": response.text})

if __name__ == "__main__":
    app.run(debug=True)
