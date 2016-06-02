defmodule AuthApi.UserView do
  use AuthApi.Web, :view

  def render("show.json", %{user: user}) do
    render_one(user, AuthApi.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{user_id: user.user_id,
      email: user.email}
  end
  
  # def error(status, message, fields) do 
    # errors = Enum.map(fields, fn {field, detail} -> %{ key: field, message: detail } end) 
    # %{status: status, message: message, fields: errors}
  # end 
end
