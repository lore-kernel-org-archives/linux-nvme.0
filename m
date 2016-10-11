From: hch@lst.de (Christoph Hellwig)
Date: Tue, 11 Oct 2016 18:44:17 +0200
Subject: [PATCH v2 6/7] SRP transport: Port srp_wait_for_queuecommand()
 to scsi-mq
In-Reply-To: <619e3ffc-2123-4cb0-361a-4025ba47b991@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
 <8ce2910d-fde0-724f-a61f-8fbd7fbf499d@grimberg.me>
 <619e3ffc-2123-4cb0-361a-4025ba47b991@sandisk.com>
Message-ID: <20161011164417.GB18822@lst.de>

On Wed, Oct 05, 2016@02:51:50PM -0700, Bart Van Assche wrote:
> There are multiple direct blk_*() calls in other SCSI transport drivers. So 
> my proposal is to wait with moving this code into scsi_lib.c until there is 
> a second user of this code.

I still don't think these low-level difference for blk-mq vs legacy
request belong into a scsi LLDD.  So I concur with Sagi that this
should go into the core SCSI code.

In fact I suspect we should just call it directly from
scsi_internal_device_block, and maybe even scsi_internal_device_unblock
for case of setting the device offline.
