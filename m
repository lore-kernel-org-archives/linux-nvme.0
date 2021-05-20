Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E462C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415C361004
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415C361004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qzfnP3AMKfnZGRYCSGtFUSteDOvOaVkY2Xg7oicoHCo=; b=fLJTlLr1kiPm5uu9qF+kmoLvY
	WhDBaWQ/BVwrTN3/vrh1/WKOi54Ga5TUBEJfp5TWzl0BJ60CpTQ2crhU7HWd4dxEncuXBLt1q6UpB
	Myc63xdepqwA38LBwIRghkJP6SG1aYAxWjikpORNyJ+Wk9dM+M3ECwCtNKvvcvotZwBbEqj1RNMP+
	qb3e05I/A+muHs5PMVqan2pxMBw2176Td26VhvvbIRI5HSLTwMT3BjRvGBVHJcP0k7QyjWAUSeIYY
	+tvq5uAC6IdkUXuNcYVuEC68Qcm/0WpBUQIl50hXdoRt4kHR8B19FfCfYiptSpkKxsOqBEtFu0eI2
	PEC1TvR4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbUP-005ygr-JU; Thu, 20 May 2021 05:44:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU4-005ydR-B4
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rgl+l7Gzb166oxmREbnVtfkMVh0QpFLrkzYo2NJE4yI=; b=lSkYP39CbM2RlaG+9cSj9lz+bz
 FU4LxuVKYnI+0TEy+5ovk0BwabRGFRkSsc3p2R5+SR/+lDTLMs6R9P3IXJKVmno2rWrkr3aR+E9vC
 aFpkjaUCj36r0xFzypprU6eATaNBsloAvfwvubuw2BH4qQlvvzF9ZZxuxAngmGtjNoYUt8AY8wUch
 RqsXxL0n64qGAr3u/rUP4Bv7JGUIlh3zhscAWEazbyzFl+NGbnTVWT2egqorl/eBCtB6+GC1XSHVc
 iE+V4kUJkPGhexKlR4mdL32rYEtDWcRLKjn3KPJD8ZpQsQkkz3ZFJk7SHpGEZQbjgwnt26iBeAX9H
 YRvoTqTQ==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU2-00FxMI-Nc; Thu, 20 May 2021 05:44:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/7] nvne: open code nvme_{get,
 put}_ns_from_disk in nvme_ns_head_ioctl
Date: Thu, 20 May 2021 07:44:21 +0200
Message-Id: <20210520054426.567241-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
References: <20210520054426.567241-1-hch@lst.de>
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

nvme_ns_head_ioctl is always used on multipath nodes, no need to
deal with the de-multiplexers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 0341767ff2e7..3f84bd3b9259 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -387,14 +387,15 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	struct nvme_ns_head *head = NULL;
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
-	int srcu_idx, ret;
+	int srcu_idx, ret = -EWOULDBLOCK;
 
-	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
-	if (unlikely(!ns))
-		return -EWOULDBLOCK;
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (!ns)
+		goto out_unlock;
 
 	/*
 	 * Handle ioctls that apply to the controller instead of the namespace
@@ -402,12 +403,11 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
-		ret = nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
-	else {
-		ret = nvme_ns_ioctl(ns, cmd, argp);
-		nvme_put_ns_from_disk(head, srcu_idx);
-	}
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
+	ret = nvme_ns_ioctl(ns, cmd, argp);
+out_unlock:
+	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
