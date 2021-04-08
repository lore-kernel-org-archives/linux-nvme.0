Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C13C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:17:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9F3610F9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F3610F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1vzlZ8xmotrDjE3JvYIvVHTG7tagWaV/int2ZOE58dI=; b=RthMnH9CF8EjLybQKktehcbH5
	lpRbDc7+O6GFrrSXzfuF5VGcDCteuOXeZkLxBT906Gd0t83nkYp8jct0kOdVlv1RpK2hRyEVZCEo0
	pbGkkUVh5q+GyH1wcARcDEKdmd/lepr0fkCZ2DveIodPmjTcRhg6pK2/FOcwA140IZxNxox33DMwF
	ho8E0FgnjRcUOMybPGZethIOGxz0Ra5bSGxIAuk9Oa+Pb6kSb63aUQ2jy3yQgdDF3lpILMIfTt4YV
	7HL6Y1fim31BiXYfBPObB1zi0omKbyipIJXmkPV5dD2lRr8b2oP5saOZs90TirCqdh2ut84wOWzVe
	F5HOF/STw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTbS-007wxM-IN; Thu, 08 Apr 2021 12:17:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTbP-007wwf-E9
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:17:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2j2l6VKcGUaLCMkpM1JWczKUZC7QjTzLc8eZVFQ0BnM=; b=NmMibSrY/QyuEsox/2xmjs/tVF
 z2iTw8P5DDyLTGM3NfcPyq2K/EK2avwdVMGUPRQ2L7bEIIFPa798vN8CZ9MeZzhsS9G697C5n0OJv
 gdnM/lqjsrUFYBYtrCHMRLRkS8g0WySlCo5c0oNP3aYVYqmq8mpNB/N/CdppSQO9e94D+mOTVJwv1
 aAHYZXVIB3dy+PsdPu0bvd7mlaj/Sv9ScPI1Mu/4/e+gzRPMJfPD2cb5RAvfwq8xq0fdbMZ71W3Kj
 XhxVZf9H4ns/yvVk5QeymE4v4A8xg5sLjuTgxpEUFHhMLLT94uI/p2z7KByfEQJ/3hSpeiTL6NBVA
 HfYbglFQ==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTbJ-00HALt-T3; Thu, 08 Apr 2021 12:17:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 03/13] nvme: pass a user pointer to nvme_nvm_ioctl
Date: Thu,  8 Apr 2021 14:08:32 +0200
Message-Id: <20210408120842.1450092-4-hch@lst.de>
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

Pass the proper user pointer instead of the not all that useful integer
representation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c     | 2 +-
 drivers/nvme/host/lightnvm.c | 8 ++++----
 drivers/nvme/host/nvme.h     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8c60ddc47b546d..6c0456e404319e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1819,7 +1819,7 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	default:
 		if (ns->ndev)
-			ret = nvme_nvm_ioctl(ns, cmd, arg);
+			ret = nvme_nvm_ioctl(ns, cmd, argp);
 		else
 			ret = -ENOTTY;
 	}
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index b705988629f224..d5ef114d2bf101 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -930,15 +930,15 @@ static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
 	return ret;
 }
 
-int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
+int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *argp)
 {
 	switch (cmd) {
 	case NVME_NVM_IOCTL_ADMIN_VIO:
-		return nvme_nvm_user_vcmd(ns, 1, (void __user *)arg);
+		return nvme_nvm_user_vcmd(ns, 1, argp);
 	case NVME_NVM_IOCTL_IO_VIO:
-		return nvme_nvm_user_vcmd(ns, 0, (void __user *)arg);
+		return nvme_nvm_user_vcmd(ns, 0, argp);
 	case NVME_NVM_IOCTL_SUBMIT_VIO:
-		return nvme_nvm_submit_vio(ns, (void __user *)arg);
+		return nvme_nvm_submit_vio(ns, argp);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ef0a355fbb4ae..70018ae2cb1876 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -799,7 +799,7 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
 void nvme_nvm_unregister(struct nvme_ns *ns);
 extern const struct attribute_group nvme_nvm_attr_group;
-int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
+int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *argp);
 #else
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 				    int node)
@@ -809,7 +809,7 @@ static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
 
 static inline void nvme_nvm_unregister(struct nvme_ns *ns) {};
 static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
-							unsigned long arg)
+		void __user *argp)
 {
 	return -ENOTTY;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
