module Selections
  class Session
    attr_reader :id

    def initialize(line)
      line.match(regex) do |m|
        @id = m[1]
      end
    end

    def valid?
      true
    end

    def to_s
      @id.to_s
    end

    private

    def regex
      %r{^([^:]+):}
    end
  end
end
