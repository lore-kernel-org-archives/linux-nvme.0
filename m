From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Jul 2017 12:24:33 -0400
Subject: [PATCH 02/13] mpt3sas: SGL to PRP Translation for I/Os to NVMe
 devices
In-Reply-To: <1499763313-7214-3-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1499763313-7214-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1499763313-7214-3-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <20170711162433.GC4604@localhost.localdomain>

On Tue, Jul 11, 2017@01:55:02AM -0700, Suganath Prabu S wrote:
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
> index 60fa7b6..cebdd8e 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.h
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
> @@ -54,6 +54,7 @@
>  #include "mpi/mpi2_raid.h"
>  #include "mpi/mpi2_tool.h"
>  #include "mpi/mpi2_sas.h"
> +#include "mpi/mpi2_pci.h"

Could you ajust your patch order for this series so each can compile? Here
in patch 2 you're including a header that's not defined until patch 12.
