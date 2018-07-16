From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 16 Jul 2018 11:12:33 -0600
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <c52b671e-8ca5-aa04-9182-7a43014aed40@grimberg.me>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <c0752e20-7d23-4b1f-b128-af952e3cf8da@grimberg.me>
 <20180716153721.GB26265@localhost.localdomain>
 <c52b671e-8ca5-aa04-9182-7a43014aed40@grimberg.me>
Message-ID: <20180716171232.GC26265@localhost.localdomain>

On Mon, Jul 16, 2018@07:36:41PM +0300, Sagi Grimberg wrote:
> > The only reason we need this is because each namespace has its own
> > request queue with their own timeout work. We don't want all of these
> > scheduling multiple controller resets, so the sync here just ensures
> > that there is no active timeout work that's about to schedule another
> > reset while we're already resetting the controller.
> 
> But scheduling a reset while a reset is running should not succeed. You
> should not be able to change state RESETTING -> RESETTING

Timeout handlers call nvme_dev_disable prior to the reset schedule
attempt, which is the part that we want to prevent occuring concurrently
with an already scheduled reset.
