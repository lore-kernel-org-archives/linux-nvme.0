From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 21 May 2019 09:08:08 +0800
Subject: [PATCH] nvme-pci: fix single segment optimization
In-Reply-To: <20190520111601.GC5137@lst.de>
References: <20190517225035.25008-1-ming.lei@redhat.com>
 <20190520111601.GC5137@lst.de>
Message-ID: <20190521010806.GB14268@ming.t460p>

On Mon, May 20, 2019@01:16:01PM +0200, Christoph Hellwig wrote:
> Given that the code only showed up in 5.2 I'd rather try to fix the
> block layer issue, lets see what Jens says.  But if not I defintively
> want the comment from my earlier patch, and to me the
> !req->bio->bi_next && req->bio->bi_vcnt == 1 check also seems slighly

The check on 'req->bio->bi_vcnt == 1' should really be avoided, and it
isn't needed too.

thanks,
Ming
