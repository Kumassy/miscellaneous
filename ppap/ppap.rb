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

    if block_given?
      yield self
    end
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

    define_singleton_method method_name do
      puts "#{synthesis}"
      if self.ppap_space.empty?
        self.ppap_space = @ppaps[method_name].ppap_space
      else
        self.ppap_space.concat @ppaps[method_name].ppap_space.reverse
      end
    end

    @ppaps[method_name] = create @ppap_space.dup
    @ppap_space = []
  end

  # def to_s
  #   if @ppap_space.length > 0
  #     @ppap_space.reverse.join(' ')
  #   elsif @ppaps.length > 0
  #     @ppaps.join(' ')
  #   end
  # end

  private
  def create list
    t = self.class.new
    t.ppap_space = list
    t
  end
end


ppap = PPAP.new
ppap.I_have_a "Pen"
ppap.I_have_a "Apple"
ppap.uh! "Apple Pen"
ppap.I_have_a "Pen"
ppap.I_have_a "Pineapple"
ppap.uh! "Pineapple Pen"

ppap.apple_pen
ppap.pineapple_pen
ppap.uh! "Pen Pineapple Apple Pen"

ppap.pen_pineapple_apple_pen
ppap.pen_pineapple_apple_pen
ppap.uh! "Pen Apple Pineapple Pen Pen Pineapple Apple Pen"


PPAP.new { |p|
  p.I_have_a "Pen"
  p.I_have_a "Apple"
  p.uh! "Apple Pen"
  p.I_have_a "Pen"
  p.I_have_a "Pineapple"
  p.uh! "Pineapple Pen"

  p.apple_pen
  p.pineapple_pen
  p.uh! "Pen Pineapple Apple Pen"
}

PPAP.new.instance_exec {
  I_have_a "Pen"
  I_have_a "Apple"
  uh! "Apple Pen"
  I_have_a "Pen"
  I_have_a "Pineapple"
  uh! "Pineapple Pen"

  apple_pen
  pineapple_pen
  uh! "Pen Pineapple Apple Pen"
}
