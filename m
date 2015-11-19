From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Nov 2015 13:53:11 -0800
Subject: [PATCH] nvme: allow queues the chance to quiesce after freezing
 them
In-Reply-To: <20151119214156.GA22690@localhost.localdomain>
References: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
 <20151119214156.GA22690@localhost.localdomain>
Message-ID: <20151119215311.GA19302@infradead.org>

On Thu, Nov 19, 2015@09:41:57PM +0000, Keith Busch wrote:
> On Thu, Nov 19, 2015@12:11:52PM -0700, Jon Derrick wrote:
> > A panic was discovered while doing io and hitting the sysfs reset.
> > Because io was completing successfully, the nvme_dev_shutdown code
> > detected this non-idle state as a stuck state and started to tear down
> > the queues. This resulted in a paging error when nvme_process_cq wrote
> > the doorbell of a deleted queue.
> > 
> > This patch allows some time after starting the queue freeze for queues
> > to quiesce on their own. It also sets a new nvme_queue member, frozen,
> > to prevent writing of the cq doorbell. If the queues successfully
> > quiesce, nvme_process_cq will run upon resuming. If the queues don't
> > quiesce, existing code considers it a dead controller and is torn down.
> 
> I think all we really want is skip notifying completions on a
> "suspended" queue. We can tell by the value of the cq-vector,
> and it's already lock protected.
> 
> It also sounds like we need to poll the cq after the delete completes
> to catch successful completions before we force cancel the rest.
> 
> This appears to work for me. Does it pass your test?

This looks reasonable.  I ran into stray ->q_db derference a lot during
reset testing, but after my abort and reset rewrites ([1] for th latest
version) I couldn't reproduce it any more. 

[1]
http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.8
