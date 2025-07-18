Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C246EC83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 01:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TGf7Zn4xpgFxKudpOaX4aa4pdVF8MYve5Wl8x1jkQWM=; b=EqvRNfGHHvgYij/IpqW7+7UipB
	4nnaFXg12ZKNzh9P+qset6YFzk3jqJKjrTSBqfqp4gick7UfEuuDlcnTpd8tHWFRIpn6u4St1uEt8
	OOuL11u4vJwYKguKrXsURP1PmHdT7yf56nT8Lx3hirKiOkrNcTETQvhXsRmGvK3SvMYQzIZkETS57
	1uaQ7q9e7dxBELV/+PJ104XdzNeSgvJjKVT+hCzoPawd/cPuy0KbYDgJA8+KbD+RT3k06lmCK7NZ4
	QboEVqiDiBkdIB8X5jxnBGhEmZ+dVZi8deb9wkgCW8EGFpqWUFpDGn7zXvyhmVbBmaLfJQr0FfOYj
	YsE5aXbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucZnc-0000000BS5W-3Be8;
	Fri, 18 Jul 2025 01:22:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucYk0-0000000BOnJ-42lM
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 00:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752797660; x=1784333660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1rtA0Hmyf2kHNVoELQi6f5hdbv4vXGv2LArfBKEp5Qo=;
  b=XAui04iiMA5kyQbCh6Z8zzEzjdxFDz5wN30lDHVpNuiHRX/QUSIYb/+9
   F6GHoJBix3QAKMHAtramwv7Fs2PQtcHl7mFinITm0PNMF5ifiYYR9YbO7
   ANwo3SK9uuzkF/OP0kirREppuAih4T+mDqLSy3+sQpyi/35lSH2c+GIi2
   pBKW/thISJqWkAn6GagubfHqy8JzxtVjs5TKIVPKc31+lWF8oygkuawRK
   uZ9C4LKrgWU2XNWkOJW5+jFvI2VzAmslnQ7Y36Eg+BeLtSiB+FLqWavrl
   632gkO7AzoDzvqkFh4d0B5H/mhq47DGvCG1+BC19o+A6btWnI0y8vTv79
   Q==;
X-CSE-ConnectionGUID: xtRp5ZMzT4KFnVLkcuVqbw==
X-CSE-MsgGUID: DrB+Joh/RmexpBTlsxacJQ==
X-IronPort-AV: E=Sophos;i="6.16,320,1744041600"; 
   d="scan'208";a="91918827"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2025 08:14:17 +0800
IronPort-SDR: 68798334_f93HuQc9OKQ164r6LoqcR7+vrbD1oTlwS3qGaJ3bAqigZpD
 CFgfjB7Ub8WnfigeCUJIoXqygRG8NCrCznvhenA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2025 16:11:49 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jul 2025 17:14:15 -0700
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
Subject: [PATCH v3 1/2] nvme: add capability to connect to an administrative controller
Date: Thu, 17 Jul 2025 17:14:14 -0700
Message-ID: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_171421_061729_1FAF216F 
X-CRM114-Status: GOOD (  13.22  )
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

Suggested-by: Niklas Cassel <cassel@kernel.org>

Add capability to connect to an administrative controller by
preventing ioq creation for admin-controllers.

* Add helper nvme_admin_ctrl() to check for an administrative controller
* Add helper nvme_override_prohibited_io_queues() to override queue_count
* Call nvme_override_prohibited_io_queues() from nvme_init_ctrl_finish()
  so it applies to nvme/tcp and nvme/rdma

Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..105127638c31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3149,6 +3149,21 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 	return ctrl->opts && ctrl->opts->discovery_nqn;
 }
 
+static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->cntrltype == NVME_CTRL_ADMIN;
+}
+
+/*
+ * An admin controller has one admin queue, but no I/O queues.
+ * Override queue_count so it only creates an admin queue.
+ */
+static inline void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
+{
+	if (nvme_admin_ctrl(ctrl))
+		ctrl->queue_count = 1;
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -3670,6 +3685,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	if (ret)
 		return ret;
 
+	if (nvme_admin_ctrl(ctrl))
+		dev_dbg(ctrl->device,
+			"Subsystem %s is an administrative controller",
+			ctrl->subsys->subnqn);
+	nvme_override_prohibited_io_queues(ctrl);
+
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


