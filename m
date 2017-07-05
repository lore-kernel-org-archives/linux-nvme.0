From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jul 2017 22:18:55 +0300
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
In-Reply-To: <20170705190811.GA7191@lst.de>
References: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
 <ccbe95fe-0711-52a6-4fec-22c2c05bc3ef@grimberg.me>
 <20170705174108.GE5417@lst.de>
 <9a40f029-9bd2-645a-d092-0656f279d94c@grimberg.me>
 <20170705190811.GA7191@lst.de>
Message-ID: <3821eac7-c558-2728-a63e-94d057156f4b@grimberg.me>


>>>> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>>> +{
>>>> +       __nvme_stop_ctrl(ctrl);
>>>>           nvme_remove_namespaces(ctrl);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
>>>
>>> And then this becomes nvme_remove_ctrl?
>>
>> Not a good idea as its not actually removing the controller...
>>
>> Maybe nvme_clear_ctrl?
> 
> Or just call both the new nvme_stop_ctrl and nvme_remove_namespaces
> from each driver.  It's a bit more code, but additional logic..

Yea... I hope we can get it centralize soon so it won't be duplicated.

btw, I think I can unconditionally call nvme_start_queues in
nvme_start_ctrl, the extra unquiesce won't hurt. In fact,
pci does it today. probe calls reset which unconditionally
starts the queues...
