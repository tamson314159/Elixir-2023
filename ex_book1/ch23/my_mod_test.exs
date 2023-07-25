ExUnit.start()

defmodule MyModTest do
  use ExUnit.Case

  describe "double/1" do
    test "リストの要素を2倍にして返す" do
      assert MyMod.double([1, 0, -2]) == [2, 0, -4]
    end

    test "Range 構造体の各要素を2倍にして返す" do
      assert MyMod.double(2..4) == [4, 6, 8]
    end
  end

  describe "sum/1" do
    test "空のリストが渡された場合は、0 を返す" do
      assert MyMod.sum([]) == 0
    end

    test "渡されたリストの要素を先頭から順に多仕上げていき、その合計を返す" do
      assert MyMod.sum([1, 2, 3]) == 6
    end

    test "3回 0 に遭遇したらそこで処理を止めて、そこまでの合計を返す" do
      # MyMod.sum の引数をモジュール属性にする
      assert MyMod.sum([1, 5, 0, 2, 1, 7, 0, 2, 0, 3, 1, 0, 1]) == 18
    end
  end
end
