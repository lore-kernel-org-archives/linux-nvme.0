From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 14 Feb 2017 19:47:19 +0200
Subject: [PATCH] nvme-cli: fabrics: Fix to pass "host_traddr" to the
 kernel driver.
In-Reply-To: <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
References: <n> <1486579584-5660-1-git-send-email-duane.grigsby@qlogic.com>
Message-ID: <38171155-38a1-096d-2069-91bb4e09f6f7@mellanox.com>

Hi Darren,
Can you send an example for usage ?
I want to try this out.

thanks,
Max.

On 2/8/2017 8:46 PM, Duane Grigsby wrote:
> This fix adds the  "host_traddr" to the contructed string that is
> passed to the kernel.
>
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> ---
>  fabrics.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fabrics.c b/fabrics.c
> index 362ca6f..3f6be53 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -595,6 +595,11 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
>  				return -EINVAL;
>  			p += len;
>
> +			len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
> +			if (len < 0)
> +				return -EINVAL;
> +			p+= len;
> +
>  			len = sprintf(p, ",traddr=%s", e->traddr);
>  			if (len < 0)
>  				return -EINVAL;
>
