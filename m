From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Jun 2015 09:00:14 +0200
Subject: [PATCHv2 1/2] blk-mq: Shared tag enhancements
In-Reply-To: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
References: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150603070014.GD11344@lst.de>

On Mon, Jun 01, 2015@09:29:53AM -0600, Keith Busch wrote:
> Storage controllers may expose multiple block devices that share hardware
> resources managed by blk-mq. This patch enhances the shared tags so a
> low-level driver can access the shared resources not tied to the unshared
> h/w contexts. This way the LLD can dynamically add and delete disks and
> request queues without having to track all the request_queue hctx's to
> iterate outstanding tags.

Why do you add a new function instead of fully replacing the old
blk_mq_tag_busy_iter?  The only other user is the timeout handler,
and I think it would be fine with your version as well.  And
blk_mq_tag_busy_iter is a much better name for your new function anyway :)

Also the patch is missing a description for the cpumask changes, which
look like they should be a separate patch, or probably just moved into
the driver as the blk core doesn't make use of it.
