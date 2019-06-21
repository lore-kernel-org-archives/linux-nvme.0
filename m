From: james.smart@broadcom.com (James Smart)
Date: Fri, 21 Jun 2019 10:23:09 -0700
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <5ec67ad6-a61a-b28f-9676-864a5f04bbad@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de> <20190620013650.GB31179@ming.t460p>
 <3dbb8dc0-2491-6226-8715-b0f5b7f6a73a@suse.de>
 <20190621065851.GA22145@ming.t460p>
 <5ec67ad6-a61a-b28f-9676-864a5f04bbad@suse.de>
Message-ID: <3ad2ba8d-980b-e154-a181-b58c5f6d5fdb@broadcom.com>


>> Your check can't help wrt. the deadlock, for example:
>>
>> 1) in scan work context:
>>
>> - blk_mq_freeze_queue() is being started after passing the controller
>>    state check
>>
>> 2) timeout & reset is triggered in another context at the exact same time:
>>
>> - all in-flight IOs won't be freed until disable controller & reset is done.
>>
>> - now flush_work() in reset context can't move on, because
>>    blk_mq_freeze_queue() in scan context can't make progress.
>>
> There might be a difference between RDMA and FC implementations; for FC
> we terminate all outstanding I/Os from the HW side, so each I/O will be
> returned with an aborted status.
> Which for all tests I (and NetApp :-) did was enough to get
> 'blk_mq_freeze_queue()' unstuck and the flush_work to complete.
> We _did_ observed, however, that the state checks are absolutely
> critical to this, otherwise we indeed ended up with a stuck flush_work().

RDMA and TCP does the same thing at what is basically the same point - 
as far as terminating all outstanding io. The difference is how they 
terminate.? RDMA and TCP use nvme_cancel_request() rather than a call 
that induces work on the link. nvme_cancel_request() is near immediate. 
FC will take longer for the i/o's to clear - that's the difference.

-- james
