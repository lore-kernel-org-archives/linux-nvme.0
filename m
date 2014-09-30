From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Tue, 30 Sep 2014 20:10:21 +0200
Subject: [PATCH v13] NVMe: Convert to blk-mq
In-Reply-To: <alpine.LRH.2.03.1409301134580.4688@AMR>
References: <1412098195-30133-1-git-send-email-m@bjorling.me>
 <1412098195-30133-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1409301134580.4688@AMR>
Message-ID: <CAOu_J6kb8pQRzhUWD=JOhi1_=mxORUiL-isSaCfrxQ-yxOUepw@mail.gmail.com>

On Tue, Sep 30, 2014@7:42 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 30 Sep 2014, Matias Bj?rling wrote:
>>
>> @@ -1967,27 +1801,30 @@ static struct nvme_ns *nvme_alloc_ns(struct
>> nvme_dev *dev, unsigned nsid,
>> {
>
> ...
>>
>> -       ns->queue->queue_flags = QUEUE_FLAG_DEFAULT;
>> +       queue_flag_set_unlocked(QUEUE_FLAG_DEFAULT, ns->queue);
>
>
> Instead of the above, you want
>
> +       ns->queue->queue_flags |= QUEUE_FLAG_DEFAULT;
>
> I only caught it because of the fun dm-mpath attempt with nvme and
> blk-mq. Or maybe we don't want to include "QUEUE_FLAG_STACKABLE" right
> now (part of the default flags) because it will kernel crash if you're
> using dm-multipath with a blk-mq driver today.
>

Great find. We should properly add a bunch of patches that add the
necessary support after the patch has gone in. I have a feeling that
there is a lot of interesting corner cases for getting stackable to
work.

> Otherwise, looks great!
