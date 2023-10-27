# builder for nix for the determi-io version of agda's std-lib

set -e

# create output directories
$MKDIR -p $out/bin    # for the binary
$MKDIR -p $out/share  # for the primitive agda

# copy the binary
$CP $AGDA/bin/agda $out/bin



# # step 1: change to root of stdlib
# cd $out

# # $MKDIR -p $out/local-stack-root

# # $ECHO "hello?"
# # $ECHO $out
# $ECHO $src
# $ECHO $out
# $LS -la $out
# $CHMOD -R u+w $out
# # $PWD

# $LOCALE -a

# # $LS -la

# # # step 2: use stack to generate the "Everything.agda" file
# # $STACK run GenerateEverything --stack-root $out/local-stack-root --stack-yaml stack-9.2.8.yaml

# # step 3: typecheck the file with agda
# $AGDA $out/src/Everything.agda
# # $AGDA $out/src/Text/Tabular/Vec.agda


