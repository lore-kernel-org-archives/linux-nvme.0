From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 19 Sep 2017 11:56:03 -0400
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in
 case of BLK_STS_RESOURCE
In-Reply-To: <1505835394.2671.18.camel@wdc.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
 <20170915164456.9803-2-ming.lei@redhat.com>
 <1505498249.3420.15.camel@wdc.com>
 <20170917124000.GB6289@ming.t460p>
 <1505747894.2685.6.camel@wdc.com>
 <20170919054308.GA2517@ming.t460p>
 <1505835394.2671.18.camel@wdc.com>
Message-ID: <20170919155603.GB22809@redhat.com>

On Tue, Sep 19 2017 at 11:36am -0400,
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> On Tue, 2017-09-19@13:43 +0800, Ming Lei wrote:
> > On Mon, Sep 18, 2017@03:18:16PM +0000, Bart Van Assche wrote:
> > > If you are still looking at removing the blk_mq_delay_run_hw_queue() calls
> > > then I think you are looking in the wrong direction. What kind of problem
> > > are you trying to solve? Is it perhaps that there can be a delay between
> > 
> > Actually the improvement on dm-rq IO schedule(the patch 2 ~ 5) doesn't
> > need this patch.
> 
> The approach of this patch series looks wrong to me and patch 5/5 is an ugly
> hack in my opinion. That's why I asked you to drop the entire patch series and
> to test whether inserting a queue run call into the dm-mpath end_io callback
> yields a similar performance improvement to the patches you posted. Please do
> not expect me to spend more time on this patch series if you do not come up
> with measurement results for the proposed alternative.

Bart, asserting that Ming's work is a hack doesn't help your apparent
goal of deligitimizing Ming's work.

Nor does it take away from the fact that your indecision on appropriate
timeouts (let alone ability to defend and/or explain them) validates
Ming calling them into question (which you are now dodging regularly).

But please don't take this feedback and shut-down.  Instead please work
together more constructively.  This doesn't need to be adversarial!  I
am at a loss for why there is such animosity from your end Bart.

Please dial it back.  It is just a distraction that fosters needless
in-fighting.

Believe it or not: Ming is just trying to improve the code because he
has a testbed that is showing fairly abysmal performance with dm-mq
multipath (on lpfc with scsi-mq).

Ming, if you can: please see if what Bart has proposed (instead: run
queue at end_io) helps.  Though I don't yet see why that should be
needed.

Mike
