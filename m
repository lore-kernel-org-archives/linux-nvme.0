Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81029C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zo6yyrOztiDlHQocXaG+jq3KbVYP7HzvFv9IO6Bj/vI=; b=ovm816tz9BDkaQhtWpWG5j2/X6
	V4qgsS0pi6dlsKD9zJTF5sASTUNCGpnL6BBUDmJdZWRidkM20v5nTrh6hNl3Frt0ZOE9yxCWLtc0U
	6iiAECg9UMIj6QCH1ZvXz4+msImFHgjX7MzDCYnRlZIgB65m5bS26wT4Lgv2CEXo5YIW1bBn/D5y5
	hFtHh2G/uGDdGw5bN4BAxcicXz55fbNciEopbMFbjliRNQbMK6w+gO8aSDIT2XoUvkxyIe2CXoJN5
	ZkBO0WZ7sioe2JwiJEJbpnJiPp9Khc45XdgEAhAJuCUnmKDei/wLNRnwm3mRFhzaduUyp1TurQ/p2
	kKamGLbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrjBX-001O8i-GY; Mon, 29 Nov 2021 16:07:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrjBU-001O82-VY
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 16:07:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F40C2615AA;
 Mon, 29 Nov 2021 16:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC44C56749;
 Mon, 29 Nov 2021 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638202034;
 bh=Lr2g2GvA4BF3kCJvaRNKTU/t5xOxfN6NnJ8oCYgRaII=;
 h=From:To:Cc:Subject:Date:From;
 b=rCb7ZMxU2GEWWpZmQfSDmr8A+et/1gdrEtY5KJscZK+bU/E8JZ1T4p/zb1PYoqnVD
 8DCzj1WQDXzNnxc4zB5grD9AgRCBSKRzZ69wMuTPjQEIHaQJ59i3QEQDpdNBchdhl0
 ZY2bAM3S+pygqh6qfyhjC8OGuMdTpWWqt4+XIK9mt+OGO3b4IeWAEbmtppFh7YHzrX
 iCTzJPupF3dk6v5WXgc0IleL0E3sUbt3QoHklf+fH+ibwIcv2v+D77rklfcUTQoDtx
 0hAsBsm1NQPfh30YPB1f3Fi4/7+ApWJygjwjh6PIqiT3KZZwMxopzijB5y6b1TQ82H
 zK+C2Xj7O/Fag==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCHv2] nvme: disable namespaces with unsupported metadata
Date: Mon, 29 Nov 2021 08:07:12 -0800
Message-Id: <20211129160712.3596738-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_080717_099082_CE8F5AF3 
X-CRM114-Status: GOOD (  13.63  )
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

The only fabrics target that supports metadata is RDMA and usable only
if it is 8B per block, and formatted for protection information. If an
rdma target were to export a namespace with a different format (ex:
4k+64B), the driver will not be able to submit valid read/write commands
for that namespace.

Suppress setting the metadata feature in the namespace so that the
gendisk capacity will be set to 0. This will prevent read/write access.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: changelog and comment updates

 drivers/nvme/host/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b5de8f5435a..47a941207058 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1740,7 +1740,18 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return -EINVAL;
-		if (ctrl->max_integrity_segments)
+
+		/*
+		 * The current fabrics transport drivers support namespace
+		 * metadata formats only if nvme_ns_has_pi() returns true.
+		 * Suppress setting the feature for all other formats so the
+		 * namespace will have a 0 capacity and not be usable through
+		 * the block stack.
+		 *
+		 * Note, this check will need to be modified if any drivers
+		 * gain the ability to use other metadata formats.
+		 */
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
 			ns->features |=
 				(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	} else {
-- 
2.25.4


