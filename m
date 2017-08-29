From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 Aug 2017 01:31:52 +0300
Subject: [PATCHv2 4/4] nvme: Use metadata for passthrough commands
In-Reply-To: <1504043164-5398-5-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
 <1504043164-5398-5-git-send-email-keith.busch@intel.com>
Message-ID: <d3f73617-0d9d-0484-fe7c-9e7efc561a7b@mellanox.com>



On 8/30/2017 12:46 AM, Keith Busch wrote:
> The ioctls' struct allows the user to provide a metadata address and
> length for a passthrough command. This patch uses these values that were
> previously ignored and deletes the now unused wrapper function.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4106e09..05d8545 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c

looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
