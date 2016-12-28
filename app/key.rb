class Key
  def initialize(ch)
    @ch = ch
  end

  def button
    case @ch
    when 'k'
        :up
    when 'j'
      :down
    when 'o'
      :enter
    when 'q'
      :quit
    end
  end
end
