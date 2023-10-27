# builder.sh
# builder for nix for the determi-io version of agda's std-lib
source $stdenv/setup

buildPhase() {
    echo "... this is my custom build phase ..."
}

installPhase() {

    # create output directories
    mkdir -p ${out}/bin    # for the binary
    mkdir -p ${out}/share/datadir  # for the primitive agda


    primitive_file="$(find $AGDA -name Primitive.agda)"
    direct_dir="$(dirname $primitive_file)"
    lib_dir="${direct_dir}/../.."

    echo "found agda library dir: $lib_dir"

    # copy the libdir
    cp -r $lib_dir $out/share/datadir/lib
    datadir=$out/share/datadir

    # copy the binary and wrap it with the datadir arg
    cp ${AGDA}/bin/agda ${out}/bin
    wrapProgram ${out}/bin/agda --set Agda_datadir $datadir

    # change permissions
    chmod -R u+w $out

    ls -la $datadir/lib/prim/Agda

    # run agda on each file
    echo "running agda..."
    find $datadir -type f -name "*.agda" -exec $out/bin/agda --no-libraries --local-interfaces "{}" \;
    echo "running agda done"

}

genericBuild

