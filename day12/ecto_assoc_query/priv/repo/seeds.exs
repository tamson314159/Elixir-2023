alias EctoAssocQuery.{Repo, Artist, MusicList, Music, User, PlayList, PlayListMusic, ActiveUser, DeleteUser}

csv_data =
  "day12_music.csv"
  |> File.stream!()
  |> CSV.decode!(headers: true)
  |> Enum.to_list()

artists =
  csv_data
  |> Enum.map(fn %{"artist_name" => artist} -> artist end)
  |> Enum.uniq()

for artist <- artists do
  %Artist{}
  |> Artist.changeset(%{name: artist})
  |> Repo.insert()
end

# for 文使わないバージョン
# csv_data
# |> Enum.map(fn %{"artist_nmae" => name} -> name end)
# |> Enum.uniq()
# |> Enum.map(fn name -> Artist.changeset(%Artist{}, %{name: name} end))
# |> Enum.map(&Repo.insert(&1))

music_list =
  csv_data
  |> Enum.map(fn data ->
    {
      %{
        name: data["music_list_name"],
        category: data["category"],
        music_category: data["music_category"]
      },
      data["artist_name"]
    }
  end)
  |> Enum.uniq()

for {music_list, artist_name} <- music_list do
  artist = Repo.get_by(Artist, name: artist_name)

  %MusicList{artist: artist}
  |> MusicList.changeset(music_list)
  |> Repo.insert()
end

music =
  Enum.map(csv_data, fn data ->
    {%{name: data["music_name"]}, data["music_list_name"]}
  end)

for {music, music_list_name} <- music do
  music_list = Repo.get_by(MusicList, name: music_list_name)

  %Music{music_list: music_list}
  |> Music.changeset(music)
  |> Repo.insert()
end

user =
  %User{}
  |> User.changeset(%{name: "taro", email: "taro@example.com"})
  |> Repo.insert!()

Repo.insert(%ActiveUser{user: user})

for index <- 1..2 do
  play_list =
    %PlayList{user: user}
    |> PlayList.changeset(%{name: "play list #{index}"})
    |> Repo.insert!()

  play_list_data =
    # ファイル名をハードコーディングするな
    "day12_play_list#{index}.csv"
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(fn data -> data["music_name"] end)

  for music_name <- play_list_data do
    music = Repo.get_by(Music, name: music_name)

    %PlayListMusic{play_list: play_list, music: music}
    |> Repo.insert!()
  end
end

user =
  %User{}
  |> User.changeset(%{name: "hanako", email: "hanako@sample.com"})
  |> Repo.insert!()

# hanako を user に束縛せずに taro を delete_user にしてるけど多分ミス
Repo.insert(%DeleteUser{user: user})
