From: harryxiyou@gmail.com (harryxiyou)
Date: Thu, 11 Sep 2014 04:26:53 +0800
Subject: Which core does a NVMe IO request would go?
In-Reply-To: <CAD+1EGN4+bGS8nw90Wf3YK_EiNJFOacbyppzSU3McPWio_5uLw@mail.gmail.com>
References: <CAD+1EGP=RLHGJYfK6PUUjA7X_W9GMRq2QS3OP9J87vjEyJpBLg@mail.gmail.com>
 <CAD+1EGO2fqNSLdtwDEsxASznuWTc7GNrmzRGGvarR87qYE2VVw@mail.gmail.com>
 <CAD+1EGN4+bGS8nw90Wf3YK_EiNJFOacbyppzSU3McPWio_5uLw@mail.gmail.com>
Message-ID: <CAD+1EGO3umHGHoN_3k1usvtKaeuU4CyoyJ_Thj0aMviR2nZvyQ@mail.gmail.com>

On Thu, Sep 11, 2014@4:10 AM, harryxiyou <harryxiyou@gmail.com> wrote:
> On Thu, Sep 11, 2014@3:46 AM, harryxiyou <harryxiyou@gmail.com> wrote:
>> On Thu, Sep 11, 2014@3:43 AM, harryxiyou <harryxiyou@gmail.com> wrote:
>>> Dear all,
>>>
>>> I am not sure "Which core does a NVMe IO request would go?" after
>>> I read the NVMe driver source codes.
>>>
>>> The code says that,
>>>
>>>
>>>  648 static int nvme_make_request(struct request_queue *q, struct request *req)
>>>  649 {
>>>  650     struct nvme_ns *ns = q->queuedata;
>>>  651     struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
>>> ...
>>>  659
>>>  660     return result;
>>>  661 }
>>>
>>>
>>>  289 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
>>>  290 {
>>>  291     return dev->queues[get_cpu() + 1];
>>>  292 }
>>>
>>>
>>> dev->queues[get_cpu() + 1] tells us which core it goes but I don't know
>>> what get_cpu() returns.
>>>
>>>
>>> Could you please give me some suggestions?
>>
>> Maybe, I find the answers like this.
>>
>> get_cpu() disables kernel preemption prior to returning the current
>> processor number
>>
>
> BTW, I cannot find the NVMe controller handle function
>
> 675 static int nvme_process_cq(struct nvme_queue *nvmeq)
>  676 {
>  677     u16 head, phase;
>  678
>  679     head = nvmeq->cq_head;
>  680     phase = nvmeq->cq_phase;
>  681
>  682     for (;;) {
>  683         void *ctx;
>  684         nvme_completion_fn fn;
> ...
>  693
>  694         ctx = free_cmdid(nvmeq, cqe.command_id, &fn);
>  695         fn(nvmeq, ctx, &cqe);
>  696     }
> }
>
> I cannot find the fn function, could anyone give me some suggestions?

At last, I find it which is a handler to self-define.


Thanks, Harry
