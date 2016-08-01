From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Aug 2016 14:21:17 +0300
Subject: [PATCH 4/5] nvme-rdma: Remove duplicate call to
 nvme_remove_namespaces
In-Reply-To: <20160801110604.GE16141@lst.de>
References: <1469822242-3477-1-git-send-email-sagi@grimberg.me>
 <1469822242-3477-5-git-send-email-sagi@grimberg.me>
 <20160801110604.GE16141@lst.de>
Message-ID: <f196255e-b179-e3e3-8439-baebd1c62211@grimberg.me>


>> -	nvme_remove_namespaces(&ctrl->ctrl);
>> -	nvme_rdma_shutdown_ctrl(ctrl);
>>  	nvme_uninit_ctrl(&ctrl->ctrl);
>> +	nvme_rdma_shutdown_ctrl(ctrl);
>
> How safe is the reordering here?  The description should explain why
> it's fine.

The reordering is safe because we do want everything in uninit_ctrl
(flush aen,scan and ns-remove) to happen before we shutdown the rdma
stuff. I'll add to the change log.

Thanks!
