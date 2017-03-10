From: yizhan@redhat.com (Yi Zhang)
Date: Fri, 10 Mar 2017 16:12:03 +0800
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <36a4aef6-d745-b0df-d6c5-f28afb1daa89@mellanox.com>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
 <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
 <36a4aef6-d745-b0df-d6c5-f28afb1daa89@mellanox.com>
Message-ID: <af839ae9-7649-d3d4-9394-c0f8972edd21@redhat.com>



On 03/09/2017 07:42 PM, Max Gurtovoy wrote:
>
>
> On 3/9/2017 6:20 AM, Yi Zhang wrote:
>>
>>> I'm using CX5-LX device and have not seen any issues with it.
>>>
>>> Would it be possible to retest with kmemleak?
>>>
>> Here is the device I used.
>>
>> Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
>>
>> The issue always can be reproduced with about 1000 time.
>>
>> Another thing is I found one strange phenomenon from the log:
>>
>> before the OOM occurred, most of the log are  about "adding queue", and
>> after the OOM occurred, most of the log are about "nvmet_rdma: freeing
>> queue".
>>
>> seems the release work: "schedule_work(&queue->release_work);" not
>> executed timely, not sure whether the OOM is caused by this reason.
>>
>> Here is the log before/after OOM
>> http://pastebin.com/Zb6w4nEv
>
>
> we are loading many jobs to the system_wq at the target side.
>
yes, the reset_controller stress test will loading many jobs
> Can you try creating local workqueue (as the rdma host does for 
> example) or using some high priority workqueue ?
>
> let me know if you need some patch to do this.
It's better give me some patch or detailed test steps to do that.

Thanks
Yi
>
> I'll try to put it on my currently full plate.
>
> Max.
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
