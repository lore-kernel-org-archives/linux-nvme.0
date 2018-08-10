From: james.smart@broadcom.com (James Smart)
Date: Fri, 10 Aug 2018 08:10:51 -0700
Subject: [PATCH] Fix for a minor typo in nvme host/target fc.c
In-Reply-To: <20180810092402.GA5653@machine1>
References: <20180810092402.GA5653@machine1>
Message-ID: <31621aac-23f1-a476-bead-4c565e6c215b@broadcom.com>



On 8/10/2018 2:24 AM, Milan P. Gandhi wrote:
> This is a minor fix for a typo in drivers/nvme/host/fc.c
> and drivers/nvme/target/fc.c:
>
> Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>
> ---
>   drivers/nvme/host/fc.c   | 4 ++--
>   drivers/nvme/target/fc.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9bac912173ba..320b5f3f9794 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1385,7 +1385,7 @@ nvme_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
>   
>   	__nvme_fc_finish_ls_req(lsop);
>   
> -	/* fc-nvme iniator doesn't care about success or failure of cmd */
> +	/* fc-nvme initiator doesn't care about success or failure of cmd */
>   
>   	kfree(lsop);
>   }
> @@ -3158,7 +3158,7 @@ nvme_fc_parse_traddr(struct nvmet_fc_traddr *traddr, char *buf, size_t blen)
>   	substring_t wwn = { name, &name[sizeof(name)-1] };
>   	int nnoffset, pnoffset;
>   
> -	/* validate it string one of the 2 allowed formats */
> +	/* validate if string is one of the 2 allowed formats */
>   	if (strnlen(buf, blen) == NVME_FC_TRADDR_MAXLENGTH &&
>   			!strncmp(buf, "nn-0x", NVME_FC_TRADDR_OXNNLEN) &&
>   			!strncmp(&buf[NVME_FC_TRADDR_MAX_PN_OFFSET],
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 29b4b236afd8..a3905673e17f 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2468,7 +2468,7 @@ nvme_fc_parse_traddr(struct nvmet_fc_traddr *traddr, char *buf, size_t blen)
>   	substring_t wwn = { name, &name[sizeof(name)-1] };
>   	int nnoffset, pnoffset;
>   
> -	/* validate it string one of the 2 allowed formats */
> +	/* validate if string is one of the 2 allowed formats */
>   	if (strnlen(buf, blen) == NVME_FC_TRADDR_MAXLENGTH &&
>   			!strncmp(buf, "nn-0x", NVME_FC_TRADDR_OXNNLEN) &&
>   			!strncmp(&buf[NVME_FC_TRADDR_MAX_PN_OFFSET],

Reviewed-by:? James Smart <james.smart at broadcom.com>


-- james
