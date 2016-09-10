fun main(args: Array<String>){
  val price = 23978
  val currencies = listOf( 10000, 5000, 1000, 500, 100, 50, 10, 5, 1)

  var _price = price
  val answer = currencies.map{
    val t = _price / it
    _price -= it * t
    t
  }

  assert(currencies.zip(answer).map{ it.first * it.second }.sum()  == price)
  println(answer)

}
