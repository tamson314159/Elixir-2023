defmodule ApiToEcto do
  alias ApiToEcto.AccessPoint

  def get_access_point(url \\ "https://api.data.metro.tokyo.lg.jp/v1/WifiAccessPoint") do
    HTTPoison.get!(url)
    |> Map.get(:body)
    |> Jason.decode!()
    |> hd()
    |> Enum.map(& map_to_schema(&1))
  end

  defp map_to_schema(map) do
    name =
      map["設置地点"]["名称"]
      |> hd()
      |> Map.get("表記")

    address =  map["設置地点"]["住所"]["表記"]

    lat =
      map["設置地点"]["地理座標"]["緯度"]
      |> String.to_float()

    lon =
      map["設置地点"]["地理座標"]["経度"]
      |> String.to_float()


    %AccessPoint{
      name: name,
      address: address,
      lat: lat,
      lon: lon
    }
  end

  def get_place(path) do
    File.stream!(path)
    |> CSV.decode!(headers: true)
    |> Enum.map(& map_to_place(&1))
  end

  defp map_to_place(map) do
    %ApiToEcto.Place{
      name: map["大字町丁目コード"],
      address: map["都道府県名"] <> map["市区町村名"] <> map["大字町丁目名"],
      lat: String.to_float(map["緯度"]),
      lon: String.to_float(map["経度"])
    }
  end
end
