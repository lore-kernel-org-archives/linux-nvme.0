From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 7 Dec 2017 12:51:58 +0200
Subject: [PATCH] nvmet: Limit num of queues to num of cpus on traget
In-Reply-To: <213ce229-705c-1d20-03b6-7c1a2ffb23e2@grimberg.me>
References: <20171206113624.989-1-nitzanc@mellanox.com>
 <a0c4d4d4-5b63-4a88-20d8-6b774802e6fb@grimberg.me>
 <ace98df1-d4a8-e25a-ffc8-de3705f2bdf7@mellanox.com>
 <213ce229-705c-1d20-03b6-7c1a2ffb23e2@grimberg.me>
Message-ID: <fe7fd643-26ab-c947-404c-dbe5ac8b7d86@mellanox.com>



On 12/7/2017 8:51 AM, Sagi Grimberg wrote:
> 
>>>> Sagi/Christoph,
>>>> In case the NVMEoF host asks num_io_queues << num_target_cpus there is
>>>> a waste of memory allocated in the target side for the sq's/cq's that
>>>> we never use. We might want to check the number of needed queues in
>>>> "set_features" cmd and allocate the minimum(wanted, target_capable).
>>>> This will block the option of creating more queues in a later stage
>>>> of the host lifecycle, but saves resources.
>>>>
>>>> thoughts ?
>>>
>>> This is not the way to go at all. If you really care about saving a few
>>> Kbytes of nvmet sq/cq and see that its a real problem, you need to
>>> allocate them on demand instead of posing this limit to the host.
>>>
>>
>> Linux host side sets "count = min(*count, nr_io_queues)" in 
>> nvme_set_queue_count so there is no chance it will ask more queues in 
>> the future. We don't really care of this scenario (wanted_queues < 
>> target_capable_queues) but we do care about the case that this patch 
>> comes to fix.
> 
> Well, I do not necessarily agree with the statement that more queues
> than cpu cores is not needed in the target simply because its the host
> that wants to set the number of queues.

Ok, but in the pci case, the host can ask for example 1024 queues but 
the drive support only 32 and will return 32. This is what we trying to 
fix here. We had a "poor" target with 8 CPUs that allocated 128 sq/cq 
and couldn't serve many initiators. When we allocated 8 sq/cq we serve 
more initiators.

> 
> If I understand you correctly, what needs to be fixed is the host
> settling for less queues than what it got in set_features (like
> how we handle it in pci).

The host (in rdma transport for example) actually using the core 
function as the pci does.
The comment the Nitzan added was for the case that the target can 
support more queues than requested (The attached patch doesn't support 
this case). In pci, the device return the number of queues he *can* but 
the actuall value we use is the minimum between the two. Other 
implementations can say: oh, the pci can allocate more than I need so I 
might create more queues later on and the device will support it. The 
thought we had for the fabrics, is to check what the host needs (we know 
it in set_features) and return (in set_features response) the minimum 
between his needs and target capability (and not support a greedy host) 
and then allocate the final amount of queues.
As I said, this is less critical then the case we allocate 128 queues in 
a weak target.

hope it is clearer now :)
