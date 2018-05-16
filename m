From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 16 May 2018 15:20:10 -0600
Subject: [PATCH] nvme: remove cq check after submission
In-Reply-To: <b88f65b5-5fa6-45a7-48ff-77a114c31160@kernel.dk>
References: <b88f65b5-5fa6-45a7-48ff-77a114c31160@kernel.dk>
Message-ID: <20180516212010.GC20223@localhost.localdomain>

On Wed, May 16, 2018@01:58:08PM -0600, Jens Axboe wrote:
> We always check the completion queue after submitting, but in my testing
> this isn't a win even on DRAM/xpoint devices. In some cases it's
> actually worse. Kill it.

Right, this was on my todo list. Agreed it's not helping anything.
Applied to nvme-4.18.
