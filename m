From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 24 Apr 2017 00:18:18 -0700
Subject: [PATCH v2 5/5] nvme_fc: add controller reset support
In-Reply-To: <ab68b3c3-7cce-336e-108d-062e4076c449@grimberg.me>
References: <20170411183512.9043-1-jsmart2021@gmail.com>
 <20170411183512.9043-6-jsmart2021@gmail.com>
 <ab68b3c3-7cce-336e-108d-062e4076c449@grimberg.me>
Message-ID: <20170424071818.GC17381@infradead.org>

On Thu, Apr 20, 2017@03:56:20PM +0300, Sagi Grimberg wrote:
> It would be very helpful to split this patch into several pieces:
> 1. fixes and cleanups
> 2. preps for teardown and establishment
> 3. delete support
> 4. reset support
> 5. reconnect support
> 
> As is, its very hard to review this patch...

Agreed.  And while looking over it again for applying the series
I don't think we can just apply this as-is, mostly due to this and
other issues you've pointed out.

I've applied the other two remaining patches with the small byte
swap fixup, though.
