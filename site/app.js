const messagesEl = document.getElementById("messages");
const inputEl = document.getElementById("input");
const sendBtn = document.getElementById("sendBtn");

sendBtn.addEventListener("click", sendMessage);
inputEl.addEventListener("keydown", (e) => {
  if (e.key === "Enter") sendMessage();
});

async function sendMessage() {
  const text = inputEl.value.trim();
  if (!text) return;

  addMessage(text, "user");
  inputEl.value = "";

  // 🔗 AI AGENT ENDPOINT (replace later)
  let reply = "⚠️ Agent not connected yet.";
  
  // FORCE UI TEST
  // await new Promise(resolve => setTimeout(resolve, 800));
  // reply = "🤖 Fake agent responding correctly";

  try {
    const response = await fetch("/api/agent",
    {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message: text })
    });
    
    if (!response.ok) throw new Error("Bad response");
    const data = await response.json();
    print("response:", response)
    if (response.ok) {
      const data = await response.json();
      reply = data.reply || reply;
    }
    // ✅ THIS PROVES IT WORKS
    // print(`Fetched title: ${data}`)
    // reply = `Fetched title: ${data}`;

  } catch (err) {
    console.warn("Agent unavailable", err);
  }

  addMessage(reply, "agent");
}

function addMessage(text, role) {
  const div = document.createElement("div");
  div.className = `message ${role}`;
  div.textContent = text;
  messagesEl.appendChild(div);
  messagesEl.scrollTop = messagesEl.scrollHeight;
}
