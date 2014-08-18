From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Aug 2014 16:49:45 -0600 (MDT)
Subject: [PATCH v12] NVMe: Convert to blk-mq
In-Reply-To: <1408126604-10611-2-git-send-email-m@bjorling.me>
References: <1408126604-10611-1-git-send-email-m@bjorling.me>
 <1408126604-10611-2-git-send-email-m@bjorling.me>
Message-ID: <alpine.LRH.2.03.1408181643280.4696@AMR>

On Fri, 15 Aug 2014, Matias Bj?rling wrote:
>
> * NVMe queues are merged with the tags structure of blk-mq.
>

I see the driver's queue suspend logic is removed, but I didn't mean to
imply it was safe to do so without replacing it with something else. I
thought maybe we could use the blk_stop/start_queue() functions if I'm
correctly understanding what they're for.

With what's in version 12, we could free an irq multiple times that
doesn't even belong to the nvme queue anymore in certain error conditions.

A couple other things I just noticed:

  * We lose the irq affinity hint after a suspend/resume or device reset
  because the driver's init_hctx() isn't called in these scenarios.

  * After a reset, we are not guaranteed that we even have the same number
  of h/w queues. The driver frees ones beyond the device's capabilities,
  so blk-mq may have references to freed memory. The driver may also
  allocate more queues if it is capable, but blk-mq won't be able to take
  advantage of that.
