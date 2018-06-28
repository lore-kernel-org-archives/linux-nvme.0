From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 09:02:18 -0600
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <c25e48f5-ace4-5d2c-8174-11ac63316323@grimberg.me>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
 <20180628005943.GC10657@localhost.localdomain>
 <c25e48f5-ace4-5d2c-8174-11ac63316323@grimberg.me>
Message-ID: <20180628150218.GA12970@localhost.localdomain>

On Thu, Jun 28, 2018@05:34:07PM +0300, Sagi Grimberg wrote:
> 
> > Thinking more on this, not using the hw qid really limits the utility
> > out of using these trace events: We may not be able to match a completion
> > to the submission without it since cmdid alone isn't enough to match up
> > the two events.
> > 
> > Here's an updated proposal and actually tested. I was also able to
> > combine admin and io submissions.
> 
> This looks good!
> 
> One thing that is missing is the controller id when we have multiple
> controllers/subsystems in the host like:
> 
> TP_printk("nvme%d: qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx,
> cmd=(%s %s)",
> 
> But Johannes can add it I guess.

Yep, I'm sort of going off on a tangent from what Johannes was adding.
We definitely need both. I have some time today, I'll send out the a
series with the combined results.
