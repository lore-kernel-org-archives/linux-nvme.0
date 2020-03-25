Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0856C43331
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 13:28:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41DB2078A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 13:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dZpecVOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41DB2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a8xhmixwNSnplwBmCB2Tg4/+1eu5p8ajFpvDuzeFiwc=; b=dZpecVOb3bAcLv
	U2CQfdfhRcqw7dutL4wr7X0LxBe+y0u6cGL+ej9EGEMmhUQc+1Fa8MPVlWs2W9FWiz/K1h5SbGH69
	A6YMgsqTJG82t0bdB0T7jcOUjMJQ8UJbHr6ok/DMnTyJCFv3diCIp7XMGlGRCoPq2TN36nYO+6AeZ
	2tPRG7ku7J5EfHQxB0r/3xgKCZCUumvwKLDrLamgQAxRH/VAvCXiPNNr+mje6EKVIz+HPnEmgmQ17
	CQGV9Dgrv7d8gEBrA7PXuwHeQow3XWKFtFEHtMtm0stdaR3gJryl0zOe6pyZjiwBnL6X6UK/jVFcs
	a4Q+Trx6s/cEcnV8LP0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jH658-0005Fy-Tz; Wed, 25 Mar 2020 13:28:30 +0000
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jH657-0005Fq-0r; Wed, 25 Mar 2020 13:28:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/3] nvme: cleanup namespace identifier reporting in
 nvme_init_ns_head
Date: Wed, 25 Mar 2020 14:19:37 +0100
Message-Id: <20200325131937.1198787-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325131937.1198787-1-hch@lst.de>
References: <20200325131937.1198787-1-hch@lst.de>
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

Lift the common namespace identifier reporting between the shared
namespace and new nshead cases into common code.  This also means
one less lock is held while doing I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51517368e56a..986df944130d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3390,7 +3390,8 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
-		unsigned nsid, struct nvme_id_ns *id)
+		unsigned nsid, struct nvme_id_ns *id,
+		struct nvme_ns_ids *ids)
 {
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
@@ -3413,12 +3414,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_ida_remove;
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
+	head->ids = *ids;
 	kref_init(&head->ref);
 
-	ret = nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
-	if (ret)
-		goto out_cleanup_srcu;
-
 	ret = __nvme_check_ids(ctrl->subsys, head);
 	if (ret) {
 		dev_err(ctrl->device,
@@ -3453,24 +3451,23 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	bool is_shared = id->nmic & (1 << 0);
 	struct nvme_ns_head *head = NULL;
+	struct nvme_ns_ids ids;
 	int ret = 0;
 
+	ret = nvme_report_ns_ids(ctrl, nsid, id, &ids);
+	if (ret)
+		goto out;;
+
 	mutex_lock(&ctrl->subsys->lock);
 	if (is_shared)
 		head = nvme_find_ns_head(ctrl->subsys, nsid);
 	if (!head) {
-		head = nvme_alloc_ns_head(ctrl, nsid, id);
+		head = nvme_alloc_ns_head(ctrl, nsid, id, &ids);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
 	} else {
-		struct nvme_ns_ids ids;
-
-		ret = nvme_report_ns_ids(ctrl, nsid, id, &ids);
-		if (ret)
-			goto out_unlock;
-
 		if (!nvme_ns_ids_equal(&head->ids, &ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
@@ -3485,6 +3482,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 
 out_unlock:
 	mutex_unlock(&ctrl->subsys->lock);
+out:
 	if (ret > 0)
 		ret = blk_status_to_errno(nvme_error_status(ret));
 	return ret;
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
