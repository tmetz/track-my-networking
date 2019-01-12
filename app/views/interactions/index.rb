<div class = "row">
    <div class = "col-sm-12"><p style = "text-align: center;">Interactions you've had</p></div>
</div>


<% @interactions.each do |interaction| %>
    <% @persons.each do |person| %>
        <% if person.id == interaction.person_id %>
        <% current_person = person %>
    <% end %>
    <div class = "row">
    <div class = "col-sm-3" style = "color:#6d4e3b;"><%= interaction.date %></div>
    <div class = "col-sm-9"><%= current_person.name %></div>
</div>
<% end %>