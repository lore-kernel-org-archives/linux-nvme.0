From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Jan 2018 16:23:40 +0100
Subject: [PATCH v4 2/2] nvme: add tracepoint for nvme_complete_rq
In-Reply-To: <20180119141819.11938-3-jthumshirn@suse.de>
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-3-jthumshirn@suse.de>
Message-ID: <20180122152340.GB5818@lst.de>

On Fri, Jan 19, 2018@03:18:19PM +0100, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reviewed-by: Keith Busch <keith.busch at intel.com>
> 
> ---
> Changes to v2:
> * Pass the whole struct request to the tracepoint
> * Removed spaces after parenthesis (Christoph)
> ---
>  drivers/nvme/host/core.c  |  2 ++
>  drivers/nvme/host/trace.h | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1ca515720216..45a9b7092993 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -193,6 +193,8 @@ static inline bool nvme_req_needs_retry(struct request *req)
>  
>  void nvme_complete_rq(struct request *req)
>  {
> +	trace_nvme_complete_rq(req);
> +
>  	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
>  		if (nvme_req_needs_failover(req)) {
>  			nvme_failover_req(req);
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index 69e054c2e791..41d000fdd96f 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -101,6 +101,30 @@ TRACE_EVENT(nvme_setup_cmd,
>  				       __entry->cdw10))
>  );
>  
> +TRACE_EVENT(nvme_complete_rq,
> +	    TP_PROTO(struct request *req),
> +	    TP_ARGS(req),
> +	    TP_STRUCT__entry(
> +		    __field(int, cid)
> +		    __field(__le64, result)
> +		    __field(u8, retries)
> +		    __field(u8, flags)
> +		    __field(u16, status)
> +	    ),
> +	    TP_fast_assign(
> +		    __entry->cid = req->tag;
> +		    __entry->result = nvme_req(req)->result.u64;
> +		    __entry->retries = nvme_req(req)->retries;
> +		    __entry->flags = nvme_req(req)->flags;
> +		    __entry->status = nvme_req(req)->status;
> +	    ),
> +	    TP_printk("cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
> +		      __entry->cid,
> +		      le64_to_cpu(__entry->result),
> +		      __entry->retries, __entry->flags, __entry->status)
> +
> +);

Wouldn't some indication on which queue this completion happens
be useful?
