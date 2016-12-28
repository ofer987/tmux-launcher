module StateMachine
  class NewSessionState
    def initialize
    end

    def action(window)
      name = window.getstr

      name = remove_prohibited_chars(name)

      commander.new_session(name)
    end

    def next_state
    end

    def to_s
      "Creating new session"
    end

    private

    def remove_prohibited_chars(name)
      name.gsub(%r{[:]}) { |m| '' }
    end

    def commander
      @commander ||= Tmux::Commands.new
    end
  end
end
