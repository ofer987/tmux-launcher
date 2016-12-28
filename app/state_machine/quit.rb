module StateMachine
  class Quit
    def action(window)
      raise ExitAction.new
    end

    def next_state
    end

    def to_s
      "Exit"
    end
  end
end
