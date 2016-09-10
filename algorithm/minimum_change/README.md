# Minimum Change
お金の出し方の考察

## infinite.kt
お札と硬貨が無限にあるときのお金の出し方

```
kotlinc infinite.kt -include-runtime -d infinite.jar
java -jar -ea infinite.jar
# Enable assert()
```

## limited.kt
もっているお金が制限されているときに、お釣りの枚数を最小化するにはどういう出し方をしたらいいか

```
kotlinc limited.kt -include-runtime -d limited.jar
java -jar -ea limited.jar
```
