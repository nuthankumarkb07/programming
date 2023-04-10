
include ./.env
DIR=$(shell pwd)

define GetFromPkg
$(shell node -p "require('$(DIR)/$(Authfile)').$(1)")
endef
Authorization:=$(call GetFromPkg,Authorization)

define GetFromPkg
$(shell node -p "require('$(DIR)/$(infra_profile)').$(1)")
endef
infra_profileUid:=$(call GetFromPkg,uid)

define GetFromPkg
$(shell node -p "require('$(DIR)/$(lb_profile)').$(1)")
endef
lb_profileUid:=$(call GetFromPkg,uid)

define GetFromPkg
$(shell node -p "require('$(DIR)/$(datainfra_profile)').$(1)")
endef
datainfra_profile_Uid:=$(call GetFromPkg,uid)

define GetFromPkg
$(shell node -p "require('$(DIR)/$(dataproduct_profile)').$(1)")
endef
dataproduct_profile_Uid:=$(call GetFromPkg,uid)

define GetFromPkg
$(shell node -p "require('$(DIR)/$(cluster)').$(1)")
endef
clusterUid:=$(call GetFromPkg,uid)


files:
	sed -i 's|_ddp_prefix|$(_ddp_prefix)|g' $(DIR)/ddp_lb_profile.json
	sed -i 's|_ddp_prefix|$(_ddp_prefix)|g' $(DIR)/ddp_native_datainfra.json
	sed -i 's|_ddp_prefix|$(_ddp_prefix)|g' $(DIR)/ddp_native_dataproducts.json
	sed -i 's|_ddp_prefix|$(_ddp_prefix)|g' $(DIR)/ddp_vmwareinfra_profile.json
	sed -i 's|_ddp_prefix|$(_ddp_prefix)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_ociregistry|$(_ddp_ociregistry)|g' $(DIR)/ddp_native_datainfra.json
	sed -i 's|_ddp_ociregistry|$(_ddp_ociregistry)|g' $(DIR)/ddp_native_dataproducts.json

cluster_files:
	sed -i 's|_ddp_cloudAccountUid|$(_ddp_cloudAccountUid)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_datacenter|$(_ddp_datacenter)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_folder|$(_ddp_folder)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_imageTemplateFolder|$(_ddp_imageTemplateFolder)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_cluster|$(_ddp_cluster)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_datastore|$(_ddp_datastore)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_networkName|$(_ddp_networkName)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_parentPoolUid|$(_ddp_parentPoolUid)|g' $(DIR)/cluster.json
	sed -i 's|_ddp_infra_profileUid|$(_ddp_infra_profileUid)|g' $(DIR)/cluster.json

backup_files:
	mkdir -p backup
	cp -r $(DIR)/config $(DIR)/backup 
	cp $(DIR)/*.json $(DIR)/backup

restore_files:
	cp -r $(DIR)/backup/* $(DIR)/
auth:
	
	@echo "---Getting Authorization Token---"
	curl -k --location --request POST '$(BASEURL)/v1/auth/authenticate' \
	--header 'Content-Type: application/json' \
	--data '{"emailId": "$(mailid)","password": "$(password)"}' > $(Authfile)

create_macros:
	curl -k --location --request POST '$(BASEURL)/v1/projects/$(projectUid)/macros' \
	--header 'Content-Type: application/json' \
	--data "@$(DIR)/ddp_macros.json" \
	--header 'Cookie: Authorization=$(Authorization)'

create_vmwareinfra_profile:
	curl -k --location --request POST '$(BASEURL)/v1/clusterprofiles/import?publish=true' \
	--header 'Content-Type: application/json' \
	--data "@$(DIR)/ddp_vmwareinfra_profile.json" \
	--header 'Accept: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' > $(DIR)/$(infra_profile)

create_lb_profile:
	curl -k --location --request POST '$(BASEURL)/v1/clusterprofiles/import?publish=true' \
	--header 'Content-Type: application/json' \
	--data "@$(DIR)/ddp_lb_profile.json" \
	--header 'Accept: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' > $(DIR)/$(lb_profile)

create_native_datainfra_profile:
	curl -k --location --request POST '$(BASEURL)/v1/clusterprofiles/import?publish=true' \
	--header 'Content-Type: application/json' \
	--data "@$(DIR)/ddp_native_datainfra.json" \
	--header 'Accept: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' > $(DIR)/$(datainfra_profile)

create_native_dataproducts_profile:
	curl -k --location --request POST '$(BASEURL)/v1/clusterprofiles/import?publish=true' \
	--header 'Content-Type: application/json' \
	--data "@$(DIR)/ddp_native_dataproducts.json" \
	--header 'Accept: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' > $(DIR)/$(dataproduct_profile)

create_cluster:
	curl -k --location --request POST '$(BASEURL)/v1/spectroclusters/vsphere' \
	--header 'Content-Type: application/json' \
	--data "@$(DIR)/cluster.json" \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' > $(DIR)/$(cluster)

add_lb:
	curl -k --location --request PUT '$(BASEURL)/v1/spectroclusters/$(clusterUid)/profiles' \
	--header 'Content-Type: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' \
	--data '{"profiles": [{"uid": "$(infra_profileUid)"},{"uid": "$(lb_profileUid)"}]}'

add_datainfra:
	curl -k --location --request PUT '$(BASEURL)/v1/spectroclusters/$(clusterUid)/profiles' \
	--header 'Content-Type: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' \
	--data '{"profiles": [{"uid": "$(infra_profileUid)"},{"uid": "$(lb_profileUid)"},{"uid": "$(datainfra_profile_Uid)"}]}'

add_dataproducts:
	curl -k --location --request PUT '$(BASEURL)/v1/spectroclusters/$(clusterUid)/profiles' \
	--header 'Content-Type: application/json' \
	--header 'projectUid: $(projectUid)' \
	--header 'Cookie: Authorization=$(Authorization)' \
	--data '{"profiles": [{"uid": "$(infra_profileUid)"},{"uid": "$(lb_profileUid)"},{"uid": "$(datainfra_profile_Uid)"},{"uid": "$(dataproduct_profile_Uid)"}]}'

pipeline1: files create_vmwareinfra_profile create_lb_profile create_native_datainfra_profile create_native_dataproducts_profile
pipeline2: cluster_files 
pipeline3: create_cluster
pipeline4: add_lb add_datainfra 
pipeline5: add_dataproducts

test:
	sh test.sh


