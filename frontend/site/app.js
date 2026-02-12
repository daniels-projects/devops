const messagesEl = document.getElementById("messages");
const inputEl = document.getElementById("input");
const sendBtn = document.getElementById("sendBtn");
const strandEl = document.getElementById("strand");

sendBtn.addEventListener("click", sendMessage);
inputEl.addEventListener("keydown", (e) => {
  if (e.key === "Enter") sendMessage();
});

async function sendMessage() {
  const text = inputEl.value.trim();
  if (!text) return;

  const strand = strandEl.value || "mentor";
  addMessage(text, "user");
  inputEl.value = "";

  let reply = "⚠️ Agent not connected yet.";

  try {
    const response = await fetch("/api/agent", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        prompt: text,
        strand: strand
      })
    });

    const data = await response.json();
    if (response.ok) {
      reply = data.body || reply;
    } else {
      reply = data.error || reply;
    }
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
