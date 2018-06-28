From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 28 Jun 2018 17:34:07 +0300
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180628005943.GC10657@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
 <20180628005943.GC10657@localhost.localdomain>
Message-ID: <c25e48f5-ace4-5d2c-8174-11ac63316323@grimberg.me>


> Thinking more on this, not using the hw qid really limits the utility
> out of using these trace events: We may not be able to match a completion
> to the submission without it since cmdid alone isn't enough to match up
> the two events.
> 
> Here's an updated proposal and actually tested. I was also able to
> combine admin and io submissions.

This looks good!

One thing that is missing is the controller id when we have multiple
controllers/subsystems in the host like:

TP_printk("nvme%d: qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, 
cmd=(%s %s)",

But Johannes can add it I guess.
