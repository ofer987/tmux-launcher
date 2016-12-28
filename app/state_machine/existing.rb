module StateMachine
  class Existing
    def initialize(session_id)
      @commander = Tmux::Commands.new
      @session_id = session_id
    end

    def to_s
      ""
    end

    def next_state
    end

    def action(window)
      @commander.attach_to(@session_id)
      raise ExitAction.new
    end
  end
end
