defmodule SimpleCrawler do
  def main do
    url = user_input("URL を入力してください。\n")
    file_name = user_input("URL とテキスト情報を出力するファイルを拡張子付きで入力してください。\n")
    domain = get_domain(url)

    check_url([url], domain)
    |> get_page_text()
    |> file_write(file_name)
  end

  @doc """
  ## Examples

    iex> SimpleCrawler.get_url("https://thewaggletraining.github.io/")
    ["https://thewaggletraining.github.io/next.html", "https://thewaggletraining.github.io/three.html", "https://www.thewaggle-training.com"]
  """
  def get_url(url \\ "https://thewaggletraining.github.io/") do
    domain = "https://thewaggletraining.github.io/"

    html = HTTPoison.get!(url)

    Floki.parse_document!(html.body)
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.filter(& String.starts_with?(&1, domain))
  end

  def get_url_list(url_list, domain) do
    list =
      for url <- url_list do
        get_url(url)
        |> Enum.filter(& String.starts_with?(&1, domain))
      end

    List.flatten(list)
  end

  def get_page_text(url_list) do
    for url <- url_list do
      html = HTTPoison.get!(url)

      text =
        Floki.parse_document!(html.body)
        |> Floki.find("body")
        |> Floki.text()
        |> String.replace([" ", "\n"], "")
        # |> String.trim() は Windows 環境だと上手く動いてくれない

      "#{url}\n#{text}\n\n"
    end
  end

  def check_url(url_list, domain) do
    all_url = Enum.uniq(url_list ++ get_url_list(url_list, domain))

    if all_url == url_list or length(all_url) >= 100 do
      Enum.take(all_url, 100)
    else
      check_url(all_url, domain)
    end
  end

  def file_write(data, file_name) do
    File.open!(file_name, [:write])
    |> IO.binwrite(data)
  end

  def user_input(display_value) do
    IO.gets(display_value)
    |> String.replace("\n", "")
  end

  def get_domain(url) do
    [means_communication, _, domain | _] = String.split(url, "/")
    "#{means_communication}//#{domain}"
  end
end
