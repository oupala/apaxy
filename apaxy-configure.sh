#!/bin/bash
echo "Apaxy Configurator - by Jordan Bancino"
echo "Checking configuration..."

CONFIG="apaxy.config"

if [ -f "$CONFIG" ]; then
    . "$CONFIG"
else
    echo "Apaxy configuration not found! Please restore or create the configuration file: $CONFIG"
    exit 1
fi

if [ -v INSTALL_DIRECTORY ] && [ -v WEB_ROOT ]; then
    echo "- Configuring Apaxy for use in directory: $INSTALL_DIRECTORY (Web root: $WEB_ROOT)"
    mkdir -p "$WEB_ROOT$INSTALL_DIRECTORY"
    if [ ! -w "$WEB_ROOT$INSTALL_DIRECTORY" ] || [ ! -d "$WEB_ROOT$INSTALL_DIRECTORY" ]; then
    	echo "Directory does not exist or is not writable by the current user: $WEB_ROOT$INSTALL_DIRECTORY"
	exit 1
    fi
else
    echo "No directory specified! Please define the INSTALL_DIRECTORY and WEB_ROOT variables in $CONFIG"
    exit 1
fi

echo "Copying files to web root..."
cp -r . "$WEB_ROOT$INSTALL_DIRECTORY"
cd "$WEB_ROOT$INSTALL_DIRECTORY"

if [ -v HTACCESS ]; then
    if [ -f "$HTACCESS" ]; then
        echo "- Using template: $HTACCESS to generate configuration"
    else
        echo "Configuration template does not exist! Please specify an existing configuration template in $CONFIG"
        exit 1
    fi
else
    echo "No configuration template specified. Please define the HTACCESS variable in $CONFIG"
    exit 1
fi

if [ ! -v TEMPLATE_VAR_FOLDERNAME ]; then
    echo "No foldername variable defined. Please define the TEMPLATE_VAR_FOLDERNAME variable in $CONFIG"
    exit
fi

echo "Configuring..."
echo "- Generating .htaccess..."
sed "s|$TEMPLATE_VAR_FOLDERNAME|$INSTALL_DIRECTORY/apaxy/|g" <"$HTACCESS" >"$HTACCESS_OUTPUT"

echo "- Setting variables in documents..."
# find all the HTML files and replace the variable in them.
# This will automatically take care of the error pages, headers and
# footers.
FILES=$(find -name "*.html")
while read -r file; do
    sed -i "s|$TEMPLATE_VAR_FOLDERNAME|$INSTALL_DIRECTORY/apaxy/|g" "$file"
done <<< "$FILES"

if [ -v THEME_HTACCESS_IN ] && [ -v THEME_HTACCESS_OUT ]; then
    echo "- Activating theme configuration..."
    mv "$THEME_HTACCESS_IN" "$THEME_HTACCESS_OUT"
fi

# TODO:
# - Implement any other options we want here

echo "Done."
exit 0
