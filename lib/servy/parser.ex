defmodule Servy.Parser do
    def parse(request) do
        [method, path, _] =
            request
            |> String.split("\n")
            |> List.first
            |> String.split(" ")

        %{
            status:    nil,
            method:    method,
            path:      path,
            resp_body: ""
        }
    end
end