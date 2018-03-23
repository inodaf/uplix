defmodule Uplix.Plug do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json, :multipart], json_decoder: Poison
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [])
  end

  post "/add-document" do
    link = Uplix.Upload.start_upload conn

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{link: link}))
  end

  match _ do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(404, "Use the <code>POST</code> /send-document route.")
  end
end
