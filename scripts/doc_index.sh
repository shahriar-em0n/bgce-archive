# #!/usr/bin/env bash

# set -e

# OUTPUT_FILE="docs/src/SUMMARY.md"
# DEST_DIR="docs/src"
# IGNORED_DIRS=("scripts" "docs" ".git" "node_modules")

# echo "🗂️ Generating mdBook SUMMARY at $OUTPUT_FILE..."
# echo "# Summary" > "$OUTPUT_FILE"
# echo "" >> "$OUTPUT_FILE"

# mkdir -p "$DEST_DIR"
# last_top_dir=""

# # Find all README.md files across the project
# find . -type f -iname "README.md" | while read -r file; do
#     # Skip ignored dirs
#     skip=false
#     for ignore in "${IGNORED_DIRS[@]}"; do
#         if [[ "$file" == ./$ignore/* ]]; then
#             skip=true
#             break
#         fi
#     done
#     $skip && continue

#     # Get the full relative path from root
#     relative_path="${file#./}"

#     # Get folder name it's inside (1 level up)
#     parent_dir=$(basename "$(dirname "$file")")
#     title=$(echo "$parent_dir" | sed -E 's/^(.)/\U\1/')  # Capitalize

#     # Build unique filename for the copy
#     sanitized_name="${relative_path//\//__}"    # e.g. "interview-qna/README.md" -> "interview-qna__README.md"
#     dest_filename="$sanitized_name"
#     cp "$file" "$DEST_DIR/$dest_filename"

#     # Add to SUMMARY
#     echo "- [$title]($dest_filename)" >> "$OUTPUT_FILE"
# done

# echo "✅ SUMMARY.md generated at $OUTPUT_FILE"

# -----------
# #!/usr/bin/env bash

# set -e

# OUTPUT_FILE="docs/src/SUMMARY.md"
# DEST_DIR="docs/src"
# IGNORED_DIRS=("scripts" "docs" ".git" "node_modules")

# if [ ! -d "$DEST_DIR" ]; then
#     echo "📁 Creating directory $DEST_DIR..."
#     mkdir -p "$DEST_DIR"
# fi

# echo "🗂️ Generating mdBook SUMMARY at $OUTPUT_FILE..."
# echo "# Summary" > "$OUTPUT_FILE"
# echo "" >> "$OUTPUT_FILE"

# # Prettify titles from filenames or folder names
# function prettify() {
#     echo "$1" | sed -E 's/[-_]/ /g' | awk '{for(i=1;i<=NF;i++)$i=toupper(substr($i,1,1))tolower(substr($i,2)); print}' | paste -sd' ' -
# }

# # Recursive function to walk directories and write to SUMMARY
# function walk_dir() {
#     local src_dir="$1"
#     local dest_subdir="$2"
#     local indent="$3"

#     mkdir -p "$DEST_DIR/$dest_subdir"

#     find "$src_dir" -maxdepth 1 -mindepth 1 | sort | while read -r entry; do
#         # Skip ignored dirs
#         for ignore in "${IGNORED_DIRS[@]}"; do
#             if [[ "$entry" == ./$ignore* || "$entry" == "$ignore"* ]]; then
#                 continue 2
#             fi
#         done

#         if [[ -d "$entry" ]]; then
#             dirname=$(basename "$entry")
#             title=$(prettify "$dirname")
#             echo "${indent}- [$title]()" >> "$OUTPUT_FILE"
#             walk_dir "$entry" "$dest_subdir/$dirname" "$indent  "
#         elif [[ "$entry" == *.md ]]; then
#             rel_path="${entry#./}"  # e.g., interview-qna/README.md
#             filename=$(basename "$entry")
#             title=$(prettify "${filename%.md}")
#             dest_path="$DEST_DIR/$dest_subdir/$filename"

#             # Copy the file into the same structure inside docs/src
#             mkdir -p "$(dirname "$dest_path")"
#             cp "$entry" "$dest_path"

#             # Write the relative path for mdBook
#             echo "${indent}- [$title](${dest_subdir#/}/$filename)" >> "$OUTPUT_FILE"
#         fi
#     done
# }

# # Start from root project directory
# walk_dir "." "." ""

# echo "✅ SUMMARY.md generated at $OUTPUT_FILE with all Markdown files copied."

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
