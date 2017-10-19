From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 17:12:55 +0200
Subject: [PATCH 07/17] nvme: use ida_simple_{get,remove} for the
 controller instance
In-Reply-To: <20171019151426.GC2768@localhost.localdomain>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-8-hch@lst.de>
 <20171019151426.GC2768@localhost.localdomain>
Message-ID: <20171019151255.GA24354@lst.de>

On Thu, Oct 19, 2017@09:14:27AM -0600, Keith Busch wrote:
> This is a good cleanup, and I'd support this patch going in ahead of
> this series on its own if you want to apply to 4.15 immediately.

Ok, will do.
