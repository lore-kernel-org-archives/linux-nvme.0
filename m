From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 12 Mar 2017 20:16:58 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <20170310165214.GC14379@mtr-leonro.local>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
 <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
 <20170310165214.GC14379@mtr-leonro.local>
Message-ID: <56e8ccd3-8116-89a1-2f65-eb61a91c5f84@mellanox.com>



On 3/10/2017 6:52 PM, Leon Romanovsky wrote:
> On Thu, Mar 09, 2017@12:20:14PM +0800, Yi Zhang wrote:
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
>> seems the release work: "schedule_work(&queue->release_work);" not executed
>> timely, not sure whether the OOM is caused by this reason.
>
> Sagi,
> The release function is placed in global workqueue. I'm not familiar
> with NVMe design and I don't know all the details, but maybe the proper way will
> be to create special workqueue with MEM_RECLAIM flag to ensure the progress?
>

Hi,

I was able to repro it in my lab with ConnectX3. added a dedicated 
workqueue with high priority but the bug still happens.
if I add a "sleep 1" after echo 1 
 >/sys/block/nvme0n1/device/reset_controller the test pass. So there is 
no leak IMO, but the allocation process is much faster than the 
destruction of the resources.
In the initiator we don't wait for RDMA_CM_EVENT_DISCONNECTED event 
after we call rdma_disconnect, and we try to connect immediatly again.
maybe we need to slow down the storm of connect requests from the 
initiator somehow to let the target time to settle up.

Max.


>>
>> Here is the log before/after OOM
>> http://pastebin.com/Zb6w4nEv
>>
>>> _______________________________________________
>>> Linux-nvme mailing list
>>> Linux-nvme at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
