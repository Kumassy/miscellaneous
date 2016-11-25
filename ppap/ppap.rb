# 素朴な実装
=begin
class PPAP
  attr_reader :list def initialize list
    @list = list
  end

  def + other # self.class.new(other.list.concat self.list.reverse)
    self.class.new(self.list.concat other.list.reverse)
  end

  def to_s
    @list.reverse.join(' ')
  end
end


apple_pen = PPAP.new(['Pen', 'Apple'])
pineapple_pen = PPAP.new(['Pen', 'Pineapple'])

puts apple_pen
puts pineapple_pen
puts apple_pen + pineapple_pen
=end

class PPAP
  attr_accessor :ppap_space
  def initialize
    @ppap_space = []
    @ppaps = {}
  end

  def I_have_a ingredient
    @ppap_space << ingredient
    puts "I have a #{ingredient}"
  end

  def uh! synthesis
    if @ppap_space.reverse.join(' ') != synthesis
      raise 'Invalid PPAP'
    end

    puts "uh! #{synthesis}"

    method_name = @ppap_space.reverse.join('_').downcase
    @ppaps[method_name] = create @ppap_space.dup

    define_singleton_method method_name do
      @ppaps[method_name]
      self.ppap_space = @ppaps[method_name]
    end

    @ppap_space = []
    # p @ppaps
    # p self.methods false
  end

  def to_s
    if @ppap_space.length > 0
      @ppap_space.reverse.join(' ')
    elsif @ppaps.length > 0
      @ppaps.join(' ')
    end
  end

  private
  def create list
    t = self.class.new
    t.ppap_space = list
    t
  end
end
