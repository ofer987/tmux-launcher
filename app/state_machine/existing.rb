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

    def action(key)
      @commander.attach_to(@session_id)
      throw :quit
    end
  end
end
