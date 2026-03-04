#!/usr/bin/bash

echo -e '\nScript execution for manual packaging triggered...\n'

# Declare variables
output_dir="output/manual"
zip_file=veracode-manual-pack-realview-c_cpp.zip

# Delete 'manual' directory
rm -rf $output_dir
echo -e  'Deleted realview/.veracode/'$output_dir' directory...\n'

# Create 'manual' directory inside 'output' directory
mkdir -p $output_dir
echo -e  'Created realview/.veracode/'$output_dir' directory...\n'

# Loop over the binaries in the "flashback/build" directory to see if the debug flag is present.
#----- for loop start -----#
for filename in $(find ./../build -type f ! -path '*/CMakeFiles/*' ! -name '*.o');
  do
	# 'readelf' is used to check if the debug flag is present.
	  debugCount=$(readelf -S $filename | grep -c "debug")
	  # echo ${debugCount}
	  if ((${debugCount}==0)); then
    		echo Skipping the file: $filename
  	  else
    	  	# echo Archiving the file: $filename
		zip $output_dir/$zip_file $filename
	  fi;
  done;
#----- for loop end -----#

# On successful archive creation, print archive path & archived file count.
if test -f $output_dir/$zip_file; then 
	echo -e '\n'Created "$zip_file" at path: realview/.veracode/$output_dir/$zip_file

	total_archive_count=$(unzip -l $output_dir/$zip_file | grep "../build" | wc -l)
	echo 'File(s) archived in total:' $total_archive_count
fi;
