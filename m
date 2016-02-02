From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Feb 2016 14:27:57 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <56B0A401.30306@dev.mellanox.co.il>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <56B0A401.30306@dev.mellanox.co.il>
Message-ID: <20160202142756.GA10690@localhost.localdomain>

On Tue, Feb 02, 2016@02:41:37PM +0200, Sagi Grimberg wrote:
> First of all, I think we need to cancel all
> inflight requests before nvme_dev_unmap.

IO cancelling is where it is because it protects against host memory
corruption. If you're going to mess with the ordering, just make sure
the PCI device is disabled from bus mastering first.
