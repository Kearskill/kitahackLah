type Props = {
  role: "user" | "bot";
  text: string;
};

export default function ChatMessage({ role, text }: Props) {
  const isUser = role === "user";

  return (
    <div className={`flex ${isUser ? "justify-end" : "justify-start"}`}>
      <div
        className={`max-w-[75%] px-4 py-2 rounded-lg text-sm
        ${isUser
          ? "bg-blue-600 text-white"
          : "bg-gray-200 text-black"}`}
      >
        {text}
      </div>
    </div>
  );
}
