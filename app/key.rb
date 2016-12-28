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
    when 'o', 10
      :enter
    when 'q'
      :quit
    else
      logger.info("Pressed key is #{@ch}")
    end
  end
end
