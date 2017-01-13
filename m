From: hare@suse.de (Hannes Reinecke)
Date: Fri, 13 Jan 2017 12:43:24 +0100
Subject: [PATCH 2/4] scsi: use blk_rq_payload_bytes
In-Reply-To: <1484306953-3194-3-git-send-email-hch@lst.de>
References: <1484306953-3194-1-git-send-email-hch@lst.de>
 <1484306953-3194-3-git-send-email-hch@lst.de>
Message-ID: <2043a73a-c616-948a-6484-faefe13ef024@suse.de>

On 01/13/2017 12:29 PM, Christoph Hellwig wrote:
> Without that we'll pass a wrong payload size in cmd->sdb, which
> can lead to hangs with drivers that need the total transfer size.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Chris Valean <v-chvale at microsoft.com>
> Reported-by: Dexuan Cui <decui at microsoft.com>
> Fixes: f9d03f96 ("block: improve handling of the magic discard payload")
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index c35b6de..ad4ff8f 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1018,7 +1018,7 @@ static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
>  	count = blk_rq_map_sg(req->q, req, sdb->table.sgl);
>  	BUG_ON(count > sdb->table.nents);
>  	sdb->table.nents = count;
> -	sdb->length = blk_rq_bytes(req);
> +	sdb->length = blk_rq_payload_bytes(req);
>  	return BLKPREP_OK;
>  }
>  
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
