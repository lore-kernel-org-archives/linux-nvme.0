From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:15:40 +0100
Subject: [PATCH 04/13] qla2xxx: Restore ZIO threshold setting
In-Reply-To: <20180312181650.20704-5-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-5-himanshu.madhani@cavium.com>
Message-ID: <43874f60-0f89-c4c1-7bc2-77c8f2612b2b@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_nvme.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index a8e81fc14c44..5ee447680ddd 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -464,11 +464,6 @@ static int qla2x00_start_nvme_mq(srb_t *sp)
>  	/* Set chip new ring index. */
>  	WRT_REG_DWORD(req->req_q_in, req->ring_index);
>  
> -	/* Manage unprocessed RIO/ZIO commands in response queue. */
> -	if (vha->flags.process_response_queue &&
> -	    rsp->ring_ptr->signature != RESPONSE_PROCESSED)
> -		qla24xx_process_response_queue(vha, rsp);
> -
>  queuing_error:
>  	spin_unlock_irqrestore(&qpair->qp_lock, flags);
>  	return rval;
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
