module StateMachine
  class Existing
    attr_reader :selected_index

    def initialize(selected_index, session_id)
      @commander = Tmux::Commands.new
      @selected_index = selected_index
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
