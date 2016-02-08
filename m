From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Feb 2016 23:48:55 +0000
Subject: [PATCH 3/4] NVMe: Surprise removal fixes
In-Reply-To: <20160208183823.GA29157@localhost.localdomain>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-4-git-send-email-keith.busch@intel.com>
 <20160208181640.GD13126@infradead.org>
 <20160208183823.GA29157@localhost.localdomain>
Message-ID: <20160208234855.GA3058@localhost.localdomain>

On Mon, Feb 08, 2016@06:38:23PM +0000, Keith Busch wrote:
> On Mon, Feb 08, 2016@10:16:40AM -0800, Christoph Hellwig wrote:
> > Do we really still need all this magic if ->queue_rq returns a failure
> > if the queue is dying?
> 
> This is far from perfect. Let me try explaining what's happening, then
> I hope to abandon this patch and do it correctly. :)

I've a new patch that passes all my tests, including the removal deadlock
using device states.

I have namespace capacity set to 0 and revalidate to get buffered writers
to end. The error handling is done in the nvme_workq, which currently
has WQ_MEM_RECLAIM set. That trigger a warning when revalidate_disk
attempts to sync with a non-MEM_RECLAIM work queue, so I removed the
flag from NVMe's to suppress the warning, but I don't see what having
that flag gained us in the first place. It looks to me that it just
spawns a rescuer, but do we need that?
