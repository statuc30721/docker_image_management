#!/usr/bin/env bash
# Purpose: Pull Images from Docker Hub website.
# Created: 20 April 2025
# Author:

# Variables
DOCKER_CMD=$(/usr/bin/which docker)
TEMPDIR="/tmp/image_pull_workdir"
MAKE_DIR_CMD=$(which mkdir) 
DELETE_FILES_CMD=$(which rm)
DELETE_DIRECTORY_CMD=$(which rmdir)

# Workflow

# Create a temporary working directory

if [[ -d ${TEMPDIR} ]]; then 
echo "Working directory ${TEMPDIR} does exist."

elif [[ ! -d ${TEMPDIR} ]]; then
echo "${TEMPDIR} does not exist, creating temporary working directory."
${MAKE_DIR_CMD} -p ${TEMPDIR}
fi



# Generate a list of images on the local system and 
# push to file under system temporary directory.
${DOCKER_CMD} images | grep -v 'REPOSITORY' | awk '{ print $1 }' > ${TEMPDIR}/local_images.txt


# Pull the "latest" image from repository.
for image in $(cat ${TEMPDIR}/local_images.txt); 
do echo ${image};
${DOCKER_CMD} pull ${image};
done

# Cleanup directory when finished pulling images.
echo "Removing image listing file from ${TEMPDIR}."
${DELETE_FILES_CMD} -v ${TEMPDIR}/local_images.txt

echo "Removing temporary working directory ${TEMPDIR}."
${DELETE_DIRECTORY_CMD} -v ${TEMPDIR}

# Print current list of images on local system.
# Check for "dangling images" on local system.

if $(${DOCKER_CMD} images | grep -q "<none>"); then 
echo "There are dangling images on this system!"
${DOCKER_CMD} images | grep "<none>"
else
echo "There are no dangling images on this system."
fi

exit 0
