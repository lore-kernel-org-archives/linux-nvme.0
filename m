From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 15:19:28 -0600
Subject: [PATCH 1/5] blk-mq: add API to get hctx index from request
In-Reply-To: <57c119c3-5704-0dcb-96dd-fede99c49511@wdc.com>
References: <20180628205601.13742-1-keith.busch@intel.com>
 <57c119c3-5704-0dcb-96dd-fede99c49511@wdc.com>
Message-ID: <20180628211928.GA13810@localhost.localdomain>

On Thu, Jun 28, 2018@02:12:38PM -0700, Bart Van Assche wrote:
> Regarding the above patch: have you considered to use the existing function
> blk_mq_unique_tag_to_hwq() instead of introducing this new function?

Interesting. I think the usage I need using that is something like:

	blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req))

Sort of a round-about way to get to the hwq from the struct request,
but I'd rather not introduce anything new if there are other ways,
so thank you for the pointer.
