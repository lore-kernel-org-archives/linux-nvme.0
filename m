From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 6 Jun 2019 15:37:10 +0000
Subject: [RFC PATCH V6 2/3] nvme: trace: do not EXPORT_SYMBOL for a trace
 function
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
 <20190606063229.17258-3-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB574962A56158412D25FA54AF86170@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 06/05/2019 11:39 PM, Minwoo Im wrote:
> nvme_trace_disk_name() is now already being invoked with the function
> prototype in trace.h.  We don't need to export this symbol at all.
>
> The following patches are going to provide target-side trace feature
> with the exactly same function with this so that this patch removes the
> EXPORT_SYMBOL() for this function.
>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/trace.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index 5f24ea7a28eb..14b0d2993cbe 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -145,6 +145,5 @@ const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
>
>   	return ret;
>   }
> -EXPORT_SYMBOL_GPL(nvme_trace_disk_name);
>
>   EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
>
