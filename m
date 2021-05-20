Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAFCC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61635610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61635610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bdTmkXIHjB94NAHqaCMqh5OstcsaC98a8HWy2RUAw6Y=; b=IODo4FYA5t2lwOzfkexZOBYhw
	LPAdn3DCqmVUVsPp7yyg4olE5PY+9Ov9/gHF494nO6hFyrJMbyCKC2qWl7xLnBxUm6FSGMFkLqCkS
	ln7E5+wXZ7pgNScUIpGJIuLbRibyWDPa1yNkFHg9yRCvL8ci+BkJ5XQ6HKQEyCLsI7JYhjB8q8epG
	CKYLQGwRVd5uWVxCi6vH/xXykkkblgQl7jbCuwcFRiddNXeykxtMXx+vBlv53Pq4cNMY/nyRkYiDj
	ofEBhaasUQc3tq5RYAZJ2CEYB44fain3kIqrwUW84wmLJkFM/3RFIJu4s71fJrEUkRBjIoBlDEvbt
	Lh8nazBsw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbUC-005yfC-Fq; Thu, 20 May 2021 05:44:44 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU1-005yd8-TZ
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=oumGisW05rVV0n6W0nvHwHgj4/qrGHYyV0LmigTQvGg=; b=z5Nbya0GgUL2ouvMoW083pCOgL
 ZL1TsNng8KosRV42oE+58+SRRbZo4hpkQwpkZ3DnkW8CdVVHf2xaOKQFhZuSToSBAMzeexOfDxBF4
 O3mE88Gc2rpiZ54+k9G6jmFHDHNiyPwrJ1ga5PGJojTnOOy4iSv4lCNVXPfOhHra5TSD8Af4sCobo
 2Jmyk86PNq45yba+/0WiKxCTAsIrrWpnjQuXxUINluGgBAzWVu1VriqTeuJN3RpVqk3ksuKarREdp
 xAarJ2TTJBcdFGoMQnOdbehO/Yo632c79wrxKugiK3DQQI+at83cPZ7hMjPJpGzNgXjr2uaPwp39k
 p7y/Goug==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU0-00FxMD-9S; Thu, 20 May 2021 05:44:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/7] nvme: open code nvme_put_ns_from_disk in
 nvme_ns_head_chr_ioctl
Date: Thu, 20 May 2021 07:44:20 +0200
Message-Id: <20210520054426.567241-2-hch@lst.de>
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

nvme_ns_head_chr_ioctl is always used on multipath nodes, so just call
srcu_read_unlock and consolidate the two unlock paths.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9557ead02de1..0341767ff2e7 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -419,21 +419,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		container_of(cdev, struct nvme_ns_head, cdev);
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
-	int srcu_idx, ret;
+	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
-	if (!ns) {
-		srcu_read_unlock(&head->srcu, srcu_idx);
-		return -EWOULDBLOCK;
-	}
+	if (!ns)
+		goto out_unlock;
 
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
 	ret = nvme_ns_ioctl(ns, cmd, argp);
-	nvme_put_ns_from_disk(head, srcu_idx);
-
+out_unlock:
+	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
 #endif /* CONFIG_NVME_MULTIPATH */
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
