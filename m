From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 20 Jun 2016 14:03:37 -0300
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification
 by default
In-Reply-To: <57679355.6000303@gmail.com>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <57679355.6000303@gmail.com>
Message-ID: <576821E9.2060009@linux.vnet.ibm.com>

On 06/20/2016 03:55 AM, Sagi Grimberg wrote:
>
>> Asynchronous events notification currently is disabled by default;
>> to enable it, one should issue a set-feature command through
>> nvme-cli userspace application. The tool also allows disabling
>> these events once they're enable, as per user desire.
>>
>> This patch makes the asynchronous events notification enabled by
>> default; to do so, we submit the set-feature command from the
>> driver, in the end of nvme_reset_work() routine. This way, the
>> feature is enabled on the driver initialization and after resets,
>> in case they happen.
>
> AEN was already enabled by default in:
>
> commit f866fc4282a81673ef973ad54c68235a3263b42e
> Author: Christoph Hellwig <hch at lst.de>
> Date:   Tue Apr 26 13:52:00 2016 +0200
>
>      nvme: move AER handling to common code
>
>      The transport driver still needs to do the actual submission, but
> all the
>      higher level code can be shared.
>
>      Signed-off-by: Christoph Hellwig <hch at lst.de>
>      Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>      Signed-off-by: Jens Axboe <axboe at fb.com>
>
> (Assuming you have at least a single queue).

Sagi, I might be wrong in my understanding (sorry in advance if this is 
the case hehe) but I guess the above commit only re-factored the async 
events handling on driver - the functions reworked by the patch aim to 
handle the events once they are 'captured', which is feasible only if 
they are enabled by setting the feature (with nvme-cli, for example).

The goal of my patch is to do the 'job' of nvme-cli automatically from 
within the driver.

One thing I was thinking is to add a sysfs parameter to be able to avoid 
the automatic enablement of async events in case we have a bogus adapter 
showing too many events, for example...not sure if this is necessary 
though, so I didn't add the parameter on this submission.

Thanks,


Guilherme

>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
