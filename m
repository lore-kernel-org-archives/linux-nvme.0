From: hare@suse.de (Hannes Reinecke)
Date: Sat, 10 Aug 2019 14:10:38 +0200
Subject: [PATCH v3 5/7] nvme-tcp: fail command with
 NVME_SC_HOST_PATH_ERROR send failed
In-Reply-To: <20190808205325.24036-6-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <20190808205325.24036-6-sagi@grimberg.me>
Message-ID: <f1919db0-5729-80ec-9295-ee9f82bd51b5@suse.de>

On 8/8/19 10:53 PM, Sagi Grimberg wrote:
> This is a more appropriate error status for a transport error
> detected by us (the host).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 2de33c4c5d14..7daf39f31b08 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -842,7 +842,7 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
>   
>   static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>   {
> -	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_DATA_XFER_ERROR);
> +	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
>   }
>   
>   static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
