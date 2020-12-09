Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053E5C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 21:33:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24A422CAD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 21:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24A422CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xaOArXbRRIRX/IeCsyb+G0Nz/dt/Is5FGpJ85XsPfXg=; b=fPwCuvK6zvYbuFMo+F6R/eU3wD
	8MsyzPCEtJ4Urfr8c/5n+/kz/nR2423bq9gvDoq9oBy6G+U1GGmAA9rI1SMmBUk/OGirsTht3h42d
	BO8uNepuyB1R8zCNrjueT0VmzbSL8UMSsvQ4lrNGWYn8oVI8ZdMq8YWmXWHN8hki4UbcXaViDrYpV
	G2igsc/QrWfnxayn1KQvM9WQ1SxYn6JFsrn0x3yXh788Dk84YubRAYfo6vkd7IZtzueGu+09J2z4s
	dZ2k7zfgdxYXDfC6ZZqXR+KR+GYEbyx+2v7zy9YaT6MZa1/IGcwdgxWs6Cl1OgxygOIzpksqaYeZq
	X04nVI0w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn75m-0005iR-8Z; Wed, 09 Dec 2020 21:33:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn75h-0005hN-II
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 21:33:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 74ACFACE1;
 Wed,  9 Dec 2020 21:33:36 +0000 (UTC)
From: Enzo Matsumiya <ematsumiya@suse.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: hwmon: fix crash on device teardown
Date: Wed,  9 Dec 2020 18:32:27 -0300
Message-Id: <20201209213228.5044-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_163341_761665_45891C27 
X-CRM114-Status: GOOD (  15.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Enzo Matsumiya <ematsumiya@suse.de>,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fix a possible NULL pointer dereference when trying to read
hwmon sysfs entries associated to NVMe-oF devices that were
hot-removed or disconnected.

Unregister the NVMe hwmon device upon controller teardown
(nvme_stop_ctrl()).

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/nvme/host/core.c  | 1 +
 drivers/nvme/host/hwmon.c | 8 ++++++++
 drivers/nvme/host/nvme.h  | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9a270e49df17..becc80a0c3b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4344,6 +4344,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_hwmon_exit(ctrl);
 	nvme_mpath_stop(ctrl);
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 552dbc04567b..7f62cca4c577 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -71,6 +71,9 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	int temp;
 	int err;
 
+	if (data->ctrl->state != NVME_CTRL_LIVE)
+		return -EAGAIN;
+
 	/*
 	 * First handle attributes which don't require us to read
 	 * the smart log.
@@ -253,3 +256,8 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	return 0;
 }
+
+void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
+{
+	hwmon_device_unregister(ctrl->dev);
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 567f7ad18a91..621e9b1575f6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -807,11 +807,13 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 
 #ifdef CONFIG_NVME_HWMON
 int nvme_hwmon_init(struct nvme_ctrl *ctrl);
+void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
 #else
 static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
 	return 0;
 }
+static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl) { }
 #endif
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
