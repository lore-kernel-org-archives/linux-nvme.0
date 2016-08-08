From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 08 Aug 2016 14:17:20 -0700
Subject: [PATCH v2 nvme-cli 1/4] fabrics: Allow ipv6 address resolution
In-Reply-To: <1470657480-5868-2-git-send-email-sagi@grimberg.me>
References: <1470657480-5868-1-git-send-email-sagi@grimberg.me>
 <1470657480-5868-2-git-send-email-sagi@grimberg.me>
Message-ID: <1470691040.4368.16.camel@linux.intel.com>

On Mon, 2016-08-08@14:57 +0300, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
> ?fabrics.c | 3 ++-
> ?1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 8a174d41b82b..961335d45bd2 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -438,7 +438,8 @@ static int connect_ctrl(struct
> nvmf_disc_rsp_page_entry *e)
> ?		/* we can safely ignore the rest of the entries */
> ?		break;
> ?	case NVMF_TRTYPE_RDMA:
> -		if (e->adrfam != NVMF_ADDR_FAMILY_IP4) {
> +		if (e->adrfam != NVMF_ADDR_FAMILY_IP4 &&
> +		????e->adrfam != NVMF_ADDR_FAMILY_IP6) {

If we are going to roll this patch series again, maybe better to just
go ahead and do the case()?

I'm indifferent either way.

> ?			fprintf(stderr, "skipping unsupported
> adrfam\n");
> ?			return -EINVAL;
> ?		}
