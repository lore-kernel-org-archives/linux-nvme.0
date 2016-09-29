From: hare@suse.de (Hannes Reinecke)
Date: Thu, 29 Sep 2016 07:54:29 +0200
Subject: [PATCH v2 6/7] SRP transport: Port srp_wait_for_queuecommand() to
 scsi-mq
In-Reply-To: <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <bedf4b45-00b0-6844-047d-f1e05bb1092f@sandisk.com>
Message-ID: <c0cae8d1-c82e-5089-3f93-cd03511b45cc@suse.de>

On 09/29/2016 02:01 AM, Bart Van Assche wrote:
> Ensure that if scsi-mq is enabled that srp_wait_for_queuecommand()
> waits until ongoing shost->hostt->queuecommand() calls have finished.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: James Bottomley <jejb at linux.vnet.ibm.com>
> Cc: Martin K. Petersen <martin.petersen at oracle.com>
> Cc: Doug Ledford <dledford at redhat.com>
> ---
>  drivers/scsi/scsi_transport_srp.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
