From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 31 Aug 2017 12:22:29 +0300
Subject: [PATCH] nvme/host: generate spec-compliant UUID NQNs
In-Reply-To: <20170830221819.43340-1-daniel.verkamp@intel.com>
References: <20170830221819.43340-1-daniel.verkamp@intel.com>
Message-ID: <74532485-992d-e0ec-d3cb-c82554fa7f0d@mellanox.com>



On 8/31/2017 1:18 AM, Daniel Verkamp wrote:
> The default host NQN, which is generated based on the host's UUID,
> does not follow the UUID-based NQN format laid out in the NVMe 1.3
> specification.  Remove the "NVMf:" portion of the NQN to match the spec.
> 
> Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
> ---
>   drivers/nvme/host/fabrics.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5f5cd306f76d..ffa7191ddfa5 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
