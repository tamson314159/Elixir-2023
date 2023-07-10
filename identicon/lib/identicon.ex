defmodule Identicon do
  def create_image() do
    name =
      IO.gets("")
      |> String.trim()

    name
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_add_cells()
    |> build_pixel_map()
    |> build_image
  end

  defp hash_input(name) do
    hash_list =
      :crypto.hash(:md5, name)
      |> :binary.bin_to_list()

    %Identicon.Image{name: name, hex: hash_list}
  end

  defp pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: [r, g, b]}
  end

  defp build_grid(data) do
    list =
      Enum.chunk_every(data.hex, 3)
      |> List.delete_at(-1)
      |> Enum.map(&mirror_row(&1))
      |> List.flatten()
      |> Enum.with_index()

      %Identicon.Image{data | grid: list}
  end

  defp filter_add_cells(data) do
    filter = Enum.filter(data.grid, fn {value, _number} -> rem(value, 2) == 0 end)
    %Identicon.Image{data | grid: filter}
  end

  defp build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        top_left = {rem(index, 5) * 50, div(index, 5) * 50}
        bottom_right = {rem(index, 5) * 50 + 50, div(index, 5) * 50 + 50}
        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  defp build_image(%Identicon.Image{name: name, color: color, pixel_map: pixel_map}) do
    img = :egd.create(250, 250)
    fill = :egd.color({Enum.at(color, 0), Enum.at(color, 1), Enum.at(color, 2)})
    # fill = :egd.color(List.to_tuple(color))
    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(img, start, stop, fill)
    end)
    :egd.save(:egd.render(img), "#{name}.png")
  end

  defp mirror_row(row) do
    [data1, data2, _tail] = row
    row ++ [data2, data1]
  end
end
