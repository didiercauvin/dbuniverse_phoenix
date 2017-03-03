defmodule Dbuniverse.Repo do

    alias Couchdb.Connector.Storage
    alias Couchdb.Connector.Writer
    alias Couchdb.Connector.Reader

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

        Writer.create_generate @database_properties, document

    end

    def get_by_id id do
        
        {:ok, character_json} = Reader.get @database_properties, id
        character_json |> Poison.Parser.parse!

    end

end