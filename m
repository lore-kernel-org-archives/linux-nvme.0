From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Jul 2018 14:46:55 +0300
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180716171232.GC26265@localhost.localdomain>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <c0752e20-7d23-4b1f-b128-af952e3cf8da@grimberg.me>
 <20180716153721.GB26265@localhost.localdomain>
 <c52b671e-8ca5-aa04-9182-7a43014aed40@grimberg.me>
 <20180716171232.GC26265@localhost.localdomain>
Message-ID: <0fb455af-946c-e45a-fc38-dc0044015cff@grimberg.me>


>> But scheduling a reset while a reset is running should not succeed. You
>> should not be able to change state RESETTING -> RESETTING
> 
> Timeout handlers call nvme_dev_disable prior to the reset schedule
> attempt, which is the part that we want to prevent occuring concurrently
> with an already scheduled reset.

So why not make the timeout handlers not call nvme_dev_disable? It looks
like this is causing us to jump over hoops to accommodate for.

I think I asked it a couple of times before, why isn't the timeout
handler simply either:
1. abort, or
2. queue a reset (and return BLK_EH_RESET_TIMER), or
3. fail early the I/O if it is coming from the reset context (and
    return BLK_EH_DONE)

*If* there is a rare race where the timed out I/O from (3) is completing
with the timeout handler concurrently, we can simply suspend that queue
alone.
