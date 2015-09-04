From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Sep 2015 15:12:29 +0000 (UTC)
Subject: [PATCH] NVMe: Set affinity after allocating request queues
In-Reply-To: <000101d0e6e8$d7a74850$86f5d8f0$@samsung.com>
References: <1441289897-16839-1-git-send-email-keith.busch@intel.com>
 <000101d0e6e8$d7a74850$86f5d8f0$@samsung.com>
Message-ID: <alpine.LNX.2.00.1509041505230.23840@localhost.lm.intel.com>

On Fri, 4 Sep 2015, ??? wrote:
> Hello, Keith Busch.
> Thank you for the patch. I've confirmed  that setting hint is now working with the patch.
>
> However, I think setting affinity hint is not sufficient to balance interrupts.
> We've observed that affinity hint has not much impact on distributing interrupts across cores on  a distro such as debian 7.0
> while setting affinity directly has worked on the distro.
>
> Plus, hint information is also provided by device driver with intention that balances interrupt loads across cores.
> And it also needs to collaborate with irqbalance option to work on.
> So, I think setting affinity is a clear way to achieve balancing effect provided by driver rather than hint information.
> I hope to listen your opinion regarding this.

No argument from me against having an API to directly set the irq
affinity. I think it's a great idea.

This patch just puts the hint where it ought to be. My machines have a
different patch that create a request_queue without a namespace (for
hidden access), so I didn't notice the async scanning broke the hint
on mainline.

With this patch, and when the new irq affinity set function is
exported (assuming that is being done), you can just change the
irq_set_affinity_hint() to the new function.
