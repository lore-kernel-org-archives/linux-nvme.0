From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 29 Nov 2018 07:50:16 -0800
Subject: [PATCH 7/7] blk-mq: use plug for devices that implement
 ->commits_rqs()
In-Reply-To: <20181129154959.GF7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-8-axboe@kernel.dk>
 <20181129154959.GF7234@infradead.org>
Message-ID: <20181129155016.GG7234@infradead.org>

On Thu, Nov 29, 2018@07:49:59AM -0800, Christoph Hellwig wrote:
> > +		/*
> > +		 * Use plugging if we have a ->commit_rqs() hook as well,
> > +		 * as we know the driver uses bd->last in a smart
> > +		 * fashion.
> > +		 */
> 
> Nipick: this could flow on just two lines:
> 
> 		/*
> 		 * Use plugging if we have a ->commit_rqs() hook as well, as we
> 		 * know the driver uses bd->last in a smart fashion.
> 		 */

But of course otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
