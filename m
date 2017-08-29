From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 Aug 2017 01:30:57 +0300
Subject: [PATCHv2 3/4] nvme: Make nvme user functions static
In-Reply-To: <1504043164-5398-4-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
 <1504043164-5398-4-git-send-email-keith.busch@intel.com>
Message-ID: <35b021e0-e588-1476-2b68-38b27477cc3d@mellanox.com>



On 8/30/2017 12:46 AM, Keith Busch wrote:
> These functions are used only locally in the nvme core.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 10 +++++-----
>   drivers/nvme/host/nvme.h |  7 -------
>   2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a28f181..4106e09 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c

looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
