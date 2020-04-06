Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CDC2BA19
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824DA20678
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bHdZlgxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824DA20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BDmibU5NTcuzYJw3uXZW/kfDr4QdU1oUSNqobUCeR+4=; b=bHdZlgxqchSKso
	KBsD5UWlQRX22gcTGwhrzrsb/679Y6CNlMwewFNto5gc+JG8zDNKzQtgV8zioHSCF3ue6AqbsQXKb
	wrA3QYYppP7L7Q8KZKSwFD5rQ9p/WtOOQGKPMmgxU1pY5t2oz0WNRuHD6Idw8J9UhvU1Ac2a/v/7w
	9tGQGY57+v9409mNBdPVJwXMC22YrfKWSjs00tkJfhXkWClpC8V5VxLLraylgvJaFSn4JqbPkqRvm
	CQyVfGDHrEPUrNvRYVMzFZOhElk5O/HfAvMsmikE72/zlvL0AaeR4Tt/WKuc+sRI2aXNJG9vUzuaN
	LCYKdEaYVrGeNVGTZMvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLQeI-0004sZ-A3; Mon, 06 Apr 2020 12:14:42 +0000
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLQdg-0004DB-Kw; Mon, 06 Apr 2020 12:14:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 4/5] nvme: avoid an Identify Controller command for each
 namespace scan
Date: Mon,  6 Apr 2020 14:13:51 +0200
Message-Id: <20200406121352.1151026-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406121352.1151026-1-hch@lst.de>
References: <20200406121352.1151026-1-hch@lst.de>
MIME-Version: 1.0
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The namespace lists are 0-terminated, so we don't really need the NN value
execept for the legacy sequential scan.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ffa1d62eaeb1..d11c462af0f3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3738,12 +3738,11 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 }
 
-static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
+static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 {
 	__le32 *ns_list;
-	unsigned i, j, nsid, prev = 0;
-	unsigned num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
-	int ret = 0;
+	u32 prev = 0;
+	int ret = 0, i;
 
 	if (nvme_ctrl_limited_cns(ctrl))
 		return -EOPNOTSUPP;
@@ -3752,22 +3751,20 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	if (!ns_list)
 		return -ENOMEM;
 
-	for (i = 0; i < num_lists; i++) {
+	for (;;) {
 		ret = nvme_identify_ns_list(ctrl, prev, ns_list);
 		if (ret)
 			goto free;
 
-		for (j = 0; j < min(nn, 1024U); j++) {
-			nsid = le32_to_cpu(ns_list[j]);
-			if (!nsid)
-				goto out;
+		for (i = 0; i < 1024; i++) {
+			u32 nsid = le32_to_cpu(ns_list[i]);
 
+			if (!nsid)	/* end of the list? */
+				goto out;
 			nvme_validate_ns(ctrl, nsid);
-
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
-		nn -= j;
 	}
  out:
 	nvme_remove_invalid_namespaces(ctrl, prev);
@@ -3776,9 +3773,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	return ret;
 }
 
-static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
+static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 {
-	unsigned i;
+	struct nvme_id_ctrl *id;
+	u32 nn, i;
+
+	if (nvme_identify_ctrl(ctrl, &id))
+		return;
+	nn = le32_to_cpu(id->nn);
+	kfree(id);
 
 	for (i = 1; i <= nn; i++)
 		nvme_validate_ns(ctrl, i);
@@ -3815,8 +3818,6 @@ static void nvme_scan_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
-	struct nvme_id_ctrl *id;
-	unsigned nn;
 
 	/* No tagset on a live ctrl means IO queues could not created */
 	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
@@ -3827,14 +3828,9 @@ static void nvme_scan_work(struct work_struct *work)
 		nvme_clear_changed_ns_log(ctrl);
 	}
 
-	if (nvme_identify_ctrl(ctrl, &id))
-		return;
-	nn = le32_to_cpu(id->nn);
-	kfree(id);
-
 	mutex_lock(&ctrl->scan_lock);
-	if (nvme_scan_ns_list(ctrl, nn) != 0)
-		nvme_scan_ns_sequential(ctrl, nn);
+	if (nvme_scan_ns_list(ctrl) != 0)
+		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
 
 	down_write(&ctrl->namespaces_rwsem);
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
