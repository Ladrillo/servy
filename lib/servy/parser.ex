defmodule Servy.Parser do
    require IEx
    
    alias Servy.Conv

    def parse_headers([], acc) do
        acc
    end

    def parse_headers([head | tail], acc) do
        [key, value] = String.split(head, ": ")
        parse_headers(tail, Map.put(acc, key, value))
    end

    def parse(request) do
        [top, params_string] = String.split(request, "\n\n")
        [request_line | header_lines] = String.split(top, "\n")
        [method, path, _] = String.split(request_line, " ")
        headers = parse_headers(header_lines, %{})
        params = parse_params(params_string)
        
        IEx.pry

        %Conv{
            method: method,
            path:   path,
            params: params,
            headers: headers
        }
    end

    def parse_params(params_string) do
        params_string |> String.trim() |> URI.decode_query
    end
end
