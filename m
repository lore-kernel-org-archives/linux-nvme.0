From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 18 Jan 2019 19:10:43 +0000
Subject: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
In-Reply-To: <20beebf9-f582-08b3-1905-8a246f12268e@suse.de>
References: <20190117125906.15479-1-jthumshirn@suse.de>
 <BYAPR04MB45024AB8410374A9B1AD81A186830@BYAPR04MB4502.namprd04.prod.outlook.com>,
 <20beebf9-f582-08b3-1905-8a246f12268e@suse.de>
Message-ID: <BYAPR04MB4502509DB53BE33C7383F7CF869C0@BYAPR04MB4502.namprd04.prod.outlook.com>

xfstest has the following nicely written routine may be we can re-use that?

from  git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git, ${XFSTEST_HOME}/common/rc :-


  2185	# check that kernel and filesystem support direct I/O
  2186	_require_odirect()
  2187	{
  2188		if [ $FSTYP = "ext4" ] ; then
  2189			if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
  2190				_notrun "ext4 encryption doesn't support O_DIRECT"
  2191			elif echo "$MOUNT_OPTIONS" | grep -q "data=journal"; then
  2192				_notrun "ext4 data journaling doesn't support O_DIRECT"
  2193			fi
  2194		fi
  2195		local testfile=$TEST_DIR/$$.direct
  2196		$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
  2197		if [ $? -ne 0 ]; then
  2198			_notrun "O_DIRECT is not supported"
  2199		fi
  2200		rm -f $testfile 2>&1 > /dev/null
  2201	}
  2202	

This will require to have xfs_io program.


From: Johannes Thumshirn <jthumshirn@suse.de>
Sent: Thursday, January 17, 2019 11:17 PM
To: Chaitanya Kulkarni; Omar Sandoval
Cc: Linux Block Layer Mailinglist; Linux NVMe Mailinglist; Anthony Iliopoulos
Subject: Re: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed namespaces
? 
 
On 18/01/2019 00:46, Chaitanya Kulkarni wrote:
> This will force the user to run all tests in the buffered_io mode.
> 
> What we really need is a config for the nvme category option which user can set and decide
> whether to run buffered_io or direct_io, you can set by default to the buffered_io mode.

We could also introduce a check if we can use direct IO on the
underlying FS, but the only way I can think of from a shell script is
doing a 'dd of=$TMPDIR/testfile oflag=direct' and then populate the
result to the helper functions.

Chaitanya, Omar any ideas?

-- 
Johannes Thumshirn??????????????????????????? SUSE Labs Filesystems
jthumshirn at suse.de??????????????????????????????? +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
    
