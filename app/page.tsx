"use client";

import { useState } from "react";
import ChatMessage from "@/components/ChatMessage";
import ChatInput from "@/components/ChatInput";
import { sendMessage } from "@/lib/api";

type Message = {
  role: "user" | "bot";
  text: string;
};

export default function ChatPage() {
  const [messages, setMessages] = useState<Message[]>([]);
  const [loading, setLoading] = useState(false);

  async function handleSend(text: string) {
    setMessages((m) => [...m, { role: "user", text }]);
    setLoading(true);

    try {
      const res = await sendMessage(text);
      setMessages((m) => [...m, { role: "bot", text: res.reply }]);
    } catch {
      setMessages((m) => [
        ...m,
        { role: "bot", text: "Something went wrong." },
      ]);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="flex flex-col h-screen max-w-2xl mx-auto">
      <header className="p-4 border-b font-semibold">
        Chatbot
      </header>

      <main className="flex-1 overflow-y-auto p-4 space-y-3">
        {messages.map((msg, i) => (
          <ChatMessage key={i} {...msg} />
        ))}
        {loading && <ChatMessage role="bot" text="Typing…" />}
      </main>

      <ChatInput onSend={handleSend} loading={loading} />
    </div>
  );
}
