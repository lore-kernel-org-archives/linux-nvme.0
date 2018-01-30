From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 30 Jan 2018 11:20:49 +0800
Subject: [PATCH V4] blk-mq: introduce BLK_STS_DEV_RESOURCE
In-Reply-To: <1517262713.2687.56.camel@wdc.com>
References: <20180129203300.50595-1-snitzer@redhat.com>
 <1517260932.2687.42.camel@wdc.com>
 <20180129214446.GD5744@redhat.com> <1517262713.2687.56.camel@wdc.com>
Message-ID: <CACVXFVPhwAoTLQ++tAPDKyycL9PLPs8h4oCCVfxEBZJp0ToKSg@mail.gmail.com>

On Tue, Jan 30, 2018@5:51 AM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Mon, 2018-01-29@16:44 -0500, Mike Snitzer wrote:
>> But regardless of which wins the race, the queue will have been run.
>> Which is all we care about right?
>
> Running the queue is not sufficient. With this patch applied it can happen
> that the block driver returns BLK_STS_DEV_RESOURCE, that the two or more
> concurrent queue runs finish before sufficient device resources are available
> to execute the request and that blk_mq_delay_run_hw_queue() does not get
> called at all. If no other activity triggers a queue run, e.g. request
> completion, this will result in a queue stall.

Please see document of BLK_STS_DEV_RESOURCE:

+ * BLK_STS_DEV_RESOURCE is returned from driver to block layer if device
+ * related resource is unavailable, but driver can guarantee that queue
+ * will be rerun in future once the resource is available (whereby
+ * dispatching requests).

I have explained the SCSI's BLK_STS_DEV_RESOURCE conversion in
another thread, let's know if you have further concern:

https://marc.info/?l=linux-block&m=151727454815018&w=2

-- 
Ming Lei
