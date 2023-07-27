defmodule ChatAppWeb.RoomLive.Show do
  use ChatAppWeb, :live_view

  alias ChatApp.Rooms
  alias ChatApp.Accounts
  alias ChatApp.Rooms.Message

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
        |> assign(:messages, Rooms.list_messages(room.id))
        |> assign_form(Rooms.change_message(%Message{}))
      else
        socket
        |> put_flash(:error, "Not join room.")
        |> redirect(to: ~p"/rooms")
      end

    {:noreply, socket}
  end

  @impl true
  def handle_event("send_message", %{"message" => params}, socket) do
    params =
      Map.merge(params, %{"account_id" => socket.assigns.current_account.id, "room_id" => socket.assigns.room.id})

    socket =
      case Rooms.create_message(params) do
        {:ok, message} ->
          socket
          |> update(:messages, fn messages -> List.insert_at(messages, -1, message) end)
          |> assign_form(Rooms.change_message(%Message{}))

        {:error, cs} ->
          assign_form(socket, cs)
      end

    {:noreply, socket}
  end

  defp assign_form(socket, cs) do
    assign(socket, :message_form, to_form(cs))
  end
end
