From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 20 Jun 2017 11:33:27 +0200
Subject: [PATCH nvme-cli] nvme-cli: add ns-descs subcommand
In-Reply-To: <20170620092917.GA17947@infradead.org>
References: <20170620092028.5083-1-jthumshirn@suse.de>
 <20170620092917.GA17947@infradead.org>
Message-ID: <20170620093327.GC3686@linux-x5ow.site>

On Tue, Jun 20, 2017@02:29:17AM -0700, Christoph Hellwig wrote:
> > +int nvme_identify_ns_descs(int fd, __u32 nsid, void *data)
> > +{
> > +
> > +	return nvme_identify(fd, nsid, 0x3, data);
> > +}
> 
> This should use NVME_ID_CNS_NS_DESC_LIST.  nvme-cli doesn't currently
> have that, but that's just a sign it needs a resync with the kernel
> nvme.h.
> 
> Also personally I find the nvme_identify_* wrappers rather pointless,
> and thin kthey should be removed instead of adding more.

I just wanted to align with the rest of the implementation.

> 
> > diff --git a/nvme-print.c b/nvme-print.c
> > index 2da5acd5c9b8..582d15a7c5e8 100644
> > --- a/nvme-print.c
> > +++ b/nvme-print.c
> > @@ -3,6 +3,8 @@
> >  #include <string.h>
> >  #include <stdlib.h>
> >  
> > +#include <uuid/uuid.h>
> 
> libuuid usage in nvme-cli is conditional on LIBUUID.  Not that I
> particularly agree on stubbing this depdency out..

Sure, just forgot to do.

[...]

> > +		switch (cur->nidt) {
> > +		case NVME_NIDT_EUI64:
> > +			memset(eui64, 0, sizeof(eui64_str));
> > +			memcpy(eui64_desc, data + off, sizeof(eui64_desc));
> 
> What's the point of this memcpy?  Alignment?

Honestly, fighting against the compiler :-D


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
