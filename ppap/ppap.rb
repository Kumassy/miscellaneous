# 素朴な実装

class PPAP
  attr_reader :list
  def initialize list
    @list = list
  end

  def + other
    # self.class.new(other.list.concat self.list.reverse)
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

__END__
class PPAP
  def initialize
    @ppap_space = []
    @ppaps = {}
  end
  def I_have_a ingredient
    @ppap_space << ingredient
  end

  def uh! synthesis
    if @ppap_space.reverse.join(' ') != synthesis
      raise 'Invalid PPAP'
    end

    @ppaps[synthesis.to_sym] = @ppap_space.dup
  end
end


ppap = PPAP.new
ppap.I_have_a "Pen"
ppap.I_have_a "Apple"
ppap.uh! "Apple Pen"
ppap.I_have_a "Pen"
ppap.I_have_a "Pineapple"
ppap.uh! "Pineapple Pen"

ppap.
