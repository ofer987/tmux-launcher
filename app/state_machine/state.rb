module StateMachine
  # TODO: Rename to Select
  class State
    attr_reader :selected_index

    def initialize(sessions, selected_index)
      raise 'no sessions' if sessions.nil? || sessions.empty?

      @sessions = sessions
      select(selected_index)
    end

    def session_id
      @sessions[@selected_index].id
    end

    def action(key)
      begin
        @next_state =
          case key.button
          when :up
            self.class.new(@sessions, selected_index-1)
          when :down
            self.class.new(@sessions, selected_index+1)
          when :enter
            Existing.new(session_id)
          when :quit
            Quit.new
          else
            self
          end
      rescue => exception
        logger.info(exception)
        @next_state = self
      end
    end

    def next_state
      @next_state
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
        raise "index (#{index}) should be between 0 and #{@sessions.count}"
      end

      @selected_index = index.to_i
    end
  end
end
