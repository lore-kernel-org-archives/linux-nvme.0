From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 12:41:21 +0300
Subject: [PATCH 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
In-Reply-To: <20171019084926.GA14227@lst.de>
References: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
 <20171019084926.GA14227@lst.de>
Message-ID: <9604c4ac-0a0f-a029-1894-051e6de50072@grimberg.me>


>>   	if (new) {
>>   		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
>> -		if (IS_ERR(ctrl->ctrl.admin_tagset))
>> +		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
>> +			error = PTR_ERR(ctrl->ctrl.admin_tagset);
>>   			goto out_free_queue;
>> +		}
> 
> Can we return an error code instead and just pass in the tag set
> to be allocated instead of the admin flag?A  E.g.:
> 
> 	error = nvme_rdma_alloc_tagset(&ctrl->ctrl, &ctrl->ctrl.admin_tagset);
> 	if (error)
> 		goto out_free_queue;

We could, but that would mean that the nvme_ctrl tagset pointer will
need to be updated later (or from the routine itself).

I'm intending this code for nvme-core (and this would be ->alloc_tagset
callout) so ultimately I'd like to move the tagset embedding in struct
nvme_ctrl but given that its a hot-path reference, I suggest we hold it
back until we make struct nvme_ctrl arranged better for the hot path
dereferencing.
