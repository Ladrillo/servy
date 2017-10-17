defmodule Servy.BearController do
  require IEx
  alias Servy.Conv
  alias Servy.Wildthings

  def index(conv) do
    items = Wildthings.list_bears()
    |> Enum.filter(&(&1.type == "Brown"))
    |> Enum.sort(fn a, b -> a.name >= b.name end)
    |> Enum.map(fn bear -> "<li>#{bear.name} #{bear.type}</li>" end)
    |> Enum.join
  
    %Conv{ conv | status: 200, resp_body: "<ul>#{items}</ul>" }  
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %Conv{ conv | status: 200, resp_body: "<h1>#{bear.name} #{bear.type}</h1>" }    
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{ conv | status: 200, resp_body: "#{type} bear #{name} created!" }    
  end
end