defmodule Servy.BearController do
  require IEx
  alias Servy.Conv
  alias Servy.Bear
  alias Servy.Wildthings

  def index(conv) do
    bears = Wildthings.list_bears
    %Conv{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }  
  end

  def show(conv, %{"id" => id}) do
    %Conv{ conv | status: 200, resp_body: "Bear #{id}" }    
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{ conv | status: 200, resp_body: "#{type} bear #{name} created!" }    
  end
end