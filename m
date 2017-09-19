From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 19 Sep 2017 15:36:35 +0000
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
In-Reply-To: <20170919054308.GA2517@ming.t460p>
References: <20170915164456.9803-1-ming.lei@redhat.com>
 <20170915164456.9803-2-ming.lei@redhat.com>
 <1505498249.3420.15.camel@wdc.com> <20170917124000.GB6289@ming.t460p>
 <1505747894.2685.6.camel@wdc.com> <20170919054308.GA2517@ming.t460p>
Message-ID: <1505835394.2671.18.camel@wdc.com>

On Tue, 2017-09-19@13:43 +0800, Ming Lei wrote:
> On Mon, Sep 18, 2017@03:18:16PM +0000, Bart Van Assche wrote:
> > If you are still looking at removing the blk_mq_delay_run_hw_queue() calls
> > then I think you are looking in the wrong direction. What kind of problem
> > are you trying to solve? Is it perhaps that there can be a delay between
> 
> Actually the improvement on dm-rq IO schedule(the patch 2 ~ 5) doesn't
> need this patch.

The approach of this patch series looks wrong to me and patch 5/5 is an ugly
hack in my opinion. That's why I asked you to drop the entire patch series and
to test whether inserting a queue run call into the dm-mpath end_io callback
yields a similar performance improvement to the patches you posted. Please do
not expect me to spend more time on this patch series if you do not come up
with measurement results for the proposed alternative.

Bart.
