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
    window = display(state)

    begin
      loop do
        state = set_next_screen(window, state)
        window = display(state)
      end
    rescue ExitAction
      logger.info("Exiting")
    rescue Interrupt => exception
      logger.info("Interrupted: exiting application")
    rescue => exception
      logger.error(exception)
      logger.error(exception.backtrace)
    ensure
      Curses.close_screen
    end
  end

  private

  def initial_state
    StateMachine::State.new(selections, 0)
  end

  def display(state)
    Curses::Window.new(0, 0, 0, 0).tap do |w|
      # w.box(?|, ?-)
      w.attrset(Curses::A_NORMAL)
      w.setpos(0, 0)
      w.addstr("TMUX Launcher")

      w.setpos(2, 0)

      i = -1
      selections.each do |selection|
        i += 1

        if i == state.selected_index
          w.attrset(Curses::A_UNDERLINE)
          w.addstr("> #{selection.to_s}")
        else
          w.addstr(selection.to_s)
        end

        w.addstr("\n") if i < selections.count - 1
        w.attrset(Curses::A_NORMAL)
      end

      display_help(w, 2 + selections.count + 3)

      w.setpos(2 + selections.count + 1, 0)
      w.addstr('Selection: ')
    end
  end

  def display_help(window, row)
    window.setpos(row, 0)

    window.addstr("Help\n")
    window.addstr("Quit\tq\n")
    window.addstr("Select\to, ENTER\n")
    window.addstr("Up\tk, \u2191\n")
    window.addstr("Down\tj, \u2193")
  end

  def set_next_screen(window, state)
    state.action(window)
    window.close

    state.next_state
  end

  def selections
    @selections ||= ([Selections::NewSession.new] + commander.sessions)
  end

  def commander
    @commander ||= Tmux::Commands.new
  end
end
