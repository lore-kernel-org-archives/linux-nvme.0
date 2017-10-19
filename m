From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 13:28:42 +0300
Subject: [PATCH 4.14-rc] nvme-rdma: Fix error status return in tagset
 allocation failure
In-Reply-To: <20171019102022.GC17326@lst.de>
References: <1508396289-12237-1-git-send-email-sagi@grimberg.me>
 <20171019084926.GA14227@lst.de>
 <9604c4ac-0a0f-a029-1894-051e6de50072@grimberg.me>
 <20171019102022.GC17326@lst.de>
Message-ID: <9cb7f448-f4a3-e3e6-e906-749a56daa943@grimberg.me>


>>> to be allocated instead of the admin flag?A  E.g.:
>>>
>>> 	error = nvme_rdma_alloc_tagset(&ctrl->ctrl, &ctrl->ctrl.admin_tagset);
>>> 	if (error)
>>> 		goto out_free_queue;
>>
>> We could, but that would mean that the nvme_ctrl tagset pointer will
>> need to be updated later (or from the routine itself).
> 
> That why I want to pass the address of the tagset pointers, so that
> it can be updated.

But I'm targeting this code to nvme-core which at this point, only has
a pointer to the tagsets (which are embedded in the transport ctrl
structs).
