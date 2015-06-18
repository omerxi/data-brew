# run with:		source install.sh
# download & install dependencies : Java 8, nodejs, Apache Jena,
# https://registry.hub.docker.com/_/java/
# Silk
mkdir $HOME/apps
SILKZIP=silk-singlemachine-2.6.1-20150616.zip
wget https://github.com/silk-framework/silk/releases/download/release-2.6.1/$SILKZIP
unzip $SILKZIP -d $HOME/apps

JENA=~/apps/apache-jena-2.13.0
for f in $JENA/lib/*.jar
do
JENAPATH=$JENAPATH:$f
done

# Jena cf https://registry.hub.docker.com/u/webratio/ant/dockerfile/
# cf https://github.com/inutano/bh14-docker-recipes/issues/1
PATH=$JENA/bin:$PATH

