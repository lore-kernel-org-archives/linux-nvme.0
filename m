From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 9 May 2019 21:31:23 +0800
Subject: [PATCH] nvme-pci: fix single segment detection
In-Reply-To: <20190509123406.GB21483@lst.de>
References: <20190509110409.19647-1-hch@lst.de>
 <20190509112410.GA20711@ming.t460p> <20190509123406.GB21483@lst.de>
Message-ID: <20190509133120.GA22059@ming.t460p>

On Thu, May 09, 2019@02:34:06PM +0200, Christoph Hellwig wrote:
> On Thu, May 09, 2019@07:24:12PM +0800, Ming Lei wrote:
> > I'd suggest to fix block layer instead of working around the issue here,
> > then any driver may benefit from the fix.
> 
> That is my plan, and I started on it.  But the fix isn't trivial, and
> will probably take a while and be invasive.
> 
> > Especially checking bio->bi_vcnt is just a hack, and drivers should
> > never use .bi_vcnt.
> 
> That is why it is explicitly commented as a hack.  But a good enough
> one to still speed up typical 4K I/Os - one a bio has been cloned
> chances are very high we don't care about the fast path any more.

NVMe hasn't max segment size limit, so fair enough for typical
4K IO workload:

Reviewed-by: Ming Lei <ming.lei at redhat.com>


Thanks,
Ming
