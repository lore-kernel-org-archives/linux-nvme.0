From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 May 2019 14:34:06 +0200
Subject: [PATCH] nvme-pci: fix single segment detection
In-Reply-To: <20190509112410.GA20711@ming.t460p>
References: <20190509110409.19647-1-hch@lst.de>
 <20190509112410.GA20711@ming.t460p>
Message-ID: <20190509123406.GB21483@lst.de>

On Thu, May 09, 2019@07:24:12PM +0800, Ming Lei wrote:
> I'd suggest to fix block layer instead of working around the issue here,
> then any driver may benefit from the fix.

That is my plan, and I started on it.  But the fix isn't trivial, and
will probably take a while and be invasive.

> Especially checking bio->bi_vcnt is just a hack, and drivers should
> never use .bi_vcnt.

That is why it is explicitly commented as a hack.  But a good enough
one to still speed up typical 4K I/Os - one a bio has been cloned
chances are very high we don't care about the fast path any more.
