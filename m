From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 30 Jan 2018 15:12:12 -0500
Subject: [PATCH v5] blk-mq: introduce BLK_STS_DEV_RESOURCE
In-Reply-To: <1517341349.2589.35.camel@wdc.com>
References: <20180130142459.52668-1-snitzer@redhat.com>
 <43ac2314-c98d-bb76-0dfb-171d15cc5fd8@wdc.com>
 <20180130193323.GA15943@redhat.com>
 <1517341349.2589.35.camel@wdc.com>
Message-ID: <20180130201212.GA16284@redhat.com>

On Tue, Jan 30 2018 at  2:42pm -0500,
Bart Van Assche <Bart.VanAssche@wdc.com> wrote:

> On Tue, 2018-01-30@14:33 -0500, Mike Snitzer wrote:
> > On Tue, Jan 30 2018 at 12:52pm -0500,
> > Bart Van Assche <bart.vanassche@wdc.com> wrote:
> > 
> > > - This patch does not fix any bugs nor makes block drivers easier to
> > >   read or to implement. So why is this patch considered useful?
> > 
> > It enables blk-mq core to own the problem that individual drivers should
> > have no business needing to worry about.  Period.
> 
> Thanks for having confirmed that this patch is an API-change only and does
> not fix any bugs.

No, it is an API change that enables blk-mq drivers to make forward
progress without compromising the potential benefits associated with
blk-mq's SCHED_RESTART functionality.

(If we're going to beat this horse to death it might as well be with
precision)
