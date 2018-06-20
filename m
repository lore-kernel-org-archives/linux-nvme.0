From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Jun 2018 12:08:30 +0300
Subject: [PATCH 0/7] few nvme-rdma fixes for 4.18
In-Reply-To: <20180620090529.GA4109@lst.de>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180620084011.GC3284@lst.de>
 <306127fb-c15e-a5c7-70cf-b4e39c328979@grimberg.me>
 <20180620085235.GA3880@lst.de>
 <daab031f-6a62-6436-cf3e-02327184d849@grimberg.me>
 <20180620090529.GA4109@lst.de>
Message-ID: <5ef819b2-1566-b39a-51a7-a3203b830ea9@grimberg.me>


>>>> 4 is needed to prevent a theoretical hang in controller removal, but
>>>> never encountered.
>>>
>>> This one I'm indeed a little concerned about as I remember various
>>> issues in this area in PCIe.  And RDMA is just different enough that
>>> it doesn't look very similar.
>>
>> Actually, 4 follows PCIe one to one:
>> --
>>          /*
>>           * The driver will not be starting up queues again if shutting down
>> so
>>           * must flush all entered requests to their failed completion to
>> avoid
>>           * deadlocking blk-mq hot-cpu notifier.
>>           */
>>          if (shutdown)
>>                  nvme_start_queues(&dev->ctrl);
>> --
>> Nothing about this is PCIe specific, its about the controller going away
>> with quiesced IO.
> 
> With the difference that PCIe does it at the end of nvme_dev_disable,
> long after we've actually disabled or shut down the controller,
> while RDMA does it before shutting down the controller.

Well yes, but the what matters (to my understanding) is that it happens
after:
1. request queue was quiesced
2. queue does not allow requests to come in anymore (!LIVE)
3. inflight requests were cancelled
4. io hw queues were flushed and teared down.

We can do this after we teardown the admin queue as well, but I don't
see a justification to do it.

>> On a side note, If you look at nvme_reset_work and nvme_dev_disable, its
>> not that different from what RDMA does, its just arranged slightly
>> different. I'm still very much think that PCIe and RDMA and FC (and TCP)
>> can have the same probe, reset, remove sequences. I guess it will just
>> take some more time to get there.
> 
> Sharing more code would be great, especially for managing the block
> layer state.

We'll get there...
