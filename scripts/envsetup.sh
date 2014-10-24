#!/bin/bash

##################################################################
#
#
# Public Enviroment Settings
#
#
##################################################################
CB_SDK_ROOTDIR=
CB_PRODUCT_NAME=
CB_PRODUCT_DIR=
CB_OUTPUT_DIR=
CB_BUILD_DIR=
CB_TARGET_DIR=
CB_KSRC_DIR=
CB_KBUILD_DIR=
CB_TOOLS_DIR=
CB_PACKAGES_DIR=
CB_RELEASE_DIR=

cb_get_product()
{
    local array
    local index
    local target
    local product

    array=(`ls products |sort`)
    echo "Products"
    for index in ${!array[*]}
    do
	printf "%4d - %s\n" $index ${array[$index]}
    done

    read -p "please select a product:" target

    for index in ${!array[*]}
    do
	if [ "${index}" == "${target}" ]; then
	    CB_PRODUCT_NAME="${array[$target]}"
	fi
    done
}

cb_get_product

while [ -z "$CB_PRODUCT_NAME" ]; do
    cb_get_product
done

export CB_SDK_ROOTDIR=${PWD}
export CB_PRODUCT_NAME
export CB_OUTPUT_DIR=${CB_SDK_ROOTDIR}/output/${CB_PRODUCT_NAME}
export CB_BUILD_DIR=${CB_SDK_ROOTDIR}/build/${CB_PRODUCT_NAME}
export CB_TARGET_DIR=${CB_OUTPUT_DIR}/target
export CB_PRODUCT_DIR=${CB_SDK_ROOTDIR}/products/${CB_PRODUCT_NAME}
export CB_RELEASE_DIR=${CB_SDK_ROOTDIR}/release/${CB_PRODUCT_NAME}
export CB_TOOLS_DIR=${CB_SDK_ROOTDIR}/tools
export CB_KSRC_DIR=${CB_SDK_ROOTDIR}/linux-sunxi
export CB_KBUILD_DIR=${CB_BUILD_DIR}/linux
export CB_PACKBUILD_DIR=${CB_BUILD_DIR}/pack
export CB_CROSS_COMPILE=arm-linux-gnueabi-
export CB_PACKAGES_DIR=${CB_SDK_ROOTDIR}/binaries

echo "Creating working dirs"
mkdir -p ${CB_OUTPUT_DIR} ${CB_BUILD_DIR} ${CB_KBUILD_DIR} ${CB_PACKBUILD_DIR} ${CB_TARGET_DIR}
source ${CB_PRODUCT_DIR}/envsetup.sh
source ${CB_TOOLS_DIR}/scripts/helper-sd.sh

if [ -f ${CB_PRODUCT_DIR}/readme.txt ]; then
echo ""
cat  ${CB_PRODUCT_DIR}/readme.txt
fi

crelease()
{
    cd $CB_RELEASE_DIR
}

clinux()
{
    cd $CB_KSRC_DIR
}

cout()
{
    cd $CB_OUTPUT_DIR
}

croot()
{
    cd $CB_SDK_ROOTDIR
}

cbuild()
{
    cd $CB_BUILD_DIR
}

ctarget()
{
    cd $CB_TARGET_DIR
}

cpack()
{
    cd $CB_PACKBUILD_DIR
}

ckbuild()
{
    cd $CB_KBUILD_DIR
}
