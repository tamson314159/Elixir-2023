# Elixir-2023

## IEx
- IEX.helpers
- h 関数
- アリティ
- モジュールを指定するとモジュールのドキュメントが見られる
- 関数を指定すると関数のドキュメントが見られる

## Elixirの型 (basic)
- integer
- float
- atom
- boolean value
- nil
- bitstring
- binary
- string
- list
- charlist
- keyword list
- tuple
- map
- function
- Process ID
- reference
- port identifier

## データ型
- 前項と同じ

## 数値
### integer
- 整数
- 大きい数値はアンダースコアで区切れる
  - 例：```1_000_000```
- 16, 8, 2 進数表記ができる
  - 0x
  - 0o
  - 0b

### float
- 浮遊動小数点数
- e: 指数
  - 指数が0の場合は省略可能

## atom
- 自分自身の名前がそのまま定数になる
- コロンをつける
- アルファベット, _, @ が使える
- 末尾では ?, ! が使える
- 役割は今後具体例を見ながら学ぶ

## string
- 文字列
- ダブルクォーテーションで囲む
- エスケープ文字が使える
  - 例：```\n```
- シングルクォーテーションで囲むと文字列リストになってしまう
- 連結 ```<>```
- 補完 ```#{}```

## list
- データの集合
- 同じ型でなくてもよい
- 連結リスト -> 先頭への追加の方が速い
- 連結 ```++```
- 差分 ```--```
- 包含 ```in```, ```not in```
- 追加 ```[head | tail]``` tail はリスト

## tuple
- 主に2から4個程度のデータの集合を扱う
  - それ以上は map
- 連結、差分はとれない
- メモリ上で隣接している
  - 長さの取得が速い
  - 修正は高コスト
  - 他言語の配列

## keyword list
- 要素が全てタプルである
- タプルの要素数は2である
- タプルの第一要素がアトムである
- 簡易記法
``` elixir
list = [name: "hoge", age: 1]
list[:name]　# hoge
```

## map
- unorderdedMap
- ```%{key => value}```
- key がアトムの場合は ```map.key``` で value を取得できる

