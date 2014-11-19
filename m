From: keith.busch@intel.com (Keith Busch)
Date: Wed, 19 Nov 2014 17:54:06 +0000 (UTC)
Subject: [PATCH] NVMe: make setup work for devices that don't do INTx
In-Reply-To: <20141114164926.GC12860@kernel.dk>
References: <20141114164926.GC12860@kernel.dk>
Message-ID: <alpine.LNX.2.00.1411191600480.4225@localhost.lm.intel.com>

On Fri, 14 Nov 2014, Jens Axboe wrote:
> The setup/probe part currently relies on INTx being there and
> working, that's not always the case. For devices that don't
> advertise INTx, enable a single MSIx vector early on and disable
> it again before we ask for our full range of queue vecs.

Acked-by: Keith Busch <keith.busch at intel.com>

I have an early sample platform that has the same behavior. I thought
it was just a buggy prototype, but the h/w makers tell me it's designed
that way.

> Signed-off-by: Jens Axboe <axboe at fb.com>
