From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 28 Jun 2018 09:44:06 +0200
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180628005943.GC10657@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
 <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>
 <20180627234313.GB10657@localhost.localdomain>
 <20180628005943.GC10657@localhost.localdomain>
Message-ID: <20180628074406.pbf4tjluylq3lkkr@linux-x5ow.site>

On Wed, Jun 27, 2018@06:59:43PM -0600, Keith Busch wrote:
> Thinking more on this, not using the hw qid really limits the utility
> out of using these trace events: We may not be able to match a completion
> to the submission without it since cmdid alone isn't enough to match up
> the two events.
> 
> Here's an updated proposal and actually tested. I was also able to
> combine admin and io submissions.

Awesome, thanks.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
