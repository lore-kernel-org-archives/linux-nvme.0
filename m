From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 09:49:52 +0200
Subject: [PATCH 12/15] lpfc: Cleanup entry_repost settings on SLI4 queues
In-Reply-To: <20170510190713.30171-13-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-13-jsmart2021@gmail.com>
Message-ID: <1f3ad2eb-4db8-5181-02d9-cde8d43e952c@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
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
> ---
>  drivers/scsi/lpfc/lpfc_init.c |  3 --
>  drivers/scsi/lpfc/lpfc_sli.c  | 64 +++++++++++--------------------------------
>  drivers/scsi/lpfc/lpfc_sli4.h |  8 ++++--
>  3 files changed, 21 insertions(+), 54 deletions(-)
> 
If this is a fix to a previous patch (Patch 6/15 ?), please merge it
with that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
