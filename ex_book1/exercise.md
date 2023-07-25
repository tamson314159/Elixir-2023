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
   - リモート呼び出しとは ```Mod.func()``` という形の呼び出し方のこと。プライベート関数では不可
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
