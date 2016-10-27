From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 27 Oct 2016 16:57:05 -0700
Subject: [PATCH v3 6/7] nvme-fabrics: Add target support for FC transport
In-Reply-To: <1638bc85-4b94-a74d-e0ef-c955c6f7bf83@broadcom.com>
References: <580d0ffe.SFprDuHa1JbmKoHU%james.smart@broadcom.com>
 <1477508953.3009.97.camel@linux.intel.com>
 <1638bc85-4b94-a74d-e0ef-c955c6f7bf83@broadcom.com>
Message-ID: <1477612625.2838.50.camel@linux.intel.com>


> nvme_fc_abort_op() would not be called in the normal case.
> 
> nvme_fc_abort_op() is called on exception cases. It's called to
> request the LLDD to kill the exchange (the thing the initiator and
> target are using for the io) mid processing due to some error.? The
> cases where it's called are:
> When queues are deleted, thus every outstanding io on that queue
> needs to be implicitly terminated.
> If the LLDD refused to send data for the exchange. Something is bad
> in the LLDD or the exchange is dead. So we formally terminate the
> exchange as there's nothing more the transport can do with it. On the
> other end of the wire, the initiator won't see the io complete, thus
> it'll usually fall into the escalation policy of terminating the
> queue or resetting the controller.
> if the transport detects a software error for the io that had a bad
> op code in it. At least kill the FC resource so the initiator will
> see it and recover.
> The call to nvmet_fc_xmt_fcp_op_done() with the ABORT op, is the LLDD
> saying it's completed the abort, freed the hw resource, and the
> job/exchange is released back to the transport. At that point, the
> transport will finish its teardown of the io.
> 

Thanks for the explanation James!
Jay

> Thanks
> 
> -- james
> 
> 
