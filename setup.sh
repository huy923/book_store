#!/bin/bash

VENV_DIR=".venv"

# function check_error
check_error() {
    if [ $? -ne 0 ]; then
        echo "❌ Error"
        exit 1
    fi

# OS type
OS_TYPE="$(uname -s)"
echo "🖥️  OS: $OS_TYPE"

# activate virtual environment
if [[ "$OS_TYPE" == "Linux" || "$OS_TYPE" == "Darwin" ]]; then 
    # linux or mac
    echo "⚙️  Active virtual environment..."
    source "$VENV_DIR/bin/activate"
elif [[ "$OS_TYPE" =~ MINGW* || "$OS_TYPE" =~ MSYS* || "$OS_TYPE" =~ CYGWIN* ]]; then
    echo "⚙️  active virtual Win..."
    $VENV_DIR/Scripts/activate
else
    echo "❗ Error"
    exit 1
fi
check_error

echo "📦 install package"
pip install -r requirements.txt
check_error

echo "🛠️  Run Django migrations..."
python manage.py makemigrations
python manage.py migrate
check_error

echo "🚀 Start server Django..."
python manage.py runserver
