From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Thu, 21 Aug 2014 14:07:13 +0200
Subject: [PATCH v12] NVMe: Convert to blk-mq
In-Reply-To: <alpine.LRH.2.03.1408181643280.4696@AMR>
References: <1408126604-10611-1-git-send-email-m@bjorling.me>
 <1408126604-10611-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1408181643280.4696@AMR>
Message-ID: <53F5E0F1.20808@bjorling.me>

On 08/19/2014 12:49 AM, Keith Busch wrote:
> On Fri, 15 Aug 2014, Matias Bj?rling wrote:
>>
>> * NVMe queues are merged with the tags structure of blk-mq.
>>
>
> I see the driver's queue suspend logic is removed, but I didn't mean to
> imply it was safe to do so without replacing it with something else. I
> thought maybe we could use the blk_stop/start_queue() functions if I'm
> correctly understanding what they're for.

They're usually only used for the previous request model.

Please correct me if I'm wrong. The flow of suspend is as following 
(roughly):

1. Freeze user threads
2. Perform sys_sync
3. Freeze freezable kernel threads
4. Freeze devices
5. ...

On nvme suspend, we process all outstanding request and cancels any 
outstanding IOs, before going suspending.

 From what I found, is it still possible for IOs to be submitted and 
lost in the process?

>
> With what's in version 12, we could free an irq multiple times that
> doesn't even belong to the nvme queue anymore in certain error conditions.
>
> A couple other things I just noticed:
>
>   * We lose the irq affinity hint after a suspend/resume or device reset
>   because the driver's init_hctx() isn't called in these scenarios.

Ok, you're right.

>
>   * After a reset, we are not guaranteed that we even have the same number
>   of h/w queues. The driver frees ones beyond the device's capabilities,
>   so blk-mq may have references to freed memory. The driver may also
>   allocate more queues if it is capable, but blk-mq won't be able to take
>   advantage of that.

Ok. Out of curiosity, why can the number of exposed nvme queues change 
from the hw perspective on suspend/resume?
