# 素朴な実装
=begin
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
=end

class PPAP
  attr_accessor :ppap_space
  def initialize
    @ppap_space = []
    @ppaps = {}
  end
  def create list
    t = self.class.new
    t.ppap_space = list
    t
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

    define_singleton_method method_name do |*args|
      if args.length > 0
        p self.method_name
        p args[0].ppap_space
        # p self.ppap_space.concat args[0].ppap_space.reverse 
        create self.ppap_space.concat args[0].ppap_space.reverse
      else
        @ppaps[method_name]
      end
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
end


ppap = PPAP.new
ppap.I_have_a "Pen"
ppap.I_have_a "Apple"
ppap.uh! "Apple Pen"
ppap.I_have_a "Pen"
ppap.I_have_a "Pineapple"
ppap.uh! "Pineapple Pen"

puts ppap.apple_pen(ppap.pineapple_pen)
# puts ppap.apple_pen
# puts ppap.pineapple_pen
