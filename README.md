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

### atom

- 自分自身の名前がそのまま定数になる
- コロンをつける
- アルファベット, _, @ が使える
- 末尾では ?, ! が使える
- 役割は今後具体例を見ながら学ぶ

### string

- 文字列
- ダブルクォーテーションで囲む
- エスケープ文字が使える
  - 例：```\n```
- シングルクォーテーションで囲むと文字列リストになってしまう
- 連結 ```<>```
- 補完 ```#{}```

### list

- データの集合
- 同じ型でなくてもよい
- 連結リスト -> 先頭への追加の方が速い
- 連結 ```++```
- 差分 ```--```
- 包含 ```in```, ```not in```
- 追加 ```[head | tail]``` tail はリスト

### tuple

- 主に2から4個程度のデータの集合を扱う
  - それ以上は map
- 連結、差分はとれない
- メモリ上で隣接している
  - 長さの取得が速い
  - 修正は高コスト
  - 他言語の配列

### keyword list

- 要素が全てタプルである
- タプルの要素数は2である
- タプルの第一要素がアトムである
- 簡易記法

``` elixir
list = [name: "hoge", age: 1]
list[:name]　# hoge
```

### map

- unorderdedMap
- ```%{key => value}```
- key がアトムの場合は ```map.key``` で value を取得できる

## Day1 Section 3

### 関数

- anonymous と named がある
- 例

``` elixir
add = fn a, b -> a + b end
x = add.(1, 1)
```

### 型の判別

- is_型の名前/1 で判別できる

### 無名関数

- fn で始まり end で終わる
- ドット(.) は関数の呼び出しを意味する

### 名前付き関数

- def で始まり end で終わる
- 原則小文字のアルファベットで始める
- 例

``` elixir
defmodule Math do
  def calc(x, y) do
    x * 3 + y
  end
end
```

- defmodule については次項で解説

### モジュール

- 関数をグループ分けする単位
- 全ての named function は1つのモジュールに属する
- 原則、モジュール名は大文字のアルファベットで始める

#### 名前付き関数の呼び出し

- elixirc でコンパイル
- コンパイルしたら .beam ファイルができる

### 無名関数の作成と呼び出し

- 仮引数は括弧をつけないのが一般的
- 変数にセットせずに使うこともできる
- 例

``` elixir
iex> (fn a, b -> a * b end).(3,5)
15
```

### キャプチャ演算子

- named function を named function のように扱う
- ```&``` で表現する
- 例1

``` elixir
f = &Math.calc/2
f.(1, 3)

func = &Math.calc(&1, &2)
func.(1, 3)
```

- 例2

``` elixir
func = &([&1 | [1, 2, 3]])
func.(0)
```

### 構造体

- 特殊な map
  - デフォルト値を持つ
  - キーはアトム
  - モジュール内で定義する
- defstruct で定義する

#### 構造体の取得

- ```%Hoge{}``` の形で呼び出せる
- ```hoge.key``` か ```Map.get(hoge, :key)``` で値を取り出す
  - ```hoge[:key]``` はエラー

#### エラーの発生

- 定義されてないキーで呼び出すとエラー
- モジュールで定義されていないキーを追加できない

#### nil の定義

- フィールド値を ```nil``` で定義できる

#### 関数を使用しての更新

- Map.put
- Map.replace

## Elixir基礎ワーク

### 標準入出力

- trim/1 で空白改行を除くことができる

### 四則演算

- div integer 型の商
- rem 余り

### 文字列とアトム

- boolean の true, false は実はアトムの :true, :false
- 厳密等価演算子 ```===```
- 大文字始まりはアトムとして評価される
  - ```Elixir.Hoge``` のように ```Elixir``` が補完されている

### 文字リスト

- シングルクォーテーションで囲む
- 32~126 の値のみを含むリストは文字リストとして評価される
- 例

``` elixir
[97, 98, 99] == 'abc'
# true
```

### リスト/タプル/マップ

- マップのキーが衝突する場合最後の要素のみがキーとして定義される
- コレクションに対する操作は公式が出している関数がいくつもある

## Day2 Section1

### 変数

- Elixir の変数は一般的なプログラミング言語の箱のイメージとは異なる

### パターンマッチ

- ```=``` はパターンマッチを行う二項演算子
- 左辺をパターンと呼ぶ
- ```=``` はパターンマッチに成功すると右辺の値を返す

### 変数への束縛

- 一般的なプログラミング言語の代入とは本質的に異なる
- この違いによる影響は先のチャプターで学ぶ

### 変数への再束縛

- ```x = x + 5``` で再束縛できる
- Erlang や Haskell では禁止されている

### パターンマッチの活用

- ```[a, 2, c] = [1, 2, 3]``` で ```a```, ```c``` が束縛される
- タプルも同様

### パターンマッチ上のアンダースコア

- アンダースコアは特別な変数
  - 束縛された値を全て捨てる
  - どんな値ともマッチする

### アンダースコアから始まる変数

- 参照されることがない変数はアンダースコアから始める
- 例：```_x = 1```
- 参照しようとすると警告が出る

### 値の不変性

- Elixir の値は不変
- リストに値を追加するときはコピーが作成される
  - 元のリストを他で参照しているコードに影響を与えない
- コピーを作成することで非効率になることはない（原理は割愛）
- 自主的に試してみた (Day2_Section2/immutability.exs)

## Day2 Section2

### 制御構造

#### if

- ```if 条件式 do 処理 end``` の形
- 条件式が true の場合 end まで実行する

#### if ･ else

- ```if 条件式 do 処理1 else 処理2 end``` の形
- 条件式が true の場合、処理1を実行する
- 条件式が false の場合、処理2を実行する

#### unless

- if の逆

#### unless ･ else

- if ･ else の逆

#### case

- 以下の形

``` elixir
case {1, 2, 3} do
  {4, 5, 6} -> "No match"
  {1, x, 3} -> "Match"
  _ -> "_ match all conditions"
end
```

- 条件にマッチするまで値を比較する
- 事前に束縛した変数と比較したいときは ```^``` を変数の前につける

#### Guard 節

- 引数によって処理を分ける
- case 文中で ```パターン when 条件式 -> 処理``` の形

#### cond

- 最初にマッチするものを探す
- 以下の形

``` elixir
cond do
  2 + 2 == 5 -> "First,not true"
  2 * 2 == 3 -> "Second,false"
  1 + 1 == 2 -> "Third,true!!"
end
```

- どれにもマッチしない場合エラー

#### do / end ブロック

- シンタックスシュガー ```if hoge, do: fuga, else: piyo```
- ```do:``` の後にはスペースを入れる
- 最も外側の関数に対してバインドされる

### 例外

- 基本的には戻り値で条件分岐すれば例外を書く必要はない

#### raise

- 明示的にエラーを発生させる
- ```raise/1``` は引数にメッセージをつける
  - 発生するのは ```RuntimeError``` のみ
- ```raise/2``` はエラーとメッセージをつける
- 例

``` elixir
defmodule OriginaErr do
  defexception message: "default"
end

raise OriginalErr, message: "custom"
```

#### try / rescue

- エラーを補足する
- 例

``` elixir
try do
  raise "oops"
rescue
  e in RuntimeError -> e
end
# %RuntimeError{message: "oops"}
```

#### try / catch

- ```throw``` で値を投げる
- 基本使わない
- 例

``` elixir
try do
  for x <- 0..10 do
    if x == 5, do: throw(x)
    IO.puts(x)
  end
catch
  x -> "Caught: #{x}"
end
```

#### after

- try の直後に必ず実行する処理

#### exit

- プロセスが死んだときに送る
- 単純なプログラムで書くことは少ない
  - ```spawn_link``` のような処理が出てきたときに思い出す

## Day2 Section3

### リストの操作

- ```in```, ```not in```
- 長さ ```length(list)```
- 要素の取得 ```List.first(list)```, ```List.last(list)```
- 挿入 ```List.insert_at(list, i, v)```
  - コンス演算子 ```[head | tail]```
- 削除 ```List.delete_at(list, i)```
- 反転 ```Enum.reverse(list)```
- 平坦化 ```List.flatten(list)```
  - 多重にネストされていても全て平坦化される（自主的に試した：Day2_Section3/flatten.exs
- 全て新しいリストが作成されることに注意

### タプルの操作

- インデックスを指定して要素を取得 ```elem(tuple, i)```
- 置換 ```put_elem(tuple, i, v)```
- サイズ ```tuple_size(tuple)```
- 末尾への追加 ```Tuple.append(tuple, v)```
- インデックスを指定して追加 ```Tuple.insert_at(tuple, i, v)```
- インデックスを指定して削除 ```Tuple.delete_at(tuple, i)```
- タプルをリストに変換する ```Tuple.to_list(tuple)```

### キーワードリストの操作

- 値の取得 ```Keyword.get(keywords, key)```
  - アリティは3
    - デフォルト値を指定（Elixir 実践ガイドより）
  - ```list[key]``` でもよい
- 要素の追加 ```|```, ```Keyword.put/3```, ```Keyword.put_new/3```
- 要素の削除 ```Keyword.delete(keywords, key)```
- キーワードリストかどうか調べる ```Keyword.keyword?(term)```
- キーを持つか調べる ```Keyword.has_key?(keywords, key)```
- 結合 ```Keyword.merge(keywords1, keywords2)```

### マップの操作

- 値の取得 ```map[key]```, ```Map.get(map, key)```
  - キーがアトムの場合 ```map.key```
- 要素の追加 ```Map.put(map, key, value)```
- 更新を行わずに追加

``` elixir
map = %{"apple" => 100, "banana" => 200, "melon" => 300}
Map.put_new(map, "apple", 400)
# %{"apple" => 100, "banana" => 200, "melon" => 300}
```

- 更新 ```Map.replace(map, key, value)```
  - key に存在しない key を指定した場合を自主的に試したが、元の map が返された
  - ```%{map | key1 => value1, key2 => value2, ...}``` とも書ける
    - パイプ記号は要素の追加の時には使えない
- 削除 ```Map.delete(map, key)```, ```Map.drop(map, key_list)```
  - 存在しないキーを指定した場合は元のマップを返す（Elixir 実践ガイドより）
- 結合 ```Map.merge(map1, map2)```
- マップであるかどうかを調べる ```is_map(term)```
- キーを持つか調べる ```is_map_key(map, key)```
- キーのリスト ```Map.keys(map)```
- 値のリスト ```Map.values(map)```

### for マクロ

- 以下の形

``` elixir
for 一時的な変数 <- リスト do
  処理
end
```

## Day3 Section1

### Enum

- enumerable の略、列挙型
- リスト、キーワードリスト、マップ、Range 構造体など
- タプルは含まない

#### Enum.map

- enumerable に処理を加えリストにする
- マップもリストになる
- 例

``` elixir
Enum.map([1, 2, 3], fn x -> x * 2 end)
# [2, 4, 6]
```

- 処理をキャプチャ演算子で簡略化してもよい

#### Enum.each

- 個々の要素に処理をする（リストは作らない）
- 戻り値は ```:ok```

#### Enum.sort/1, Enum.sort/2

- 昇順ソートする
- 英字もソートできる
  - sigil ```~w``` を使い空白区切りの名前リストを返す
- ```~w``` はエスケープや埋め込みを含まない単語のリストを作る
- sigil については先のセクションで詳しくやる
- 第2引数に ```:desc``` を入れると降順ソート
- 第2引数に無名関数を指定できる
  - 無名関数はアリティ2で boolean を返す
- 自主的にアトムのリストをソートしてみたら実行できた

#### Enum.reverse/1

- 逆順

#### Enum.find/2

- 条件に合う要素を探す
- 最初に見つけた要素のみを返す
- 見つからない場合を自主的に試したら ```nil``` が返ってきた

### Enum.empty?/1

- 空か判断
- 第1 引数に ```nil``` を入れると ```Protocol.UndefindeError```

#### Enum.filter/2

- 条件に合う要素を全て探してリストで返す

#### Enum.reject/2

- 条件に合う要素を全て除外してリストで返す

#### Enum.join/2

- 第2引数の文字列を挟んで出力する
- 第2変数を省略すると空の文字列で結合される

#### Enum.all?/2

- 全ての要素が条件を満たすか調べる

#### Enum.any?2

- 条件を満たす要素が存在するか調べる

#### Enum.uniq/1

- 重複を除く

#### Enum.min/1, Enum.min/2

- 最小値
- アリティ2の場合、空の要素が与えられたときの最小値を生成するための関数を渡すことができる

#### Enum.max/1, Enum.max/2

- 最大値
- アリティの違いは Enum.min と同じ
- 自主的に英文字のリストで試したら辞書順で最後の値が返ってきた

#### Enum.reduce/3

- 要素数分の処理を繰り返す
- 第2引数は最初の数
- 例：```Enum.reduce([1, 2, 3], 1000, &(&1 * 2 + &2)) # 1012)```

#### Enum.take/2

- 第2引数で指定した個数の要素を取得する
- 第2引数をマイナスにすると末尾から取得する
- 自主的に試したところ：
  - 0 を指定すると空のリストが返ってきた
  - 要素数より絶対値が大きい数を指定すると元のリストが返ってきた

#### Enum.zip/1, Enum.zip/2

- 複数の配列を組み合わせたタプルのリストを返す
- 例：

``` elixir
Enum.zip([[1, 2, 3, 4], [:a, :b, :c]])
# [{1, :a}, {2, :b}, {3, :c}]
```

- 要素数が違う場合は少ない方の要素数まで zip する
- 配列の数が2つの場合はそのまま渡せる ```Enum.zip([1, 2, 3], [:a, :b, :c])```

### サフィックスルール

#### _by

- 条件に沿って処理
- ```Enum.max_by(enum, fnction)```

#### _while

- 条件まで処理
- ```Enum.take_while(enum, fuction)``` 関数は boolean を返す

#### _every

- 個数毎に処理
- 例：

``` elixir
Enum.map_every([1, 2, 3, 4, 5], 2, fn x -> x + 10000 end)
#[10001, 2, 10003, 4, 10005]
```

### 複数の Enum 関数を1つにまとめて提供されている関数

- ```Enum.map_join/3``` は ```Enum.map/2``` の後に ```Enum.join/2``` を行う
- それぞれで処理するよりまとめた関数で処理する方が高速

### Stream

- enumerable を処理する
- 遅延処理が可能（Enum は全て先行処理）
- Enum は先にリストを生成している
- Stream は即時に計算するのではなく Stream 構造体を返す
- Stream 構造体は将来適用される関数を保持している
- ```Enum.take(stream, n)``` 等で値を取得できる

## Day3 Section2

### リストのヘッドとテール

- リストの先頭が head 2番目以降が tail
- head と tail はそれぞれ hd/1 と tl/1 で取得できる

### パターンマッチを使ったヘッドとテールの取得

- パターンマッチでも head と tail が取得できる ```[head | tail] = list```

### 再起処理とは

- 再起処理とは関数の中で自身の関数を呼び出すこと
- 無限ループさせないため、終了条件プログラムしておく

### リストの再帰的構造

- 例

``` elixir
def f([]), do: 終了処理
def f([head | tail]) do
  head2 = head への処理
  hoge(f, head2, tail)
  # hoge は足し算とか tail への head1 の append など
end
```

### map 関数の作成

- map 関数は前節の例で以下のようにしたもの
  - ```head2 = func(head)```
  - ```def hoge(f, head2, tail), do: [head2 | map(tail, func)]```

### 再起中の値の保持

- sum 関数は前節の例で以下のようにしたもの
  - ```head2 = head + total```
  - ```def hoge(head2, tail), do: sum(tail, head2)```

### より複雑なリストのパターン

- 複数の要素を head としてマッチできる ```[head1, head2, ... | tail]```

### 特定リストの抽出

- 例：```[[hoge1, fuga1], [hoge2, fuga2], ...]``` から ```hoge = 1``` のリストを取得する
  - ```def f([]), do: []```
  - ```def f([[1, fuga] | tail]), do: ([[1, fuga] | f(tail)])```
  - ```def f([_ | tail]), do: f(tail)```

## Day3 Section3

### バイナリと文字列

#### キャラリスト

- printable character のみを含むリストは iex が勝手にエンコーディングする
- エンコーディングしてほしくないときは印字可能文字以外をリストに追加する方法がある
