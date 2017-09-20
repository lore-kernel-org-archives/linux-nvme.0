From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Sep 2017 16:55:46 +0200
Subject: nvme multipath support V2
In-Reply-To: <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
 <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
Message-ID: <20170920145546.GB4709@lst.de>

On Wed, Sep 20, 2017@01:09:59PM +0200, Johannes Thumshirn wrote:
> Using your patchset and doing the sanme double connect trick I get the same
> two block devices of cause.
> 
> How do I connect using both paths?

Same as above.  But now in addition to the /dev/nvmeXnY devices you
should also see a /dev/nvme/nsZ device.  The sysfs entry for it shows
which paths it belongs to.
