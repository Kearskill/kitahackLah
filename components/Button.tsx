
type ButtonProps = {
  isLoading?: boolean;
  label: string;
  onClick: () => void;
};

export const Button = ({ isLoading, label, onClick }: ButtonProps) => {
  return (
    <button
      onClick={onClick}
      disabled={isLoading}
      className="relative flex items-center justify-center px-4 py-2 bg-brand-primary text-white rounded-sm 
                 hover:translate-y-[-2px] active:translate-y-0 transition-transform duration-200 ease-out-expo
                 disabled:opacity-70 disabled:cursor-not-allowed"
    >
      <span className={isLoading ? "opacity-0" : "opacity-100"}>{label}</span>
      {isLoading && (
        <div className="absolute inset-0 flex items-center justify-center">
          {/* Simple, functional spinner - no sparkles */}
          <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
        </div>
      )}
    </button>
  );
};