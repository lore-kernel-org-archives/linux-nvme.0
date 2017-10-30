From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 30 Oct 2017 18:14:30 +0800
Subject: [PATCHv2 5/5] nvme: Send uevent for unhandled AEN completions
In-Reply-To: <20171020223746.31287-1-keith.busch@intel.com>
References: <20171020223746.31287-1-keith.busch@intel.com>
Message-ID: <b05dcfac-0d50-4b90-544e-646bbfce57bb@huawei.com>


On 2017/10/21 6:37, Keith Busch wrote:
>  static void nvme_async_event_work(struct work_struct *work)
>  {
>  	struct nvme_ctrl *ctrl =
>  		container_of(work, struct nvme_ctrl, async_event_work);
>  
> +	nvme_aen_uevent(ctrl);
>  	ctrl->ops->submit_async_event(ctrl);
>  }

Is this based on 4.15 or 4.14? I failed to apply it.
