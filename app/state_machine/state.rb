module StateMachine
  # TODO: Rename to Select
  class State
    attr_reader :selected_index

    def initialize(selections, selected_index)
      raise 'no selections' if selections.nil? || selections.empty?

      @selections = selections
      select(selected_index)
    end

    def action(window)
      key = Key.new(window.getch)

      begin
        @next_state =
          case key.button
          when :up
            self.class.new(@selections, selected_index-1)
          when :down
            self.class.new(@selections, selected_index+1)
          when :enter
            selected_index == 0 ?
              NewSessionState.new(selected_index) :
              Existing.new(selected_index, @selections[selected_index])
          when :quit
            Quit.new(selected_index)
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

    private

    def select(index)
      index = index.to_i

      if index < 0 || index > @selections.count - 1
        raise "index (#{index}) should be between 0 and #{@selections.count}"
      end

      @selected_index = index.to_i
    end
  end
end
