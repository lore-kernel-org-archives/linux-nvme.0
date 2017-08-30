From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 Aug 2017 10:17:51 +0300
Subject: [PATCH] nvme: fix the definition of Amin doorbell buffer config
 support
In-Reply-To: <1504149769-15307-1-git-send-email-changpeng.liu@intel.com>
References: <1504149769-15307-1-git-send-email-changpeng.liu@intel.com>
Message-ID: <d02bb862-427a-81e9-8f44-7aa8d07331e0@mellanox.com>



On 8/31/2017 6:22 AM, Changpeng Liu wrote:
> NVMe 1.3 specification defines the Optioal Admin Command Support
> feature flags, bit 8 set to '1' then the controller supports the
> Doorbell Buffer Config command. Bit 7 is used for Virtualization
> Mangement command.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu at intel.com>
> ---
>   include/linux/nvme.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h

Looks good (need to update the typo Optioal -> Optional during the merge),

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
