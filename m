From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 10 Jul 2017 12:20:49 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
Message-ID: <20170710102049.GF5105@linux-x5ow.site>

On Mon, Jul 10, 2017@01:13:35PM +0300, Sagi Grimberg wrote:
> 
> >Tried up to 120 now, still broken.
> 
> Then something else is broken. 120 seconds is literally forever
> in IB world. can you please turn on pr_debug in
> nvmet_execute_keep_alive() and check that the target sees it
> in a timely manner?

OK, running a test now. I have a local test patch that cancels and
re-schedules the kato work on every mq_ops->complete() for testing as well
which I also like to check as a proof of my hypothesis and then I'll report
back.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
