extends Control

onready var input_text_box := $VBoxContainer2/HBoxContainer/LineEdit
onready var output_text_box := $VBoxContainer2/TextEdit

onready var ip_join := $VBoxContainer/HBoxContainer/VBoxContainer/IPJoin
onready var port_join := $VBoxContainer/HBoxContainer/VBoxContainer/PortJoin

onready var port_host := $VBoxContainer/HBoxContainer2/VBoxContainer/PortHost

func _on_Join_pressed():
	if ip_join.text.is_valid_ip_address() and port_join.text.is_valid_integer():
		Network.join_server(ip_join.text, int(port_join.text))
		ip_join.text = ""
		port_join.text = ""
	else:
		Network.join_server()

func _on_Host_pressed():
	if port_host.text.is_valid_integer():
		Network.create_server(int(port_host.text))
		port_host.text = ""
	else:
		Network.create_server()

func _on_Send_pressed():
	var text = input_text_box.text
	input_text_box.text = ""
	if text.replace(" ", "") == "":
		print("empty string")
		return
	Network.call_peer("Lobby", "set_text", text)
	output_text_box.text += text+"\n"

func run_server_func(function, data):
	if function == "set_text":
		set_text(data)

func set_text(text):
	output_text_box.text += text+"\n"
