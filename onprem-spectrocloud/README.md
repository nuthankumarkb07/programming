### spectro cloud to provide the below values.
1. mailid=nuthan.basavaraju@ge.com
2. password=
3. BASEURL=https://spectro-internal.mdh-dev.gehc-ehl.spectrocloud.com
4. projectUid=62d14030756e0c9d3d00fc2c
5. _ddp_parentPoolUid=63c7c1f5eda267badec4bc0f
6. _ddp_cloudAccountUid=635a83763b60b45b7c1a3163
7. _ddp_ociregistry=lcsdigitaldev

### IT team should provide these values.
1. _ddp_prefix=csk
2. _ddp_datacenter=CCS-Digital
3. _ddp_folder=DDP-user/ddp-platform/spc-ddp-onprem-$(_ddp_prefix)
4. _ddp_imageTemplateFolder=DDP-user/spectro-templates
5. _ddp_cluster=DDP
6. _ddp_datastore=Localdata31130
7. _ddp_networkName=velocloud

** changes with respect to cluster configuration should be done in cluster.json **

#### macros can be updated in ddp_macros.json

## Steps

+ pipeline1 : All the task for file creation, except for cluster files
+ pipeline2: Create cluster files.
+ pipeline3: Cluster Creation.
+ pipeline4: Add lb and datainfra profiles to cluster.
+ pipeline5: Add dataproduct profiles.

### Execution
##### files creation
- make auth
- make pipeline1
- make pipeline2

** Validate files for changes required and confirm. **

- make auth
- make pipeline3

##### wait for the cluster to get created. (40 minutes approximately)
##### execute only after cluster is created.
- make auth
- make pipeline4

##### wait for the datainfra apps and up and running before executing.
- make auth
- make pipeline5