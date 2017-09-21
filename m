From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 21 Sep 2017 07:23:45 +0200
Subject: nvme multipath support V2
In-Reply-To: <20170920145546.GB4709@lst.de>
References: <20170918231453.27128-1-hch@lst.de>
 <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
 <20170920145546.GB4709@lst.de>
Message-ID: <20170921052345.pj5ymmqsfmckas2b@linux-x5ow.site>

On Wed, Sep 20, 2017@04:55:46PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 20, 2017@01:09:59PM +0200, Johannes Thumshirn wrote:
> > Using your patchset and doing the sanme double connect trick I get the same
> > two block devices of cause.
> > 
> > How do I connect using both paths?
> 
> Same as above.  But now in addition to the /dev/nvmeXnY devices you
> should also see a /dev/nvme/nsZ device.  The sysfs entry for it shows
> which paths it belongs to.

Ah OK, we maybe should update nvme-cli to recognize it as well then. I just
looked at the output of nvme list and obviously didn't find it.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
