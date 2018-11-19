From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Nov 2018 12:38:24 -0800
Subject: [PATCH v4 1/5] qla2xxx_nvmet: Add FC-NVMe Target Link Service
 request handling
In-Reply-To: <20181031164059.6286-2-himanshu.madhani@cavium.com>
References: <20181031164059.6286-1-himanshu.madhani@cavium.com>
 <20181031164059.6286-2-himanshu.madhani@cavium.com>
Message-ID: <a0034841-5c6e-5072-d24d-3c09519bb9cd@broadcom.com>



On 10/31/2018 9:40 AM, Himanshu Madhani wrote:
> From: Anil Gurumurthy <anil.gurumurthy at cavium.com>
>
> This patch provides link service pass through feature handling
> in the driver. This feature is implemented mainly by the firmware
> and the same implementation is handled in the driver via an
> IOCB interface.
>
> Signed-off-by: Anil Gurumurthy <anil.gurumurthy at cavium.com>
> Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>
> +
> +/*
> + * Used by FC-NVMe Target
> + */
> +int qla_nvmet_ls(srb_t *sp, void *rsp_pkt);
> +int qlt_send_els_resp(srb_t *sp, void *pkt);
> +
> ...
>   
> +int qlt_send_els_resp(srb_t *sp, void *pkt)
> +{
> +	return 0;
> +}
> +
> +int
> +qla_nvmet_ls(srb_t *sp, void *rsp_pkt)
> +{
> +	return 0;
> +}
> +
>   void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
>   	struct rsp_que *rsp, response_t *pkt)
>   {

Rather than add these 2 routines in now, only to remove them in patch 3 
- you can leave the stubs, just make the prototypes correct.? Then patch 
3 can flush them out.

- james
