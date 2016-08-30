From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Aug 2016 18:56:13 +0300
Subject: [PATCH WIP/RFC v2 6/6] nvme-rdma: use ib_client API to detect
 device removal
In-Reply-To: <00e601d202d6$00fc0920$02f41b60$@opengridcomputing.com>
References: <cover.1472506505.git.swise@opengridcomputing.com>
 <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
 <b0f1740f-bcf7-d508-7a64-223202d6c063@grimberg.me>
 <00e601d202d6$00fc0920$02f41b60$@opengridcomputing.com>
Message-ID: <d0bf0b9b-8f81-4d6b-4534-1fccb146e328@grimberg.me>


>> Will this code work?
>>
>> 	mutex_lock(&nvme_rdma_ctrl_mutex);
>> 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
>> 		if (ctrl->device->dev != ib_device)
>> 			continue;
>>
>> 		__nvme_rdma_del_ctrl(ctrl);
>> 	}
>> 	mutex_unlock(&nvme_rdma_ctrl_mutex);
>>
>> 	flush_workqueue(nvme_rdma_wq);
>
> I'll try this.  It is cleaner/easier to understand.
>
> I'm also moving the controller list to per-device as Christoph recommends.

I'm still not sure if it's a real must. This will only save us the
condition (as we'll get the device in the client data)
