defmodule Uplix.Upload do
  require ExAws

  def start_upload(conn) do
    bucket = Application.get_env(:uplix, :bucket_name)

    body_params = Enum.into conn.body_params, %{}
    headers = Enum.into conn.req_headers, %{}
    file = Map.from_struct body_params["file"]

    filename = resolve_s3_path(headers, file)

    file.path
    |> ExAws.S3.Upload.stream_file
    |> ExAws.S3.upload(bucket, filename)
    |> ExAws.request

    "https://#{bucket}.s3.amazonaws.com/#{filename}"
  end

  defp resolve_s3_path(headers, file) do
    folder = encode_data headers["mpa"]
    extension = Path.extname file.filename

    "#{folder}/documents/#{headers["contestation"]}/#{headers["document"]}#{extension}"
  end

  defp encode_data(data) do
    :crypto.hmac(:sha, Application.get_env(:uplix, :crypto_key), data)
    |> Base.encode16
  end
end