# 演習問題

## 第3章 Elixir の基礎 (1)

### 3-1

1. x
   - o: コンパイル時にバイトコードファイルはカレントディレクトリに作られる
2. x
3. o
   - x: 文ではなく式 (experssion)
4. o
   - x: メソッドという用語は使わない
5. o

## 3-2

アリティ

## 第4章 Elixir の基礎 (2)

### 4-1

1. x
2. o
3. x
4. x
5. x
   - キーワードリストはキーが重複してもよい

### 4-2

1. string
2. list
3. keyword
   - list
4. tuple
5. integer

### 4-3

3

## 第5章 Elixir の基礎 (3)

### 5-1

1

### 5-2

{"alice", 0}

### 5-3

- ア. ->
- イ. end

### 5-4

- ア. defmodule
- イ. def

### 5-5

ch05/string_utility.exs

### 5-6

- ア. String.to_integer()
- イ. abs()

## 第6章 Elixir の基礎 (4)

### 6-1

true

### 6-2

false

- "A": and, && の方が or, || より優先度が高い

### 6-3

- ア. String
- イ. :ok

### 6-4

- ア. <-
- イ. "(#{name})"

## 第7章 モジュール

### 7-1

1. x
2. o
3. o
4. o
5. x

### 7-2

- ア. alias MyApp.MyMod

## 第8章 関数 (1)

### 8-1

- ア. -> a - b
- イ. subtract.

### 8-2

- ア. quote
  - apply
- イ. connect
  - :connect

### 8-3

def connect(a, b), do: a <> "-" <> b

## 第9章 関数 (2)

### 9-1

1. o
2. o
   - x:リモート呼び出しとは ```Mod.func()``` という形の呼び出し方のこと。プライベート関数では不可
3. o
4. x
5. o

### 9-2

&Enum.join([&1, &2, &3])

### 9-3

1. fn x -> x end
2. fn x, y -> x * y end
3. fn x -> rem(x, 10) end
4. fn x -> {x, x + 1} end

## 第10章 マクロの初歩と条件分岐

### 10-1

"many"

### 10-2

if len >= 3, do: :large, else: :small

### 10-3

- ア. len == 0 -> "zero"
- イ. len == 1 -> "one"
- ウ. len == 2 -> "two"
- エ. true -> "many"

## 第11章 アトム

### 11-1

1. x
2. x
3. o
4. x

## 第12章 リスト

### 12-1

1. x
2. x
3. o
4. o
   - x: リストのサイズを返す関数は length
5. x

### 12-2

1. o
2. x
3. x
4. o
5. x

### 12-3

[ture, false]

false: flattenn は全ての深さのリストを展開する

### 12-4

["v", ["w", "x"], "y", "z"]

### 12-5

- ア. size
  - length
- イ. List
  - Enum
- ウ. get_at
  - at

## 第13章 タプルとキーワードリスト

### 13-1

1. o
2. x
3. x
4. x
5. o

### 13-2

- ア. replace_at
  - put_elem
- イ. 1
- ウ. "x"

### 13-3

true

## 第14章 マップ

### 14-1

1. x
2. x
3. o
4. x

### 14-2

1. o
2. x
3. x
4. o
5. o

### 14-3

- ア. values

## 第15章 ビットストリング、バイナリ、文字列、文字リスト

### 15-1

1. x
2. o
3. x
4. o
5. o

### 15-2

- ア. -3
  - -3..-1

## 第16章 パターンマッチング

### 16-1

:a

### 16-2

"beta"

### 16-3

<<5>>

5

### 16-4

ch16/my_mod.exs

## 第17章 Enum モジュール

### 17-1

- ア. filter
- イ. uniq
- ウ. sort

### 17-2

ch17/my_mod.ex

### 17-3

- ア. all?
- イ. length

## 第18章 for マクロ

### 18-1

["\*\*", "\*\*\*\*"]

### 18-2

- ア. players
- イ. p.stage == :gold

### 18-3

[{1, 3, 0, 0}, {0, 1, 1, 3}]

## 第19章 case マクロと with マクロ

### 19-1

- ア. 0 -> "zero"
- イ. 1 -> "one"
- ウ. 2 -> "two"
- エ. _ -> "many"

### 19-2

ch19/auth.exs

### 19-3

- ア. %{name: name, data: data}
  - %{name: name, data: data} when is_binary(data)
- イ. {i, ""}
- ウ. nil
  - _ -> nil

## 第20章 複数の節を持つ関数

### 20-1

ch20/exercise1.exs

### 20-2

ch20/math.exs

### 20-3

ch20/multiple_clauses4.exs

## 第21章 reduce 関数

### 21-1

30

### 21-2

"AABBZ"

### 21-3

"Bob/Carol/Alice/Eve"

### 21-4

- ア. {[{spare, entry} | pairs], entry}

## 第22章 エラー処理

### 22-1

- ア. catch
- イ. rescue

## 第23章 ExUnit

### 23-1

ch23/my_mod.ex と ch23/my_mod_test.exs

### 23-2

ch23/my_mod.ex と ch23/my_mod_test.exs

## 第24章 Mix

### 24-1

ch24/adder/test/adder_test.exs

### 24-2

ch24/adder/lib/adder.ex

### 24-3

ch24/adder/test/adder_test.exs

### 24-4

ch24/adder/lib/mix/tasks/sum.ex
