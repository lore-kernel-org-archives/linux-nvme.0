From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 19 Sep 2016 09:59:39 +0200
Subject: [PATCH v3 1/3] nvme/scsi: Remove power management support
In-Reply-To: <20160916142500.GA9578@lst.de>
References: <cover.1474002926.git.luto@kernel.org>
 <714df91022b06c6799afb315962769f22b8ab9f4.1474002926.git.luto@kernel.org>
 <20160916083333.GB2415@lst.de>
 <20160916143301.GB1852@localhost.localdomain>
 <20160916142500.GA9578@lst.de>
Message-ID: <20160919075939.eoycfbur4zchf3m3@linux-x5ow.site>

On Fri, Sep 16, 2016@04:25:00PM +0200, Christoph Hellwig wrote:
> On Fri, Sep 16, 2016@10:33:02AM -0400, Keith Busch wrote:
> > On Fri, Sep 16, 2016@10:33:33AM +0200, Christoph Hellwig wrote:
> > > On Thu, Sep 15, 2016@10:24:19PM -0700, Andy Lutomirski wrote:
> > > > Since this code appears to be useless, just delete it.
> > > 
> > > Yes, please!
> > 
> > For a future patch, any objection to deleting the whole file? :)
> 
> Not from me for sure, but I fear some users might be using it after all.

IIRC there was some issues with openSUSE and pre NVMe 1.2 Adapters
without the scsi translation.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
