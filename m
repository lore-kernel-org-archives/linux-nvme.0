From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Feb 2019 10:37:37 +0100
Subject: [PATCH] nvmet: disable direct I/O when unavailable
In-Reply-To: <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
 <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
Message-ID: <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>

On 24/02/2019 11:54, Max Gurtovoy wrote:
> 
> On 2/22/2019 7:55 AM, Johannes Thumshirn wrote:
>> On 22/02/2019 01:41, Chaitanya Kulkarni wrote:
>> [...]
>>> As per specified in the patch, this is only useful for testing, then we
>>> should modify the test scripts so that on creation of the ctrl we switch
>>> to the buffered I/O before running fio.
>> Or on any other file-system that does not support DIO..
> 
> Do we really want to support these kind of filesystems for fabrics
> backend device ? only for testing ?
> 
> What is the status of iSCSI/SRP targets in this case ?

iSCSI/SRP passes in the following:

 /*
  * Use O_DSYNC by default instead of O_SYNC to forgo syncing
  * of pure timestamp updates.
  */
 flags = O_RDWR | O_CREAT | O_LARGEFILE | O_DSYNC;

Meaning it uses O_DSYNC, so for instance if I do a dd to tmpfs with O_DSYNC:
$ dd if=/dev/zero of=/dev/shm/foo oflag=dsync bs=4k count=1
1+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000175094 s, 23.4 MB/s

Same with O_DIRECT:
$ dd if=/dev/zero of=/dev/shm/foo oflag=direct bs=4k count=1
dd: failed to open '/dev/shm/foo': Invalid argument


-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
