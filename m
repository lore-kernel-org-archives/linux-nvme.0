Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E8AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F2B2072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="btHy+B5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F2B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CFEeVI5cDWt9LH81n6tkjbkAXey42n9pEpdvZYvIXXY=; b=btHy+B5smOwMelSogHiNJD+1UZ
	h4ofLfXxif3AAOTGTOOpXdjfXw7lKZ6/CgRoFyQbJrYT1RsYS20dM6NltP1bnAdSbvbZgwa4D0bwS
	9HZhEb238sNg4vvREGFBcne5WMpOYqaUxmBv3OhFUyNZbJcfaCLBrABThJbR5sqrE1Wb1v5iaS+qN
	qkKdJglGj9r8heYn3VGVow/E/GU9TdR8L840c4InVySnk6r8R5tK3XVJoCp06Z2XkBSunnxlNofs2
	4/Ahu9M9Ifea9tHVRWIhHwHs6lIVhGxDnoAAYqC9eJglQJSPNhkoJQJ4wVor2igRxYUDIRbMea2vK
	PX21uhjg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzF6-0006PR-0l; Wed, 24 Jun 2020 06:50:44 +0000
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzEj-0006MX-DA
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:50:22 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07425;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U0ZTZul_1592981407; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0ZTZul_1592981407) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 14:50:07 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v2 1/2] nvme: Add Arbitration Burst support
Date: Wed, 24 Jun 2020 14:49:57 +0800
Message-Id: <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From the NVMe spec, "In order to make efficient use of the non-volatile
memory, it is often advantageous to execute multiple commands from a
Submission Queue in parallel. For Submission Queues that are using
weighted round robin with urgent priority class or round robin
arbitration, host software may configure an Arbitration Burst setting".
Thus add Arbitration Burst setting support.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 29 +++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2c5bc4..f5f882f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -61,6 +61,10 @@
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+static bool use_rab;
+module_param(use_rab, bool, 0644);
+MODULE_PARM_DESC(use_rab, "use controller's recommended arbitration burst");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1241,6 +1245,28 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+static void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
+{
+	u32 result;
+	int status;
+
+	if (!use_rab || !ctrl->rab)
+		return;
+
+	/*
+	 * The Arbitration Burst setting indicates the maximum number of
+	 * commands that the controller may launch at one time from a
+	 * particular Submission Queue. It is recommended that host software
+	 * configure the Arbitration Burst setting as close to the recommended
+	 * value by the controller as possible.
+	 */
+	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION,
+				   ctrl->rab & NVME_FEAT_ARBITRATION_MASK,
+				   NULL, 0, &result);
+	if (status)
+		dev_warn(ctrl->device, "Failed to set Arbitration Burst\n");
+}
+
 #define NVME_AEN_SUPPORTED \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
@@ -2953,6 +2979,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	} else
 		ctrl->shutdown_timeout = shutdown_timeout;
 
+	ctrl->rab = id->rab;
+	nvme_set_arbitration_burst(ctrl);
+
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
 	prev_apst_enabled = ctrl->apst_enabled;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c0f4226..bc424c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -246,6 +246,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u8 rab;
 	u16 wctemp;
 	u16 cctemp;
 	u32 oaes;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab..fa629c8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -909,6 +909,7 @@ enum {
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
 	NVME_FEAT_ARBITRATION	= 0x01,
+	NVME_FEAT_ARBITRATION_MASK = 0x7,
 	NVME_FEAT_POWER_MGMT	= 0x02,
 	NVME_FEAT_LBA_RANGE	= 0x03,
 	NVME_FEAT_TEMP_THRESH	= 0x04,
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
