From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 13:40:03 +0200
Subject: [PATCH 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <cb2271d1-5af1-7b23-fac0-9d0139454cee@mellanox.com>
References: <1510146032-25434-1-git-send-email-maxg@mellanox.com>
 <2d6e460f-2310-bb06-3d1c-f2ecdc4b2dc7@grimberg.me>
 <cb2271d1-5af1-7b23-fac0-9d0139454cee@mellanox.com>
Message-ID: <5b0bc10a-1b0f-95d5-7563-d4c92fc547c4@grimberg.me>


>> Are you rebased? this message have changed I think.
> 
> I'm working on the main master. Should I work on top of nvme-4.15 ? from 
> what I saw few days ago, it's wasn't rebased on top of 4.14-rc8

Yes, or at least make sure your patches apply on nvme-4.XX latest branch
where we collect patches to.

>>> -??????? goto out_destroy_cm_id;
>>> +??????? goto out_destroy_queue_ib;
>>> ????? }
>>> ????? clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
>>> ????? return 0;
>>> +out_destroy_queue_ib:
>>> +??? if (ret == -ETIMEDOUT)
>>> +??????? nvme_rdma_destroy_queue_ib(queue);
>>
>> This does not look safe to me. What protects that nvme_rdma_cm_handler
>> will not destroy the ib queue as well? I think we need to destroy the
>> cm_id first (guarantee that we will never handle other cma events)
>> and only then destroy the ib queue if needed.
> 
> You mean we need to destroy cm_id always before destroying ib queue ?

Yes, this is the only way to guarantee that the cm handler won't race
with this call site.
