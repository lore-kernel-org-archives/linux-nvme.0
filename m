From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 2 Feb 2018 00:53:51 +0000
Subject: [dm-devel] [PATCH V4] blk-mq: introduce BLK_STS_DEV_RESOURCE
In-Reply-To: <23155.45114.317289.396546@quad.stoffel.home>
References: <20180129203300.50595-1-snitzer@redhat.com>
 <1517260932.2687.42.camel@wdc.com> <20180129214446.GD5744@redhat.com>
 <1517262713.2687.56.camel@wdc.com>
 <23155.45114.317289.396546@quad.stoffel.home>
Message-ID: <1517532830.2746.43.camel@wdc.com>

On Thu, 2018-02-01@19:26 -0500, John Stoffel wrote:
> Doesn't this argue that you really want some sort of completions to be
> run in this case instead?  Instead of busy looping or waiting for a
> set amount of time, just fire off a callback to run once you have the
> resources available, no?

Hello John,

Rerunning the queue when the resource we ran out of is available again would
be ideal. However, I'm not sure it is possible to implement this. If a driver
performs memory allocation while executing a request and kmalloc() returns
-ENOMEM then I don't know which mechanism should be used to trigger a queue
rerun when sufficient memory is available again.

Another example is the SCSI subsystem. If a the .queuecommand() implementation
of a SCSI LLD returns SCSI_MLQUEUE_*_BUSY because a certain HBA condition
occurred and the HBA does not trigger an interrupt when that condition is
cleared, how to figure out whether or not a request can be executed other than
by retrying, which means rerunning the queue?

Thanks,

Bart.
