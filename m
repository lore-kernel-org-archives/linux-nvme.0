From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 9 Mar 2017 13:42:41 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
 <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
Message-ID: <36a4aef6-d745-b0df-d6c5-f28afb1daa89@mellanox.com>



On 3/9/2017 6:20 AM, Yi Zhang wrote:
>
>> I'm using CX5-LX device and have not seen any issues with it.
>>
>> Would it be possible to retest with kmemleak?
>>
> Here is the device I used.
>
> Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
>
> The issue always can be reproduced with about 1000 time.
>
> Another thing is I found one strange phenomenon from the log:
>
> before the OOM occurred, most of the log are  about "adding queue", and
> after the OOM occurred, most of the log are about "nvmet_rdma: freeing
> queue".
>
> seems the release work: "schedule_work(&queue->release_work);" not
> executed timely, not sure whether the OOM is caused by this reason.
>
> Here is the log before/after OOM
> http://pastebin.com/Zb6w4nEv


we are loading many jobs to the system_wq at the target side.

Can you try creating local workqueue (as the rdma host does for example) 
or using some high priority workqueue ?

let me know if you need some patch to do this.

I'll try to put it on my currently full plate.

Max.
