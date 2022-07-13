Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200EDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 05:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUAHmR0L7XpkCjOqkQBubXsc91qLqGwicmYn5Qa3vxE=; b=XY3U6jk2VX64KK4QD3HiORmR/m
	Uxd22Ap43uUXKoyo+mrvu4T+6NOxiXVEKlpG1WwMvDzw5LaMHa+jwxYCTK0CH9BXBtiOg4DvXL2xS
	K0s/1obrkVmMWqEZr+F6ZqndqIZq6KQjKSOoAfIoOoP1pfio7ROzx5UMQO6itpwT9hCTTUpWf4xIf
	HNt6X1zyurhv1ZBcBn79Ch7dvxGWfGrm7poXocW8G4qFjYTsfZem8xqIwyu3o7BAyG7FL5zgijoQC
	S+GQrpZE54gxmVstF+9eWzv4qIqYE+zoTvRFCaF32z7k2pp1L3Zmh4+dghZ/MT/3s0//jNzJgupgZ
	XMUvVmLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFW-000LA5-8i; Wed, 13 Jul 2022 05:49:26 +0000
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFT-000L7Z-Mo; Wed, 13 Jul 2022 05:49:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: [PATCH 2/5] nvme: generalize the nvme_multi_css check in nvme_scan_ns
Date: Wed, 13 Jul 2022 07:49:11 +0200
Message-Id: <20220713054914.1888305-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713054914.1888305-1-hch@lst.de>
References: <20220713054914.1888305-1-hch@lst.de>
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

Check for multiple command set support early on an error out if is
not supported when a !NVM command set namespace is found.  This
prepares for adding command set independent passthrough support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b14fbb7a5a8..4769c49141913 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4293,6 +4293,12 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
 		return;
 
+	if (ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
+		dev_warn(ctrl->device,
+			"command set not reported for nsid: %d\n", nsid);
+		return;
+	}
+
 	/*
 	 * Check if the namespace is ready.  If not ignore it, we will get an
 	 * AEN once it becomes ready and restart the scan.
@@ -4324,12 +4330,6 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				nsid);
 			break;
 		}
-		if (!nvme_multi_css(ctrl)) {
-			dev_warn(ctrl->device,
-				"command set not reported for nsid: %d\n",
-				nsid);
-			break;
-		}
 		nvme_alloc_ns(ctrl, nsid, &ids);
 		break;
 	default:
-- 
2.30.2


