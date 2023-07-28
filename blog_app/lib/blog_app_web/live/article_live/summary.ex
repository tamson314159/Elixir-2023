defmodule BlogAppWeb.ArticleLive.Summary do
  use BlogAppWeb, :live_view

  alias BlogApp.Articles

  def render(assigns) do
    ~H"""
    <.header>
      Listing Articles
    </.header>

    <div>
      <.simple_form for={@form} phx-change="search_articles">
        <.input
          field={@form["keyword"]}
          type="text"
          placeholder="Search articles"
        />
      </.simple_form>
    </div>

    <div :for={article <- @articles} class="mt-2">
      <a href={~p"/accounts/profile/#{article.account_id}"}>
        <%= article.account.name %>
      </a>
      <a href={~p"/articles/show/#{article.id}"}>
        <div><%= article.submit_date %></div>
        <h2><%= article.title %></h2>
        <div>Liked: <%= Enum.count(article.likes) %></div>
      </a>
    </div>
    """
  end

  def mount(_parama, _session, socket) do
    socket =
      socket
      |> assign(:articles, Articles.list_articles())
      |> assign(:page_title, "blog")
      |> assign_form()

    {:ok, socket}
  end

  def handle_event("search_articles", %{"search_article" => %{"keyword" => keyword}}, socket) do
    socket =
      socket
      |> assign(:articles, Articles.search_articles_by_keyword(keyword))
      |> assign_form()

    {:noreply, socket}
  end

  defp assign_form(socket) do
    assign(socket, :form, to_form(%{}, as: "search_article"))
  end
end
