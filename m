From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 11 May 2018 16:54:11 -0400
Subject: [PATCH] nvme/pci: Sync controller reset for AER slot_reset
In-Reply-To: <20180510160113.4432-1-keith.busch@intel.com> (Keith Busch's
 message of "Thu, 10 May 2018 10:01:13 -0600")
References: <20180510160113.4432-1-keith.busch@intel.com>
Message-ID: <yq1in7tq5fw.fsf@oracle.com>


Keith,

> AER handling expects a successful return from slot_reset means the
> driver made the device functional again. The nvme driver had been using
> an asynchronous reset to recover the device, so the device
> may still be initializing after control is returned to the
> AER handler. This creates problems for subsequent event handling,
> causing the initializion to fail.
>
> This patch fixes that by syncing the controller reset before returning
> to the AER driver, and reporting the true state of the reset.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
