Return-Path: <SRS0=9Kud=5W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A57BC2BA19
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F055E20678
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2020 12:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="doSVRgfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F055E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=63qyyU/Z10PdthlGVmoOUIPZjnlQ/N9NBkPFlfpnLt8=; b=doSVRgfxbTkV22
	yEEeowpW/oSsStegCXAM6/YhiqX37gmCOjBWHcn85swUsEiAeRJWhPqpacM6w4voAyR9ex0exHKLr
	knpLNn06/a0Ylzv0gMjSkL1ue0aC04jDtgGXjcUs+hjbl6aiYqlb0uFE4qaeYQ3LepndDxB8qE+A4
	0oEB+4maf8A4G7eGF/fjGGJ9RsYRyWTl6gUorFuFrpoV6r4Bvx0fdiLF4VM1B11zpOTr+XqM5YRo0
	gTpYDdaBsrPiiLPFuOHpbfMIQUVJuSUxHDNnUO0yI0uuVznnHjyRcyTAz9aug9X4+pP+SP+RudHNz
	jtKs4hKy7v0GKFoVdoeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jLQdv-0004Vq-2X; Mon, 06 Apr 2020 12:14:19 +0000
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLQdb-00048s-Gy; Mon, 06 Apr 2020 12:13:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 2/5] nvme: clean up nvme_scan_work
Date: Mon,  6 Apr 2020 14:13:49 +0200
Message-Id: <20200406121352.1151026-3-hch@lst.de>
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

Move the check for the supported CNS value into nvme_scan_ns_list, and
limit the life time of the identify controller allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 01889905875b..5fcc35f74eac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3736,6 +3736,9 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	unsigned num_lists = DIV_ROUND_UP_ULL((u64)nn, 1024);
 	int ret = 0;
 
+	if (nvme_ctrl_limited_cns(ctrl))
+		return -EOPNOTSUPP;
+
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
@@ -3822,17 +3825,14 @@ static void nvme_scan_work(struct work_struct *work)
 
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
+	nn = le32_to_cpu(id->nn);
+	kfree(id);
 
 	mutex_lock(&ctrl->scan_lock);
-	nn = le32_to_cpu(id->nn);
-	if (!nvme_ctrl_limited_cns(ctrl)) {
-		if (!nvme_scan_ns_list(ctrl, nn))
-			goto out_free_id;
-	}
-	nvme_scan_ns_sequential(ctrl, nn);
-out_free_id:
+	if (nvme_scan_ns_list(ctrl, nn) != 0)
+		nvme_scan_ns_sequential(ctrl, nn);
 	mutex_unlock(&ctrl->scan_lock);
-	kfree(id);
+
 	down_write(&ctrl->namespaces_rwsem);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	up_write(&ctrl->namespaces_rwsem);
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
