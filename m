From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Dec 2017 08:51:48 +0200
Subject: [PATCH] nvmet: Limit num of queues to num of cpus on traget
In-Reply-To: <ace98df1-d4a8-e25a-ffc8-de3705f2bdf7@mellanox.com>
References: <20171206113624.989-1-nitzanc@mellanox.com>
 <a0c4d4d4-5b63-4a88-20d8-6b774802e6fb@grimberg.me>
 <ace98df1-d4a8-e25a-ffc8-de3705f2bdf7@mellanox.com>
Message-ID: <213ce229-705c-1d20-03b6-7c1a2ffb23e2@grimberg.me>


>>> Sagi/Christoph,
>>> In case the NVMEoF host asks num_io_queues << num_target_cpus there is
>>> a waste of memory allocated in the target side for the sq's/cq's that
>>> we never use. We might want to check the number of needed queues in
>>> "set_features" cmd and allocate the minimum(wanted, target_capable).
>>> This will block the option of creating more queues in a later stage
>>> of the host lifecycle, but saves resources.
>>>
>>> thoughts ?
>>
>> This is not the way to go at all. If you really care about saving a few
>> Kbytes of nvmet sq/cq and see that its a real problem, you need to
>> allocate them on demand instead of posing this limit to the host.
>>
> 
> Linux host side sets "count = min(*count, nr_io_queues)" in 
> nvme_set_queue_count so there is no chance it will ask more queues in 
> the future. We don't really care of this scenario (wanted_queues < 
> target_capable_queues) but we do care about the case that this patch 
> comes to fix.

Well, I do not necessarily agree with the statement that more queues
than cpu cores is not needed in the target simply because its the host
that wants to set the number of queues.

If I understand you correctly, what needs to be fixed is the host
settling for less queues than what it got in set_features (like
how we handle it in pci).
