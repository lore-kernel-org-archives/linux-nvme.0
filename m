From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sat, 30 Sep 2017 21:37:38 +0200
Subject: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170928155315.GK8463@localhost.localdomain> (Keith Busch's
 message of "Thu, 28 Sep 2017 09:53:16 -0600")
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
 <20170928155315.GK8463@localhost.localdomain>
Message-ID: <mqdk20ghta5.fsf@linux-x5ow.site>


[+Cc Hannes ]

Keith Busch <keith.busch at intel.com> writes:

> On Mon, Sep 25, 2017@03:40:30PM +0200, Christoph Hellwig wrote:
>> The new block devices nodes for multipath access will show up as
>> 
>> 	/dev/nvm-subXnZ
>
> Just thinking ahead ... Once this goes in, someone will want to boot their
> OS from a multipath target. It was a pain getting installers to recognize
> /dev/nvmeXnY as an install destination. I'm not sure if installers have
> gotten any better in the last 5 years about recognizing new block names.

We discussed (Hannes, Christoph and me) this as well offline this week
and it should eithr be possible with some udev magic (fake a
/dev/mapper/WWID symlink) or a shim device-mapper target that prevents
dm-mpath from attaching to the underlying block devices and creates a
real /dev/mapper/WWID device node (Christoph especially dislikes
this). None of them are pretty, but probably all we can do so far.

Byte,
        Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
