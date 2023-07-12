defmodule Day6Work do
  def read_csv(path \\ "./132209_open_data_list.csv") do
    File.stream!(path)
    |> CSV.decode!(headers: true)
    |> Enum.to_list()
  end

  def create_csv(map, name \\ "create_tourism.csv") do
  # 記事では拡張子は関数側で固定していた
    content =
      CSV.encode(map, headers: true)
      |> Enum.to_list()
      |> Enum.join()

    File.write(name, content)
    # 動画では File.write を無名関数化してパイプでつないでいた
  end

  def create_json(map, name \\ "create_tourism.json") do
    File.write!(name, Jason.encode!(map))
  end

end
