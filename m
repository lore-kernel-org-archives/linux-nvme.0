From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 18 Jul 2018 07:52:24 -0600
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <0fb455af-946c-e45a-fc38-dc0044015cff@grimberg.me>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <c0752e20-7d23-4b1f-b128-af952e3cf8da@grimberg.me>
 <20180716153721.GB26265@localhost.localdomain>
 <c52b671e-8ca5-aa04-9182-7a43014aed40@grimberg.me>
 <20180716171232.GC26265@localhost.localdomain>
 <0fb455af-946c-e45a-fc38-dc0044015cff@grimberg.me>
Message-ID: <20180718135223.GA30873@localhost.localdomain>

On Wed, Jul 18, 2018@02:46:55PM +0300, Sagi Grimberg wrote:
> 
> > > But scheduling a reset while a reset is running should not succeed. You
> > > should not be able to change state RESETTING -> RESETTING
> > 
> > Timeout handlers call nvme_dev_disable prior to the reset schedule
> > attempt, which is the part that we want to prevent occuring concurrently
> > with an already scheduled reset.
> 
> So why not make the timeout handlers not call nvme_dev_disable? It looks
> like this is causing us to jump over hoops to accommodate for.
> 
> I think I asked it a couple of times before, why isn't the timeout
> handler simply either:
> 1. abort, or
> 2. queue a reset (and return BLK_EH_RESET_TIMER), or
> 3. fail early the I/O if it is coming from the reset context (and
>    return BLK_EH_DONE)
> 
> *If* there is a rare race where the timed out I/O from (3) is completing
> with the timeout handler concurrently, we can simply suspend that queue
> alone.

You're just moving the hoop you have to jump through. Handling it inline
with the timeout handler reclaims lost commands in starting, deleting,
and live contexts. The existing reset_work can only reclaim from live.

If you want to create an intermediary work just to do the reset, you'll
first need to untangle the state machine to allow that to happen in a
deleting state, and that work needs to sync with these request queues
anyway, and then everyone else needs to sync with that new work we
created just to do something that is already handled in a work context
that we already sync with.
