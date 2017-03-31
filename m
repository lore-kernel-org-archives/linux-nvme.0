From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Mar 2017 09:41:56 -0600
Subject: [RFC 5/8] scatterlist: Modify SG copy functions to support io
 memory.
In-Reply-To: <20170331070950.GA9059@infradead.org>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-6-git-send-email-logang@deltatee.com>
 <20170331070950.GA9059@infradead.org>
Message-ID: <435d4471-436b-87e6-8827-c9fc6cbdde2c@deltatee.com>



On 31/03/17 01:09 AM, Christoph Hellwig wrote:
> You're calling memcpy_{to,from}_iomem on non-__iomem pointers.  This
> is a fundamental no-go as we keep I/O memory separate from kernel
> pointers.

Yes, that's true, however I don't know how we could get around that when
the iomem is referenced by struct pages inside a scatter gather list. Do
we need to now have special __iomem sgls? And even still, I'm not sure
how that could work when the nvme target code is using the same sgls to
sometimes point to iomem and sometimes point to regular memory.

I'm certainly open to suggestions, though.

Logan
