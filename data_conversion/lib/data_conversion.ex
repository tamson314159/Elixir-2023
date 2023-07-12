defmodule DataConversion do
  def json_get(end_point_api) do
    [data, _] = end_point_api
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Json.decode!

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
end
