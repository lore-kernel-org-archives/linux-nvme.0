From: Chayan.Biswas@sandisk.com (Chayan Biswas)
Date: Wed, 17 Oct 2012 22:40:34 +0000
Subject: IRQ allocation in nvme driver
In-Reply-To: <82C9F782B054C94B9FC04A331649C77A07B9195D@FMSMSX106.amr.corp.intel.com>
References: <E821E2F372F08945977BD15EAE588D61084671CE@SACMBXIP02.sdcorp.global.sandisk.com>
 <82C9F782B054C94B9FC04A331649C77A07B9195D@FMSMSX106.amr.corp.intel.com>
Message-ID: <E821E2F372F08945977BD15EAE588D610846763F@SACMBXIP02.sdcorp.global.sandisk.com>

Yes, that is a better approach. 

However, in the current Linux driver, the NVME queue pointer is passed in the IRQ handler and hence it will require lot more code to choose the correct NVME queue pointer for MSIX 0 handler. Hence I chose the easier approach of allocating an additional MSIX without changing a lot of tested code.

Thanks,
Chayan

-----Original Message-----
From: Luse, Paul E [mailto:paul.e.luse@intel.com] 
Sent: Wednesday, October 17, 2012 3:12 PM
To: Chayan Biswas; Matthew Wilcox; linux-nvme at lists.infradead.org
Subject: RE: IRQ allocation in nvme driver

FYI The OFA Windows driver currently shares MSIX 0 with the admin queue and an IO queue.  Its not the case that an "extra" INT is generated, its just that any processing of MSIX 0 needs to check the admin queue as well as the associated IO queue.  We went this direction to conserve vectors as the impact is negligible under normal usage (the instructions to read one completion queue entry on the admin queue and notice that its not new).  Not sure how it works in Linux but in Windows if we don't get our requested allocation then we get just one so we wanted to avoid that in this case.

Thx
Paul

-----Original Message-----
From: linux-nvme-bounces@lists.infradead.org [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Chayan Biswas
Sent: Wednesday, October 17, 2012 2:39 PM
To: Matthew Wilcox; linux-nvme at lists.infradead.org
Subject: IRQ allocation in nvme driver

Hi Matthew,

The nvme driver allocates MSIX vector 0 for admin queue, but it also allocates the same vector 0 for IO queue 0. Is this a bug, since any completion on the admin queue after MSIX IRQ allocation will generate an interrupt for IO queue 0?

We have changed our code to avoid this by allocating n+1 MSIX vectors and IO queue 0 using MSIX vector 1. If this fix is needed, we can send our patch.

Thanks,
Chayan


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
