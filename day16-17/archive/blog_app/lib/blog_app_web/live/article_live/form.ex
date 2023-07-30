defmodule BlogAppWeb.ArticleLive.Form do
  use BlogAppWeb, :live_view

  alias BlogApp.Articles
  alias BlogApp.Articles.Article

  def render(assigns) do
    ~H"""
    <.header>
      <div>
        <%= @page_title %>
      </div>
    </.header>

    <.simple_form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:title]} type="text" label="Title" />
      <.input field={@form[:body]} type="textarea" label="Body" />
      <.input
        field={@form[:status]}
        type="select"
        label="Public Type"
        options={[draft: 0, public: 1, limited: 2]}
      />
      <:actions>
        <.button phx-disable-with="Saveing...">
          Save
        </.button>
      </:actions>
    </.simple_form>
    """
  end

  def mount(_parms, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _session, socket) do
    socket =
      apply_action(socket, socket.assigns.live_action, params)

    {:noreply, socket}
  end

  def handle_event("validate", %{"article" => params}, socket) do
    cs = Articles.change_article(socket.assigns.article, params)
    IO.inspect(cs)
    {:noreply, assign_form(socket, cs)}
  end

  def handle_event("save", %{"article" => params}, socket) do
    socket =
      save_article(socket, socket.assigns.live_action, params)

    {:noreply, socket}
  end

  defp apply_action(socket, :edit, %{"article_id" => article_id}) do
    article = Articles.get_article!(article_id)

    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, article)
    |> assign_form(Articles.change_article(article))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Article{})
    |> assign_form(Articles.change_article(%Article{}))
  end

  defp save_article(socket, :edit, params) do
    case Articles.update_article(socket.assigns.article, params) do
      {:ok, %Article{status: 0}} ->
        socket
        |> put_flash(:info, "Article saved successfully.")
        |> redirect(to: ~p"/accounts/profile/#{socket.assigns.current_account.id}/draft")

      {:ok, article} ->
        socket
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: ~p"/articles/show/#{article.id}")

      {:error, cs} ->
        assign_form(socket, cs)
    end
  end

  defp save_article(socket, :new, params) do
    current_account_id = socket.assigns.current_account.id
    params = Map.merge(params, %{"account_id" => current_account_id})

    case Articles.create_article(params) do
      {:ok, %Article{status: 0}} ->
        socket
        |> put_flash(:info, "Article saved successfully.")
        |> redirect(to: ~p"/accounts/profile/#{current_account_id}/draft")

      {:ok, article} ->
        socket
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: ~p"/articles/show/#{article.id}")

      {:error, cs} ->
        assign_form(socket, cs)
    end
  end

  defp assign_form(socket, cs) do
    assign(socket, :form, to_form(cs))
  end
end
