defmodule Team8es.SessionController do
    use Team8es.Web, :controller

    def new(conn, _) do
      render conn, "new.html"
    end

    def create(conn, %{"session" => %{"email" => user, "password" => password}}) do
      case Team8es.Auth.login_by_email_and_pass(conn, user, password, repo: Repo) do
        {:ok, conn} ->
          conn
          |> put_flash(:info, "Logged in.")
          |> redirect(to: user_path(conn, :index))
        {:error, _reason, conn} ->
          conn
          |> put_flash(:error, "Wrong username/password")
          |> render("new.html")
       end
    end

    def delete(conn, _) do
      conn
      |> Guardian.Plug.sign_out
      |> redirect(to: "/")
    end

end
