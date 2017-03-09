defmodule Dbuniverse.Repo do

    alias Couchdb.Connector.Storage
    alias Couchdb.Connector.Writer
    alias Couchdb.Connector.Reader
    alias Couchdb.Connector.View

    @database_properties %{
        protocol: Application.get_env(:couchdb_connector, :protocol),
        hostname: Application.get_env(:couchdb_connector, :hostname),
        database: Application.get_env(:couchdb_connector, :database),
        port:     Application.get_env(:couchdb_connector, :port)
    }

    @server_uri "#{@database_properties[:protocol]}://#{@database_properties[:hostname]}:#{@database_properties[:port]}/"
    @database_uri "#{@server_uri}/#{@database_properties[:database]}"

    def test_database_server_connection do

        case HTTPoison.get @server_uri do
        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
            raise RuntimeError, message: "Connection refused. Is the database running?"
        {:ok, %HTTPoison.Response{status_code: 200}} ->
            {:ok, :connection_accepted}
        end

    end

    def create_database do

        case HTTPoison.get "#{@database_uri}" do
            {:ok, %HTTPoison.Response{status_code: 200}} ->
                {:ok, :database_exists}
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                case Storage.storage_up @database_properties do
                    {:ok, body} -> {:ok, body}
                    {:error, body} -> {:error, body}
                end
        end

    end

    def drop_database do

        case HTTPoison.get "#{@database_uri}" do
            {:ok, %HTTPoison.Response{status_code: 200}} ->
                Storage.storage_down @database_properties
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                {:ok, :database_does_not_exists}
        end

    end
    
    def insert document do

        {:ok, json, _headers} = Writer.create_generate @database_properties, document
        IO.puts "document inserted"
        json |> Poison.Parser.parse!

    end

    def update document, id do

        IO.inspect Poison.encode!(document)
        IO.inspect Writer.update @database_properties, Poison.encode!(document), id

    end

    def get_by_id id do
        
        {:ok, character_json} = Reader.get @database_properties, id
        character_json |> Poison.Parser.parse!

    end

    def get_all do

        {:ok, characters_json} = View.fetch_all @database_properties, "character", "by_name"
        characters_json |> Poison.Parser.parse!

    end

    def create_view design_name, code do

        View.create_view @database_properties, design_name, code

    end

end