From: sashal@kernel.org (Sasha Levin)
Date: Tue,  4 Jun 2019 19:21:40 -0400
Subject: [PATCH AUTOSEL 5.1 30/60] nvme: remove the ifdef around nvme_nvm_ioctl
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
Message-ID: <20190604232212.6753-30-sashal@kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3f98bcc58cd5f1e4668db289dcab771874cc0920 ]

We already have a proper stub if lightnvm is not enabled, so don't bother
with the ifdef.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e29c395f44d2..decc0b3a3854 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1396,10 +1396,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, (void __user *)arg);
 	default:
-#ifdef CONFIG_NVM
 		if (ns->ndev)
 			return nvme_nvm_ioctl(ns, cmd, arg);
-#endif
 		if (is_sed_ioctl(cmd))
 			return sed_ioctl(ns->ctrl->opal_dev, cmd,
 					 (void __user *) arg);
-- 
2.20.1
