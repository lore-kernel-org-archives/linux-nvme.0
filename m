From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 23 Sep 2016 10:21:50 -0600
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <20160923033157.GA12637@infradead.org>
References: <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org> <20160922210255.GA11015@infradead.org>
 <023c01d21519$b3cda450$1b68ecf0$@opengridcomputing.com>
 <20160922214800.GA16008@infradead.org>
 <024201d2151d$28013b90$7803b2b0$@opengridcomputing.com>
 <022301d2152d$94c202e0$be4608a0$@opengridcomputing.com>
 <20160923033157.GA12637@infradead.org>
Message-ID: <b118929e-a841-6262-3bd1-5a5c840199f2@kernel.dk>

On 09/22/2016 09:31 PM, 'Christoph Hellwig' wrote:
> On Thu, Sep 22, 2016@07:01:05PM -0500, Steve Wise wrote:
>> The fabrics module displays these errors.  But the 28 rdma connections still
>> get setup.  I'm not sure this is what we want, but it does avoid failing the
>> connect altogether...
>
> Bo, it's not really what we want.  I think we simply need to move
> forward with the queue state machine, and use that to check if we have
> a blk-mq queue allocated for the queue.  If not we can simply skip it
> later on.
>
> So I'd say I'll send the crash fix in blk-mq to Jens ASAP, and you'll
> look into the queue state machine for 4.9?

I'm going to flush the remaining patches for 4.8 later today. Did you
send it out yet? If so, I haven't seen it. I'll be traveling the next 2
weeks. With internet, so I'll get some work done, but it'll be a bit
more intermittent.

--
Jens Axboe
