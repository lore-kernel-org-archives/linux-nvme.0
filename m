Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EB5C83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=en8ll/ZDPjMesLuEYVvWQ9nCxPjzsAl9cM2Wuu2jcfM=; b=O6eM/qBV5W0PUesqlScnNVv/X0
	piX1pICavwtdNCxPAo/HG7rRlL2bwEeuif1DHCDeE+xaIPZ/RKuzoR6cbhSjyqn4MLrhYAkEYgVbO
	v89Ds+Ckp34pkZwEXsZzGfcS6odHnlohaG8nkvBCUYlV+RrBVMr/nvwGWrUvA5z0nRt9kjeAG3ocH
	WUm+poz+VZzJofOQ/KzfTmm/+wP1IeKatC4M07/R8YWohsRZLlkE8htV5dY/IIxkh9X5aIV4dpVsf
	oaH3g1gRVH6+Kv3DYnH27ZTOIZCemVG235FDeOwd5SlSxJkCgW+bbbR4weze4NJ0YOVdw0Kz5d+XV
	r7AxPuUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubLGO-00000002i3z-13Hr;
	Mon, 14 Jul 2025 15:38:44 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKPb-00000002Vs9-273B;
	Mon, 14 Jul 2025 14:44:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	yi.zhang@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: revert the cross-controller atomic write size validation
Date: Mon, 14 Jul 2025 16:44:01 +0200
Message-ID: <20250714144406.1692041-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714144406.1692041-1-hch@lst.de>
References: <20250714144406.1692041-1-hch@lst.de>
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

This was originally added by commit 8695f060a029 ("nvme: all namespaces
in a subsystem must adhere to a common atomic write size") to check
the all controllers in a subsystem report the same atomic write size,
but the check wasn't quite correct and caused problems for devices
with multiple namespaces that report different LBA sizes.  Commit
f46d273449ba ("nvme: fix atomic write size validation") tried to fix
this, but then caused problems for namespace rediscovery after a
format with an LBA size change that changes the AWUPF value.

This drop the validation and essentially revers those two commits while
keeping the cleanup that went in between the two.  We'll need to figure
out how to properly check for the mouse trap that nvme left us, but for
now revert the check to keep devices working for users who couldn't care
less about the atomic write feature.

Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
Fixes: f46d273449ba ("nvme: fix atomic write size validation")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1d2240494f3d..fdd2334dacca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3537,15 +3537,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		if (ret)
 			goto out_free;
 	}
-
-	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
-		dev_err_ratelimited(ctrl->device,
-			"inconsistent AWUPF, controller not added (%u/%u).\n",
-			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
-		ret = -EINVAL;
-		goto out_free;
-	}
-
 	memcpy(ctrl->subsys->firmware_rev, id->fr,
 	       sizeof(ctrl->subsys->firmware_rev));
 
-- 
2.47.2


