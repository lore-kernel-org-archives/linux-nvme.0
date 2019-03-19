From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 19 Mar 2019 10:04:23 +0800
Subject: [PATCH 5/8] nbd: use blk_mq_queue_tag_busy_iter
In-Reply-To: <1552929384.152266.27.camel@acm.org>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-6-git-send-email-jianchao.w.wang@oracle.com>
 <1552929384.152266.27.camel@acm.org>
Message-ID: <6447c549-d531-58a7-57f7-00480ec2d128@oracle.com>

Hi Bart

Thanks for your comment on this.

On 3/19/19 1:16 AM, Bart Van Assche wrote:
> On Fri, 2019-03-15@16:57 +0800, Jianchao Wang wrote:
>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>> ---
>>  drivers/block/nbd.c | 2 +
>>  1 file changed, 1 insertion(), 1 deletion(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 7c9a949..9e7e828 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -747,7 +747,7 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
>>  static void nbd_clear_que(struct nbd_device *nbd)
>>  {
>>         blk_mq_quiesce_queue(nbd->disk->queue);
>> -       blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
>> +       blk_mq_queue_tag_busy_iter(nbd->disk->queue, nbd_clear_req, NULL, true);
>>         blk_mq_unquiesce_queue(nbd->disk->queue);
>>         dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
>>  }
> 
> Hi Jianchao,
> 
> The nbd driver calls nbd_clear_que() after having called sock_shutdown(). So
> what makes you think that it's not safe to call blk_mq_tagset_busy_iter()
> from nbd_clear_que()?
> 

The request_queue is not frozen, so there still could be someone enters and get
request. If no io scheduler attached, the driver tag could be allocated and 
tags->rqs[] would be set. During this, blk_mq_tagset_busy_iter could get some stale
requests in tags->rqs[] which maybe freed due to switching io scheduler to none.

Thanks
Jianchao
