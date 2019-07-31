From: kbusch@kernel.org (Keith Busch)
Date: Wed, 31 Jul 2019 13:11:21 -0600
Subject: [PATCH] nvme: fix a possible deadlock when passthru commands
 sent to a multipath device
In-Reply-To: <20190731180026.4725-1-sagi@grimberg.me>
References: <20190731180026.4725-1-sagi@grimberg.me>
Message-ID: <20190731191121.GA15643@localhost.localdomain>

On Wed, Jul 31, 2019@11:00:26AM -0700, Sagi Grimberg wrote:
> When the user issues a command with side effects, we will end up freezing
> the namespace request queue when updating disk info (and the same for
> the corresponding mpath disk node).
> 
> However, we are not freezing the mpath node request queue,
> which means that mpath I/O can still come in and block on blk_queue_enter
> (called from nvme_ns_head_make_request -> direct_make_request).
> 
> This is a deadlock, because blk_queue_enter will block until the inner
> namespace request queue is unfroze, but that process is blocked because
> the namespace revalidation is trying to update the mpath disk info
> and freeze its request queue (which will never complete because
> of the I/O that is blocked on blk_queue_enter).
> 
> Fix this by freezing all the subsystem nsheads request queues before
> executing the passthru command. Given that these commands are infrequent
> we should not worry about this temporary I/O freeze to keep things sane.

Looks good to me.

Reviewed-by: Keith Busch <kbusch at kernel.org>
