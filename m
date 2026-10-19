Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0CCCCA46C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOxbluBvGUNbX2Ri/N3z81iVuWVuHGIO0hj0wP46aSA=; b=RIX4p0ThcqeD7LZw8XdL/VOaOI
	qwb3uokYitkEFOvaLsshEwjHBaIxoAhWN/iz1lqDCpnTzqw+xMMB6udJ09wR5qsEg2cPIbWS0FtUf
	1IaZU9GEX/GpHEEap30Fhb4vgGtuQsB6OlpeHWBy/M0alDCs0AZnZZ+yjiQHAAcZmq0DE38Ouojza
	YMjTPzlBRa0AKePlCGzlf0VLGDcLnrzCTogHRxKwQDtkmG10/+/OtZGdtds0wO92M33vFc8G4wa95
	Wk0INuLMumCXS6E7YjvR1+LslruHktPOHHdja2BN2UhsARfO1q6oe4d7tc7kguHkPPzMk7klnKc3g
	nQ+pcv3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeB4-00000006XkU-06XP;
	Mon, 19 Oct 2026 03:36:46 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAw-00000006Xe3-3QWD
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380997; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZOxbluBvGUNbX2Ri/N3z81iVuWVuHGIO0hj0wP46aSA=;
	b=MPNDimh74Lf59xNTtFmDlCzQ0Bk3yLd1NPfNoQZgHRv8jx0N5edhhNyoNsrxBf1jK2nyAuK/2bm70wgluU6Qy5EzFxhSJsFTQyQjg8Fin80RDs4XPthKY3B1YvJCm+bYCg2LBEcvtyApRtRqWrltW93NR8PXALfdO57+jk2UNdE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-YSCt_1792380995;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-YSCt_1792380995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:36 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 07/11] nvmet: implement the FDP feature
Date: Mon, 19 Oct 2026 11:36:20 +0800
Message-ID: <20261019033624.402337-8-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203639_026422_44D71A01 
X-CRM114-Status: GOOD (  20.80  )
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

Implement Set Features and Get Features for FID 1Dh.  The Endurance
Group Identifier in Command Dword 11 names the namespace directly,
since nvmet identifies each namespace as its own endurance group
(endgid = nsid).  Get Features reports FDPE set with FDPCIDX 0.

Set Features is served locally: the bridge runs the one configuration
that the backing device is already in, so setting the feature to that
same value is a no-op that succeeds, and any other value is a change
of a feature whose endurance group has namespaces, which the spec
aborts with Command Sequence Error.  That also covers disabling,
which would strand the write streams already handed out to hosts.

The namespace lookup takes a namespace reference, so that a namespace
being disabled concurrently with the command cannot go away under
it.  Report the feature in the Features log page under the same
per-subsystem condition as the FDPS bit.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c |  9 ++++
 drivers/nvme/target/fdp.c       | 77 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 10 +++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b293ce418e2c3..93fb9c3d500a3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -600,6 +600,9 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
 	features->fis[NVME_FEAT_RESV_MASK] =
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
+	if (IS_ENABLED(CONFIG_NVME_TARGET_FDP))
+		features->fis[NVME_FEAT_FDP] =
+			cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_EGSCPE);
 
 	status = nvmet_copy_to_sgl(req, 0, features, sizeof(*features));
 	kfree(features);
@@ -1385,6 +1388,9 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_RESV_MASK:
 		status = nvmet_set_feat_resv_notif_mask(req, cdw11);
 		break;
+	case NVME_FEAT_FDP:
+		status = nvmet_set_feat_fdp(req);
+		break;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, cdw10);
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
@@ -1562,6 +1568,9 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_RESV_MASK:
 		status = nvmet_get_feat_resv_notif_mask(req);
 		break;
+	case NVME_FEAT_FDP:
+		status = nvmet_get_feat_fdp(req);
+		break;
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
index 17949e3665293..0327970a9cb9d 100644
--- a/drivers/nvme/target/fdp.c
+++ b/drivers/nvme/target/fdp.c
@@ -12,6 +12,10 @@
 #include "../host/nvme.h"
 #include "nvmet.h"
 
+/* Flexible Data Placement feature (FID 1Dh), Command Dword 12 */
+#define NVME_FDP_CDW12_FDPE			(1U << 0)
+#define NVME_FDP_CDW12_FDPCIDX_MASK		(0xffU << 8)
+
 bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ns *ns;
@@ -83,3 +87,76 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
 	ns->fdp.backend_q = NULL;
 	ns->fdp.backend_ctrl = NULL;
 }
+
+
+/*
+ * Each namespace is its own endurance group, so the Endurance Group
+ * Identifier in Command Dword 11, and in the Log Specific Identifier
+ * of the FDP log pages, directly names the namespace.  Returns the
+ * namespace with a reference held.
+ */
+static struct nvmet_ns *nvmet_fdp_lookup_ns(struct nvmet_req *req, u32 endgid)
+{
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
+	struct nvmet_ns *ns;
+
+	ns = xa_load(&subsys->namespaces, endgid);
+	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
+		return NULL;
+
+	if (!percpu_ref_tryget_live(&ns->ref))
+		return NULL;
+
+	return ns;
+}
+
+/*
+ * The bridge runs the one configuration that the backing device is
+ * already in, so setting the feature to that same value is the only
+ * transition that can be served.  The spec aborts any other value
+ * change of a feature whose endurance group has namespaces with
+ * Command Sequence Error, which also covers disabling: pulling FDP
+ * from under a live namespace would strand the write streams already
+ * handed out to hosts.
+ */
+u16 nvmet_set_feat_fdp(struct nvmet_req *req)
+{
+	u32 cdw12 = le32_to_cpu(req->cmd->features.dword12);
+	struct nvmet_ns *ns;
+	u16 status;
+
+	ns = nvmet_fdp_lookup_ns(req,
+				 le32_to_cpu(req->cmd->features.dword11));
+	if (!ns)
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+
+	if (cdw12 & ~(NVME_FDP_CDW12_FDPCIDX_MASK | NVME_FDP_CDW12_FDPE)) {
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+	} else if ((cdw12 & NVME_FDP_CDW12_FDPE) &&
+		   !(cdw12 & NVME_FDP_CDW12_FDPCIDX_MASK)) {
+		nvmet_set_result(req, FDPCFG_FDPE);
+		status = 0;
+	} else {
+		status = NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
+	}
+
+	percpu_ref_put(&ns->ref);
+	return status;
+}
+
+u16 nvmet_get_feat_fdp(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns;
+
+	ns = nvmet_fdp_lookup_ns(req,
+				 le32_to_cpu(req->cmd->features.dword11));
+	if (!ns)
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+
+	/* the namespace is up, so FDP is enabled on the backing device */
+	nvmet_set_result(req, FDPCFG_FDPE);
+
+	percpu_ref_put(&ns->ref);
+	return 0;
+}
+
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 07880db4468ad..e95bafe1fb019 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -997,6 +997,8 @@ static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 int nvmet_fdp_init_ns(struct nvmet_ns *ns);
 void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
 bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys);
+u16 nvmet_set_feat_fdp(struct nvmet_req *req);
+u16 nvmet_get_feat_fdp(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1013,6 +1015,14 @@ static inline bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
 {
 	return false;
 }
+static inline u16 nvmet_set_feat_fdp(struct nvmet_req *req)
+{
+	return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+}
+static inline u16 nvmet_get_feat_fdp(struct nvmet_req *req)
+{
+	return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+}
 #endif
 
 /*
-- 
2.43.7


