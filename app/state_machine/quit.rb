module StateMachine
  class Quit
    attr_reader :selected_index

    def initialize(selected_index)
      @selected_index = selected_index
    end

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
