From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 28 Jan 2016 17:20:49 +0200
Subject: [PATCH 1/2] NVMe: Make surprise removal work again
In-Reply-To: <20160128145550.GB3863@localhost.localdomain>
References: <1453757017-13640-1-git-send-email-keith.busch@intel.com>
 <56A8AE61.6070100@dev.mellanox.co.il>
 <20160127141931.GA19346@localhost.localdomain>
 <56AA2A30.2040304@dev.mellanox.co.il>
 <20160128145550.GB3863@localhost.localdomain>
Message-ID: <56AA31D1.1010202@dev.mellanox.co.il>


>> Isn't that what blk_mq_wake_waiters() is for?
>
> Yes, that'll wake processes waiting on tags, but not to their
> demise. They'll get a tag and send it to the h/w context. We need to
> start these back up so the driver can end those requests, or we need to
> do something to end them at the block layer. It sounds like developers
> are preferring the latter.

Yes please.
