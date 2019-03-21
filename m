From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Mar 2019 19:04:09 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190321013908.GA15115@ming.t460p>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
 <20190318073826.GA29746@ming.t460p> <1552921495.152266.8.camel@acm.org>
 <20190318151618.GA20371@ming.t460p> <1552924164.152266.21.camel@acm.org>
 <448615db-64e2-cbe7-c09e-19b2d86a720a@grimberg.me>
 <20190321013908.GA15115@ming.t460p>
Message-ID: <95da080a-7fb4-33a9-1dc3-4452c565c83a@grimberg.me>


>> Hi Bart,
>>
>> If I understand the race correctly, its not between the requests
>> completion and the queue pairs removal nor the timeout handler
>> necessarily, but rather it is between the async requests completion and
>> the tagset deallocation.
>>
>> Think of surprise removal (or disconnect) during I/O, drivers
>> usually stop/quiesce/freeze the queues, terminate/abort inflight
>> I/Os and then teardown the hw queues and the tagset.
>>
>> IIRC, the same race holds for srp if this happens during I/O:
>> 1. srp_rport_delete() -> srp_remove_target() -> srp_stop_rport_timers() ->
>> __rport_fail_io_fast()
>>
>> 2. complete all I/Os (async remotely via smp)
>>
>> Then continue..
>>
>> 3. scsi_host_put() -> scsi_host_dev_release() -> scsi_mq_destroy_tags()
>>
>> What is preventing (3) from happening before (2) if its async? I would
>> think that scsi drivers need the exact same thing...
> 
> blk_cleanup_queue() will do that, but it can't be used in device recovery
> obviously.

But in device recovery we never free the tagset... I might be missing
the race here then...

> BTW, blk_mq_complete_request_sync() is a bit misleading, maybe
> blk_mq_complete_request_locally() is better.

Not really...
