From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 27 Jun 2019 05:10:39 +0900
Subject: [PATCH][next] nvme-trace: fix spelling mistake "spcecific" ->
 "specific"
In-Reply-To: <20190626124323.5925-1-colin.king@canonical.com>
References: <20190626124323.5925-1-colin.king@canonical.com>
Message-ID: <20190626201039.GA4934@minwooim-desktop>

On 19-06-26 13:43:23, Colin King wrote:
> From: Colin Ian King <colin.king at canonical.com>
> 
> There are two spelling mistakes in trace_seq_printf messages, fix these.
> 
> Signed-off-by: Colin Ian King <colin.king at canonical.com>
> ---
>  drivers/nvme/host/trace.c   | 2 +-
>  drivers/nvme/target/trace.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index f01ad0fd60bb..6980ab827233 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -178,7 +178,7 @@ static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
>  {
>  	const char *ret = trace_seq_buffer_ptr(p);
>  
> -	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
> +	trace_seq_printf(p, "specific=%*ph", 24, spc);
>  	trace_seq_putc(p, 0);
>  	return ret;
>  }
> diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
> index cdcdd14c6408..6af11d493271 100644
> --- a/drivers/nvme/target/trace.c
> +++ b/drivers/nvme/target/trace.c
> @@ -146,7 +146,7 @@ static const char *nvmet_trace_fabrics_common(struct trace_seq *p, u8 *spc)
>  {
>  	const char *ret = trace_seq_buffer_ptr(p);
>  
> -	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
> +	trace_seq_printf(p, "specific=%*ph", 24, spc);
>  	trace_seq_putc(p, 0);
>  	return ret;
>  }
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

*facepalm*..

Thanks for fixing this, Colin!

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
