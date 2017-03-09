From: yizhan@redhat.com (Yi Zhang)
Date: Thu, 9 Mar 2017 12:20:14 +0800
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
Message-ID: <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>


> I'm using CX5-LX device and have not seen any issues with it.
>
> Would it be possible to retest with kmemleak?
>
Here is the device I used.

Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]

The issue always can be reproduced with about 1000 time.

Another thing is I found one strange phenomenon from the log:

before the OOM occurred, most of the log are  about "adding queue", and 
after the OOM occurred, most of the log are about "nvmet_rdma: freeing 
queue".

seems the release work: "schedule_work(&queue->release_work);" not 
executed timely, not sure whether the OOM is caused by this reason.

Here is the log before/after OOM
http://pastebin.com/Zb6w4nEv

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
