defmodule ChatApp.Rooms.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApp.Accounts.Account
  alias ChatApp.Rooms.Room

  schema "messages" do

    belongs_to :account_id, Account
    belongs_to :room_id, Room

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:messages, :account_id, :room_id])
    |> validate_required([:message])
  end
end
