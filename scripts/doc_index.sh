#!/usr/bin/env bash

set -e

OUTPUT_FILE="docs/src/SUMMARY.md"
DEST_DIR="docs/src"
IGNORED_DIRS=("scripts" "docs" ".git" "node_modules")

if [ ! -d "$DEST_DIR" ]; then
    echo "📁 Creating directory $DEST_DIR..."
    mkdir -p "$DEST_DIR"
fi

echo "🗂️ Generating mdBook SUMMARY at $OUTPUT_FILE..."
echo "# Summary" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Prettify folder/file names
function prettify() {
    echo "$1" | sed -E 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1))tolower(substr($i,2)); print}' | paste -sd' ' -
}

# Recursive function to process directories
function walk_dir() {
    local current_path="$1"
    local relative_path="$2"
    local indent="$3"

    local has_readme=0
    local readme_path="$current_path/README.md"

    # Check if README exists in current folder
    if [[ -f "$readme_path" ]]; then
        has_readme=1
    fi

    # If this is not root and has a README, list it
    if [[ "$relative_path" != "." && "$has_readme" == 1 ]]; then
        local title
        title=$(prettify "$(basename "$current_path")")

        echo "${indent}- [$title]()" >> "$OUTPUT_FILE"
        local rel_md_path="./${relative_path}/README.md"
        echo "${indent}  - [Readme](${rel_md_path})" >> "$OUTPUT_FILE"

        # Copy README to destination
        local dest_md_path="$DEST_DIR/$relative_path/README.md"
        mkdir -p "$(dirname "$dest_md_path")"
        cp "$readme_path" "$dest_md_path"
    elif [[ "$relative_path" == "." ]]; then
        # root README
        if [[ -f "./README.md" ]]; then
            echo "- [Readme](./README.md)" >> "$OUTPUT_FILE"
            cp "./README.md" "$DEST_DIR/README.md"
        fi
    fi

    # Recursively process subfolders
    find "$current_path" -mindepth 1 -maxdepth 1 -type d | sort | while read -r subdir; do
        local dirname
        dirname=$(basename "$subdir")

        # Skip ignored directories
        for ignore in "${IGNORED_DIRS[@]}"; do
            if [[ "$dirname" == "$ignore" ]]; then
                continue 2
            fi
        done

        walk_dir "$subdir" "${relative_path}/${dirname}" "  ${indent}"
    done
}

# Start from root
walk_dir "." "." ""

echo "✅ SUMMARY.md generated at $OUTPUT_FILE with only README.md files."
