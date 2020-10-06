PROJECT_DIR=$1

eval SWIFTGEN=$(printf %q "$PROJECT_DIR/scripts/swiftgen/bin/swiftgen")
eval RESOURCES_DIR=$(printf %q "$PROJECT_DIR/TestProjectApp/Resources")

# Localizable strings
"$SWIFTGEN" strings "$RESOURCES_DIR/Localizable.strings" -t structured-swift4 -o "$RESOURCES_DIR/Strings.swift"

#Storyboards
"$SWIFTGEN" storyboards "$PROJECT_DIR/TestProjectApp" -t scenes-swift4 --param enumName=Storyboard -o "$RESOURCES_DIR/Storyboards.swift"
