#!/bin/bash

# ==============================================
# SCRIPT sed.sh
# DESCRIPTION: Demonstrates how to use sed.
#              Sed is a stream editor that is used to perform basic text transformations on an input stream (a file or input).
# USAGE: First make the script executable with `chmod +x sed.sh` and then run it with `./sed.sh`.
# ==============================================

# ==============================================
# UTILITY FUNCTIONS
# ==============================================

# CREATE A FILE
# This command creates a file named $filename with the specified $content.
create_file() {
    echo ""
    echo "---"
    echo ""

    local heading=$1
    local filename=$2
    local content=$3

    echo "$heading"
    echo "Creating $filename..."

    # %s is a format specifier that means "string". It allows us to print the content with newlines.
    # \n is a newline character.
    printf "%s\n" "$content"
    echo "$content" >"../resources/sed/$filename"
    echo ""
    echo "Running commands..."
}

# ==============================================

create_file "PRINTING A SPECIFIC LINE FROM A FILE" "file-01.txt" "line 1
line 2
line 3
line 4
line 5"

# PRINTING A SPECIFIC LINE FROM A FILE
# This command prints the 3rd line from file.txt.
# The `-n` option suppresses automatic printing, and `3p` prints only the 3rd line.
sed -n '3p' ../resources/sed/file-01.txt

# ==============================================

create_file "DELETING A SPECIFIC LINE FROM A FILE" "file-02.txt" "line 1
line 2
line 3
line 4
line 5"

# DELETING A SPECIFIC LINE FROM A FILE
# This command removes the 2nd line from file.txt.
# The `2d` tells `sed` to delete the second line. The 2 is the line number, and d is the delete command.
sed '2d' ../resources/sed/file-02.txt

# ==============================================

create_file "REPLACING THE FIRST OCCURRENCE OF A STRING ON EACH LINE IN A FILE" "file-03.txt" "super super 1
super super 2
super super 3
super super 4
super super 5"

# REPLACING THE FIRST OCCURRENCE OF A STRING ON EACH LINE IN A FILE
# This command replaces the first occurrence of 'line' with 'word' in file.txt.
# The `s` command substitutes 'line' with 'word'.
# Syntax: `s/old/new/`
sed 's/super/very/' ../resources/sed/file-03.txt

# ==============================================

create_file "REPLACING ALL OCCURRENCES OF A STRING IN A FILE" "file-04.txt" "super super 1
super super 2
super super 3
super super 4
super super 5"

# REPLACING ALL OCCURRENCES OF A STRING IN A FILE
# This command replaces all occurrences of 'old' with 'new' in file.txt.
# The `g` flag replaces all occurrences of 'old' with 'new' on each line.
sed 's/super/very/g' ../resources/sed/file-04.txt

# ==============================================
create_file "IN-PLACE EDITING MODIFICATIONS USING -I" "file-05.txt" "super super 1
super super 2
super super 3
super super 4
super super 5"

# IN-PLACE EDITING MODIFICATIONS USING SED -I
# The -i (in-place) modifies the file directly instead of just printing the result.
#   E.g. sed 's/super/very/g' ../resources/sed/file-04.txt will print the result to the console, but the file will remain unchanged. However, sed -i '' 's/super/very/g' ../resources/sed/file-04.txt will modify the file directly.
# The command below replaces all occurrences of 'super' with 'very' in file-05.txt.
# On Mac, an empty string is required for the `-i` option to avoid creating a backup file (empty string for no backup). On linux -i can be used without the ''
sed -i '' 's/super/very/g' ../resources/sed/file-05.txt
cat ../resources/sed/file-05.txt

# ==============================================
create_file "IN-PLACE EDITING MODIFICATIONS USING SED -I WITH BACKUP" "file-06.txt" "super super 1
super super 2
super super 3
super super 4
super super 5"

# IN-PLACE EDITING MODIFICATIONS USING `SED -I` WITH BACKUP
# The `-i.bak` option tells `sed` to edit the file in place and create a backup file.
# This command replaces all occurrences of 'super' with 'vary' in file-06.txt and creates a backup file.
sed -i.bak 's/super/very/g' ../resources/sed/file-06.txt
cat ../resources/sed/file-06.txt

# ==============================================

create_file "USING A DIFFERENT DELIMITER" "file-07.txt" "s/usr/bin"

# USING A DIFFERENT DELIMITER
# This command replaces all occurrences of '/usr/bin' with '/opt/bin' in file.txt.
# The `#` delimiter is used instead of `/` to avoid escaping the slashes.
sed 's#/usr/bin#/opt/bin#g' ../resources/sed/file-07.txt

# ==============================================

create_file "REPLACING A STRING IN A SPECIFIC LINE" "file-08.txt" "super super 1
super super 2
super super 3
super super 4
super super 5"

# REPLACING A STRING IN A SPECIFIC LINE
# This command replaces the first occurrence of 'super' with 'very' in the 2nd line of file-08.txt.
sed '2s/super/very/' ../resources/sed/file-08.txt

# ==============================================

create_file "REPLACING MULTIPLE STRINGS IN A FILE" "file-09.txt" "foo baz 
foo baz
foo baz
foo baz
foo baz"

# REPLACING MULTIPLE STRINGS IN A FILE
# This command replaces 'foo' with 'bar' and 'baz' with 'qux' in file.txt.
# The `-e` option allows multiple `sed` commands to be executed.
# e stands for expression.
sed -e 's/foo/bar/g' -e 's/baz/qux/g' ../resources/sed/file-09.txt

# ==============================================

create_file "PRINTING LINES THAT MATCH A PATTERN" "file-10.txt" "hello world 
hello world
hello australia
hello world
hello greenland"

# PRINTING LINES THAT MATCH A PATTERN
# Syntax: `sed '/pattern/p' file.txt`, prints lines that contain 'pattern', the `p` command prints the line.
# This command replaces 'world' with 'planet' in lines that contain 'hello' in file.txt.
# The `/hello/` restricts the replacement to lines that contain 'pattern'.
sed '/hello/s/world/planet/' ../resources/sed/file-10.txt

# ==============================================

create_file "PRINTING LINES THAT MATCH PATTERN WITH MULTIPLE COMMANDS" "file-11.txt" "hello world 
hello world
hello australia
hello world
hello greenland"

# PRINTING LINES THAT MATCH PATTERN WITH MULTIPLE COMMANDS
# Syntax: `sed '/pattern/p' file.txt`, prints lines that contain 'pattern', the `p` command prints the line.
# This command replaces 'world' with 'planet' in lines that contain 'hello' in file.txt.
# The `/hello/` restricts the replacement to lines that contain 'pattern'.
# The -e option allows multiple `sed` commands to be executed.
sed -e '/hello/s/world/planet/' -e '/planet/s/planet/nice place/' ../resources/sed/file-11.txt

# ==============================================

create_file "PRINTING LINES BETWEEN TWO PATTERNS" "file-12.txt" "hello world
bye world
hello australia
bye world
hello greenland"

# PRINTING LINES THAT MATCH A PATTERN
# This command will replace 'hello' with 'Hi' in file-12.txt if the line starts with 'hello'.
# The `^` matches the beginning of a line
# The 's' command substitutes the entire line with itself
sed 's/^hello/Hi/' ../resources/sed/file-12.txt

# ==============================================

create_file "REPLACING A STRING IN A SPECIFIC LINE" "file-13.txt" "root:x:0:0:root:/root:/bin/bash
user2:x:1000:1000:user:/home/user:/bin/bash
user2:x:1001:1001:user2:/home/user2:/bin/bash
user3:x:1002:1002:user3:/home/user3:/bin/bash
user4:x:1003:1003:user4:/home/user4:/bin/bash"

# REPLACING A STRING IN A SPECIFIC LINE
# This command will replace root's shell from /bin/bash to /sbin/nologin in /etc/passwd.
# -i option is used to edit the file in place.
# '' is used to specify that no backup file should be created this is only on Mac on linux -i can be used without the ''
# The `^root:` matches lines that start with 'root:'
# The `s` command substitutes the entire line with itself
# The `#` delimiter is used instead of `/` to avoid escaping the slashes.
#  The delimiter is to separate the pattern and replacement. Usually we use / as the delimiter, but because we have file paths with /, we use # as the delimiter.
#  However, when working with file paths, / appears frequently. If we use / as the delimiter in this command, it becomes hard to read and may cause confusion
#  Here, / is part of both the pattern and replacement, making it unclear which / belongs to the command syntax and which is part of the file paths.
#  Remember the syntax is sed 's<delimiter>pattern<delimiter>replacement<delimiter>'
sed -i '' 's#^root:x:0:0:root:/root:/bin/bash#root:x:0:0:root:/root:/sbin/nologin#' ../resources/sed/file-13.txt
cat ../resources/sed/file-13.txt
