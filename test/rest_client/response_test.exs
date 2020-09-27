defmodule RestClient.ResponseTest do
  @moduledoc false

  alias RestClient.Response

  use ExUnit.Case, async: true

  describe "from_mojito/1" do
    mojito_response = %Mojito.Response{status_code: 200, headers: [], body: "body"}

    assert %Response{status: 200, headers: [], body: "body"} =
             Response.from_mojito(mojito_response)
  end
end
