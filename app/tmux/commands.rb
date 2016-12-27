module Tmux
  class Commands
    def initialize
    end

    def sessions
      lines = command

      if lines.nil? || (lines.count == 1 && empty_session?(lines.first))
        return []
      end

      lines.map { |line| Session.new(line) }
    end

    def attach(id)
      system("tmux attach -t #{id}")
    end

    private

    def command
      `tmux list-sessions`.split("\n")
    end

    def empty_session?(line)
      false
    end
  end
end
