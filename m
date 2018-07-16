From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 19:36:41 +0300
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180716153721.GB26265@localhost.localdomain>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <c0752e20-7d23-4b1f-b128-af952e3cf8da@grimberg.me>
 <20180716153721.GB26265@localhost.localdomain>
Message-ID: <c52b671e-8ca5-aa04-9182-7a43014aed40@grimberg.me>


>> Keith,
>>
>>> This patch fixes races that occur with simultaneous controller
>>> resets by synchronizing request queues prior to initializing the
>>> controller. Withouth this, a thread may attempt disabling a controller
>>> at the same time as we're trying to enable it.
>>
>> I'll need a little more help with this. This is due to the
>> fact that we disable the controller directly from the timeout
>> handler? If not, what context may disable when nvme_reset_work
>> is running?
>>
>> I'm trying what the sync should serialize and why is it not
>> serialized by the controller state machine.
> 
> The only reason we need this is because each namespace has its own
> request queue with their own timeout work. We don't want all of these
> scheduling multiple controller resets, so the sync here just ensures
> that there is no active timeout work that's about to schedule another
> reset while we're already resetting the controller.

But scheduling a reset while a reset is running should not succeed. You
should not be able to change state RESETTING -> RESETTING
