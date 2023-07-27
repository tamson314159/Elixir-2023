defmodule ChatAppWeb.RoomLive.Show do
  use ChatAppWeb, :live_view

  alias ChatApp.Rooms
  alias ChatApp.Accounts

  @impl true
  def mount(_params, session, socket) do
    account =
      Accounts.get_account_by_session_token(session["account_token"])

    {:ok, assign(socket, :current_account, account)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    socket =
      if room = Rooms.get_room!(id, socket.assigns.current_account.id) do
        socket
        |> assign(:page_title, room.room_name)
        |> assign(:room, room)
      else
        socket
        |> put_flash(:error, "Not join room.")
        |> redirect(to: ~p"/rooms")
      end

    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Room"
  defp page_title(:edit), do: "Edit Room"
end
