Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E79C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:19:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9829F6115B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9829F6115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DFgyfDvqXLD1JBwuN/hByrfTBaZHU6szHrTAYGrjngY=; b=bcwhbCsGDRITd5Apy0pOM2wEa
	MrwNNYqLVZEtgQT5CAfcyPEAodxHGTczbQkVTbhiRbXb8b3z9sckxZLkgvf+AY/Vzaf//4qWxUTEY
	BZKacKSY6N0KSCpknPvA3oywE8GU1U1yB25KRXqA5D0YIQ3OI0nM/yzjEzGA8XcT7Aqa5smU1QXhJ
	xJ9UMnDtl8ThxQZv3XvqpNBSYlj0mL93O/FCArGgSzshm8KPJ5gIcFd1nE2OVy21qwqgvHIYz55Vi
	1nCstljB3dmP02a6n3H5bkU8kx0ss5+0Vzsitg3tPMOwPR/4bMdU5l9QF92Dh2glInGN7Vuig4Vhm
	N0ShluMpQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTdZ-007xKI-3r; Thu, 08 Apr 2021 12:19:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdW-007xJm-Rl
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:19:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=PiHs9n2PJ5RKY9qwThBaoHxiyzymTYBZxuASaiOXKWQ=; b=rJEh7FDgITfNVphRJx6REWEN5+
 6I0HN/RaXzKC0Jf4alwepW7jY5zElsEgpYemFVWVUTtgFkApbD53APP4Z4+AvEQV11y33jeIejvsG
 Vdbi1SU9jPkPjovU7/Rt6hNT5GfB9sNH4usdkS3O359IY86yXgtfamhzJqEFDP2kNZEIBFT+m45lK
 6e3M0lHCDTEp9FciGHaCX5AhdEJ4fFpbUQRn6Qn8ZXeZJDpPC/F4PZzDzSr/IwHafWcUcZzwruIyu
 4nNP96yPuNZIkVQo3Of1fE6l8SslLO5Ya7uJ4x9m9+7kq9tkT03lpdRxmAs5Pxa9vECKLeuEXDJDo
 JpyRkUqA==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdS-00HATI-TN; Thu, 08 Apr 2021 12:19:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 04/13] nvme: factor out a nvme_ns_ioctl helper
Date: Thu,  8 Apr 2021 14:08:33 +0200
Message-Id: <20210408120842.1450092-5-hch@lst.de>
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

Factor out a helper for the namespace based ioctls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6c0456e404319e..56fe5b9712e756 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1783,6 +1783,26 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	return ret;
 }
 
+static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
+		void __user *argp)
+{
+	switch (cmd) {
+	case NVME_IOCTL_ID:
+		force_successful_syscall_return();
+		return ns->head->ns_id;
+	case NVME_IOCTL_IO_CMD:
+		return nvme_user_cmd(ns->ctrl, ns, argp);
+	case NVME_IOCTL_SUBMIT_IO:
+		return nvme_submit_io(ns, argp);
+	case NVME_IOCTL_IO64_CMD:
+		return nvme_user_cmd64(ns->ctrl, ns, argp);
+	default:
+		if (!ns->ndev)
+			return -ENOTTY;
+		return nvme_nvm_ioctl(ns, cmd, argp);
+	}
+}
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -1803,27 +1823,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	if (is_ctrl_ioctl(cmd))
 		return nvme_handle_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
-	switch (cmd) {
-	case NVME_IOCTL_ID:
-		force_successful_syscall_return();
-		ret = ns->head->ns_id;
-		break;
-	case NVME_IOCTL_IO_CMD:
-		ret = nvme_user_cmd(ns->ctrl, ns, argp);
-		break;
-	case NVME_IOCTL_SUBMIT_IO:
-		ret = nvme_submit_io(ns, argp);
-		break;
-	case NVME_IOCTL_IO64_CMD:
-		ret = nvme_user_cmd64(ns->ctrl, ns, argp);
-		break;
-	default:
-		if (ns->ndev)
-			ret = nvme_nvm_ioctl(ns, cmd, argp);
-		else
-			ret = -ENOTTY;
-	}
-
+	ret = nvme_ns_ioctl(ns, cmd, argp);
 	nvme_put_ns_from_disk(head, srcu_idx);
 	return ret;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
