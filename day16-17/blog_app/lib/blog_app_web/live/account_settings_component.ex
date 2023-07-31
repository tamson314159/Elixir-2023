defmodule BlogAppWeb.AccountSettingsComponent do
  use BlogAppWeb, :live_component

  alias BlogApp.Accounts

  def render(assigns) do
    ~H"""
    <div>
      <.header class="text-center">
        Account Settings
        <:subtitle>Manage your account email address and password settings</:subtitle>
      </.header>

      <div class="space-y-12 divide-y">
        <div>
          <.simple_form
            for={@profile_form}
            id="profile_form"
            phx-target={@myself}
            phx-submit="update_profile"
            phx-change="validate_profile"
          >
            <.input field={@profile_form[:name]} type="text" label="Name" required />
            <.input field={@profile_form[:introduction]} type="textarea" label="Introduction" />
            <:actions>
              <.button phx-disable-with="Changing...">Change Profile</.button>
            </:actions>
          </.simple_form>
        </div>
        <div>
          <.simple_form
            for={@email_form}
            id="email_form"
            phx-target={@myself}
            phx-submit="update_email"
            phx-change="validate_email"
          >
            <.input field={@email_form[:email]} type="email" label="Email" required />
            <.input
              field={@email_form[:current_password]}
              name="current_password"
              id="current_password_for_email"
              type="password"
              label="Current password"
              value={@email_form_current_password}
              required
            />
            <:actions>
              <.button phx-disable-with="Changing...">Change Email</.button>
            </:actions>
          </.simple_form>
        </div>
        <div>
          <.simple_form
            for={@password_form}
            id="password_form"
            action={~p"/accounts/log_in?_action=password_updated"}
            method="post"
            phx-target={@myself}
            phx-change="validate_password"
            phx-submit="update_password"
            phx-trigger-action={@trigger_submit}
          >
            <.input
              field={@password_form[:email]}
              type="hidden"
              id="hidden_account_email"
              value={@current_email}
            />
            <.input field={@password_form[:password]} type="password" label="New password" required />
            <.input
              field={@password_form[:password_confirmation]}
              type="password"
              label="Confirm new password"
            />
            <.input
              field={@password_form[:current_password]}
              name="current_password"
              type="password"
              label="Current password"
              id="current_password_for_password"
              value={@current_password}
              required
            />
            <:actions>
              <.button phx-disable-with="Changing...">Change Password</.button>
            </:actions>
          </.simple_form>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("validate_profile", %{"account" => params}, socket) do
    profile_form =
      socket.assigns.current_account
      |> Accounts.change_account_profile(params)
      |> to_form()

    {:noreply, assign(socket, :profile_form, profile_form)}
  end

  def handle_event("update_profile", %{"account" => params}, socket) do
    socket =
      case Accounts.update_account_profile(socket.assigns.current_account, params) do
        {:ok, account} ->
          notify_parent({:update_profile, account})

          profile_form =
            account
            |> Accounts.change_account_profile()
            |> to_form()

          assign(socket, :profile_form, profile_form)

        {:error, cs} ->
          assign(socket, :profile_form, to_form(cs))
      end

    {:noreply, socket}
  end

  def handle_event("validate_email", params, socket) do
    %{"current_password" => password, "account" => account_params} = params

    email_form =
      socket.assigns.current_account
      |> Accounts.change_account_email(account_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, email_form: email_form, email_form_current_password: password)}
  end

  def handle_event("update_email", params, socket) do
    %{"current_password" => password, "account" => account_params} = params
    account = socket.assigns.current_account

    case Accounts.apply_account_email(account, password, account_params) do
      {:ok, applied_account} ->
        notify_parent({:update_email, applied_account})

        Accounts.deliver_account_update_email_instructions(
          applied_account,
          account.email,
          &url(~p"/accounts/settings/confirm_email/#{&1}")
        )

        info = "A link to confirm your email change has been sent to the new address."
        {:noreply, socket |> put_flash(:info, info) |> assign(email_form_current_password: nil)}

      {:error, changeset} ->
        {:noreply, assign(socket, :email_form, to_form(Map.put(changeset, :action, :insert)))}
    end
  end

  def handle_event("validate_password", params, socket) do
    %{"current_password" => password, "account" => account_params} = params

    password_form =
      socket.assigns.current_account
      |> Accounts.change_account_password(account_params)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: password_form, current_password: password)}
  end

  def handle_event("update_password", params, socket) do
    %{"current_password" => password, "account" => account_params} = params
    account = socket.assigns.current_account

    case Accounts.update_account_password(account, password, account_params) do
      {:ok, account} ->
        password_form =
          account
          |> Accounts.change_account_password(account_params)
          |> to_form()

        {:noreply, assign(socket, trigger_submit: true, password_form: password_form)}

      {:error, changeset} ->
        {:noreply, assign(socket, password_form: to_form(changeset))}
    end
  end

  def update(%{current_account: account} = assigns, socket) do
    profile_changeset = Accounts.change_account_profile(account)
    email_changeset = Accounts.change_account_email(account)
    password_changeset = Accounts.change_account_password(account)

    socket =
      socket
      |> assign(:current_password, nil)
      |> assign(:email_form_current_password, nil)
      |> assign(:current_email, account.email)
      |> assign(:profile_form, to_form(profile_changeset))
      |> assign(:email_form, to_form(email_changeset))
      |> assign(:password_form, to_form(password_changeset))
      |> assign(:trigger_submit, false)
      |> assign(assigns)

    {:ok, socket}
  end

  defp notify_parent(msg), do: send(self(), msg)
end
