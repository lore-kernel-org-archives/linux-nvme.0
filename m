Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4619FEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1YyF6MhYdMbqTvsaaognXuFhGeRHnQ1UfdYoP22pnYw=; b=KJqC6pyfA06CuwoSZwrTFfyK9o
	mKxz6WIbUyXtLwHij2Fp3caDm6W1H4eI3XuTo4FGE9oVc2/myuFFQYoXNxafg5pQDu1yO6ytheaae
	CwDH1raID7kklLDqcOrIse0PGFw+AoPH/Fau4TdPoX4auZPBfz+9egehEPBGqluZwX3HjvDv4I9OW
	GosW13H4Y2DC4H7+AwSVUKBKUbhWCN4KsRjTYjgUG8dBAPatzd7uEm6BVBfXQMIFjmKmpljbVe9F9
	L0ii/zn7qch09Y+qIlU6HKnqLf4tbJ9bhNTQ1aIXk6u/d8myoxFNLLncO/er9AV4cMXICj9ee588j
	GyTLzP7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJwP9-003Q5P-0Y;
	Thu, 13 Jul 2023 13:30:47 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJwP6-003Q4Z-2j;
	Thu, 13 Jul 2023 13:30:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices
Date: Thu, 13 Jul 2023 15:30:42 +0200
Message-Id: <20230713133042.3981-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

While duplicate IDs are still very harmful, including the potential to easily
see changing devices in /dev/disk/by-id, it turn out they are extremely
common for cheap end user NVMe devices.

Relax our check for them for so that it doesn't reject the probe on
single-ported PCIe devices, but prints a big warning instead.  In doubt
we'd still like to see quirk entries to disable the potential for
changing supposed stable device identifier links, but this will at least
allow users how have two (or more) of these devices to use them without
having to manually add a new PCI ID entry with the quirk through sysfs or
by patching the kernel.

Co-developed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47d7ba2827ff29..37b6fa74666204 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3431,10 +3431,40 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
 	if (ret) {
-		dev_err(ctrl->device,
-			"globally duplicate IDs for nsid %d\n", info->nsid);
+		/*
+		 * We've found two different namespaces on two different
+		 * subsystems that report the same ID.  This is pretty nasty
+		 * for anything that actually requires unique device
+		 * identification.  In the kernel we need this for multipathing,
+		 * and in user space the /dev/disk/by-id/ links rely on it.
+		 *
+		 * If the device also claims to be multi-path capable back off
+		 * here now and refuse the probe the second device as this is a
+		 * recipe for data corruption.  If not this is probably a
+		 * cheap consumer device if on the PCIe bus, so let the user
+		 * proceed and use the shiny toy, but warn that with changing
+		 * probing order (which due to our async probing could just be
+		 * device taking longer to startup) the other device could show
+		 * up at any time.
+		 */
 		nvme_print_device_info(ctrl);
-		return ret;
+		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
+		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
+		     info->is_shared)) {
+			dev_err(ctrl->device,
+				"ignoring nsid %d because of duplicate IDs\n",
+				info->nsid);
+			return ret;
+		}
+
+		dev_err(ctrl->device,
+			"clearing duplicate IDs for nsid %d\n", info->nsid);
+		dev_err(ctrl->device,
+			"use of /dev/disk/by-id/ may cause data corruption\n");
+		memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
+		memset(&info->ids.uuid, 0, sizeof(info->ids.uuid));
+		memset(&info->ids.eui64, 0, sizeof(info->ids.eui64));
+		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
-- 
2.39.2


