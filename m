From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Jun 2018 11:32:34 +0200
Subject: [PATCH 3/3] nvme-fabrics: fix and refine state checks in
 __nvmf_check_ready
In-Reply-To: <2185be0b-7936-3b3f-2659-d6634336f907@broadcom.com>
References: <20180614122215.4395-1-hch@lst.de>
 <20180614122215.4395-4-hch@lst.de>
 <2185be0b-7936-3b3f-2659-d6634336f907@broadcom.com>
Message-ID: <20180615093234.GB21138@lst.de>

On Thu, Jun 14, 2018@10:37:01AM -0700, James Smart wrote:
> I like what's here and think it's pretty conclusive. Enough that I'm good 
> with a Reviewed-by for me to be added.

Thanks.

> In thinking this through: There's still the issue of queue_live being set 
> true when in a RESETTING/DELETING state as the workqueue element to enact 
> the reset/delete has yet to be run or is just starting to run. Since above 
> restricts it to kernel-generated commands only, the only things that should 
> get through in this case are:
> 1) a property_set command to write CC.NE=0 is issued by the transport 
> reset/delete handler. Note: it's unclear whether the queue will be live or 
> not.
> 2) controller was in a NEW/CONNECTING state and was sending a command used 
> to init the controller.
> 3) a keep alive
>
> (1) is desired behavior, assuming queue is live to let it through.
> (2) and (3) - I assume the transport reset/delete handler will freeze the 
> queues, cycle through any outstanding command and will terminate them. So 
> it should be ok.

Yes.

> I assume, based on the time needed to freeze the queues, 
> that there shouldn't be a possibility for the delete/reset handler queue 
> freeze code to race with an io allowed by the checks (it should be long 
> gone).?? If there's not agreement on that assumption, then a clause 
> should be added after the switch case that checks for RESETTING or DELETING 
> and if so, only allows a Property_Set for CC.EN=0 command.

Note that in PCIe until recently we actually had other commands in
the shutdown sequence, and at least for an oderly shutdown other commands
might reappear.  So I'm not really sure adding additional restrictions
is a good idea, as we'd need to update the state machine every time
the shutdown sequence changes.  Especially given that the queue should
be frozen for external I/O anyway.

>
> -- james
---end quoted text---
