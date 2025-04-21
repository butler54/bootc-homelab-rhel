

get-deps:
	wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz -O node-exporter.tar.gz
	tar -xvzf ./node-exporter.tar.gz
	mv node_exporter-1.9.1.linux-amd64/node_exporter node_exporter