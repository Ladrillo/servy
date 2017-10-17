defmodule Servy.BearController do
  require IEx
  alias Servy.Conv
  alias Servy.Wildthings
  alias Servy.Bear

  def index(conv) do
    items = Wildthings.list_bears()
    |> Enum.filter(&Bear.is_brown/1)
    |> Enum.sort(&Bear.sort_bear_by_name/2)
    |> Enum.map(&Bear.make_bear_item/1)
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