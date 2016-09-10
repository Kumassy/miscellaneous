val INF = 100000
val currencies = listOf( 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 )
fun main(args: Array<String>){
  /*val price = 23978*/
  val price = 756
  /*val have = listOf( INF, 1, 4, 1, 2, 0, 3, 1, 2 )*/
  val have = listOf( INF, 0, 1, 0, 3, 0, 1, 0, 1 )


  val result = calculate_pay_amount(price, have)
  println(result)
  val pay_sum = currencies.zip(result).map{ it.first * it.second }.sum()
  println("price: $price")
  println("you have: $have")
  println("you should pay: ${pay_sum}(${result.sum()}) ${result}")
  println("change is: ${pay_sum - price}(${normalize(pay_sum - price).sum()}) ${normalize(pay_sum - price)}")
}

fun calculate_pay_amount(price: Int, available_currencies: List<Int>): List<Int>{
  var flag = false // true when currently focusing money shouldn't be used.
  val normalized_price = normalize(price)

  // 小さい方から検討する
  return available_currencies.reversed().zip(normalized_price.reversed()).map{
    if( !flag && it.first >= it.second ){
      flag = false
      it.second
    }
    else if( flag && it.first >= it.second + 1 ){
      // 下位小銭がないので多めに払う
      flag = false
      it.second + 1
    }
    else{
      // 払えないのでスキップ
      flag = true
      0
    }
  }.reversed() // 大きい順に戻す
}


fun normalize(price: Int): List<Int>{
  var _price = price
  val result = currencies.map{
    val t = _price / it
    _price -= it * t
    t
  }

  assert(currencies.zip(result).map{ it.first * it.second }.sum()  == price)
  val requirement = listOf(INF, 1, 4, 1, 4, 1, 4, 1, 4)
  assert(currencies.size == requirement.size)
  assert(result.zip(requirement).all{ it.first <= it.second })
  return result
}
