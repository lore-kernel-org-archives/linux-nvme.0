From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 8 May 2019 18:00:45 +0000
Subject: [PATCH] nvme-core: trace discovery log change AEN
References: <20190506193320.30884-1-chaitanya.kulkarni@wdc.com>
Message-ID: <SN6PR04MB45273950C09083AEB955480D86320@SN6PR04MB4527.namprd04.prod.outlook.com>

Ping, it helps in debugging discovery related events.

Can someone please review this ?

On 05/06/2019 12:33 PM, Chaitanya Kulkarni wrote:
> This patch allows the user to trace discovery log change notification.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>   drivers/nvme/host/core.c  | 3 +++
>   drivers/nvme/host/trace.h | 1 +
>   2 files changed, 4 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cd16d98d1f1a..32e12ee42785 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3615,6 +3615,9 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
>   		trace_nvme_async_event(ctrl, aer_notice_type);
>   		queue_work(nvme_wq, &ctrl->fw_act_work);
>   		break;
> +	case NVME_AER_NOTICE_DISC_CHANGED:
> +		trace_nvme_async_event(ctrl, aer_notice_type);
> +		break;
>   #ifdef CONFIG_NVME_MULTIPATH
>   	case NVME_AER_NOTICE_ANA:
>   		trace_nvme_async_event(ctrl, aer_notice_type);
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index 97d3c77365b8..f2fda5fb01fb 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -165,6 +165,7 @@ TRACE_EVENT(nvme_async_event,
>   		__entry->ctrl_id, __entry->result,
>   		__print_symbolic(__entry->result,
>   		aer_name(NVME_AER_NOTICE_NS_CHANGED),
> +		aer_name(NVME_AER_NOTICE_DISC_CHANGED).
>   		aer_name(NVME_AER_NOTICE_ANA),
>   		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
>   		aer_name(NVME_AER_ERROR),
>
