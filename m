Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60886C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:20:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D91F61106
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D91F61106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=njCo4kuvmzKdsstv0RxENOX7SHzVOgUNv8qb4dbtL3g=; b=LR5uwKeGY89oYPhXObV8TmXFI
	vPqR0oBRVvk2A+rVMunp2kcfpdgxt/0MB8PYsyfijd+Inbd8DhYY2Fk2vkiieaGgigvQ8rhy6VCjp
	C7inu6dUITR9+Ous90eyyLOtFHz4g9q/Dm5aMjD60LF2EWcx5czBIXlP9N5l2UfKyw2Qgotm5XOGe
	KQ3cK2vgcVeGbLRb9DYbHy42XEwtRPqzWNNpuOqkCCv3CSGeYF3YRGK/k7+KHRYuMhCBqSAIQ4Osz
	S0BHcUWQooSDPhzqR6BghBb1IxWnFH3wTdwUP8aHm7igpfp0f8ySeeXRc16TDbcj4o2pm7ZHJBQIH
	jY6ew2lDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTe6-007xRU-PY; Thu, 08 Apr 2021 12:20:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdc-007xKu-7z
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=oZx+a4s9KNMZaqZSIplUpTV6gRZbC1BIgHQcAniNgtU=; b=S5qR++is9JPEYFtK1sOepmew9M
 qGxwJyvwtrpmAw+M8Dr7gS4SjNdkrZos75xeiXlzI8QvGfZSovv/lZKlKzri2ugXtbVwMHvrN2hG5
 XQeuuGqMo4YAyumMkPVKMIBpYzdVHGOGppXnicOJL6szRtSx3uqGDNoQmqzycgJdDkAMV+LtF4lGL
 h6DU50v7gzNeo287567WcsKh5ktWLGYmnbpre9rtUO9G7hEI434yD5ayL9QVV0F+8PeEsvcYXvUrA
 VcqtRSvy+gdime0b5kNIkrvdWDyz0aCag3zgy3yQGkfZ6VWmyhOfK78x/lq9CEHjvR+u0roHw25Dl
 wUbiIhjA==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdY-00HATf-DZ; Thu, 08 Apr 2021 12:19:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 06/13] nvme: simplify block device ioctl handling for the
 !multipath case
Date: Thu,  8 Apr 2021 14:08:35 +0200
Message-Id: <20210408120842.1450092-7-hch@lst.de>
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

Only use the existing ioctl handler for the multipath case, and add a
simpler one that reverts to the pre-multipath case for not shared
use case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 83 +++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b80868e2539df..edf7d7fc8e4bbb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1757,30 +1757,17 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 	return false;
 }
 
-static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-				  void __user *argp,
-				  struct nvme_ns_head *head,
-				  int srcu_idx)
+static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
+		void __user *argp)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	int ret;
-
-	nvme_get_ctrl(ns->ctrl);
-	nvme_put_ns_from_disk(head, srcu_idx);
-
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		ret = nvme_user_cmd(ctrl, NULL, argp);
-		break;
+		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		ret = nvme_user_cmd64(ctrl, NULL, argp);
-		break;
+		return nvme_user_cmd64(ctrl, NULL, argp);
 	default:
-		ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
-		break;
+		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
-	nvme_put_ctrl(ctrl);
-	return ret;
 }
 
 #ifdef COMPAT_FOR_U64_ALIGNMENT
@@ -1832,26 +1819,12 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	struct nvme_ns_head *head = NULL;
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
-	struct nvme_ns *ns;
-	int srcu_idx, ret;
-
-	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
-	if (unlikely(!ns))
-		return -EWOULDBLOCK;
 
-	/*
-	 * Handle ioctls that apply to the controller instead of the namespace
-	 * seperately and drop the ns SRCU reference early.  This avoids a
-	 * deadlock when deleting namespaces using the passthrough interface.
-	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_handle_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
-
-	ret = nvme_ns_ioctl(ns, cmd, argp);
-	nvme_put_ns_from_disk(head, srcu_idx);
-	return ret;
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	return nvme_ns_ioctl(ns, cmd, argp);
 }
 
 static int nvme_open(struct block_device *bdev, fmode_t mode)
@@ -2363,12 +2336,50 @@ static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
 	nvme_put_ns_head(disk->private_data);
 }
 
+static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
+
+	nvme_get_ctrl(ns->ctrl);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	nvme_put_ctrl(ctrl);
+	return ret;
+}
+
+static int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	struct nvme_ns_head *head = NULL;
+	void __user *argp = (void __user *)arg;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		return -EWOULDBLOCK;
+
+	/*
+	 * Handle ioctls that apply to the controller instead of the namespace
+	 * seperately and drop the ns SRCU reference early.  This avoids a
+	 * deadlock when deleting namespaces using the passthrough interface.
+	 */
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+
+	ret = nvme_ns_ioctl(ns, cmd, argp);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	return ret;
+}
+
 const struct block_device_operations nvme_ns_head_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= nvme_ns_head_submit_bio,
 	.open		= nvme_ns_head_open,
 	.release	= nvme_ns_head_release,
-	.ioctl		= nvme_ioctl,
+	.ioctl		= nvme_ns_head_ioctl,
 	.getgeo		= nvme_getgeo,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
