From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 Aug 2017 01:29:55 +0300
Subject: [PATCHv2 2/4] nvme/pci: Use req_op to determine DIF remapping
In-Reply-To: <1504043164-5398-3-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
 <1504043164-5398-3-git-send-email-keith.busch@intel.com>
Message-ID: <6031440c-3f80-f5ed-403d-5c7e8cb0f40e@mellanox.com>



On 8/30/2017 12:46 AM, Keith Busch wrote:
> Only read and write commands need DIF remapping. Everything else uses
> a passthrough integrity payload.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
