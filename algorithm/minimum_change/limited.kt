val INF = 100000
val currencies = listOf( 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 )
fun main(args: Array<String>){
  /*val price = 23978*/
  val price = 756
  /*val have = listOf( INF, 1, 4, 1, 2, 0, 3, 1, 2 )*/
  val have = listOf( INF, 0, 1, 0, 3, 0, 1, 0, 1 )


  var flag = false // true when currently focusing money shouldn't be used.
  val normalized_price = split(price)
  val r = have.reversed().zip(normalized_price.reversed()).map{
    if( !flag && it.first >= it.second ){
      flag = false
      it.second
    }
    else if( flag && it.first >= it.second + 1 ){
      // do move up
      flag = false
      it.second + 1
    }
    else{
      // skip to next larger money
      flag = true
      0
    }
  }


  val pay_sum = currencies.zip(r.reversed()).map{ it.first * it.second }.sum()

  println("price: $price")
  println("you have: $have")
  println("you should pay: ${pay_sum}(${r.reversed().sum()}) ${r.reversed()}")
  println("change is: ${pay_sum - price}(${split(pay_sum - price).sum()}) ${split(pay_sum - price)}")
}



fun split(price: Int): List<Int>{
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
