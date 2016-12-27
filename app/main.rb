require 'rutui'

class Main
  attr_accessor :arg

  def sessions
    @sessions ||= Tmux::Commands.new.sessions
  end

  def initialize(arg)
    self.arg = arg
  end

  def run
    manager.add :default, new_screen(0)
    manager.set_current :default

    i = 1
    manager.loop({ autofit: true, autodraw: true }) do |key|
      break if key == 'q' || key.ord == 97
      if key == 'o'
        Tmux::Commands.new.attach(@last_state.session_id)
        break
      end

      manager.add :default, new_screen(i % 2)
      i += 1
    end
  end

  private

  def new_screen(index)
    RuTui::Screen.new.tap do |screen|
      state = StateMachine::State.new(sessions, index)

      screen.add_static RuTui::Text.new(
        x: 0,
        y: 1,
        text: state.to_s
      )

      @last_state = state
    end
  end

  def manager
    RuTui::ScreenManager
  end
end
