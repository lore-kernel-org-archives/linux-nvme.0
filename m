From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Mar 2013 11:02:59 -0600 (MDT)
Subject: [PATCH 2/8] NVMe: Controller reset from user
In-Reply-To: <20130226140458.GE4530@linux.intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
 <1361404365-18982-2-git-send-email-keith.busch@intel.com>
 <20130226140458.GE4530@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1303110952480.17928@localhost.localdom>

On Tue, 26 Feb 2013, Matthew Wilcox wrote:
> 2. Avoid freeing the queue.  When resetting the controller, we don't
> actually have to free the memory and then reallocate it; we can reprogram
> the controller when it comes back up with the addresses that this memory
> already has.  So what we could do is put a single bit in nvme_queue
> ... call it something like q_suspended, and check it thusly:

This sounds like a pretty good idea. The only problem I see is the queues
had to have been created in the first place, and if a controller was
security locked, it would not have allowed this operation.

I was trying to reuse the exisiting queue initialization as much as
possible in case something changes after the reset, like more cpu's were
brought online to allow more queues, or if the controller configuration
changed from new firmware that may alter the queue count or depth. I
think this can all be accounted for without freeing the queue memory,
but not quite as easily.

> The problem with this implementation of reset controller is that it
> requires the controller to be sufficiently alive to process admin
> commands.  I think we need reset controller to be able to work if the
> admin queue is broken for some reason.  So just whacking the config
> register, waiting for it to complete, then reprogramming the registers,
> and resending all the admin init commands seems like the right move to me.

The patch was following the Shutdown sequence from the NVMe spec (7.6.2 in
revision 1.1). Hitting CC.EN to reset the controller isn't recommended
for normal shutdowns, but you're right, we can't hold up a shutdown
if the controller isn't responding to admin commands either. I added
schedule_timeout for sync commands in this patch set for commands that
do not complete, but that would hold things up for an unexceptable time
if the controller is not responding. Maybe we should have separate
graceful and abrupt shutdown sequences?

Anyway, thanks for the info. I'll take another shot at this.
