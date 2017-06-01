From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 17:41:07 +0200
Subject: [PATCH] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <3db3cb8f-0851-f114-2fc6-4710d5aab2db@grimberg.me>
References: <20170601140629.15313-1-hch@lst.de>
 <20170601140629.15313-2-hch@lst.de>
 <3db3cb8f-0851-f114-2fc6-4710d5aab2db@grimberg.me>
Message-ID: <20170601154107.GA8118@lst.de>

On Thu, Jun 01, 2017@05:37:41PM +0300, Sagi Grimberg wrote:
> Did you catch my proposal to Keith and Rakesh?

I saw it.

>
> I proposed to synchronize with ctrl state NVME_CTRL_RESETTING
> before scheduling the reset_work and on removal flow (which is
> why the warning exist) simply do a sync cancel of reset_work.
>
> IMO, this is better than adding a new state to the ctrl state machine.

Why?  Knowing from the state machine that we're going to reset
is very useful and will safe us from doing pointless work elsewhere.
There is a reason we have done it that way in Fabrics from the beginning.

E.g. as the work_busy check in nvme_should_reset can now be replaced
with a check for NVME_CTRL_SCHED_RESET and NVME_CTRL_RESETTING and
we're much more reliable.
