From: hare@suse.de (Hannes Reinecke)
Date: Tue, 16 May 2017 11:53:04 +0200
Subject: [PATCH v2 12/15] lpfc: Cleanup entry_repost settings on SLI4
 queues
In-Reply-To: <20170515222052.26004-13-jsmart2021@gmail.com>
References: <20170515222052.26004-1-jsmart2021@gmail.com>
 <20170515222052.26004-13-jsmart2021@gmail.com>
Message-ID: <ac839511-61fb-5aab-f54e-0f85ae038e91@suse.de>

On 05/16/2017 12:20 AM, James Smart wrote:
> Too many work items being processed in IRQ context take a lot
> of CPU time and cause problems.
> 
> With a recent change, we get out of the ISR after hitting entry_repost
> work items on a queue. However, the actual values for entry repost are
> still high. EQ is 128 and CQ is 128, this could translate into
> processing 128 * 128 (16384) work items under IRQ context.
> 
> Set entry_repost in the actual queue creation routine now.
> Limit EQ repost to 8 and CQ repost to 64 to further limit the amount
> of time spent in the IRQ.
> 
> Fix fof IRQ routines as well.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2: portions of the original patch reworked:
>  rq/mrq entry_repost values - moved to
>      0004-lpfc-Fix-nvmet-RQ-resource-needs-for-large-block-wri.patch
>  eq/cq processing breaks- moved to
>      0006-lpfc-Fix-NMI-watchdog-assertions-when-running-nvmet-.patch
> 
>  drivers/scsi/lpfc/lpfc_sli.c  | 19 ++++++++-----------
>  drivers/scsi/lpfc/lpfc_sli4.h |  6 ++++--
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
