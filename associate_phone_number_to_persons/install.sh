# download & install dependencies : Java 8, nodejs, Apache Jena,
# https://registry.hub.docker.com/_/java/

source config.sh

# Silk
mkdir $HOME/apps

wget https://github.com/silk-framework/silk/releases/download/release-2.6.1/$SILKZIP
unzip $SILKZIP -d $HOME/apps

# Jena cf https://registry.hub.docker.com/u/webratio/ant/dockerfile/
# cf https://github.com/inutano/bh14-docker-recipes/issues/1

