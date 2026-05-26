const functions = require("firebase-functions");
const axios = require("axios");

exports.chatWithAI = functions.https.onRequest(async (req, res) => {
  try {
    const userMessage = req.body.message;

    const response = await axios.post(
      "https://api.openai.com/v1/chat/completions",
      {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: userMessage },
        ],
      },
      {
        headers: {
          Authorization: `Bearer YOUR_OPENAI_KEY`,
          "Content-Type": "application/json",
        },
      },
    );

    const aiReply = response.data.choices[0].message.content;

    res.json({ reply: aiReply });
  } catch (error) {
    res.status(500).send(error.toString());
  }
});
