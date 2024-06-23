#!/bin/biash

echo "task is started !"

ssh_directory=$HOME/.test
authorized_keys_file=$ssh_directory/authorized_keys

if [ -z $key_directory ]; then

	echo "Environment variable isn't set.Set it please"
	exit 1
fi

if [ ! -f $authorized_keys_file ]; then

	if [ ! -d $ssh_directory ]; then

		mkdir -p $ssh_directory
		chmod 700 $ssh_directory
		echo "directory created with require permit"
	fi

		touch $authorized_keys_file
		chmod 600 $authorized_keys_file
		echo "authohrized_keys file created with require permit"
		cat $key_directory/*.pub >> $authorized_keys_file
		echo "authorized_keys_file is updated"

else
	echo "authorized_keys file is already exist."

	check_auth_keys=$(mktemp)
		
	cat $key_directory/*.pub > $check_auth_keys

	cat $check_auth_keys
	
	grep -Ff $check_auth_keys $authorized_keys_file > $authorized_keys_file
	 
	cat $authorized_keys_file

	echo "unmatched keys are removed. $authorized_keys_file"

	grep -Fvf $authorized_keys_file $check_auth_keys >> $authorized_keys_file
	
	
	echo "new keys filtered and added. authohrized_keys is up to date"
        

fi


