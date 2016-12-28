require 'curses'

class Main
  attr_accessor :arg

  def initialize(arg)
    self.arg = arg

    # raise 'Cannot run nested Tmux session' if commander.in_tmux?
    # RuTui::Theme.use :light
  end

  def run
    state = initial_state

    catch(:quit) {
      loop do
        state = set_next_screen(state)
      end
    }
    # if state.is_a? StateMachine::State
      #   manager.loop({ autofit: true, autodraw: true }) do |key|
      #     break if key == 'q' || key.ord == 97
      #     if key == 'o'
      #       commander.attach_to(state.session_id)
      #       break
      #     end
      #     if key == 'j'
      #       if i < sessions.count - 1
      #         i = (i + 1) % sessions.count
      #       end
      #     end
      #     if key == 'k'
      #       if i > 0
      #         i = (i - 1) % sessions.count
      #       end
      #     end
      #
      #     begin
      #       state = next_state(i)
      #     rescue => exception
      #     end
      #     set_next_screen(state)
      #   end
      # else
      #   set_next_screen(state)
      #
      #   str = ""
      #   manager.loop({ autofit: false, autodraw: true }) do |key|
      #     if key == ':'
      #       break
      #     end
      #
      #     set_next_screen(state, str)
      #     str += key
      #   end
      #
      #   commander.new_session(str)
      # end
    # end
  end

  private

  def initial_state
    StateMachine::State.new(sessions, 0)
  end

  def set_next_screen(state, text = "")
    Curses.crmode
    window = Curses::Window.new(0, 0, 0, 0)
    window.box(?|, ?-)
    window.setpos(2, 0)
    window.addstr(state.to_s)
    window.refresh
    key = Key.new(window.getch)
    state.action(key)
    window.close

    state.next_state
  end

  def next_state(index)
    if sessions.empty?
      StateMachine::NewSessionState.new
    else
      StateMachine::State.new(sessions, index)
    end
  end

  def manager
    # RuTui::ScreenManager
  end

  def sessions
    @sessions ||= commander.sessions
  end

  def commander
    @commander ||= Tmux::Commands.new
  end
end
