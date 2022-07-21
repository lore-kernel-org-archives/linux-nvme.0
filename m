Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54ECC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLR5/0CkHmNqrK9Ubi7Ads1LglRceNklDiSR44XnkHc=; b=SqufFjYUAwbI14RhceglHecChn
	NgBoQG6WaXyVg/IQfzo5bD10G8PShetJwlDr73+lkUBKd/kQuO/pF4x3X6JSz5K7zWmJndcsZRDks
	Ys1cw9CSAIZxMKOWyqgYsB1pPzKaEXZve/YwH0hYpfUMbQvOklbMvfaCQum/26e12+E3H2JrMfnYY
	4t5HWOfgVJkjoWhwCp1q2B5Fly6q2FQ0vCopHCh6P0DXC8iQk8mN49dgLxBMpNJ54z0nFgBPaq2Aj
	8ua15Q408coyO9iXEOvJzPGyVKM2hinIIv3QA3oT6dXZ+XWODB/7Oi3L8LCfoT+jjiXL9jet14CEP
	yRtFvyqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPPt-000nXH-Qc; Thu, 21 Jul 2022 06:12:09 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPHY-000dfn-As; Thu, 21 Jul 2022 06:03:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/6] nvme: generalize the nvme_multi_css check in nvme_scan_ns
Date: Thu, 21 Jul 2022 08:03:17 +0200
Message-Id: <20220721060320.1704646-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721060320.1704646-1-hch@lst.de>
References: <20220721060320.1704646-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Javier González <javier.gonz@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af3b90ca9131d..5ba09d010daba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4295,6 +4295,12 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
@@ -4326,12 +4332,6 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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


