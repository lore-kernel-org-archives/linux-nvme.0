From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 May 2016 07:17:49 -0700
Subject: [PATCH v2 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <572A27EB.5060202@collabora.co.uk>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <5718D697.3050800@collabora.co.uk>
 <20160421133823.GA13563@infradead.org>
 <1461262295.4797.11.camel@ssi>
 <20160503080552.GA13239@infradead.org>
 <572A27EB.5060202@collabora.co.uk>
Message-ID: <20160505141749.GB5260@infradead.org>

On Wed, May 04, 2016@01:48:43PM -0300, Helen Koike wrote:
> 1) I predict the command Set Doorbell/EventIdx Memory in the proposal,
> should have an Unset command?

Why would you unset it?  What's probably more important is to define
that you do / do not need to set it again after a reset.  Probably the
former.

> 2) What should be filled in the function field in figure 40?

Probably nothing for now, just let the editor update it.

> 3) In the original patch, the command Set Doorbell/EventIdx Memory is
> assumed to be performed after all the queues are created, then what should
> happen if a queue is created after this command? We should abort the create
> queue command? Or we should first unset the doorbel/eventIdx memory then
> create the queues and then set it again? Or we just change the original
> proposal and if the controller has this functionality, it should support
> queues being created after the Set Doorbell/EventIdx Memory command?
> Personally I think the controller should support creating queues after the
> Set Doorbell/EventIdx Memory command was performed, what do you think?

I would not treat it any different than the existing doorbell registers,
which have the same issue.  NVMe allows you to create I/O queues
any time, but you better get the sizing of the bar / memory right
for the maximum possible number of queues allocated.
