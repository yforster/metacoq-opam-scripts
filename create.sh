#!/bin/bash

COQVERS="8.11
8.12
8.13"

for ver in $COQVERS
do

  COQVER=$ver
	BRANCH=coq-$COQVER
	VERSION=1.0
	SUFFIX=beta2
	FULLVERSION=$VERSION~$SUFFIX+$COQVER
	SRC=https://github.com/MetaCoq/metacoq/archive/v$VERSION-$SUFFIX-$COQVER.tar.gz
	
  echo "Downloading opam files for coq-$COQVER"

	git clone -b $BRANCH --depth 1 https://github.com/MetaCoq/metacoq.git metacoq-repo
	cp metacoq-repo/*.opam .
	rm -rf metacoq-repo
	
	echo "Downloading archive from $SRC"
	
	curl $SRC > tarfile
	CHECKSUM=`sha256sum tarfile | cut -d " " -f 1 `
	
	echo "Archive sha256 checksum is $CHECKSUM"

  rm tarfile
	
	FILES=*.opam
	for f in $FILES
	do
	    echo "Creating package ${f%.opam}.$FULLVERSION"
	    mkdir -p ${f%.opam}
	    cd ${f%.opam}
	    mkdir ${f%.opam}.$FULLVERSION
	    cd ${f%.opam}.$FULLVERSION
	    cp ../../$f opam
	    cat << EOF >> opam
url {
  src: "$SRC"
  checksum: "sha256=$CHECKSUM"
}
EOF
	    cd ../..
	done

  rm -f *.opam
done
