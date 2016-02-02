From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 14:46:48 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <56B0BE26.6070208@dev.mellanox.co.il>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <56B0A401.30306@dev.mellanox.co.il>
 <20160202142756.GA10690@localhost.localdomain>
 <56B0BE26.6070208@dev.mellanox.co.il>
Message-ID: <20160202144648.GA10728@localhost.localdomain>

On Tue, Feb 02, 2016@04:33:10PM +0200, Sagi Grimberg wrote:
> Hey Keith,
> 
> >>First of all, I think we need to cancel all
> >>inflight requests before nvme_dev_unmap.
> >
> >IO cancelling is where it is because it protects against host memory
> >corruption. If you're going to mess with the ordering, just make sure
> >the PCI device is disabled from bus mastering first.
> 
> Little help? :)
> 
> What corruption is the ordering protecting against?

Sure thing. :)

We free the transfer buffers when a command is cancelled. The controller,
however, may still own the command and may try to write to them. We
have to fence the controller off from being able to do that, so we can't
cancel inflight commands while the PCI device is still bus master enabled.

In a perfect world, we could trust in disabling with NVMe registers,
but sometimes we can't rely on that.

This was commit 07836e659c81ec6b0d683dfbf7958339a22a7b69, which might
explain the scenario a little better, and was reported by end user.
