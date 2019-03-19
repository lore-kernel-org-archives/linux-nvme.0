From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 19 Mar 2019 09:54:12 +0800
Subject: [PATCH 6/8] skd: use blk_mq_queue_tag_busy_iter
In-Reply-To: <1552929635.152266.30.camel@acm.org>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>
 <1552929635.152266.30.camel@acm.org>
Message-ID: <d21aa530-7466-a21b-69f5-cfc8750c6e1a@oracle.com>

Hi Bart

Thanks so much for you comment for this.

After make blk_mq_queue_tag_busy_iter safer in patch 2, the patches that
replace blk_mq_tagset_busy_iter with blk_mq_queue_tag_busy_iter in drivers
are efforts to unify the tag iterate interface and finally we could remove
the blk_mq_tagset_busy_iter which is not safe.

The blk_mq_queue_tag_busy_iter will try to get a non-zero q_usage_counter
of a request_queue before it try to access the tags, so it could avoid the
race with the procedures that need to freeze and drain the queue, such as
update nr_hw_queues, switch io scheduler and even queue clean up. And also
it iterate the static_rqs and needn't to worry about the stale requests issue.
So it is a safer interface. Although for shared tagset case, the driver
need to loop every request_queue itself with blk_mq_queue_tag_busy_iter,
but all of the work is in error handler path, so it should not be a big deal.


Thanks
Jianchao

On 3/19/19 1:20 AM, Bart Van Assche wrote:
> On Fri, 2019-03-15@16:57 +0800, Jianchao Wang wrote:
>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>> ---
>>  drivers/block/skd_main.c | 4 ?????????(), 2 deletions(-)
>>
>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
>> index ab893a7..60c34ff 100644
>> --- a/drivers/block/skd_main.c
>> diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
>> index ab893a7..60c34ff 100644
>> --- a/drivers/block/skd_main.c
>> +++ b/drivers/block/skd_main.c
>> @@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
>>  {
>>         int count = 0;
>>  
>> -       blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
>> +       blk_mq_queue_tag_busy_iter(skdev->queue, skd_inc_in_flight, &count, true);
>>  
>>         return count;
>>  }
> 
> Hi Jianchao,
> 
> If you have a look at the skd_in_flight() callers you will see that the above
> change is not necessary.
> 
>> @@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
>>  
>>  static void skd_recover_requests(struct skd_device *skdev)
>>  {
>> -	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
>> +	blk_mq_queue_tag_busy_iter(skdev->queue, skd_recover_request, skdev, true);
>>  }
> 
> Same comment here. If you have a look at the callers of this function you will
> see that this change is not necessary.
> 
> Thanks,
> 
> Bart.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwIGgQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=sLURgJ0-Ppht_QzBm__dp4MAaPyGCYjTWVYVglTtnoQ&s=fmR2wU9GQUr-0yrG88JCs1afrjYTd9or1wPKyDKgemg&e=
> 
