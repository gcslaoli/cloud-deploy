#!/bin/bash
# Copy your SSH public key to a multipass instance
# Usage: multipass-copy-id.sh [-f <file>] [-h] <instance>
#   -f <file>  The file containing the public key to copy (default: ~/.ssh/id_rsa.pub)
#   -h Display help
#   <instance> The name of the instance to copy the key to
# Example: multipass-copy-id.sh -f ~/.ssh/id_ed25519.pub my-ubuntu
# Example: multipass-copy-id.sh my-ubuntu
# Author: LiDong
# Date: 2020-12-05

# The file containing the public key to copy
PUBKEY_FILE=~/.ssh/id_rsa.pub

# Parse the command line arguments
while getopts "f:h" opt; do
    case $opt in
        f)
            PUBKEY_FILE=$OPTARG
            ;;
        h)
            echo "This is the help file."
            exit 1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

# Check if the public key file exists
if [ ! -f "$PUBKEY_FILE" ]; then
    echo "Public key file not found: $PUBKEY_FILE" >&2
    exit 1
fi

# Check if the instance name is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 [-f <file>] <instance>" >&2
    exit 1
fi

# 设置虚拟机名称
vm_name=$1

# 检查虚拟机是否存在
if ! multipass list | grep -q $vm_name; then
    echo "Virtual machine $vm_name does not exist"
    exit 1
fi

# 增加本地公钥到虚拟机
multipass exec $vm_name -- bash -c "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>~/.ssh/authorized_keys" < $PUBKEY_FILE

# 设置权限
multipass exec $vm_name -- bash -c "chmod 600 ~/.ssh/authorized_keys"

# 提示成功
echo "Successfully added ssh key to $vm_name"