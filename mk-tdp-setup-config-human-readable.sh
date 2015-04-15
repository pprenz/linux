sed 's/\(<property Name="[^ ]\)\([^ ]\+\)\(\>\)/\n\1\2\3/g' tdp-setup-config.xml | sed 's/\(<component Name="[^ ]\)\([^ ]\+\)\(\>\)/\n\n\1\2\3/g'
