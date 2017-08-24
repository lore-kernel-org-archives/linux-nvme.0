From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 24 Aug 2017 20:17:32 +0000
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170824085954.GD19504@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de> <1503512512.2484.16.camel@wdc.com>
 <20170824085954.GD19504@lst.de>
Message-ID: <1503605798.2899.43.camel@wdc.com>

On Thu, 2017-08-24@10:59 +0200, hch@lst.de wrote:
> On Wed, Aug 23, 2017@06:21:55PM +0000, Bart Van Assche wrote:
> > Since generic_make_request_fast() returns BLK_STS_AGAIN for a dying path:
> > can the same kind of soft lockups occur with the NVMe multipathing code as
> > with the current upstream device mapper multipathing code? See e.g.
> > "[PATCH 3/7] dm-mpath: Do not lock up a CPU with requeuing activity"
> > (https://www.redhat.com/archives/dm-devel/2017-August/msg00124.html).
> 
> I suspect the code is not going to hit it because we check the controller
> state before trying to queue I/O on the lower queue.  But if you point
> me to a good reproducer test case I'd like to check.

For NVMe over RDMA, how about the simulate_network_failure_loop() function in
https://github.com/bvanassche/srp-test/blob/master/lib/functions? It simulates
a network failure by writing into the reset_controller sysfs attribute.

> Also does the "single queue" case in your mail refer to the old
> request code?  nvme only uses blk-mq so it would not hit that.
> But either way I think get_request should be fixed to return
> BLK_STS_IOERR if the queue is dying instead of BLK_STS_AGAIN.

The description in the patch I referred to indeed refers to the old request
code in the block layer. When I prepared that patch I had analyzed the
behavior of the old request code only.

Bart.
