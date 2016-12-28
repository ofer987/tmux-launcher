class Key
  def initialize(ch)
    @ch = ch
  end

  def button
    case @ch
    when 'j'
        :up
    when 'k'
      :down
    when 'o'
      :enter
    when 'q'
      :quit
    end
  end
end
