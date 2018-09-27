From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 27 Sep 2018 08:42:44 -0700
Subject: nvmet: Kernel v4.19-rc4 circular locking complaint
In-Reply-To: <1b13d375-3ab4-4e95-ea3b-662ddba8bdf9@grimberg.me>
References: <1537465780.224533.19.camel@acm.org>
 <1b13d375-3ab4-4e95-ea3b-662ddba8bdf9@grimberg.me>
Message-ID: <1538062964.226558.2.camel@acm.org>

On Tue, 2018-09-25@22:38 -0700, Sagi Grimberg wrote:
> I think that moving release work to a private wq should help, does it
> make this complaint go away?

Hi Sagi,

Thanks for the patch. However, it seems like your patch got line-wrapped.
Can you resend it?

Thanks,

Bart.

$ patch -p1 < ~/Re\:_nvmet\:_Kernel_v4.19-rc4_circular_locking_complaint.mbox        
(Stripping trailing CRs from patch; use --binary to disable.)

patching file drivers/nvme/target/rdma.c

Hunk #1 FAILED at 122.

patch: **** malformed patch at line 129: rdma_cm_id *cm_id,
