Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05406606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j0XcpyEM;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FGBY/pdn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gRuMF/UIU8v2WX+NZLP4QadMJE9g0PcCevN6hz6+uYg=; b=j0XcpyEMOE1r6H
	5sIT5/NHO6gIK/GmBW/0JTl8r9G3tgUr0NYZC/9ZPHl8K94jjnYYMtjyrjwUWx+VD2f0h5e3oLJUQ
	zJqx5BLp+QhmW74/YhtbShgtt8DyHmybyBho+Jq0904NcvMOQNFBKyGchkzknrQpC7JBop/JJmIPZ
	SfGtZwzpayQc71nYIOe/MpWKYjNY90fKYC9eC+fjwZpilJTMfmcvM+mPsgIVILD1km9+BetWHknZM
	LEkMr/IYnWTYE9KDmHCySZ+vAx6idYxiW75rBSIC9WJDmufCRvQ89g/vRAnlEk9j3DPlOjVvSX4F4
	zOg8I0XjQm3rfdzNrz+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAFA-0000000Fqs1-2X0s;
	Fri, 23 Oct 2026 08:03:16 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF2-0000000Fqke-43of
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742587; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gRuMF/UIU8v2WX+NZLP4QadMJE9g0PcCevN6hz6+uYg=;
	b=FGBY/pdnyMDiBLJfLgGhpG185zucCj8otA0skNZRV84iZY22hsB/1MWybtUd2CYQqD9fQ7zQzatvCM5g2pYyuiO1l3nHQhGSLYuVm1iKt8wA85YpnYKjjHjzVXtiOTgK0Iak9vS7AiHHzsMKxRkAuiXK8uhCjiGrHSRKphKjM+g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLXpd2_1792742586;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLXpd2_1792742586 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:06 +0800
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
Date: Fri, 23 Oct 2026 16:02:47 +0800
Message-ID: <20261023080251.2606443-8-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010311_725804_9C497696 
X-CRM114-Status: GOOD (  20.21  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

The namespace lookup runs under RCU and takes a namespace reference,
so that a namespace being disabled concurrently with the command
cannot go away under it.  Report the feature in the Features log
page under the same per-subsystem condition as the FDPS bit.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c |  9 ++++
 drivers/nvme/target/fdp.c       | 83 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 10 ++++
 3 files changed, 102 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b293ce418e2c3..8062f7e59f561 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -600,6 +600,9 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
 	features->fis[NVME_FEAT_RESV_MASK] =
 		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_NSCPE);
+	if (nvmet_fdp_subsys_configured(nvmet_req_subsys(req)))
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
index 17949e3665293..5008294984885 100644
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
@@ -83,3 +87,82 @@ void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
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
+	rcu_read_lock();
+	ns = xa_load(&subsys->namespaces, endgid);
+	if (!ns || !ns->enabled || !nvmet_fdp_enabled(ns))
+		goto out_unlock;
+
+	if (!percpu_ref_tryget_live(&ns->ref))
+		goto out_unlock;
+
+	rcu_read_unlock();
+	return ns;
+
+out_unlock:
+	rcu_read_unlock();
+	return NULL;
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
index e287b7c0d20f0..94cea9dcf0f74 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -1001,6 +1001,8 @@ static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 int nvmet_fdp_init_ns(struct nvmet_ns *ns);
 void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
 bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys);
+u16 nvmet_set_feat_fdp(struct nvmet_req *req);
+u16 nvmet_get_feat_fdp(struct nvmet_req *req);
 #else
 static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
 {
@@ -1017,6 +1019,14 @@ static inline bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
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


