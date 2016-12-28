require 'curses'

class Main
  attr_accessor :arg

  def initialize(arg)
    self.arg = arg

    raise 'Cannot run nested Tmux session' if commander.in_tmux?
  end

  def run
    Curses.crmode

    state = initial_state
    window = display(state.to_s)

    begin
      loop do
        state = set_next_screen(window, state)
        window = display(state.to_s)
      end
    rescue ExitAction
      logger.info("Exiting")
      display("EXIT")
    rescue => exception
      logger.error(exception)
      logger.error(exception.backtrace)
    ensure
      Curses.close_screen
    end
  end

  private

  def initial_state
    StateMachine::State.new(sessions, 0)
  end

  def display(text)
    Curses::Window.new(0, 0, 0, 0).tap do |w|
      # w.box(?|, ?-)
      w.setpos(2, 0)
      w.addstr(text.to_s)

      # w.refresh
    end
  end

  def set_next_screen(window, state)
    state.action(window)
    window.close

    state.next_state
  end

  def sessions
    @sessions ||= ([NewSession.new] + commander.sessions)
  end

  def commander
    @commander ||= Tmux::Commands.new
  end
end
