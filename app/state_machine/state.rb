module StateMachine
  class State
    def initialize(sessions, selected_index)
      raise 'no sessions' if sessions.nil? || sessions.empty?

      @sessions = sessions
      select(selected_index)
    end

    def session_id
      @sessions[@selected_index].id
    end

    def to_s
      index = -1
      @sessions.map do |session|
        index += 1

        index == @selected_index ?  "> #{session.to_s}" : session.to_s
      end.join("\n")
    end

    private

    def select(index)
      index = index.to_i

      if index < 0 || index > @sessions.count - 1
        raise "index should be between 0 and #{@sessions.count-1}"
      end

      @selected_index = index.to_i
    end
  end
end
