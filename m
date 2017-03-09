From: yizhan@redhat.com (Yi Zhang)
Date: Thu, 9 Mar 2017 18:33:58 +0800
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <20170309084641.GY14379@mtr-leonro.local>
References: <1908657724.31179983.1488539944957.JavaMail.zimbra@redhat.com>
 <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <20170305081206.GI14379@mtr-leonro.local>
 <20170309084641.GY14379@mtr-leonro.local>
Message-ID: <e4a9ba2d-6ccd-53bc-1c0d-f6ad6c2c8ce3@redhat.com>


>> + Christoph and Sagi.
> +Tariq and Yishai.
>
> How can we know from this log which memory order failed?
>
> It can be one of two: memory leak (most probably) or/and fragmented
> memory.

I have tried to enable memleak and retest, didn't found any kmemleak 
reported from kernel.
Just as I said from previous mail: before the OOM occurred, most of the 
log are  about "adding queue", and after the OOM occurred, most of the 
log are about "nvmet_rdma: freeing queue".
I guess the release work: "schedule_work(&queue->release_work);" not 
executed timely that caused this issue, correct me if I'm wrong.

As the attachment size limit I have to cut to 500KB, pls check the 
attached file for more log.
>>>
>>> Best Regards,
>>>    Yi Zhang
>>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-------------- next part --------------
A non-text attachment was scrubbed...
Name: oom.log
Type: text/x-log
Size: 465811 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170309/1c9704b6/attachment-0001.bin>
