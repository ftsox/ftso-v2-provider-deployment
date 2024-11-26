## Ubuntu 20.04 fresh instance

# connect to instance
# ssh -i ~/.ssh/migrated/gcp1 mcz@35.211.196.55
ssh -i ~/.ssh/migrated/id_rsa root@68.183.152.248

# update to latest
sudo apt update

# install nvm and activate in shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# install node version 18.X (repo requires < 20)
nvm install --lts=hydrogen

# install yarn
npm install -g yarn

# install dependencies

# jq
sudo apt install jq

# docker
# https://docs.docker.com/engine/install/ubuntu/

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install latest version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# # Install Docker Compose
# sudo apt-get install docker-compose-plugin


## Clone repo
git clone https://github.com/flare-foundation/ftso-v2-provider-deployment.git
cd ftso-v2-provider-deployment/

# Set up .env file
nano .env
# copy in file

# populate configs
./populate_config.sh

# run docker compose
sudo docker compose up -d

# useful commands
sudo docker compose ps  # should show 4 containers running, one for each in docker-compose.yml
sudo docker compose ls
sudo docker compose logs
sudo docker logs ftso-v2-deployment-client
sudo docker system df
sudo docker volume ls
# sudo docker compose down


## Database is persisted in a named docker volume. If you need to wipe database you need to remove the volume manually.
## When codebase is changed new images need to be pulled:
# docker compose pull