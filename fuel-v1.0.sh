#!/bin/bash

function update_and_install() {
    echo "正在更新系统..."
    sudo apt update -y
    if [ $? -ne 0 ]; then
        echo "系统更新失败，请检查您的网络连接和包管理器状态。"
        exit 1
    fi

    echo "正在安装必要软件..."
    sudo apt install -y curl screen
    if [ $? -ne 0 ]; then
        echo "软件安装失败，请检查您的网络连接和包管理器状态。"
        exit 1
    fi

    echo "系统软件更新和安装完成。"

    echo "正在安装Rust..."
    curl --proto '=https' --tlsv1.2 -Sf --retry 3 --retry-delay 5 https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    if [ $? -ne 0 ]; then
        echo "Rust安装失败，请检查您的网络连接。"
        exit 1
    fi

    echo "正在安装Fuel服务..."
    if curl --retry 3 --retry-delay 5 https://install.fuel.network -o fuel_install.sh; then
      sh fuel_install.sh
      echo "Fuel 程序下载成功并执行。"
    else
      echo "Fuel 程序下载失败，请检查网络并重试。"
      exit 1
    fi
    sleep 5
    source "$HOME/.bashrc"
    if [ $? -ne 0 ]; then
        echo "Fuel服务安装失败，请检查您的网络连接。"
        exit 1
    fi
    
    echo "正在配置chainConfig文件..."
    cat > chainConfig.json << EOF
    {
      "chain_name": "Testnet Beta 5",
      "block_gas_limit": 30000000,
      "initial_state": {
        "coins": [
          {
            "owner": "0xa1184d77d0d08a064e03b2bd9f50863e88faddea4693a05ca1ee9b1732ea99b7",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          {
            "owner": "0xb5566df884bee4e458151c2fe4082c8af38095cc442c61e0dc83a371d70d88fd",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          {
            "owner": "0x9da7247e1d63d30d69f136f0f8654ee8340362c785b50f0a60513c7edbf5bb7c",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          {
            "owner": "0x4b2ca966aad1a9d66994731db5138933cf61679107c3cde2a10d9594e47c084e",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          {
            "owner": "0x26183fbe7375045250865947695dfc12500dcc43efb9102b4e8c4d3c20009dcb",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          {
            "owner": "0x81f3a10b61828580d06cc4c7b0ed8f59b9fb618be856c55d33decd95489a1e23",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          },
          {
            "owner": "0x587aa0482482efea0234752d1ad9a9c438d1f34d2859b8bef2d56a432cb68e33",
            "amount": "0x1000000000000000",
            "asset_id": "0x0000000000000000000000000000000000000000000000000000000000000000"
          }
        ],
        "contracts": [
          {
            "contract_id": "0x7777777777777777777777777777777777777777777777777777777777777777",
            "code": "0x9000000994318e6e453f30e85bf6088f7161d44e57b86a6af0c955d22b353f91b2465f5e6140000a504d00205d4d30001a4860004945048076440001240400005050c0043d51345024040000",
            "salt": "0x1bfd51cb31b8d0bc7d93d38f97ab771267d8786ab87073e0c2b8f9ddc44b274e"
          }
        ]
      },
      "consensus_parameters": {
        "tx_params": {
          "max_inputs": 255,
          "max_outputs": 255,
          "max_witnesses": 255,
          "max_gas_per_tx": 30000000,
          "max_size": 17825792
        },
        "predicate_params": {
          "max_predicate_length": 1048576,
          "max_predicate_data_length": 1048576,
          "max_message_data_length": 1048576,
          "max_gas_per_predicate": 30000000
        },
        "script_params": {
          "max_script_length": 1048576,
          "max_script_data_length": 1048576
        },
        "contract_params": {
          "contract_max_size": 16777216,
          "max_storage_slots": 65536
        },
        "fee_params": {
          "gas_price_factor": 92,
          "gas_per_byte": 63
        },
        "chain_id": 0,
        "gas_costs": {
          "add": 2,
          "addi": 2,
          "aloc": 1,
          "and": 2,
          "andi": 2,
          "bal": 366,
          "bhei": 2,
          "bhsh": 2,
          "burn": 33949,
          "cb": 2,
          "cfei": 2,
          "cfsi": 2,
          "croo": 40,
          "div": 2,
          "divi": 2,
          "eck1": 3347,
          "ecr1": 46165,
          "ed19": 4210,
          "eq": 2,
          "exp": 2,
          "expi": 2,
          "flag": 1,
          "gm": 2,
          "gt": 2,
          "gtf": 16,
          "ji": 2,
          "jmp": 2,
          "jne": 2,
          "jnei": 2,
          "jnzi": 2,
          "jmpf": 2,
          "jmpb": 2,
          "jnzf": 2,
          "jnzb": 2,
          "jnef": 2,
          "jneb": 2,
          "lb": 2,
          "log": 754,
          "lt": 2,
          "lw": 2,
          "mint": 35718,
          "mlog": 2,
          "mod": 2,
          "modi": 2,
          "move": 2,
          "movi": 2,
          "mroo": 5,
          "mul": 2,
          "muli": 2,
          "mldv": 4,
          "noop": 1,
          "not": 2,
          "or": 2,
          "ori": 2,
          "poph": 3,
          "popl": 3,
          "pshh": 4,
          "pshl": 4,
          "ret_contract": 733,
          "rvrt_contract": 722,
          "sb": 2,
          "sll": 2,
          "slli": 2,
          "srl": 2,
          "srli": 2,
          "srw": 253,
          "sub": 2,
          "subi": 2,
          "sw": 2,
          "sww": 29053,
          "time": 79,
          "tr": 46242,
          "tro": 33251,
          "wdcm": 3,
          "wqcm": 3,
          "wdop": 3,
          "wqop": 3,
          "wdml": 3,
          "wqml": 4,
          "wddv": 5,
          "wqdv": 7,
          "wdmd": 11,
          "wqmd": 18,
          "wdam": 9,
          "wqam": 12,
          "wdmm": 11,
          "wqmm": 11,
          "xor": 2,
          "xori": 2,
          "call": {
            "LightOperation": {
              "base": 21687,
              "units_per_gas": 4
            }
          },
          "ccp": {
            "LightOperation": {
              "base": 59,
              "units_per_gas": 20
            }
          },
          "csiz": {
            "LightOperation": {
              "base": 59,
              "units_per_gas": 195
            }
          },
          "k256": {
            "LightOperation": {
              "base": 282,
              "units_per_gas": 3
            }
          },
          "ldc": {
            "LightOperation": {
              "base": 45,
              "units_per_gas": 65
            }
          },
          "logd": {
            "LightOperation": {
              "base": 1134,
              "units_per_gas": 2
            }
          },
          "mcl": {
            "LightOperation": {
              "base": 3,
              "units_per_gas": 523
            }
          },
          "mcli": {
            "LightOperation": {
              "base": 3,
              "units_per_gas": 526
            }
          },
          "mcp": {
            "LightOperation": {
              "base": 3,
              "units_per_gas": 448
            }
          },
          "mcpi": {
            "LightOperation": {
              "base": 7,
              "units_per_gas": 585
            }
          },
          "meq": {
            "LightOperation": {
              "base": 11,
              "units_per_gas": 1097
            }
          },
          "retd_contract": {
            "LightOperation": {
              "base": 1086,
              "units_per_gas": 2
            }
          },
          "s256": {
            "LightOperation": {
              "base": 45,
              "units_per_gas": 3
            }
          },
          "scwq": {
            "HeavyOperation": {
              "base": 30375,
              "gas_per_unit": 28628
            }
          },
          "smo": {
            "LightOperation": {
              "base": 64196,
              "units_per_gas": 1
            }
          },
          "srwq": {
            "HeavyOperation": {
              "base": 262,
              "gas_per_unit": 249
            }
          },
          "swwq": {
            "HeavyOperation": {
              "base": 28484,
              "gas_per_unit": 26613
            }
          },
          "contract_root": {
            "LightOperation": {
              "base": 45,
              "units_per_gas": 1
            }
          },
          "state_root": {
            "HeavyOperation": {
              "base": 350,
              "gas_per_unit": 176
            }
          },
          "new_storage_per_byte": 63,
          "vm_initialization": {
            "LightOperation": {
              "base": 1645,
              "units_per_gas": 14
            }
          }
        },
        "base_asset_id": "0000000000000000000000000000000000000000000000000000000000000000"
      },
      "consensus": {
        "PoA": {
          "signing_key": "f65d6448a273b531ee942c133bb91a6f904c7d7f3104cdaf6b9f7f50d3518871"
        }
      }
    }
EOF
    
    echo "正在生成P2P密钥..."
    source $HOME/.bashrc
    export PATH=$HOME/.fuelup/bin:$PATH
    echo "正在生成P2P密钥..."
    KEY_OUTPUT=$(fuel-core-keygen new --key-type peering)
    echo "${KEY_OUTPUT}"
    read -p "请从上方输出中复制'secret'值，并在此粘贴: " SECRET
    
    # 用户输入节点名称和RPC地址
    read -p "请输入您想设置的节点名称: " NODE_NAME
    read -p "请输入您的ETH Sepolia RPC地址: " RPC
    
    # 开始配置并运行节点
    echo "开始配置并启动您的fuel节点..."
    sleep 3

    screen -dmS Fuel bash -c "source $HOME/.bashrc; fuel-core run \
    --service-name '${NODE_NAME}' \
    --keypair '${SECRET}' \
    --relayer '${RPC}' \
    --ip 0.0.0.0 --port 4000 --peering-port 30333 \
    --db-path ~/.fuel_beta5 \
    --chain ./chainConfig.json \
    --utxo-validation --poa-instant false --enable-p2p \
    --min-gas-price 1 --max-block-size 18874368  --max-transmit-size 18874368 \
    --reserved-nodes /dns4/p2p-beta-5.fuel.network/tcp/30333/p2p/16Uiu2HAmSMqLSibvGCvg8EFLrpnmrXw1GZ2ADX3U2c9ttQSvFtZX,/dns4/p2p-beta-5.fuel.network/tcp/30334/p2p/16Uiu2HAmVUHZ3Yimoh4fBbFqAb3AC4QR1cyo8bUF4qyi8eiUjpVP \
    --sync-header-batch-size 100 \
    --enable-relayer \
    --relayer-v2-listening-contracts 0x557c5cE22F877d975C2cB13D0a961a182d740fD5 \
    --relayer-da-deploy-height 4867877 \
    --relayer-log-page-size 2000
    "
    
    echo "服务配置和启动完成。"
    sleep 3
}

function view_logs() {
    if ! screen -list | grep -q "Fuel"; then
        echo "Fuel服务没有启动，请手动启动服务或重新安装。"
        sleep 5
    else
        echo "10秒后开始输出日志，退出查看日志请使用键盘组合键：Ctrl + a + d"
        sleep 10
        screen -r Fuel
    fi
}

function restart_fuel(){

    screen -X -S Fuel quit

    echo "正在生成P2P密钥..."
    source $HOME/.bashrc
    export PATH=$HOME/.fuelup/bin:$PATH
    echo "正在生成P2P密钥..."
    KEY_OUTPUT=$(fuel-core-keygen new --key-type peering)
    echo "${KEY_OUTPUT}"
    read -p "请从上方输出中复制'secret'值，并在此粘贴: " SECRET
    
    # 用户输入节点名称和RPC地址
    read -p "请输入您想设置的节点名称: " NODE_NAME
    read -p "请输入您的ETH Sepolia RPC地址: " RPC
    
    # 开始配置并运行节点
    echo "开始配置并启动您的fuel节点..."
    sleep 3
    screen -dmS Fuel bash -c "source $HOME/.bashrc; fuel-core run \
    --service-name '${NODE_NAME}' \
    --keypair '${SECRET}' \
    --relayer '${RPC}' \
    --ip 0.0.0.0 --port 4000 --peering-port 30333 \
    --db-path ~/.fuel_beta5 \
    --chain ./chainConfig.json \
    --utxo-validation --poa-instant false --enable-p2p \
    --min-gas-price 1 --max-block-size 18874368  --max-transmit-size 18874368 \
    --reserved-nodes /dns4/p2p-beta-5.fuel.network/tcp/30333/p2p/16Uiu2HAmSMqLSibvGCvg8EFLrpnmrXw1GZ2ADX3U2c9ttQSvFtZX,/dns4/p2p-beta-5.fuel.network/tcp/30334/p2p/16Uiu2HAmVUHZ3Yimoh4fBbFqAb3AC4QR1cyo8bUF4qyi8eiUjpVP \
    --sync-header-batch-size 100 \
    --enable-relayer \
    --relayer-v2-listening-contracts 0x557c5cE22F877d975C2cB13D0a961a182d740fD5 \
    --relayer-da-deploy-height 4867877 \
    --relayer-log-page-size 2000
    "
    
    echo "服务配置和启动完成。"
    sleep 3

}

function main_menu() {
    while true; do
        clear
        echo "请选择要执行的操作:"
        echo "1. 安装节点"
        echo "2. 查看日志"
        echo "3. 重启节点"
        echo "0. 退出脚本"
        
        read -p "请输入选项（0-3）: " OPTION
        
        case $OPTION in
            1) update_and_install ;;
            2) view_logs ;;
            3) restart_fuel ;;
            0) echo "退出脚本。"; exit 0 ;;
            *) echo "无效选项，请重新输入。"; sleep 5 ;;
        esac
    done
}

#主菜单
main_menu
