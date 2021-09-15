Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 15:39:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2766761186
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 15:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2766761186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TssSITFaylrIdV0rrf3GWVY22TRiz0PEZ/ZDmVnXF8I=; b=06k+u8LI30Xm1U
	d4r4B3LMUdxDM5R+4Sn24VZr18u5y8abQ6RxakSATVqI6YS4v6XQ5q5/R69BB81mifW/gVxXXdu8I
	fhJaoxw7XzEryfp6CzrMzovEfjwTa/66LtLLJH4aCCv0asFWCIc9QJX3Z1pmzukCxAJHjASiCwnnS
	ibddZbjTkbL9yefmqRbVdJDaBO9Y4Uv3FsjdARiVYkFl8TmpVLYtfGYxDY7KIwcxCt0glmn4k/TJK
	BdTghBs5C0aUn+HiMpkQ1+WEfSa89FqBVpUNugPAIUXAfazSj5YdMhcb83/NZI+qfXi33vMOLhlt7
	H2NyTkyCr+UH0sMcMVoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQWzX-009RHK-2y; Wed, 15 Sep 2021 15:38:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQWzV-009RGh-Og
 for linux-nvme@bombadil.infradead.org; Wed, 15 Sep 2021 15:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=v0Pn9wbsoNYfGfmqSsK/wonlSKsoDe2Tvu5xhiJDAuo=; b=s1487snucR0TACdjJWqxDFsjBK
 imuHgcuuvZHUHqEUQoZGVW+d4E6nOObIp1c3KNIVUva4S0Z5ys+QfBTTw7B0IfzgUaGIXeJ8Z8BFc
 GNDH0u0JxCh8Zlys+YNAKLzZ0GMpCI0Kj+VGY4jbDwxPZzHhlQA9wlae+4vqZJSn4FRXfB9uTkNnI
 3IoE6wjceA8zqOnYGEmIpUp4Sg6AaJKiG8O7hVNqzPhJDcdLHH8eSFTR4gF9ju7EZr7xLN6F9lhIk
 BzdmiYdYFSUsJKb1GnkE4RFFk4/RV+u5buoLbuWoNZ2xuFC6c2xdMsWW2jYE/csJFz0mi44xoL+UK
 MGNZkLZg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQWyu-00FnYV-9U; Wed, 15 Sep 2021 15:38:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: anton.eidelman@gmail.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: keep ctrl->namespaces ordered
Date: Wed, 15 Sep 2021 17:37:51 +0200
Message-Id: <20210915153751.1457173-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Various places in the nvme code that rely on ctrl->namespace to be
ordered.  Ensure that the namespae is inserted into the list at the
right position from the start instead of sorting it after the fact.

Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
Reported-by: Anton Eidelman <anton.eidelman@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7efb31b87f37a..3894a8508065d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
-#include <linux/list_sort.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pr.h>
@@ -3714,15 +3713,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	return ret;
 }
 
-static int ns_cmp(void *priv, const struct list_head *a,
-		const struct list_head *b)
-{
-	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
-	struct nvme_ns *nsb = container_of(b, struct nvme_ns, list);
-
-	return nsa->head->ns_id - nsb->head->ns_id;
-}
-
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
@@ -3743,6 +3733,22 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+/*
+ * Add the namespace to the controller list while keeping the list ordered.
+ */
+static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
+{
+	struct nvme_ns *tmp;
+
+	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
+		if (tmp->head->ns_id < ns->head->ns_id) {
+			list_add(&ns->list, &tmp->list);
+			return;
+		}
+	}
+	list_add(&ns->list, &ns->ctrl->namespaces);
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -3793,9 +3799,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
-	list_add_tail(&ns->list, &ctrl->namespaces);
+	nvme_ns_add_to_ctrl_list(ns);
 	up_write(&ctrl->namespaces_rwsem);
-
 	nvme_get_ctrl(ctrl);
 
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
@@ -4083,10 +4088,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
-
-	down_write(&ctrl->namespaces_rwsem);
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	up_write(&ctrl->namespaces_rwsem);
 }
 
 /*
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
