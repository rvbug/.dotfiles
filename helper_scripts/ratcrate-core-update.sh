
#!/bin/bash

TARGET_DIR="sparse-index"
CORE_DIR="/Users/rv/Documents/projects/ratcrate-core"
REPO_URL="https://github.com/rust-lang/crates.io-index.git"

cd $CORE_DIR
echo "Inside of $CORE_DIR"

if [ -d "$TARGET_DIR/.git" ]; then
    echo "Folder exists. Fetching deltas..."
    cd "$TARGET_DIR"
    # 1. Get the latest commit metadata
    git fetch --depth 1 origin master
    # 2. Force update the files in the folder
    git reset --hard origin/master
    # 3. Clean up any leftover junk
    git clean -dfx
    cd ..
else
    echo "Folder missing. Performing initial shallow clone..."
    git clone --depth 1 $REPO_URL $TARGET_DIR
fi

# Now run your tool
cargo run -- -s .
