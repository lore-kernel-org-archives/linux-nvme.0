From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 8 May 2017 09:10:08 +0200
Subject: [PATCH v3] lpfc: Fix panic on BFS configuration.
In-Reply-To: <20170427220826.12693-1-jsmart2021@gmail.com>
References: <20170427220826.12693-1-jsmart2021@gmail.com>
Message-ID: <20170508071008.GA3982@linux-x5ow.site>

On Thu, Apr 27, 2017@03:08:26PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> To select the appropriate shost template, the driver is issuing
> a mailbox command to retrieve the wwn. Turns out the sending of
> the command precedes the reset of the function.  On SLI-4 adapters,
> this is inconsequential as the mailbox command location is specified
> by dma via the BMBX register. However, on SLI-3 adapters, the
> location of the mailbox command submission area changes. When the
> function is first powered on or reset, the cmd is submitted via PCI
> bar memory. Later the driver changes the function config to use
> host memory and DMA. The request to start a mailbox command is the
> same, a simple doorbell write, regardless of submission area.
> So.. if there has not been a boot driver run against the adapter,
> the mailbox command works as defaults are ok. But, if the boot
> driver has configured the card and, and if no platform pci
> function/slot reset occurs as the os starts, the mailbox command
> will fail. The SLI-3 device will use the stale boot driver dma
> location. This can cause PCI eeh errors.
> 
> Fix is to reset the sli-3 function before sending the
> mailbox command, thus synchronizing the function/driver on mailbox
> location.
> 
> Note: The fix uses routines that are typically invoked later in the
> call flow to reset the sli-3 device. The issue in using those routines is
> that the normal (non-fix) flow does additional initialization, namely the
> allocation of the pport structure. So, rather than significantly reworking
> the initialization flow so that the pport is alloc'd first, pointer checks
> are added to work around it. Checks are limited to the routines invoked
> by a sli-3 adapter (s3 routines) as this fix/early call is only invoked
> on a sli3 adapter. Nothing changes post the fix. Subsequent initialization,
> and another adapter reset, still occur - both on sli-3 and sli-4 adapters.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Fixes: 96418b5e2c88 ("scsi: lpfc: Fix eh_deadline setting for sli3 adapters.")
> Cc: stable at vger.kernel.org
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
