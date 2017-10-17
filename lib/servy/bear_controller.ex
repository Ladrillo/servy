defmodule Servy.BearController do
  require IEx
  alias Servy.Conv
  alias Servy.Wildthings

  def index(conv) do
    items = Wildthings.list_bears()
    |> Enum.filter(fn bear -> bear.type == "Brown" end)
    |> Enum.map(fn bear -> "<li>#{bear.name} #{bear.type}</li>" end)
    |> Enum.join
  
    %Conv{ conv | status: 200, resp_body: "<ul>#{items}</ul>" }  
  end

  def show(conv, %{"id" => id}) do
    %Conv{ conv | status: 200, resp_body: "Bear #{id}" }    
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{ conv | status: 200, resp_body: "#{type} bear #{name} created!" }    
  end
end