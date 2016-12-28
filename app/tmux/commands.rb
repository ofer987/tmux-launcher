module Tmux
  class Commands
    def initialize(executable=nil)
      @executable ||= `which tmux`.chomp
    end

    def sessions
      strings = `#{@executable} list-sessions`.split("\n")

      if strings.nil? || (strings.count == 1 && empty_session?(strings.first))
        return []
      end

      strings.map { |str| Session.new(str) }
    end

    def attach_to(id)
      system("#{@executable} attach -t #{id}")
    end

    def new_session(id)
      system("#{@executable} new-session -s #{id}")
    end

    def in_tmux?
      ENV.has_key?('TMUX')
    end

    private

    def empty_session?(line)
      false
    end
  end
end
