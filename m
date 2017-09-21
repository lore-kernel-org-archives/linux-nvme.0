From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 21 Sep 2017 07:16:15 +0200
Subject: [PATCH v3 1/3] nvme_fc: create fc class and transport device
In-Reply-To: <20170920175018.GA8962@infradead.org>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-2-jsmart2021@gmail.com>
 <20170918161330.GC310@infradead.org>
 <20170920103041.idkzk5kerewgv5yk@linux-x5ow.site>
 <20170920175018.GA8962@infradead.org>
Message-ID: <20170921051615.6fnmqktvuoi4smyr@linux-x5ow.site>

On Wed, Sep 20, 2017@10:50:18AM -0700, Christoph Hellwig wrote:
> On Wed, Sep 20, 2017@12:30:41PM +0200, Johannes Thumshirn wrote:
> > the problem with libfc currently is it is made for fcoe, despite being named
> > libfc.
> 
> Well, that's my point - we should be able to use more bits in a common
> FC layer.  I don't really care about the exact name.

Yes, that's on my long term TODO list, getting rid of the SKBs used internally
so ibmvfc can be switched over, allow the setting of the NVMe Type code (or
even arbitrary typecodes) yada, yada.  It'll benefit fnic, bnx2fc and qedfc as
well, but I haven't been able to do much in this regard. Hannes and I have
internal patchsets flying around solving the fist little bits for it but
they're far from completion.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
