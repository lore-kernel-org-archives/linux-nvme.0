From: james.smart@broadcom.com (James Smart)
Date: Mon, 18 Mar 2019 10:30:57 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
Message-ID: <c6a28972-d33f-6d65-2123-19875db0c07f@broadcom.com>


On 3/17/2019 9:09 PM, Bart Van Assche wrote:
> On 3/17/19 8:29 PM, Ming Lei wrote:
>> In NVMe's error handler, follows the typical steps for tearing down
>> hardware:
>>
>> 1) stop blk_mq hw queues
>> 2) stop the real hw queues
>> 3) cancel in-flight requests via
>> ????blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>> cancel_request():
>> ????mark the request as abort
>> ????blk_mq_complete_request(req);
>> 4) destroy real hw queues
>>
>> However, there may be race between #3 and #4, because 
>> blk_mq_complete_request()
>> actually completes the request asynchronously.
>>
>> This patch introduces blk_mq_complete_request_sync() for fixing the
>> above race.
>
> Other block drivers wait until outstanding requests have completed by 
> calling blk_cleanup_queue() before hardware queues are destroyed. Why 
> can't the NVMe driver follow that approach?
>

speaking for the fabrics, not necessarily pci:

The intent of this looping, which happens immediately following an error 
being detected, is to cause the termination of the outstanding requests. 
Otherwise, the only recourse is to wait for the ios to finish, which 
they may never do, or have their upper-level timeout expire to cause 
their termination - thus a very long delay. ? And one of the commands, 
on the admin queue - a different tag set but handled the same, doesn't 
have a timeout (the Async Event Reporting command) so it wouldn't 
necessarily clear without this looping.

-- james
