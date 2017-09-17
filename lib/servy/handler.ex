defmodule Servy.Handler do
    @moduledoc "Handles HTTP requests"

    alias Servy.Conv

    @pages_path Path.expand("../../pages", __DIR__)

    import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
    import Servy.Parser, only: [parse: 1]

    @doc "Transforms the request into a response"
    def handle(request) do
        request
        |> parse
        |> rewrite_path
        |> log
        |> route
        |> track
        |> format_response
    end

    def route(%Conv{ method: "GET", path: "/wildthings" } = conv) do
        %Conv{ conv | status: 200, resp_body: "Bears, Lions, Tigerz" }
    end

    def route(%Conv{ method: "GET", path: "/bears" } = conv) do
        %Conv{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
    end

    def route(%Conv{ method: "GET", path: "/bears/" <> id } = conv) do
        %Conv{ conv | status: 200, resp_body: "Bear #{id}" }
    end

    def route(%Conv{ method: "GET", path: "/about" } = conv) do
        @pages_path
        |> Path.join("about.html")
        |> File.read
        |> handle_file(conv)
    end

    def handle_file({:error, :enoent}, conv) do
        %Conv{ conv | status: 404, resp_body: "File not found" }
    end

    def handle_file({:error, reason}, conv) do
        %Conv{ conv | status: 500, resp_body: "File error: #{reason}" }
    end

    def handle_file({:ok, content}, conv) do
        %Conv{ conv | status: 200, resp_body: content }
    end

    def route(%Conv{path: path} = conv) do
        %Conv{ conv | status: 404, resp_body: "No #{path} here!" }
    end

    def format_response(conv) do
        """
        HTTP/1.0 #{conv.status} #{status_reason(conv.status)}
        Content-Type: text/html
        Content-Length: #{String.length(conv.resp_body)}

        #{conv.resp_body}
        """
    end

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


request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request2 = """
GET /bears/2 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request3 = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request4 = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

request5 = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

# response = Servy.Handler.handle(request)
# IO.puts response

# response2 = Servy.Handler.handle(request2)
# IO.puts response2

# response3 = Servy.Handler.handle(request3)
# IO.puts response3

# response4 = Servy.Handler.handle(request4)
# IO.puts response4

response5 = Servy.Handler.handle(request5)
IO.puts response5
