#!/bin/bash

#usage
#set following terraform variables
#export PROFILE=<aws-profile>
#export ENVIRONMENT=<environment> #e.g. test
#export REGION=<region> #e.g. eu-west-1
#export RESOURCE=<resource-name> #e.g.  dynamodb-table

SUBCOMMAND=$1
#prefix for the project - must be unique
PROJECT="<TODO>"

FULL_BUCKET_NAME="${PROJECT}-${REGION}-${ENVIRONMENT}-dolittle-tf-backend-bucket"
FULL_DYNAMO_TABLE="${PROJECT}-${REGION}-${ENVIRONMENT}-dolittle-tf-backend-table"
BACKEND_STATE_FILE="${REGION}/${ENVIRONMENT}/${RESOURCE}.tfstate"
TF_VARS_FILE='../terraform.tfvars'

ROOT_DIR='environments'
OPTIONS="-var-file=${TF_VARS_FILE} -var profile=${PROFILE} -var region=${REGION} -var environment=${ENVIRONMENT} -var project=${PROJECT} -var resource=${RESOURCE}"

_cmd_init() {
  cd ${ROOT_DIR}/${REGION}/${ENVIRONMENT}/${RESOURCE} && terraform init -backend-config="region=${REGION}" \
    -backend-config="bucket=${FULL_BUCKET_NAME}" \
    -backend-config="dynamodb_table=${FULL_DYNAMO_TABLE}" \
    -backend-config="key=${BACKEND_STATE_FILE}" \
    -backend-config="profile=${PROFILE}"
  cd -
}

_cmd_plan() {
  cd ${ROOT_DIR}/${REGION}/${ENVIRONMENT}/${RESOURCE} && terraform plan $OPTIONS
}

_cmd_apply() {
  cd ${ROOT_DIR}/${REGION}/${ENVIRONMENT}/${RESOURCE} && terraform apply $OPTIONS
}

_cmd_destroy() {
  cd ${ROOT_DIR}/${REGION}/${ENVIRONMENT}/${RESOURCE} && terraform destroy $OPTIONS
}

_cmd_backend(){
  cd "${ROOT_DIR}/${REGION}/${ENVIRONMENT}/${RESOURCE}" && terraform init \
  && terraform apply -var="project=${PROJECT}" -var="environment=${ENVIRONMENT}" \
                     		-var="region=${REGION}" -var="resource=${RESOURCE}" \
                     		 -var="profile=${PROFILE}" -var-file=${TF_VARS_FILE}
}

_cmd_backend_destroy(){
  cd "${ROOT_DIR}/${REGION}/${ENVIRONMENT}/${RESOURCE}" && terraform init \
  && terraform destroy -var="project=${PROJECT}" -var="environment=${ENVIRONMENT}" \
                     		-var="region=${REGION}" -var="resource=${RESOURCE}" \
                     		 -var="profile=${PROFILE}" -var-file=${TF_VARS_FILE}
}


if [[ $SUBCOMMAND == "init" ]]; then
  _cmd_init
elif [[ $SUBCOMMAND == "plan" ]]; then
  _cmd_init
  _cmd_plan
elif [[ $SUBCOMMAND == "apply" ]]; then
  _cmd_init
  _cmd_apply
elif [[ $SUBCOMMAND == "backend" ]]; then
  _cmd_backend
elif [[ $SUBCOMMAND == "backend_destroy" ]]; then
  _cmd_backend_destroy
elif [[ $SUBCOMMAND == "destroy" ]]; then
  _cmd_init
  _cmd_destroy
fi

