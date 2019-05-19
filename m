From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 May 2019 16:48:12 +0000
Subject: [PATCH V2 1/4] nvme.h: Fix typos in status code values
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
 <20190513170342.9497-2-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB5749A82313D11DC76974C16D86050@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
On 05/13/2019 10:04 AM, Minwoo Im wrote:
> Fix typos in status code value.  linux/nvme.h in kernel project is going
> to be fixed soon or later.
>
> Cc: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   linux/nvme.h | 4 ++--
>   nvme-print.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/linux/nvme.h b/linux/nvme.h
> index 2c840b9..c99b438 100644
> --- a/linux/nvme.h
> +++ b/linux/nvme.h
> @@ -1365,9 +1365,9 @@ enum {
>   	NVME_SC_FW_NEEDS_SUBSYS_RESET	= 0x110,
>   	NVME_SC_FW_NEEDS_RESET		= 0x111,
>   	NVME_SC_FW_NEEDS_MAX_TIME	= 0x112,
> -	NVME_SC_FW_ACIVATE_PROHIBITED	= 0x113,
> +	NVME_SC_FW_ACTIVATE_PROHIBITED	= 0x113,
>   	NVME_SC_OVERLAPPING_RANGE	= 0x114,
> -	NVME_SC_NS_INSUFFICENT_CAP	= 0x115,
> +	NVME_SC_NS_INSUFFICIENT_CAP	= 0x115,
>   	NVME_SC_NS_ID_UNAVAILABLE	= 0x116,
>   	NVME_SC_NS_ALREADY_ATTACHED	= 0x118,
>   	NVME_SC_NS_IS_PRIVATE		= 0x119,
> diff --git a/nvme-print.c b/nvme-print.c
> index c038355..0ce88d4 100644
> --- a/nvme-print.c
> +++ b/nvme-print.c
> @@ -1801,9 +1801,9 @@ const char *nvme_status_to_string(__u32 status)
>   	case NVME_SC_FW_NEEDS_SUBSYS_RESET:	return "FW_NEEDS_SUBSYSTEM_RESET: The firmware commit was successful, however, activation of the firmware image requires an NVM Subsystem";
>   	case NVME_SC_FW_NEEDS_RESET:		return "FW_NEEDS_RESET: The firmware commit was successful; however, the image specified does not support being activated without a reset";
>   	case NVME_SC_FW_NEEDS_MAX_TIME:		return "FW_NEEDS_MAX_TIME_VIOLATION: The image specified if activated immediately would exceed the Maximum Time for Firmware Activation (MTFA) value reported in Identify Controller. To activate the firmware, the Firmware Commit command needs to be re-issued and the image activated using a reset";
> -	case NVME_SC_FW_ACIVATE_PROHIBITED:	return "FW_ACTIVATION_PROHIBITED: The image specified is being prohibited from activation by the controller for vendor specific reasons";
> +	case NVME_SC_FW_ACTIVATE_PROHIBITED:	return "FW_ACTIVATION_PROHIBITED: The image specified is being prohibited from activation by the controller for vendor specific reasons";
>   	case NVME_SC_OVERLAPPING_RANGE:		return "OVERLAPPING_RANGE: This error is indicated if the firmware image has overlapping ranges";
> -	case NVME_SC_NS_INSUFFICENT_CAP:	return "NS_INSUFFICIENT_CAPACITY: Creating the namespace requires more free space than is currently available. The Command Specific Information field of the Error Information Log specifies the total amount of NVM capacity required to create the namespace in bytes";
> +	case NVME_SC_NS_INSUFFICIENT_CAP:	return "NS_INSUFFICIENT_CAPACITY: Creating the namespace requires more free space than is currently available. The Command Specific Information field of the Error Information Log specifies the total amount of NVM capacity required to create the namespace in bytes";
>   	case NVME_SC_NS_ID_UNAVAILABLE:		return "NS_ID_UNAVAILABLE: The number of namespaces supported has been exceeded";
>   	case NVME_SC_NS_ALREADY_ATTACHED:	return "NS_ALREADY_ATTACHED: The controller is already attached to the namespace specified";
>   	case NVME_SC_NS_IS_PRIVATE:		return "NS_IS_PRIVATE: The namespace is private and is already attached to one controller";
>
