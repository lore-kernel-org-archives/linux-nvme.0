From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 21 Jun 2018 10:27:26 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <697a18cb-43c7-c768-6d17-6eb8123f26ff@kernel.dk>
References: <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
 <20180621152456.GB29947@infradead.org>
 <873b1ec2-50a9-1660-2550-c4e539c2413d@kernel.dk>
 <20180621154539.GA30025@infradead.org>
 <697a18cb-43c7-c768-6d17-6eb8123f26ff@kernel.dk>
Message-ID: <20180621162725.GA26993@localhost.localdomain>

On Thu, Jun 21, 2018@09:49:37AM -0600, Jens Axboe wrote:
> From: Jens Axboe <axboe at kernel.dk>
> Subject: [PATCH] nvme: limit max IO size and segments for pci-e
> 
> nvme requires an sg table allocation for each request. If the request
> is large, then the allocation can become quite large. For instance,
> with our default software settings of 1280KB IO size, we'll need
> 10248 bytes of sg table. That turns into a 2nd order allocation,
> which we can't always guarantee. If we fail the allocation, blk-mq
> will retry it later. But there's no guarantee that we'll EVER be
> able to allocate that much contigious memory.
> 
> Limit the IO size such that we never need more than a single page
> of memory. That's a lot faster and more reliable. Then back that
> allocation with a mempool, so that we know we'll always be able
> to succeed the allocation at some point.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>

This looks good to me. Thanks!

Acked-by: Keith Busch <keith.busch at intel.com>
