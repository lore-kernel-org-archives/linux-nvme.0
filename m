From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 9 Apr 2018 00:02:30 +0300
Subject: [PATCH 1/2 V2] nvme-rdma: Fix race between queue timeout and
 error recovery
In-Reply-To: <586fda65-2038-f157-c278-f189b7524fdf@mellanox.com>
References: <1523196519-23268-1-git-send-email-israelr@mellanox.com>
 <1523196519-23268-2-git-send-email-israelr@mellanox.com>
 <bf223d7b-42fb-1a85-fd22-9f93e68015ff@grimberg.me>
 <586fda65-2038-f157-c278-f189b7524fdf@mellanox.com>
Message-ID: <bdab697b-70dc-7c10-b7e2-5919f665924d@grimberg.me>



On 04/08/2018 07:16 PM, Israel Rukshin wrote:
> On 4/8/2018 6:26 PM, Sagi Grimberg wrote:
>>
>>> When returning BLK_EH_HANDLED from nvme_rdma_timeout() the block layer
>>> complete the request.
>>> Error recovery may also complete the request when aborting the requests.
>>>
>>
>> This is still not a sufficient change log.
>>
>> You need to describe why is this being done vs. invalidating the rkey
>> in the timeout handler. And what does "may also" mean?
>>
>> Second, isn't the double completion protected by the request gstate?
> 
> It is protected if you use only blk_mq_complete_request() and not 
> __blk_mq_complete_request().
> You can see that blk_mq_rq_timed_out()? calls directly to 
> __blk_mq_complete_request() if the timeout
> function returns BLK_EH_HANDLED.

But we first update aborted_gstate (with interrupts disabled), sync srcu
and only them terminate expired requests. So I still don't understand
how we can end up completing a request twice.
