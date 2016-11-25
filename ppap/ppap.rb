# 素朴な実装
class PPAP
  attr_reader :list
  def initialize list
    @list = list
  end

  def + other
    self.class.new(other.list.concat self.list.reverse)
  end

  def to_s
    @list.join(' ')
  end
end


apple_pen = PPAP.new(['Pen', 'Apple'])
pineapple_pen = PPAP.new(['Pen', 'Pineapple'])

puts apple_pen + pineapple_pen

