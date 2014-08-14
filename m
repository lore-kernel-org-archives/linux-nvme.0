From: axboe@fb.com (Jens Axboe)
Date: Thu, 14 Aug 2014 09:09:25 -0600
Subject: [PATCH v11] NVMe: Convert to blk-mq
In-Reply-To: <53EC7273.5060303@bjorling.me>
References: <1406365643-27020-1-git-send-email-m@bjorling.me>
 <1406365643-27020-2-git-send-email-m@bjorling.me>
 <CAOu_J6mW-2e2Jgm+khodLPah_-RZrD599SmSH+Mszd0AjterrQ@mail.gmail.com>
 <alpine.LRH.2.03.1408131519590.14603@AMR> <53EC7273.5060303@bjorling.me>
Message-ID: <53ECD125.3080701@fb.com>

On 08/14/2014 02:25 AM, Matias Bj?rling wrote:
> On 08/14/2014 12:27 AM, Keith Busch wrote:
>> On Sun, 10 Aug 2014, Matias Bj?rling wrote:
>>> On Sat, Jul 26, 2014@11:07 AM, Matias Bj?rling <m@bjorling.me> wrote:
>>>> This converts the NVMe driver to a blk-mq request-based driver.
>>>>
>>>
>>> Willy, do you need me to make any changes to the conversion? Can you
>>> pick it up for 3.17?
>>
>> Hi Matias,
>>
> 
> Hi Keith, Thanks for taking the time to take another look.
> 
>> I'm starting to get a little more spare time to look at this again. I
>> think there are still some bugs here, or perhaps something better we
>> can do. I'll just start with one snippet of the code:
>>
>> @@ -765,33 +619,49 @@ static int nvme_submit_bio_queue(struct nvme_queue
>> *nvmeq, struct nvme_ns *ns,
>>   submit_iod:
>>      spin_lock_irq(&nvmeq->q_lock);
>>      if (nvmeq->q_suspended) {
>>          spin_unlock_irq(&nvmeq->q_lock);
>>          goto finish_cmd;
>>      }
>>
>>   <snip>
>>
>>   finish_cmd:
>>      nvme_finish_cmd(nvmeq, req->tag, NULL);
>>      nvme_free_iod(nvmeq->dev, iod);
>>      return result;
>> }
>>
>>
>> If the nvme queue is marked "suspended", this code just goto's the finish
>> without setting "result", so I don't think that's right.
> 
> The result is set to BLK_MQ_RQ_QUEUE_ERROR, or am I mistaken?

Looks OK to me, looking at the code, 'result' is initialized to
BLK_MQ_RQ_QUEUE_BUSY though. Which looks correct, we don't want to error
on a suspended queue.

>> But do we even need the "q_suspended" flag anymore? It was there because
>> we couldn't prevent incoming requests as a bio based driver and we needed
>> some way to mark that the h/w's IO queue was temporarily inactive, but
>> blk-mq has ways to start/stop a queue at a higher level, right? If so,
>> I think that's probably a better way than using this driver specific way.
> 
> Not really, its managed by the block layer. Its on purpose I haven't
> removed it. The patch is already too big, and I want to keep the patch
> free from extra noise that can be removed by later patches.
> 
> Should I remove it anyway?

No point in keeping it, if it's not needed...

>> I haven't event tried debugging this next one: doing an insmod+rmmod
>> caused this warning followed by a panic:
>>
> 
> I'll look into it. Thanks

nr_tags must be uninitialized or screwed up somehow, otherwise I don't
see how that kmalloc() could warn on being too large. Keith, are you
running with slab debugging? Matias, might be worth trying.

FWIW, in general, we've run a bunch of testing internally at FB, all on
backported blk-mq stack and nvme-mq. No issues observed, and performance
is good and overhead low. For other reasons that I can't go into here,
this is the stack on which we'll run nvme hardware. Other features are
much easily implemented on top of a blk-mq based driver as opposed to a
bio based one, similarly to the suspended part above.

-- 
Jens Axboe
