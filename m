From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 3 Nov 2017 10:33:36 -0600
Subject: block layer patches for nvme multipath support
In-Reply-To: <20171102182954.9263-1-hch@lst.de>
References: <20171102182954.9263-1-hch@lst.de>
Message-ID: <983167e5-5e0c-9d83-bde3-ee0ec9bd3223@kernel.dk>

On 11/02/2017 12:29 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> these patches add the block layer helpers / tweaks for NVMe multipath
> support.  Can you review them for inclusion?
> 
> There have been no functional changes to the versions posted with
> previous nvme multipath patchset.

I've queued this up. I really hate the direct_make_request(), but
I also don't have a good suggestion on how to do this any better
right now.

-- 
Jens Axboe
