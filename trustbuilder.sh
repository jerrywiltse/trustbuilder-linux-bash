remoteHost=$1
remotePort=$2
keyPath=/root/.ssh
localId=tbldr-$(hostname)-key
remoteId=NotYetSet

#
#  Generate the local Key
#
ssh-keygen -t dsa -N '' -C $localId -f $keyPath/$localId
#
#  Copy the local public key to the remote machine
#
rsync -rvpe "ssh -p $remotePort" $keyPath/$localId.pub $remoteHost:$keyPath/
#
#  Connect to remote machine shell and cat the local public key to the remote "authorized_keys" file
#
ssh $remoteHost -p $remotePort "cat $keyPath/$localId.pub >> $keyPath/authorized_keys"
#
#  One way trust has now been established
#  Connect again to get the remote hostname into a variable, Now no password required
#
remoteName=$(ssh $remoteHost -p $remotePort -i $keyPath/$localId "hostname")
#
#  Use the remote hostname to form the name of the remote identity and key filenames
#
remoteId=tbldr-$remoteName-key
#
#  Connect to remote machine shell again and generate the remote keys
#
ssh $remoteHost -p $remotePort -i $keyPath/$localId "ssh-keygen -t dsa -N '' -C $remoteId -f $keyPath/$remoteId"
#
# Copy remote key to local machine
#
rsync -rvpe "ssh -p $remotePort -i $keyPath/$localId" $remoteHost:$keyPath/$remoteId.pub $keyPath/
#
# Cat the remote machine public key into the local authorized_keys file
#
cat $keyPath/$remoteId.pub >> $keyPath/authorized_keys

