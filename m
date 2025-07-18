Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67EBC83F34
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 01:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5BUl1E0q/AyE9rGuzuSXBEfU3J6j4OcXJG87WZJMog=; b=yKbiRCSyJt9kAfKFgbKonGtZ3b
	gXN+MoAlhIwgKhqY0JR8/F2p4xsAnDfrSC9+idKMgU6+MdoIOMVYQ8F93LeyOXgUwj+sTaJRGxrca
	COZIwilnWfJpABksRRCs4NlLxie96Q5+7a8q5WStzZD9Hw9MBchZ31aKcmgGbZnZ1jmzApp8JlWLB
	WHXQ38pnzu6idj4PiP46vQclysfFnIDw/foGRK5R5wRz8ZOCXGwFmqGWEGvwg4YLB/uGhSOs1czl9
	CtTnS/semduZz3kYbbXOcAVPxhkNLbLZr2gnEpE/KBAObKKwlnOJfweUy5XTyr4ZkPUShfCxEFm2B
	f6BVBT2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucZnd-0000000BS5f-1OXW;
	Fri, 18 Jul 2025 01:22:09 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucYk1-0000000BOnj-0mRF
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 00:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752797661; x=1784333661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzcnrP68AUYH3vlmULE6dDlehfFbFKnSRglouYGv1LQ=;
  b=g7O7a7ayj79WEZcObRE7mLsbTc76Mb2P3TSutkucXzKvSSANya67QUdr
   v4TloO+uUyRYh6BpmzfFluM0Y0eaKvXUeJQPrCRgDQNkSyvU4t8s8WyI7
   oOEq8WkmchNv/LfjjMMDlkZu0VsNHWY/c/v+e7Tzpcc6O09znEy7WKuau
   bTNNPTegL1x/WrG/JuvPV/nqEbnbQtCdwiX8OjdHKM0/O82pUDug7aviy
   hTEs20YqyIzyqDJgtCb9tDDVRIx+SrduSCPvgUHNQwhvBi5FLyWgZkNdS
   VKDGZLHpD2awFW/8jYTj6Akax3XowIceR5D7WsMf1w/KjH8wRacoFkWd8
   Q==;
X-CSE-ConnectionGUID: 0VyGREOaRVKXxAEXQX7Y7Q==
X-CSE-MsgGUID: RWk4ey+bSjCWQtLDWkhL4Q==
X-IronPort-AV: E=Sophos;i="6.16,320,1744041600"; 
   d="scan'208";a="91918828"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2025 08:14:17 +0800
IronPort-SDR: 68798335_b7sQLW0+tSdvgEsEz8A1dp/DHBhrHHwPKg+GRbtlmTmWr2X
 CZPNvv3R3dciUSoIxJ6N9tlkNwHZReX08A8abgg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2025 16:11:49 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jul 2025 17:14:16 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v3 2/2] nvme: prevent admin controller from smart log fetch (LID 2)
Date: Thu, 17 Jul 2025 17:14:15 -0700
Message-ID: <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_171421_281483_52F92410 
X-CRM114-Status: GOOD (  13.60  )
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

Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
log. LID 2 is optional for admin controllers to support.

In the future when support for LID=0 (supported log pages) is added,
GLP accesses can be made smarter by basing such calls on response
from LID=0 reads.

Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.
Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 105127638c31..6e5c9871b76d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 
 	nvme_configure_opal(ctrl, was_suspended);
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
 		/*
 		 * Do not return errors unless we are in a controller reset,
 		 * the controller works perfectly fine without hwmon.
-- 
2.43.0


