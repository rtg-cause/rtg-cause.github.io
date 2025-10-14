#!/bin/python3
import os

def check_text_after_second_dashes(file_path):
    """
    Checks if there is any non-empty text after the second occurrence of '---' line in a file.
    """
    print("Processing " + file_path)
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    dash_count = 0
    second_dash_index = None

    for i, line in enumerate(lines):
        if line.strip() == "---":
            dash_count += 1
            if dash_count == 2:
                second_dash_index = i
                break

    if second_dash_index is None:
        print("There are fewer than two '---' lines in the file.")
        return False

    # Check for any non-empty text after the second occurrence
    for line in lines[second_dash_index + 1:]:
        if line.strip():  # Non-empty line found
            print("There is text after the second '---' line.")
            return True

    print("Missing bio in "+ file_path)
    return False



def get_markdown_files():
    """
    Returns a list of all files in the current directory that end with '.md'.
    """
    return [f for f in os.listdir('.') if os.path.isfile(f) and f.lower().endswith('.md')]

bioOK= []
bioMissing= []
# Example usage:
if __name__ == "__main__":
    md_files = get_markdown_files()
    print("Markdown files found:")
    for f in md_files:
        #print(" -", f)
        if (check_text_after_second_dashes(f)):
          bioOK.append(f)
        else:
          bioMissing.append(f)
print("Bio available for")
print(", ".join(bioOK))
print("No bio for")
print(", ".join(bioMissing))
