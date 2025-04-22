

get_vma:
	wget https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v1.115.0/vmutils-linux-amd64-v1.115.0.tar.gz -O vmutils.tar.gz
	tar -xvzf ./vmutils.tar.gz
	mv vmagent-prod vmagent
	rm *-prod vmutils.tar.gz
get_node:
	wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz -O node-exporter.tar.gz
	tar -xvzf ./node-exporter.tar.gz
	mv node_exporter-1.9.1.linux-amd64/node_exporter node_exporter
	rm -r node-exporter.tar.gz node_exporter-1.9.1.linux-amd64


get-deps: get_node get_vma
