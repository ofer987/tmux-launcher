module StateMachine
  class Quit
    def action(key)
      throw :quit
    end

    def next_state
    end

    def to_s
      ""
    end
  end
end
