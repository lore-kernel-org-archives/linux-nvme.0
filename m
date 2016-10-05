From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 19:57:11 +0300
Subject: [PATCH rfc 3/6] nvme-pci: Use irq-poll for completion processing
In-Reply-To: <20161005134013.jkgc6jfbya7x7ou3@linux-x5ow.site>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-4-git-send-email-sagi@grimberg.me>
 <20161005134013.jkgc6jfbya7x7ou3@linux-x5ow.site>
Message-ID: <6ec3fc69-7f1f-250c-2f9e-f1639694b9dc@grimberg.me>


>> @@ -49,6 +50,7 @@
>>  #define NVME_AQ_DEPTH		256
>>  #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
>>  #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
>> +#define NVME_POLL_BUDGET_IRQ	256
>
> Is there a reason for the 256 or is it just a nicely suited value?

Umm, No good reason behind it, I used this value before for irq-poll
and it seemed to fit best. We can try other budgets or have it
configurable. The point is to not abuse the soft-irq context for too
long and maintain fairness between completion queues so we just need
a reasonable value.


> Especially
> as you've been using INT_MAX as a budget for CQ processing before (which I
> think is kinda high).

That was just for keeping the existing logic before we change to
irq-poll.
