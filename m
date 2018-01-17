From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 17 Jan 2018 22:07:53 +0900
Subject: [PATCH V2] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <20180115020016.GB13580@localhost.localdomain>
References: <1515963650-3805-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180115020016.GB13580@localhost.localdomain>
Message-ID: <CAA7jztcuhiiv3a4C62Z4FfY8MB=c==jFod6YJu1bV5jcL0feeQ@mail.gmail.com>

On Mon, Jan 15, 2018@11:00 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Jan 15, 2018@06:00:50AM +0900, Minwoo Im wrote:
>>  static const struct blk_mq_ops nvme_mq_admin_ops = {
>>       .queue_rq       = nvme_queue_rq,
>>       .complete       = nvme_pci_complete_rq,
>> @@ -1637,8 +1636,10 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>>       max = min(dev->max_qid, dev->ctrl.queue_count - 1);
>>       for (i = dev->online_queues; i <= max; i++) {
>>               ret = nvme_create_queue(dev->queues[i], i);
>> -             if (ret)
>> +             if (ret) {
>> +                     nvme_free_queues(dev, dev->online_queues);
>>                       break;
>> +             }
>>       }
>
> Unless this is the very first pass at initialisation, I don't think we
> can free queues until after blk_mq_update_nr_hw_queues since the hctx
> could otherwise point to freed memory.

Keith,

I agree that if not all create io and sq commands are failed,
blk_mq_update_nr_hw_queues()
will update nr_hw_queues and hw ctxs to be freed.

If it's not in the very first initialization step, however, and *all*
create io sq and cq commands
are failed in nvme_reset_work() because of controller reset (e.g. #
nvme reset /dev/nvme0),
blk_mq_update_nr_hw_queues() seems it cannot update nr_hw_queues
because this function
will not update it when it's zero.

Would it be better if request blk-mq to free all hw ctxs instead of trying
blk_mq_update_nr_hw_queues() ?

Thanks,
