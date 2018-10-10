From: james.smart@broadcom.com (James Smart)
Date: Wed, 10 Oct 2018 08:57:08 -0700
Subject: [PATCH v2 2/2] nvmet-fcloop: Suppress a compiler warning
In-Reply-To: <20181010150820.203745-3-bvanassche@acm.org>
References: <20181010150820.203745-1-bvanassche@acm.org>
 <20181010150820.203745-3-bvanassche@acm.org>
Message-ID: <73fab5b8-b612-a6cd-e6c3-d55ee66cf75a@broadcom.com>



On 10/10/2018 8:08 AM, Bart Van Assche wrote:
> Building with W=1 enables the compiler warning -Wimplicit-fallthrough=3. That
> option does not recognize the fall-through comment in the fcloop driver. Add
> a fall-through comment that is recognized for -Wimplicit-fallthrough=3. This
> patch avoids that the compiler reports the following warning when building
> with W=1:
>
> drivers/nvme/target/fcloop.c:647:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (op == NVMET_FCOP_READDATA)
>        ^
>
> Cc: James Smart <james.smart at broadcom.com>
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>
> ---
>   drivers/nvme/target/fcloop.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 5251689a1d9a..291f4121f516 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -648,6 +648,7 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>   			break;
>   
>   		/* Fall-Thru to RSP handling */
> +		/* FALLTHRU */
>   
>   	case NVMET_FCOP_RSP:
>   		if (fcpreq) {

Reviewed-by: James Smart <james.smart at broadcom.com>

I had no idea there was a "standard" way to declare this.

-- james
