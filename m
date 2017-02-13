From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 09:32:57 +0100
Subject: [PATCH v3 04/16] lpfc: refactor debugfs queue prints
In-Reply-To: <58a0d91c.FMlII2L+0d4RFlSj%jsmart2021@gmail.com>
References: <58a0d91c.FMlII2L+0d4RFlSj%jsmart2021@gmail.com>
Message-ID: <c8f1e00a-974a-8e65-4a64-f5fcbe1af0dc@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> Create common wq, cq, eq, rq print functions
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h         |   1 +
>  drivers/scsi/lpfc/lpfc_debugfs.c | 564 ++++++++++++++++-----------------------
>  2 files changed, 228 insertions(+), 337 deletions(-)
> 
One should look at converting it to seq_file(), seeing that there are
provisions for overflow already.
But that can be done in a later patch.

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
