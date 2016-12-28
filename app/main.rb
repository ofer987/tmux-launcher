require 'rutui'

class Main
  attr_accessor :arg

  def initialize(arg)
    self.arg = arg

    raise 'Cannot run nested Tmux session' if commander.in_tmux?
    RuTui::Theme.use :light
  end

  def run
    i = 0
    state = next_state(i)
    set_next_screen(state)
    manager.set_current :default

    if state.is_a? StateMachine::State
      manager.loop({ autofit: true, autodraw: true }) do |key|
        break if key == 'q' || key.ord == 97
        if key == 'o'
          commander.attach_to(state.session_id)
          break
        end
        if key == 'j'
          if i < sessions.count - 1
            i = (i + 1) % sessions.count
          end
        end
        if key == 'k'
          if i > 0
            i = (i - 1) % sessions.count
          end
        end

        begin
          state = next_state(i)
        rescue => exception
        end
        set_next_screen(state)
      end
    else
      set_next_screen(state)

      str = ""
      manager.loop({ autofit: false, autodraw: true }) do |key|
        if key == ':'
          break
        end

        set_next_screen(state, str)
        str += key
      end

      commander.new_session(str)
    end
  end

  private

  def set_next_screen(state, text = "")
    RuTui::Screen.new.tap do |screen|
      # table = RuTui::Table.new({
      #   x: 1,
      #   y: 1,
      #   highlight_direction: :horizontal,
      #   table: [
      #     [1, 'foo', 'bar'],
      #     [2, 'Dan', 'Ofer']
      #   ],
      #   cols: [
      #     { title: 'ID', length: 3 },
      #     { title: 'Name', length: 10 },
      #     { title: 'Description', length: 10 }
      #   ],
      #   header: true,
      #   hover: 100,
      #   background: 255,
      #   foreground: 50
      # })
      #
      # screen.add(table)
      if state.is_a? StateMachine::State
        screen.add_static RuTui::Text.new(
          x: 0,
          y: sessions.count,
          text: "The selected index is #{state.selected_index}\n #{state.to_s}",
          background: 255,
          foreground: 100,
          hover: 100
        )
      else
        screen.add_static RuTui::Text.new(
          x: 0,
          y: 1,
          text: "Name of new session:\n#{text}",
          background: 255,
          foreground: 100,
          hover: 100
        )
      end

      manager.add(:default, screen)
    end
  end

  def next_state(index)
    if sessions.empty?
      StateMachine::NewSessionState.new
    else
      StateMachine::State.new(sessions, index)
    end
  end

  def manager
    RuTui::ScreenManager
  end

  def sessions
    @sessions ||= commander.sessions
  end

  def commander
    @commander ||= Tmux::Commands.new
  end
end
