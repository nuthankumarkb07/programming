# if [ "$vars_declared" = false ] ; then
#     echo 'Be careful not to fall off!'
#     set -o allexport
#     source release/rc9/.env
#     set +o allexport
# fi
echo 'Be careful not to fall off!'
set -o allexport
source release/rc9/.env
set +o allexport
echo 'Be careful not to fall off!'
set -o allexport
source release/rc9/constants.env
set +o allexport

### Create the macros json file from the environment variables given. (take only vars starting with _macro_)
for var in ${!_macro_@}; do
   jq -n --arg name "$_ddp_prefix-${var//_macro_/}" --arg value "${!var}" '{name: $name, value: $value}'
done | jq -n '.macros |= [inputs]' > release/$_ddp_release_version/macros.json

### set up infrastructure.json for infra profile
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[0].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[1].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[2].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json
jq --arg newval "$_ddp_spectrocloudRegistryUid" '.spec.template.packs[3].registry.metadata.uid|= $newval' release/$_ddp_release_version/infrastructure.json > infrastructure.json
mv infrastructure.json release/$_ddp_release_version/infrastructure.json


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
jq --arg newval "$_ddp_parentPoolUid" '.spec.profiles[0].uid|= $newval' release/$_ddp_release_version/cluster.json > cluster.json
mv cluster.json release/$_ddp_release_version/cluster.json


#   curl -k --location --request POST 'https://spectro-internal.mdh-dev.gehc-ehl.spectrocloud.com/v1/clusterprofiles/import?publish=true' \
#   --header 'Content-Type: application/json' \
#   --header 'ApiKey:6XE4HnU309Q7ujLVINFZE1KdJpnB9BOZ' \
#   --data "@/Users/nuthankumar/sun/github_codebase/onprem-spectrocloud/github_codebase/onprem-spectrocloud/ddp_lb_profile.json" \
#   --header 'Accept: application/json' \
#   --header 'projectUid:62d14030756e0c9d3d00fc2c'

# echo "  [plugins."io.containerd.grpc.v1.cri".registry.configs."lcsdigitaldev.azurecr.io".auth]
#     username = "lcsdigitaldev"
#     password = "8VB7YMGpHh1cWxcdGmToNLcE=z8kSR9x"" | base64

#   curl -k --location --request POST 'https://spectro-internal.mdh-dev.gehc-ehl.spectrocloud.com/v1/clusterprofiles/import?publish=true' \
#   --header 'Content-Type: application/json' \
#   --header 'ApiKey:6XE4HnU309Q7ujLVINFZE1KdJpnB9BOZ' \
#   --data "@/Users/nuthankumar/sun/github_codebase/onprem-spectrocloud/release/rc9/namespaces.json" \
#   --header 'Accept: application/json' \
#   --header 'projectUid:62d14030756e0c9d3d00fc2c'


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

### setup loadbalancer profile
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[0].registry.metadata.uid|= $newval' release/$_ddp_release_version/loadbalancer.json > loadbalancer.json
mv loadbalancer.json release/$_ddp_release_version/loadbalancer.json
jq --arg newval "$_ddp_flink_charts_version" '.spec.template.packs[1].registry.metadata.uid|= $newval' release/$_ddp_release_version/loadbalancer.json > loadbalancer.json
mv loadbalancer.json release/$_ddp_release_version/loadbalancer.json

echo $_ddp_release_version
### replace prefix in all files
rm -rf apply_files
mkdir -p apply_files
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/dataproducts.json > apply_files/dataproducts.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/datainfra.json  > apply_files/datainfra.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/infrastructure.json  > apply_files/infrastructure.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/loadbalancer.json  > apply_files/loadbalancer.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/namespaces.json  > apply_files/namespaces.json
sed "s|_ddp_prefix|$_ddp_prefix|g" release/$_ddp_release_version/cluster.json  > apply_files/cluster.json
cp release/$_ddp_release_version/macros.json apply_files/


# Create macros
curl -k --location --request POST $BASEURL/v1/projects/$_ddp_projectUid/macros \
--header 'Content-Type: application/json' \
--data "@apply_files/macros.json" \
--header ApiKey:$SpectroAPIKey \
--header 'Accept: application/json' \
--header projectUid:$_ddp_projectUid

# create_vmwareinfra_profile:
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/infrastructure.json" \
--header ApiKey:$SpectroAPIKey \
--header 'Accept: application/json' \
--header projectUid:$_ddp_projectUid

# create_lb_profile:
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/loadbalancer.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid

# create namespace profile
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/namespaces.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid

# create datainfra profile
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/datainfra.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid

# create dataproduct profile
curl -k --location --request POST "$BASEURL/v1/clusterprofiles/import?publish=true" \
--header 'Content-Type: application/json' \
--data "@apply_files/dataproducts.json" \
--header ApiKey:$SpectroAPIKey \
--header projectUid:$_ddp_projectUid


