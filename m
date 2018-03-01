From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Mar 2018 14:04:03 +0200
Subject: [PATCH] nvmet_fc: prevent new io rqsts in possible isr completions
In-Reply-To: <20180228224911.15754-2-jsmart2021@gmail.com>
References: <20180228224911.15754-1-jsmart2021@gmail.com>
 <20180228224911.15754-2-jsmart2021@gmail.com>
Message-ID: <5e545915-14e1-857f-3013-ebd2687ab8e7@grimberg.me>

Hi James,

> When a bio completion calls back into the transport for a
> back-end io device, the request completion path can free
> the transport io job structure allowing it to be reused for
> other operations.

Is this true doe something that is not aborted?

> The transport has a defer_rcv queue which
> holds temporary cmd rcv ops while waitng for io job structures.
> when the job frees, if there's a cmd waiting, it is picked up
> and submitted for processing, which can call back out to the
> bio path if it's a read.  Unfortunately, what is unknown is the
> context of the original bio done call, and it may be in a state
> (softirq) that is not compatible with submitting the new bio in
> the same calling sequence. This is especially true when using
> scsi back-end devices as scsi is in softirq when it makes the
> done call.
> 
> Correct by scheduling the io to be started via workq rather
> than calling the start new io path inline to the original bio
> done path.

Isn't free_iod called for every rsp completion? Is triggering defer_work
unconditionally the optimal approach? In other words, won't that yield
extra overhead in the "normal" case?
