# if [ "$vars_declared" = false ] ; then
#     echo 'Be careful not to fall off!'
#     set -o allexport
#     source release/rc9/.env
#     set +o allexport
# fi

set -o allexport
source release/rc9/.env
source release/rc9/constants.env
set +o allexport



echo "creating macros."
### Create the macros json file from the environment variables given. (take only vars starting with _macro_)
for var in ${!_macro_@}; do
   jq -n --arg name "$_ddp_prefix-${var//_macro_/}" --arg value "${!var}" '{name: $name, value: $value}'
done | jq -n '.macros |= [inputs]' > release/$_ddp_release_version/macros.json
echo "creating macros. DONE"
### set up infrastructure.json for infra profile
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[0].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[1].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[2].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[3].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json

echo "setting up  infrastructure payload. DONE"

### set up datainfra json for ddp datainfra profile
jq --arg newval "$_ddp_infra_charts_name" '.spec.template.packs[0].name|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_ociregistryUid" '.spec.template.packs[0].registry.metadata.uid|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_ociregistry" '.spec.template.packs[0].registry.metadata.name|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_infra_charts_version" '.spec.template.packs[0].version|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_infra_charts_tag" '.spec.template.packs[0].tag|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_namespace_charts_name" '.spec.template.packs[1].name|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_ociregistryUid" '.spec.template.packs[1].registry.metadata.uid|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_ociregistry" '.spec.template.packs[1].registry.metadata.name|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_namespace_charts_version" '.spec.template.packs[0].version|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json
jq --arg newval "$_ddp_namespace_charts_tag" '.spec.template.packs[0].tag|= $newval' release/$_ddp_release_version/datainfra.json > datainfra.json
mv datainfra.json release/$_ddp_release_version/datainfra.json

echo "setting up  datainfra payload. DONE"
### set up dataproducts.json for ddp dataproducts profile
jq --arg newval "$_ddp_flink_charts_name" '.spec.template.packs[0].name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[0].version|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_tag" '.spec.template.packs[0].tag|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[0].registry.metadata.uid|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_tag" '.spec.template.packs[0].registry.metadata.name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_acm_charts_name" '.spec.template.packs[1].name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_acm_charts_version" '.spec.template.packs[1].version|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_acm_charts_tag" '.spec.template.packs[1].tag|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[1].registry.metadata.uid|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_tag" '.spec.template.packs[1].registry.metadata.name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_wcm_charts_name" '.spec.template.packs[2].name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_wcm_charts_version" '.spec.template.packs[2].version|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_wcm_charts_tag" '.spec.template.packs[2].tag|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[2].registry.metadata.uid|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_tag" '.spec.template.packs[2].registry.metadata.name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_adt_charts_name" '.spec.template.packs[3].name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_adt_charts_version" '.spec.template.packs[3].version|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_adt_charts_tag" '.spec.template.packs[3].tag|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[3].registry.metadata.uid|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
jq --arg newval "$_ddp_flink_charts_tag" '.spec.template.packs[3].registry.metadata.name|= $newval' release/$_ddp_release_version/dataproducts.json > dataproducts.json
mv dataproducts.json release/$_ddp_release_version/dataproducts.json
echo "setting up  dataproducts payload. DONE"
### setup loadbalancer profile
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[0].registry.metadata.uid|= $newval' release/$_ddp_release_version/loadbalancer.json > loadbalancer.json
mv loadbalancer.json release/$_ddp_release_version/loadbalancer.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[1].registry.metadata.uid|= $newval' release/$_ddp_release_version/loadbalancer.json > loadbalancer.json
mv loadbalancer.json release/$_ddp_release_version/loadbalancer.json
echo "setting up  loadbalancer payload. DONE"
echo "release deploying is "$_ddp_release_version

### replace prefix in all files
rm -rf apply_files
mkdir -p apply_files
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/dataproducts.json > apply_files/dataproducts.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/datainfra.json  > apply_files/datainfra.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/infrastructure.json  > apply_files/infrastructure.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/loadbalancer.json  > apply_files/loadbalancer.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/namespaces.json  > apply_files/namespaces.json
cp release/$_ddp_release_version/macros.json apply_files/

echo "Creating macros"
# Create macros
curl -k --location --request POST $BASEURL/v1/projects/$_ddp_projectUid/macros \
--header 'Content-Type: application/json' \
--data "@apply_files/macros.json" \
--header ApiKey:$SpectroAPIKey \
--header 'Accept: application/json' \
--header projectUid:$_ddp_projectUid
echo "Creating macros DONE" 

echo "Creating infrastructure profile"
# create_vmwareinfra_profile:
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/infrastructure.json" \
--header ApiKey:$SpectroAPIKey \
--header 'Accept: application/json' \
--header projectUid:$_ddp_projectUid > config/infrastructureUid.json
echo "Creating infrastructure profile. DONE"

echo "Creating loadbalancer profile"
# create_lb_profile:
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/loadbalancer.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid > config/loadbalancerUid.json
echo "Creating loadbalancer profile. DONE"

echo "Creating namespaces profile"
# create namespace profile
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/namespaces.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid > config/namespacesUid.json
echo "Creating namespaces profile. DONE"

echo "Creating datainfra profile"
# create datainfra profile
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/datainfra.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid > config/datainfraUid.json
echo "Creating datainfra profile. DONE"

echo "Creating dataproducts profile"
# create dataproduct profile
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/dataproducts.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid > config/dataproductsUid.json
echo "Creating dataproducts profile. DONE"

infrastructureUid=$(cat config/infrastructureUid.json| jq '.uid' | sed -e 's/^.//' -e 's/.$//')
loadbalancerUid=$(cat config/loadbalancerUid.json| jq '.uid' | sed -e 's/^.//' -e 's/.$//')
namespacesUid=$(cat config/namespacesUid.json| jq '.uid' | sed -e 's/^.//' -e 's/.$//')
datainfraUid=$(cat config/datainfraUid.json| jq '.uid' | sed -e 's/^.//' -e 's/.$//')
dataproductsUid=$(cat config/dataproductsUid.json| jq '.uid' | sed -e 's/^.//' -e 's/.$//')

### set up cluster json for cluster creation profile
jq --arg newval "$_ddp_node_sshkey" '.spec.cloudConfig.sshKeys|= [$newval]' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_node_ntpserver" '.spec.cloudConfig.ntpServers|= [$newval]' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_datacenter" '.spec.cloudConfig.placement.datacenter|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_folder-$_ddp_prefix" '.spec.cloudConfig.placement.folder|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_imageTemplateFolder" '.spec.cloudConfig.placement.imageTemplateFolder|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_cluster" '.spec.machinePoolConfig[0].cloudConfig.placements[0].cluster|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_resourcepool" '.spec.machinePoolConfig[0].cloudConfig.placements[0].resourcePool|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_datastore" '.spec.machinePoolConfig[0].cloudConfig.placements[0].datastore|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_networkName" '.spec.machinePoolConfig[0].cloudConfig.placements[0].network.networkName|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_parentPoolUid" '.spec.machinePoolConfig[0].cloudConfig.placements[0].network.parentPoolUid|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_cluster" '.spec.machinePoolConfig[1].cloudConfig.placements[0].cluster|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_resourcepool" '.spec.machinePoolConfig[1].cloudConfig.placements[0].resourcePool|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_datastore" '.spec.machinePoolConfig[1].cloudConfig.placements[0].datastore|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_networkName" '.spec.machinePoolConfig[1].cloudConfig.placements[0].network.networkName|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_parentPoolUid" '.spec.machinePoolConfig[1].cloudConfig.placements[0].network.parentPoolUid|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$_ddp_cloudAccountUid" '.spec.cloudAccountUid|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
jq --arg newval "$infrastructureUid" '.spec.profiles[0].uid|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/cluster.json  > apply_files/cluster.json

curl -k --location --request POST "$BASEURL/v1/spectroclusters/vsphere" \
--header 'Content-Type: application/json' \
--data "@apply_files/cluster.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid > config/clusterUid.json
echo "Creating Cluster."

clusterUid=$(cat config/clusterUid.json| jq '.uid' | sed -e 's/^.//' -e 's/.$//')
while [ true ]
do
clusterUp=$(curl --location "$BASEURL/v1/spectroclusters/$clusterUid?ProjectUid=$_ddp_projectUid" --header ApiKey:$SpectroAPIKey | jq '.status.state')
if [ "$clusterUp" == "\"Running\"" ]; then
   echo "Cluster up and running"
   break
else
   echo "Cluster not up and running, sleeping 5 mins"
   sleep 300
fi
done

 
echo "Adding loadbalancer profile"
curl -k --location --request PUT "$BASEURL/v1/spectroclusters/$clusterUid/profiles" \
--header ApiKey:$SpectroAPIKey \
--header 'Content-Type: application/json' \
--header projectUid:$_ddp_projectUid \
--data '{"profiles": [{"uid": "'$infrastructureUid'"},{"uid": "'$loadbalancerUid'"}]}'
echo "Adding loadbalancer profile. DONE"


echo "Adding namespaces profile"
curl -k --location --request PUT "$BASEURL/v1/spectroclusters/$clusterUid/profiles" \
--header ApiKey:$SpectroAPIKey \
--header 'Content-Type: application/json' \
--header projectUid:$_ddp_projectUid \
--data '{"profiles": [{"uid": "'$infrastructureUid'"},{"uid": "'$loadbalancerUid'"},{"uid": "'$namespacesUid'"}]}'
echo "Adding namespaces profile. DONE"

echo "Adding datainfra profile"
curl -k --location --request PUT "$BASEURL/v1/spectroclusters/$clusterUid/profiles" \
--header ApiKey:$SpectroAPIKey \
--header 'Content-Type: application/json' \
--header projectUid:$_ddp_projectUid \
--data '{"profiles": [{"uid": "'$infrastructureUid'"},{"uid": "'$loadbalancerUid'"},{"uid": "'$namespacesUid'"},{"uid": "'$datainfraUid'"}]}'
echo "Adding datainfra profile. DONE"


echo "Adding dataproducts profile"
curl -k --location --request PUT "$BASEURL/v1/spectroclusters/$clusterUid/profiles" \
--header ApiKey:$SpectroAPIKey \
--header 'Content-Type: application/json' \
--header projectUid:$_ddp_projectUid \
--data '{"profiles": [{"uid": "'$infrastructureUid'"},{"uid": "'$loadbalancerUid'"},{"uid": "'$namespacesUid'"},{"uid": "'$datainfraUid'"},{"uid": "'$dataproductsUid'"}]}'
echo "Adding dataproducts profile. DONE"

