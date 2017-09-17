defmodule Servy.Handler do
    def handle(request) do
        request
        |> parse
        |> rewrite_path
        |> log
        |> route
        |> track
        |> format_response
    end

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

    def track(%{ status: 404, path: path } = conv) do
        IO.puts "Warning: #{path} is on the loose"
        conv
    end

    def track(conv), do: conv

    def rewrite_path(%{ path: "/wildlife" } = conv) do
        %{ conv | path: "/wildthings" }
    end

    def rewrite_path(conv), do: conv

    def log(conv), do: IO.inspect conv

    def route(%{ method: "GET", path: "/wildthings" } = conv) do
        %{ conv | status: 200, resp_body: "Bears, Lions, Tigers" }
    end

    def route(%{ method: "GET", path: "/bears" } = conv) do
        %{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
    end

    def route(%{ method: "GET", path: "/bears/" <> id } = conv) do
        %{ conv | status: 200, resp_body: "Bear #{id}" }
    end

    def route(%{ method: "GET", path: "/about" } = conv) do
        IO.puts __DIR__
        file =
            Path.expand("../../pages", __DIR__)
            |> Path.join("about.html")

        case File.read(file) do
            {:error, :enoent} -> %{ conv | status: 404, resp_body: "File not found" }
            {:error, reason}  -> %{ conv | status: 500, resp_body: "File error: #{reason}" }
            {:ok, content}    -> %{ conv | status: 200, resp_body: content }
        end
    end

    def route(%{ path: path } = conv) do
        %{ conv | status: 404, resp_body: "No #{path} here!" }
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
