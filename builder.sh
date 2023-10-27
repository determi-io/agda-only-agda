# builder for nix for the determi-io version of agda's std-lib

set -e

# create output directories
$MKDIR -p ${out}/bin    # for the binary
$MKDIR -p ${out}/share/datadir  # for the primitive agda

# copy the binary
$CP ${AGDA}/bin/agda ${out}/bin

primitive_file="$($FIND $AGDA -name Primitive.agda)"
direct_dir="$($DIRNAME $primitive_file)"
lib_dir="${direct_dir}/../.."

$ECHO "found agda library dir: $lib_dir"

# copy the libdir
$CP -r $lib_dir $out/share/datadir/lib
datadir=$out/share/datadir

# change permissions
$CHMOD -R u+w $out

$LS -la $datadir/lib/prim/Agda

# run agda on each file
$ECHO "running agda..."
Agda_datadir=$datadir $FIND $datadir -type f -name "*.agda" -exec $out/bin/agda --no-libraries --local-interfaces "{}" \;
$ECHO "running agda done"
