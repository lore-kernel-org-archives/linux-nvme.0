Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A52FC636D7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N7be2RukEtknQEg962nsS3+sWr+NRQ/ZbMYoSxc0wHo=; b=Gl2I092w+PqAQws7BIg8IaNare
	Z0q0qigO+O1R7PBa8MoI4QbFK1w3tH+N6Si3WFm2xLfCtbrtsv1Dyx/I3Wvj9DSUqw5K8SVrXNMVR
	JQkga3U7DVmxU2pU1oeWStsYqcmwGJjy4UjORyrw/EP1CeawtKAu0Ws4D34Oy5mg7xrIzNidTs9rC
	q8zZL8ZmVaa+/H/lmpIbf/tFIK/RhvQe6x1ip997kAdpQF209LMhV8ClkQ5AyudD7iLi6EP1gfNvc
	fVJ/n6q3RTIyQSfbo4yU/EU/rXDTBw2izDRHtEHpR851YQPMzpMK1VbPnZtbetmn6joU5b27O4Y2R
	hahEey/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUb2U-009yGN-EB; Tue, 21 Feb 2023 22:23:10 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUb2R-009yG1-TR; Tue, 21 Feb 2023 22:23:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	nh@edgeless.systems
Subject: [PATCH] nvme: bring back auto-removal of deleted namespaces during sequential scan
Date: Tue, 21 Feb 2023 14:23:07 -0800
Message-Id: <20230221222307.557935-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
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

Bring back the check of the Identify Namespace return value for the
legacy NVMe 1.0-style sequential scanning.  While NVMe 1.0 does not
support namespace management, there are "modern" cloud solutions like
Google Cloud Platform that claim the obsolete 1.0 compliance for no
good reason while supporting proprietary sideband namespace management.

Fixes: 1a893c2bfef4 ("nvme: refactor namespace probing")
Reported-by: Nils Hanke <nh@edgeless.systems>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Nils, this is a slightly different variant from the one you tested
earlier, can you retest it?

 drivers/nvme/host/core.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8b64211411626b..fbed8d1a02ef42 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -38,6 +38,7 @@ struct nvme_ns_info {
 	bool is_shared;
 	bool is_readonly;
 	bool is_ready;
+	bool is_removed;
 };
 
 unsigned int admin_timeout = 60;
@@ -1445,16 +1446,8 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
-		goto out_free_id;
+		kfree(*id);
 	}
-
-	error = NVME_SC_INVALID_NS | NVME_SC_DNR;
-	if ((*id)->ncap == 0) /* namespace not allocated or attached */
-		goto out_free_id;
-	return 0;
-
-out_free_id:
-	kfree(*id);
 	return error;
 }
 
@@ -1468,6 +1461,13 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	ret = nvme_identify_ns(ctrl, info->nsid, &id);
 	if (ret)
 		return ret;
+
+	if (id->ncap == 0) {
+		/* namespace not allocated or attached */
+		info->is_removed = true;
+		return -ENODEV;
+	}
+
 	info->anagrpid = id->anagrpid;
 	info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 	info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
@@ -4418,6 +4418,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
+	int ret;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
@@ -4434,19 +4435,19 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
 	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
-	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS)) {
-		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
-			return;
-	} else {
-		if (nvme_ns_info_from_identify(ctrl, &info))
-			return;
-	}
+	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
+		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);
+	else
+		ret = nvme_ns_info_from_identify(ctrl, &info);
+
+	if (info.is_removed)
+		nvme_ns_remove_by_nsid(ctrl, nsid);
 
 	/*
 	 * Ignore the namespace if it is not ready. We will get an AEN once it
 	 * becomes ready and restart the scan.
 	 */
-	if (!info.is_ready)
+	if (ret || !info.is_ready)
 		return;
 
 	ns = nvme_find_get_ns(ctrl, nsid);
-- 
2.39.1


