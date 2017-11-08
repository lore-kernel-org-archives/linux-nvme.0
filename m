From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 8 Nov 2017 09:35:39 +0800
Subject: [PATCHv3 3/5] nvme: Single AEN request
In-Reply-To: <20171107221314.27822-4-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-4-keith.busch@intel.com>
Message-ID: <6cdfcd03-37d2-06cb-35e7-0d5798a2a827@huawei.com>


On 2017/11/8 6:13, Keith Busch wrote:
>  static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
> @@ -2758,22 +2750,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		union nvme_result *res)
>  {
>  	u32 result = le32_to_cpu(res->u32);
> -	bool done = true;
>  
> -	switch (le16_to_cpu(status) >> 1) {
> -	case NVME_SC_SUCCESS:
> -		done = false;
> -		/*FALLTHRU*/
> -	case NVME_SC_ABORT_REQ:
> -		++ctrl->event_limit;
> -		if (ctrl->state == NVME_CTRL_LIVE)
> -			queue_work(nvme_wq, &ctrl->async_event_work);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (done)
> +	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
>  		return;
If  le16_to_cpu(status) >> 1 is NVME_SC_ABORT_REQ, the current async event request is
aborted and there is no pending request in the queue of async event request of the target.
Why do you choose not to submit another async event request to the target?
