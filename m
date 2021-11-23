Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A73C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 17:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=57ixsZWBLTeZ/2AOamvsGM3ZSHZjSmUh7klSv7MB39M=; b=QScXBDXi5F5YhqrqUjswG5Aq38
	SofkUsT1v5YlpVhz0LyVknFlxOKVhdxidLVp0vJbCmYOPZA9kd88NrLXh0cBkVxBVOQFa9+1r8yVN
	iARIPtbnkjqGxkWR/YEaO85YOW1cCZO5tIB1pxZymrXfJLl7Yda3qRkwSETPQsh+hOJAMyWQSfWII
	dR+uDbncIekmpenwnbijmUt1ZARiMVot1FIiC4Lq8eZZOW3nN/4PVlZyEpoLcSmx4DWwpOWdb3ah8
	KkgIxB367HNXRhJmmXuXDteZw0MAjMVnE9h/daGNOIFJGbEoaWzwDx89g/NK9PSu53e6OXdFI1hyB
	h30YfgLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpZrp-0035LH-D4; Tue, 23 Nov 2021 17:46:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpZrm-0035KN-7W
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 17:46:03 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0937760F41;
 Tue, 23 Nov 2021 17:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637689561;
 bh=sGXqzSTAWi+KfJ/Wzm2ABEUV8ZnLYm8WJ84aEXyfSCk=;
 h=From:To:Cc:Subject:Date:From;
 b=r01TwYCP1Htj0SanMWA2T/7aPNCxS5ni1Y/uaBDCW9brdPUZ90WTayxIodgwPgghJ
 47EDDFYuSFcSsmUVk9jbU6+VWd6A0qX/rYFeQy0VESMoFeZwe2wVEOaCxhAOuowFDw
 B13JnDqOeX0Q3M5xUoSUg1SOmFK7dyX6J18YCoShB6KUdkMRJaw3UO2+Ol3CV0obRp
 pM9yYln66R9EjNMJLbE4yjyFH85hnZ4zRIeHRx2JaSot52+NUGxb9xelWVDJoks49v
 vbmtdAtI2MMf2Zvk2xueM3qBWVoTdDZj7K2X8l34cCubTp/0kJ9iWeZDkj2M+XVTO3
 7oTKo2EfKrmKQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: disable namespaces with unsupported metadata
Date: Tue, 23 Nov 2021 09:45:54 -0800
Message-Id: <20211123174554.3574990-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_094602_331735_DCD76C10 
X-CRM114-Status: GOOD (  11.82  )
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
4k+64B), the driver will not be able to submit a valid command for that
format.

Suppress exporting these namespaces as read/writeable to the block
stack.

Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b5de8f5435a..3afbf73639c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1740,7 +1740,16 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return -EINVAL;
-		if (ctrl->max_integrity_segments)
+
+		/*
+		 * Currently rdma is the only fabrics nvme host that supports
+		 * metadata integrity segments, but will not use the metadata
+		 * payload if it doesn't satisfy 'nvme_ns_has_pi()'. Since the
+		 * initiator is not able to form requests that satisify the
+		 * format, do not support the namespace if the metadata does
+		 * not satisfy that requirement.
+		 */
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
 			ns->features |=
 				(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	} else {
-- 
2.25.4


