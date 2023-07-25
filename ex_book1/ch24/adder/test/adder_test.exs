defmodule AdderTest do
  use ExUnit.Case

  describe "get_total/1" do
    @data """
    30
    40
    ABC
    15
    """

    test "整数として解釈できない行は無視される" do
      assert Adder.get_total(@data) == 85
    end

    test "空文字を受け取った場合は 0 を返す" do
      assert Adder.get_total("") == 0
    end

    test "文字列のリストを受け取り、各文字列を整数に変換して合計値を返す" do
      assert Adder.get_total(["15", "25", "50"]) == 90
    end

    test "リストに含まれる整数として解釈できない文字列は無視される" do
      assert Adder.get_total(["15", "ABC", "50"]) == 65
    end
  end
end
