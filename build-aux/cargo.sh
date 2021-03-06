#!/bin/sh

export MESON_BUILD_ROOT="$1"
export MESON_SOURCE_ROOT="$2"
export CARGO_TARGET_DIR="$MESON_BUILD_ROOT"/target
export CARGO_HOME="$CARGO_TARGET_DIR"/cargo-home
export OUTPUT="$3"
export BUILDTYPE="$4"
export APP_BIN="$5"


if [ $BUILDTYPE = "release" ]
then
    echo "RELEASE MODE"
    cargo build --manifest-path \
        "$MESON_SOURCE_ROOT"/Cargo.toml --release --package=gtk-app && \
        cp "$CARGO_TARGET_DIR"/release/gtk-app "$CARGO_TARGET_DIR"/release/"$APP_BIN" && \
        cp "$CARGO_TARGET_DIR"/release/"$APP_BIN" "$OUTPUT"
else
    echo "DEBUG MODE"
    cargo build --manifest-path \
        "$MESON_SOURCE_ROOT"/Cargo.toml --verbose --package=gtk-app && \
        cp "$CARGO_TARGET_DIR"/debug/gtk-app "$CARGO_TARGET_DIR"/debug/"$APP_BIN" && \
        cp "$CARGO_TARGET_DIR"/debug/"$APP_BIN" "$OUTPUT"
fi

