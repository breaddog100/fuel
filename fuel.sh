#!/bin/bash

# 节点安装功能
function install_node() {

	# 填写变量
	# 节点名称
	read -p "节点名称: " node_name
	# RPC地址
	read -p "ETH Sepolia RPC地址: " RPC
	
	sudo apt update
	sudo apt install screen git jq -y
	
	# 安装Rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source $HOME/.cargo/env
	
	# 安装Fuel
	yes y | curl https://install.fuel.network | sh
	source ~/.bashrc
	
	# 生成P2P密钥
	export PATH=$HOME/.fuelup/bin:$PATH
	p2p_key=$(echo $(fuel-core-keygen new --key-type peering) | jq -r '.secret')
	
	# 下载chain information
	git clone https://github.com/FuelLabs/chain-configuration.git
	
	# 开始配置并运行节点
	screen -dmS fuel_$node_name bash -c "source $HOME/.bashrc; fuel-core run \
	--service-name=fuel-sepolia-testnet-node \
	--keypair ${p2p_key} \
	--relayer ${RPC} \
	--ip=0.0.0.0 --port=4000 --peering-port=30333 \
	--db-path=~/.fuel-sepolia-testnet \
	--snapshot ~/chain-configuration/ignition \
	--utxo-validation --poa-instant false --enable-p2p \
	--reserved-nodes /dns4/p2p-testnet.fuel.network/tcp/30333/p2p/16Uiu2HAmDxoChB7AheKNvCVpD4PHJwuDGn8rifMBEHmEynGHvHrf \
	--sync-header-batch-size 100 \
	--enable-relayer \
	--relayer-v2-listening-contracts=0x01855B78C1f8868DE70e84507ec735983bf262dA \
	--relayer-da-deploy-height=5827607 \
	--relayer-log-page-size=500 \
	--sync-block-stream-buffer-size 30
	"
	
	echo "部署完成"

}

# 查看日志
function view_logs() {
	read -p "节点名称: " node_name
    screen -r fuel_node_name
}

# 卸载节点
function uninstall_node() {
    echo "确定要卸载节点程序吗？这将会删除所有相关的数据。[Y/N]"
    read -r -p "请确认: " response

    case "$response" in
        [yY][eE][sS]|[yY]) 
            echo "开始卸载节点程序..."
            screen -ls | grep 'fuel_' | cut -d. -f1 | awk '{print $1}' | xargs -I {} screen -X -S {} quit
            rm -rf $HOME/.fuelup $HOME/fuelup
            echo "节点程序卸载完成。"
            ;;
        *)
            echo "取消卸载操作。"
            ;;
    esac
}

# 主菜单
function main_menu() {
    while true; do
        clear
        echo "===============Fuel一键部署脚本==============="
        echo "沟通电报群：https://t.me/lumaogogogo"
        echo "最低配置：2C4G30G；推荐配置：8C12G100G"
        echo "请选择要执行的操作:"
        echo "1. 安装节点 install_node"
        echo "2. 查看日志 view_logs"
        echo "3. 卸载节点 uninstall_node"
        echo "0. 退出脚本 exit"
        
        read -p "请输入选项（0-3）: " OPTION
        
        case $OPTION in
            1) install_node ;;
            2) view_logs ;;
            3) uninstall_node ;;
            0) echo "退出脚本。"; exit 0 ;;
            *) echo "无效选项，请重新输入。"; sleep 1 ;;
        esac
    done
}

# 显示主菜单
main_menu