From: hare@suse.de (Hannes Reinecke)
Date: Tue, 14 May 2019 12:20:03 +0200
Subject: [PATCH 4/7] lpfc: Add support to generate RSCN events for nport
In-Reply-To: <20190513224314.24169-5-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
 <20190513224314.24169-5-jsmart2021@gmail.com>
Message-ID: <e052dd2f-1466-5679-19af-0ca3fedfbd85@suse.de>

On 5/14/19 12:43 AM, James Smart wrote:
> This patch adds general RSCN support:
> - The ability to transmit an RSCN to the port on the other end of
>    the link (regular port if pt2pt, or fabric controller if fabric).
> - And general recognition of an RSCN ELS when an ELS is received.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc.h         |   1 +
>   drivers/scsi/lpfc/lpfc_crtn.h    |   2 +
>   drivers/scsi/lpfc/lpfc_els.c     | 122 +++++++++++++++++++++++++++++++++++++++
>   drivers/scsi/lpfc/lpfc_hbadisc.c |  35 +++++++++++
>   drivers/scsi/lpfc/lpfc_hw.h      |   2 +
>   drivers/scsi/lpfc/lpfc_sli.c     |   1 +
>   6 files changed, 163 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
