From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 17:51:47 +0300
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180713205609.19701-2-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
Message-ID: <c0752e20-7d23-4b1f-b128-af952e3cf8da@grimberg.me>

Keith,

> This patch fixes races that occur with simultaneous controller
> resets by synchronizing request queues prior to initializing the
> controller. Withouth this, a thread may attempt disabling a controller
> at the same time as we're trying to enable it.

I'll need a little more help with this. This is due to the
fact that we disable the controller directly from the timeout
handler? If not, what context may disable when nvme_reset_work
is running?

I'm trying what the sync should serialize and why is it not
serialized by the controller state machine.
