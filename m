Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8494C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:20:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DABE61041
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DABE61041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ioN/HrMRD2DstQyiYTNOYDKaYmCWFQEXDeryoqN2xpk=; b=VYlzsjKYLRhiFyfrH1h38h+8f
	IYY3TJSzoB9H8AgahqBQLweWGyEEVYWEg31kTHxl1duNlrNkujv5v2TnZTM18hIbEIHpq2ipe5kDc
	B3ItNux7HOOsjJPat92MMWVjROk7LHOgaGL0RFFJKFiqkME/jtXg0FwY/dY/Uq7Xg8GRz5Z7dLBFv
	abI75J2uaLIvt6AQs3mIkVBFIGAKyquZYr7FNqLPjaR/fuKKL41Teu/yA/XH1qS9V3o9uboL5VCYC
	QsZAVbyqeqJTShJq1FzFAAmxxuds8YSEdvxjU93f/TvvsBFroeGPF7GVV+ctPri6ZiteO6p9RnssA
	cFy4iV/Qw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTeN-007xW5-49; Thu, 08 Apr 2021 12:20:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdg-007xLi-8f
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Yy+SC6LSfeM+SzhsNnzDfJQVUZn2pW/CEqxyxD60LHI=; b=2yPHcrUtJrxgPsgd0pBzCjV1ii
 zIm02z1/u4jsddenzPU9YXx2jTZnDbK2YNVYfPLbMfNmJqhPK+OY3noJOcsI2gPYp0WpxtogC9Ov8
 g/1XrLU2DG/HJ4NdgpGT08y/iN3MclduMRRfLQxT+94MKi/2sd9jHpZdBVYZ0Na7eYNMSXFQFcRVE
 XhXJIyUvayc3AGxqEQE29VRbvlznMbsNnAp5LKf36TbSAQx5PbFqxNFO3LmNQjpEXTvEoshDny7hK
 aNFBRyksA8nFZBYD5JApKvOZ37LYRoaUJbM9p+I5v0GpOo3/hOyC3sx8cUPu7KLZwkv3nDg0Dz59p
 SXfPqTCw==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTda-00HATo-Vd; Thu, 08 Apr 2021 12:19:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 07/13] nvme: don't bother to look up a namespace for
 controller ioctls
Date: Thu,  8 Apr 2021 14:08:36 +0200
Message-Id: <20210408120842.1450092-8-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Don't bother to look up a namespace just to drop if after retreiving the
controller for the multipath case.  Just look up a live controller for
the subsystem directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 66 +++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index edf7d7fc8e4bbb..75e230dcbfef06 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2336,42 +2336,60 @@ static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
 	nvme_put_ns_head(disk->private_data);
 }
 
-static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+static struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_ctrl *ctrl;
 	int ret;
 
-	nvme_get_ctrl(ns->ctrl);
-	nvme_put_ns_from_disk(head, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = mutex_lock_killable(&nvme_subsystems_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->state == NVME_CTRL_LIVE)
+			goto found;
+	}
+	mutex_unlock(&nvme_subsystems_lock);
+	return ERR_PTR(-EWOULDBLOCK);
+found:
+	nvme_get_ctrl(ctrl);
+	mutex_unlock(&nvme_subsystems_lock);
+	return ctrl;
+}
+
+static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
+		unsigned int cmd, void __user *argp)
+{
+	struct nvme_ctrl *ctrl = nvme_find_get_live_ctrl(head->subsys);
+	int ret;
+
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+	ret = nvme_ctrl_ioctl(ctrl, cmd, argp);
 	nvme_put_ctrl(ctrl);
 	return ret;
 }
 
+static int nvme_ns_head_ns_ioctl(struct nvme_ns_head *head,
+		unsigned int cmd, void __user *argp)
+{
+	int srcu_idx = srcu_read_lock(&head->srcu);
+	struct nvme_ns *ns = nvme_find_path(head);
+	int ret = -EWOULDBLOCK;
+
+	if (ns)
+		ret = nvme_ns_ioctl(ns, cmd, argp);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
 static int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	struct nvme_ns_head *head = NULL;
-	void __user *argp = (void __user *)arg;
-	struct nvme_ns *ns;
-	int srcu_idx, ret;
-
-	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
-	if (unlikely(!ns))
-		return -EWOULDBLOCK;
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 
-	/*
-	 * Handle ioctls that apply to the controller instead of the namespace
-	 * seperately and drop the ns SRCU reference early.  This avoids a
-	 * deadlock when deleting namespaces using the passthrough interface.
-	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
-
-	ret = nvme_ns_ioctl(ns, cmd, argp);
-	nvme_put_ns_from_disk(head, srcu_idx);
-	return ret;
+		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
+	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
 }
 
 const struct block_device_operations nvme_ns_head_ops = {
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
