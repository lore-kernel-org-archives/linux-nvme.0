From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 2 Feb 2016 19:20:01 +0200
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <20160202144648.GA10728@localhost.localdomain>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <56B0A401.30306@dev.mellanox.co.il>
 <20160202142756.GA10690@localhost.localdomain>
 <56B0BE26.6070208@dev.mellanox.co.il>
 <20160202144648.GA10728@localhost.localdomain>
Message-ID: <56B0E541.1000907@dev.mellanox.co.il>


> We free the transfer buffers when a command is cancelled. The controller,
> however, may still own the command and may try to write to them. We
> have to fence the controller off from being able to do that, so we can't
> cancel inflight commands while the PCI device is still bus master enabled.
>
> In a perfect world, we could trust in disabling with NVMe registers,
> but sometimes we can't rely on that.

OK, I wasn't aware that we cannot rely on that.

So it looks like we cannot change the ordering. So this leaves us with
the need to guarantee that no queue_rq is inflight before we unmap.
