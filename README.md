# cloud-deploy

## 启动

```bash
docker-compose run --rm cloud-deploy bash
```

## ansible

查看版本

```bash
ansible --version
```

查看 playbook 版本

```bash
ansible-playbook --version
```

查看 ansible 配置

```bash
ansible-config dump
```

执行 playbook

```bash
ansible-playbook -i hosts playbook.yml
```
