Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F46C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D7D2158C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UuFvWz+3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="daON/Kec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D7D2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WPExUiiG2bWacw8ERW6JfoFmOGa1egA+Uph/l5l3VDs=; b=UuFvWz+30Hc/4ptvTF1W87ecC
	kvW0bF4Ejb///YVwhqK5Z+7bNXN8EUTMvgqTg0GAe2lmGrbLx5CXS5QcLOi+BLNSqULsuA7ceaZp7
	qhz4z0GS3FiCAVQcAIasgqyZx89+vEs96IalvIZSdNQSBGsic5dVnyaLaZ6nSFP64tsIXl3p+xlSe
	xDE6uKLQrn7Fhm7yCkpducjYuR7LOAy8H9W9fHPKz4HEqv322vGzO/Ptss7mlyBtAAdnXK6kvhD3T
	t1T7obNPgirNM3jSh/D1FvU+KEswNZP3bQbr6ghLogYBbqEt1r2BKNCLiZbKHWlW+9fXVtuBHOxHl
	Wru4OoX9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsO1-0002lf-1H; Mon, 28 Sep 2020 12:36:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNP-0002Sg-FY
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9fT3+do5MR/vyI/TqKnHESdNyb4ZFF2kjEgzTroyXxY=; b=daON/KeciJYJ5KPu2TGj7Xymu8
 2/NAigYKqdjpN5XcOlT0HgPK71q1viIzcE96dW0pQVDkcfWitygsxwN/aSHePkjUPH11ifcPPmoKs
 lbfCBeQJwwm+a3kGAqQFz8xA5TV7g6ngTqUWo+aW/whYcjhKMapwN2f5mpdCpFgYqne2ET2zR99am
 25O9zYbdXuKbUXEpZIFbTLCbEGnqTmqOZ+QWaOwh7FJH95cyZ31MNWrNagttBbFdLboKBGqtMZFAs
 2wcIzTq2Gsx1Fzfw1AuPei85S6/bpbN+SYWgfRz1Ac8t9hk4smPW8gj4/GiHj9M2QnuozQDovt0oU
 YwgoqRDg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNO-0004mo-2w; Mon, 28 Sep 2020 12:35:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 18/20] nvme: move nvme_validate_ns
Date: Mon, 28 Sep 2020 14:35:00 +0200
Message-Id: <20200928123502.435373-19-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move nvme_validate_ns just above its only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 74 ++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ad18c32b36e7b6..07309f6c14faab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2156,43 +2156,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return ret;
 }
 
-static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
-{
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_id_ns *id;
-	int ret = 0;
-
-	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
-		set_capacity(ns->disk, 0);
-		return -ENODEV;
-	}
-
-	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
-	if (ret)
-		goto out;
-
-	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
-		dev_err(ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		ret = -ENODEV;
-		goto free_id;
-	}
-
-	ret = nvme_update_ns_info(ns, id);
-free_id:
-	kfree(id);
-out:
-	/*
-	 * Only fail the function if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 */
-	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
-		ret = 0;
-	else if (ret > 0)
-		ret = blk_status_to_errno(nvme_error_status(ret));
-	return ret;
-}
-
 static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -3973,6 +3936,43 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
+static int nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_id_ns *id;
+	int ret = 0;
+
+	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
+		set_capacity(ns->disk, 0);
+		return -ENODEV;
+	}
+
+	ret = nvme_identify_ns(ctrl, ns->head->ns_id, ids, &id);
+	if (ret)
+		goto out;
+
+	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
+		dev_err(ctrl->device,
+			"identifiers changed for nsid %d\n", ns->head->ns_id);
+		ret = -ENODEV;
+		goto free_id;
+	}
+
+	ret = nvme_update_ns_info(ns, id);
+free_id:
+	kfree(id);
+out:
+	/*
+	 * Only fail the function if we got a fatal error back from the
+	 * device, otherwise ignore the error and just move on.
+	 */
+	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
+		ret = 0;
+	else if (ret > 0)
+		ret = blk_status_to_errno(nvme_error_status(ret));
+	return ret;
+}
+
 static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_ids ids = { };
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
