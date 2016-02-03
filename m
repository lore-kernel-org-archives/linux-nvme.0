From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Wed, 3 Feb 2016 00:49:14 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <56B0E541.1000907@dev.mellanox.co.il>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <56B0A401.30306@dev.mellanox.co.il>
 <20160202142756.GA10690@localhost.localdomain>
 <56B0BE26.6070208@dev.mellanox.co.il>
 <20160202144648.GA10728@localhost.localdomain>
 <56B0E541.1000907@dev.mellanox.co.il>
Message-ID: <BJXPR01MB199FB54890F656169E92617E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

nvme interrupt handler touches cq door bell, so actually before unmap it must be taken care of too. Currently it checks cq_vector >= 0 to avoid touching unmapped door bell. 

I think it is better to let queue_rq and interrupt handler use the same mechanism to detect unmap, by driver itself (e.g. cq_vector) or by block layer (e.g. a new API to guarantee no inflight IO under hw queue).


-----Original Message-----
From: Sagi Grimberg [mailto:sagig@dev.mellanox.co.il] 
Sent: Wednesday, February 3, 2016 1:20 AM
To: Keith Busch
Cc: Wenbo Wang; Jens Axboe; Wenbo Wang; Wenwei.Tao; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended


> We free the transfer buffers when a command is cancelled. The 
> controller, however, may still own the command and may try to write to 
> them. We have to fence the controller off from being able to do that, 
> so we can't cancel inflight commands while the PCI device is still bus master enabled.
>
> In a perfect world, we could trust in disabling with NVMe registers, 
> but sometimes we can't rely on that.

OK, I wasn't aware that we cannot rely on that.

So it looks like we cannot change the ordering. So this leaves us with the need to guarantee that no queue_rq is inflight before we unmap.
