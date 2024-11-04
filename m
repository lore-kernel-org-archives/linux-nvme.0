Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C98E67819
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tz2o1yf0rtiLI69f6xAg5v85Hs5NSQk2Ze1F+V9vRyQ=; b=g+9f/8hXCk7j3t/iAV05zCxZG2
	/96kTX3/t517B0s5Xq7NeWHCsOJvLjq0ebCrgQcRIX2tWssPMiwqlzr9Y6ID+t+Z/plI1YZSCCqfi
	4t7EfVPeEOSETEHa+wJ08tPE7ClLFRvoOBgzxLa2LkvdqH+QyC/Vi66MJ1cRa5P5TxzZ8lCeyojDq
	XcDMdpq3JoTrFOm5zj4XkBpZ6RR6OyCu+hab1EBUhGTIWCfM6xKio94WrvZq0batsmax85c6aDFVT
	y7j1vyrWe4C52KXZOypQISOX56akilDYC162MvCi48gaavtSo5a2fmbAfoJZKZf742MucBPVbAZ9B
	+hquaziw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssp-0000000D2gt-0aaD;
	Mon, 04 Nov 2024 08:56:23 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssA-0000000D2RI-1BCq
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710539; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tz2o1yf0rtiLI69f6xAg5v85Hs5NSQk2Ze1F+V9vRyQ=;
	b=nDbmlUUh0zYF4FjAilcwz4OMpNzUVnvH+nvgY/hS8vWTWmuJpH2YHRIK2Jzr1odFxdQ/whD4GTbVvvnQV9LPjAO9/Dyitmzbtpb4NVQ8WNlWTuLRRGH6kaWrSOeIUOsptMzCh32ILm2RHCuwiq/u20RjfNQXG9kzI+jYPjrakDk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIe2aSl_1730710530 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:55:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RFC 1/3] nvme: check ns's volatile write cache not present
Date: Mon,  4 Nov 2024 16:55:00 +0800
Message-ID: <20241104085524.118221-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104085524.118221-1-kanie@linux.alibaba.com>
References: <20241104085524.118221-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005542_486585_8EBE7571 
X-CRM114-Status: GOOD (  12.80  )
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

When the VWC of a namespace does not exist, the BLK_FEAT_WRITE_CACHE
flag should not be set when registering the block device, regardless
of whether the controller supports VWC.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 4 +++-
 include/linux/nvme.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b149b638453f..eed41d4d2599 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -42,6 +42,7 @@ struct nvme_ns_info {
 	bool is_readonly;
 	bool is_ready;
 	bool is_removed;
+	bool no_vwc;
 };
 
 unsigned int admin_timeout = 60;
@@ -1639,6 +1640,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
+		info->no_vwc = id->nsfeat & NVME_NS_VWC_NOT_PRESENT;
 	}
 	kfree(id);
 	return ret;
@@ -2185,7 +2187,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
 
-	if (ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT)
+	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
 	else
 		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..6ce2533cf9b4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -560,6 +560,7 @@ enum {
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_NS_NMIC_SHARED	= 1 << 0,
+	NVME_NS_VWC_NOT_PRESENT = 1 << 5,
 	NVME_LBAF_RP_BEST	= 0,
 	NVME_LBAF_RP_BETTER	= 1,
 	NVME_LBAF_RP_GOOD	= 2,
-- 
2.43.0


