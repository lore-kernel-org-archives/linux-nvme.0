From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:26:51 +0200
Subject: [PATCH 3/3] nvme: bio remapping tracepoint
In-Reply-To: <ef70773f-491c-274f-7273-f4f0d8b29470@kernel.dk>
References: <20180607083847.51019-1-hare@suse.de>
 <20180607083847.51019-4-hare@suse.de> <20180607112759.GC10939@lst.de>
 <20180607133332.798a8bbc@pentland.suse.de> <20180607114251.GA11119@lst.de>
 <ef70773f-491c-274f-7273-f4f0d8b29470@kernel.dk>
Message-ID: <20180611142651.GA14160@lst.de>

On Thu, Jun 07, 2018@10:21:42AM -0600, Jens Axboe wrote:
> I was going to suggest that too, but there's really nothing
> in direct_make_request() that implies that it's necessarily
> a remap of an existing bio. The two current callers implies
> that, but that's really not a given.

I don't really think it makes much sense in a different context.

I've applied the patch for now, but I think this area could
use ?ome improvement.
