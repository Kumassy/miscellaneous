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


  val t = exchange_currencies(listOf(0, 0, 6, 0, 12, 1, 0, 0, 6), normalize(6256))
  println(t)
}
fun exchange_currencies(available_currencies: List<Int>, normalized_currencies_list: List<Int>): List<Int>{
  // normalized_currencies_list で与えられる正規化されたお金リストを、available_currencies 制約内で最前になるまで両替する

// m_: Map version
  /*val m_available_currencies = currencies.zip(available_currencies).toMap()
  var m_remaining = normalized_currencies_list.toMutableList()*/

  // m_: Map version
  val m_normalized_currencies = currencies.zip(normalized_currencies_list).toMap()
  var remaining = available_currencies.toMutableList()

  m_normalized_currencies.forEach{ entry ->
    if(entry.key > 0){
      // 残りのお金の 1 円側から it.key * it.value の額を構成できるか調べる
      val pair_to_consume = currencies.zip(remaining).findLast{ it.first * it.second >= entry.key * entry.value }

      val index = when(pair_to_consume!!.first){
        10000 -> 0
        5000 -> 1
        1000 -> 2
        500 -> 3
        100 -> 4
        50 -> 5
        10 -> 6
        5 -> 7
        1 -> 8
        else -> -1
      }
      remaining[index] -= (entry.key * entry.value) / pair_to_consume!!.first
      assert(remaining[index] >= 0)
    }
  }

  return available_currencies.zip(remaining.toList()).map{
    it.first - it.second
  }
}
fun calculate_pay_amount(price: Int, available_currencies: List<Int>): List<Int>{
  var flag = false // true when currently focusing money shouldn't be used.
  val normalized_price = normalize(price)
  val normalized_currencies = normalize(available_currencies)

  // 小さい方から検討する
  return normalized_currencies.reversed().zip(normalized_price.reversed()).map{
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
fun normalize(currencies_list: List<Int>): List<Int>{
  return normalize(currencies.zip(currencies_list).map{ it.first * it.second }.sum())
}
