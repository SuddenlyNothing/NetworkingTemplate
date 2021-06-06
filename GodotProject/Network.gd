extends Node

const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 31400
const MAX_CLIENTS = 2

func create_server(port = DEFAULT_PORT, clients = MAX_CLIENTS):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, clients)
	get_tree().set_network_peer(peer)
	print("hosting")

func join_server(ip = DEFAULT_IP, port = DEFAULT_PORT):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)
	print("joined")

func call_peer(node_path, function, data):
	rpc("receive_call", node_path, function, data)

remote func receive_call(node_path, function, data):
	get_tree().get_root().get_node(node_path).run_server_func(function, data)
