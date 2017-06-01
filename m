From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Jun 2017 17:37:41 +0300
Subject: [PATCH] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170601140629.15313-2-hch@lst.de>
References: <20170601140629.15313-1-hch@lst.de>
 <20170601140629.15313-2-hch@lst.de>
Message-ID: <3db3cb8f-0851-f114-2fc6-4710d5aab2db@grimberg.me>


> From: Rakesh Pandit <rakesh at tuxera.com>
>
> Commit c5f6ce97c1210 tries to address multiple resets but fails as
> work_busy doesn't involve any synchronization and can fail.  This is
> reproducible easily as can be seen by WARNING below which is triggered
> with line:
>
> WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)
>
> Allowing multiple resets can result in multiple controller removal as
> well if different conditions inside nvme_reset_work fail and which
> might deadlock on device_release_driver.
>
> This patch introduces new state called NVME_CTRL_SCHED_RESET and uses
> it for synchronizing work queue addition (reset_work) as state change
> uses controller spinlock.

Christoph,

Did you catch my proposal to Keith and Rakesh?

I proposed to synchronize with ctrl state NVME_CTRL_RESETTING
before scheduling the reset_work and on removal flow (which is
why the warning exist) simply do a sync cancel of reset_work.

IMO, this is better than adding a new state to the ctrl state machine.
