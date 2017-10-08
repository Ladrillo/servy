defmodule Servy.Conv do
    defstruct method: "",
        path: "",
        resp_body: "",
        status: nil,
        headers: %{},
        params: %{}

    def full_status(conv), do:
        "HTTP/1.0 #{conv.status} #{status_reason(conv.status)}"

    defp status_reason(code), do:
        %{
            200 => "OK",
            201 => "Created",
            401 => "Unauthorized",
            403 => "Forbidden",
            404 => "Not found",
            500 => "Internal Server Error"
        }[code]
end
