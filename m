From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 Aug 2017 10:55:11 +0300
Subject: [PATCH v2] nvme: fix the definition of Admin doorbell buffer
 config support
In-Reply-To: <1504166149-16770-1-git-send-email-changpeng.liu@intel.com>
References: <1504166149-16770-1-git-send-email-changpeng.liu@intel.com>
Message-ID: <769ffc1e-7861-c984-2c4f-48ae417ded73@mellanox.com>



On 8/31/2017 10:55 AM, Changpeng Liu wrote:
> NVMe 1.3 specification defines the Optional Admin Command Support
> feature flags, bit 8 set to '1' then the controller supports the
> Doorbell Buffer Config command. Bit 7 is used for Virtualization
> Mangement command.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu at intel.com>
> ---
>   include/linux/nvme.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

thanks,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
