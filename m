From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jan 2016 14:55:50 +0000
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <56AA2A30.2040304@dev.mellanox.co.il>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <56A8AE61.6070100@dev.mellanox.co.il>
 <20160127141931.GA19346@localhost.localdomain>
 <56AA2A30.2040304@dev.mellanox.co.il>
Message-ID: <20160128145550.GB3863@localhost.localdomain>

On Thu, Jan 28, 2016@04:48:16PM +0200, Sagi Grimberg wrote:
> >That works only for active requests. There could be processes that entered
> >the queue and waiting for request tags to become available. These need
> >to be flushed to completion somehow ... maybe they shouldn't even succeed
> >in getting a request on a dying queue?
> 
> Isn't that what blk_mq_wake_waiters() is for?

Yes, that'll wake processes waiting on tags, but not to their
demise. They'll get a tag and send it to the h/w context. We need to
start these back up so the driver can end those requests, or we need to
do something to end them at the block layer. It sounds like developers
are preferring the latter.
