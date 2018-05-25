From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 25 May 2018 09:09:24 -0600
Subject: [PATCHv3 9/9] nvme-pci: Don't wait for HMB completion on shutdown
In-Reply-To: <3452269f-a1bb-cfe6-635b-6b69a46862c1@oracle.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-10-keith.busch@intel.com>
 <20180524204506.GA29048@lst.de>
 <20180524211539.GM11037@localhost.localdomain>
 <3452269f-a1bb-cfe6-635b-6b69a46862c1@oracle.com>
Message-ID: <20180525150923.GS11037@localhost.localdomain>

On Fri, May 25, 2018@11:10:39AM +0800, jianchao.wang wrote:
> Does it mean just need to disable the controller with transiting CC.EN ?1? to ?0?
> without sending any admin commands including deleting cq/sq ?
> The specification indeed says that
> when Controller Reset (CC.EN transitions from ?1? to ?0
>  - The controller stops processing any outstanding Admin or I/O commands.
>  - All I/O Submission Queues are deleted.
>  - All I/O Completion Queues are deleted.
>  - The controller is brought to an Idle state. When this is complete, CSTS.RDY is cleared to ?0?.
>  - The Admin Queue registers (AQA, ASQ, or ACQ) are not reset as part of a controller reset. All
> other controller registers defined in section 3 and internal controller state are reset.

Yeah, that's true. I'd still like to preserve the orderly shutdown as
recommended per spec, but maybe we don't need a single function to handle
both orderly and error cases.

> Then for the timeout case at least, for LIVE state, nvme_timeout could hand over all the things to
> reset_work and return BLK_EH_RESET_TIMER, when reset_work is ongoing, just  disable the controller
> with setting CC.EN and disable the related pci things and return BLK_EH_HANDLED to complete the
> admin commands to wake up the reset_work. (certainly with your patch to move update_hw_nr to scan_work)
> nvme_timeout doesn't need to invoke nvme_dev_disable any more and life will be simpler :).

I'll need to think about this a little more. I do like simpler. :)
