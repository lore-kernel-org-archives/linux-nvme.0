From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 17:59:06 +0300
Subject: [PATCH v4 1/8] nvme: introduce NVMe Namespace Identification
 Descriptor structures
In-Reply-To: <20170604103649.22130-2-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-2-jthumshirn@suse.de>
Message-ID: <fda3105a-706d-0b38-6ff8-8b69749d8374@grimberg.me>



On 04/06/17 13:36, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   include/linux/nvme.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b625bacf37ef..afa6ef484e50 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -288,6 +288,7 @@ enum {
>   	NVME_ID_CNS_NS			= 0x00,
>   	NVME_ID_CNS_CTRL		= 0x01,
>   	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
> +	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
>   	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
>   	NVME_ID_CNS_NS_PRESENT		= 0x11,
>   	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
> @@ -314,6 +315,22 @@ enum {
>   	NVME_NS_DPS_PI_TYPE3	= 3,
>   };
>   
> +struct nvme_ns_identifier_hdr {
> +	__u8 nidt;
> +	__u8 nidl;
> +	__le16 reserved;
> +};

Nit: _hdr is usually associated with a message or alike.

Maybe nvme_ns_id_desc is more consistent with the spec language.
