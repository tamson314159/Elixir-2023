defmodule ChatApp.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias ChatApp.Repo
  alias Ecto.Multi

  alias ChatApp.Rooms.Room
  alias ChatApp.Rooms.Member

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Room
    |> preload(:accounts)
    |> Repo.all()
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(room_id, account_id) do
    query =
      from(r in Room,
        join: a in assoc(r, :accounts),
        where: r.id == ^room_id and a.id == ^account_id
      )

    Repo.one(query)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(account_id, attrs \\ %{}) do
    Multi.new()
    |> Multi.insert(:room, Room.changeset(%Room{}, attrs))
    |> Multi.insert(:member, fn %{room: %Room{id: room_id}} ->
      %Member{account_id: account_id, room_id: room_id}
    end)
    |> Repo.transaction()
  end

  def join_room(account_id, room_id) do
    %Member{}
    |> Member.changeset(%{"account_id" => account_id, "room_id" => room_id})
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{data: %Room{}}

  """
  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end
end
