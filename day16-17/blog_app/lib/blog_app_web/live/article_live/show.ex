defmodule BlogAppWeb.ArticleLive.Show do
  use BlogAppWeb, :live_view

  alias BlogApp.Articles
  alias BlogApp.Articles.Comment

  def render(assigns) do
    ~H"""
    <div :if={@article.status == 2}>
      This is a limited article.
    </div>

    <div>
      <a
        href={~p"/accounts/profile/#{@article.account_id}"}
        class="hover:underline"
      >
        <%= @article.account.name %>
      </a>
      <div class="text-gray-600 text-xs"><%= @article.submit_date %></div>
      <div>Liked: <%= Enum.count(@article.likes) %></div>
      <h2 class="my-2 font-bold text-2xl"><%= @article.title %></h2>
      <div class="my-2 whitespace-pre-wrap"><%= @article.body %></div>
      <div
        phx-click="like_article"
        phx-value-account_id={@current_account_id}
        class="rounded-lg w-min py-1 px-2 bg-gray-200 hover:bg-400 cursor-pointer"
        :if={
          @current_account &&
          (@current_account_id != @article.account_id and
          @current_account_id not in Enum.map(@article.likes, & &1.account_id))
        }
      >
        Like
      </div>
    </div>

    <div class="mt-4 border-2 rounded-lg py-2 px-4">
      <h3 class="font-semibold text-xl">Comment</h3>
      <div :for={comment <- @article.comments} class="mt-2 border-b last:border-none">
        <a href={~p"/accounts/profile/#{comment.account_id}"} class="hover:underline"><%= comment.account.name %></a>
        <div class="text-gray-600 text-xs"><%= Calendar.strftime(comment.inserted_at, "%c") %></div>
        <div class="my-2 whitespace-pre-wrap"><%= comment.body %></div>
      </div>
      <.simple_form
        for={@form}
        phx-change="comment_validate"
        phx-submit="comment_save"
        :if={@current_account_id != @article.account_id and @current_account}
      >
        <.input field={@form[:body]} type="textarea" placeholder="Enter a comment" />
        <:actions>
          <.button phx-diabled-with="submitting...">Submit</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"article_id" => article_id}, _uri, socket) do
    article = Articles.get_article!(article_id)

    socket =
      unless article.status == 0 do
        current_account_id =
          Map.get(socket.assigns.current_account || %{}, :id)

        socket
        |> assign(:article, article)
        |> assign_form(Articles.change_comment(%Comment{}))
        |> assign(:current_account_id, current_account_id)
        |> assign(:page_title, article.title)
      else
        redirect(socket, to: ~p"/")
      end

    {:noreply, socket}
  end

  def handle_event("comment_validate", %{"comment" => params}, socket) do
    cs = Articles.change_comment(%Comment{}, params)

    {:noreply, assign_form(socket, cs)}
  end

  def handle_event("comment_save", %{"comment" => params}, socket) do
    params =
      Map.merge(
        params,
        %{
          "account_id" => socket.assigns.current_account.id,
          "article_id" => socket.assigns.article.id
        }
      )

    socket =
      case Articles.create_comment(params) do
        {:ok, _comment} ->
          socket
          |> put_flash(:info, "Comment created successfuly.")
          |> assign(:article, Articles.get_article!(socket.assigns.article.id))
          |> assign_form(Articles.change_comment(%Comment{}))

        {:error, cs} ->
          assign_form(socket, cs)
      end

    {:noreply, socket}
  end

  def handle_event("like_article", %{"account_id" => account_id}, socket) do
    Articles.create_like(socket.assigns.article.id, account_id)

    {:noreply, assign(socket, :article, Articles.get_article!(socket.assigns.article.id))}
  end

  defp assign_form(socket, cs) do
    assign(socket, :form, to_form(cs))
  end
end
