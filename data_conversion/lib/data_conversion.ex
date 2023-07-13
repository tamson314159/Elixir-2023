defmodule DataConversion do
  def json_get(end_point_api \\ "https://api.data.metro.tokyo.lg.jp/v1//WifiAccessPoint") do
  # URL は関数側ではなく seeds.exs 側に書く
    [data, _] = end_point_api
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Jason.decode!

    data
  end

  def json_encode!(string_lists) do
    Enum.map(string_lists, & String.split(&1, ","))
    |> Enum.map(fn [name, lon, lat] -> %{name: name, lon: lon, lat: lat} end)
    |> Jason.encode!()
  end

  def get(head) do
    lat = head["設置地点"]["地理座標"]["経度"]
    lon = head["設置地点"]["地理座標"]["緯度"]
    [h | _t] = head["設置地点"]["名称"]
    name = h["表記"]

    "#{name},#{lon},#{lat}"
  end

  def gets(data) do
    Enum.map(data, &get(&1))
  end

  def create_csv(map_list, filename \\ "new.csv") do
    data = CSV.encode(map_list, headers: true)
      |> Enum.map(& &1)
      |> Enum.join()

    File.write!(filename, data)
  end

  def read_csv(path) do
    file = File.stream!(path)
    CSV.decode!(file, headers: true)
    |> Enum.map(& &1)
  end
end
