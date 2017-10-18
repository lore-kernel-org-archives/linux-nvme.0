From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:16:24 +0300
Subject: [PATCH 5/9] nvme: track subsystems
In-Reply-To: <20171018101230.GA14859@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-6-hch@lst.de>
 <1535c6f9-8ddf-ab30-2bbd-5d9ce626b913@grimberg.me>
 <20171018101230.GA14859@lst.de>
Message-ID: <47322793-9d9c-abc6-e739-ecda91353ea3@grimberg.me>


>>>    static void nvme_free_ctrl(struct kref *kref)
>>>    {
>>>    	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
>>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>>      	put_device(ctrl->device);
>>>    	nvme_release_instance(ctrl);
>>>    	ida_destroy(&ctrl->ns_ida);
>>>    +	if (subsys) {
>>> +		mutex_lock(&subsys->lock);
>>> +		list_del(&ctrl->subsys_entry);
>>> +		mutex_unlock(&subsys->lock);
>>> +	}
>>> +
>>
>> When can this happen? can a controller not have a subsys?
> 
> When we fail early enough to not have set up the subsystem yet.

I think that the fact the nvme_free_ctrl cleans up after everything
that is setup in a random place is not a very good approach (just sent
a patchset that moves the uninit_ctrl cleanup back to its natural
place).

However here, given that each individual driver calls nvme_init_identify
on its own as part of its private admin configuration I don't see how
we can avoid it for now...

Hopefully we can sort this out when we centralize some more
setup/teardown logic and this subsys detach would move to where
we teardown the admin_queue (as it was added when we configured it)...
