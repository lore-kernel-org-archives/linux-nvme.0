Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929EC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:04:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C661561426
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C661561426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=16bPNgHycBEZD+TF6hPgx/1LH3QohuqSsyaEDYd0KkA=; b=fpNV5cWyxCsqEfozdFzoVWw8f
	d9/KWxmhI/TAuobyf0DHMZT3x3JOkpb5XnKNrvmcsGdsGA5F3uz2jadDPsFJOCQqaOP3gMPFKQmWf
	zXMBGE5+wsT9eL2Sc1yPY53xQDOO7mtTTRh26oHzdFiD3VxIY9l10fVG+KVkr6ZLEaE1UNKC1I0uP
	UzEvJO16Mco7aDyfLsjybMFm8AOuxkZhXusKHJlXEel2WC/t0Vga311AXi6tSVe/LVWhz2JhnIVC+
	37EMv+iT79Uxvf7CTa//iIOcA+LM6XBNOORwHktYfVQfOcke1TO55IY/jfKYuitI0waA6WkV16jbB
	YjljJYapg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZUK6-00GCOo-L2; Thu, 22 Apr 2021 08:04:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUJu-00GCNW-Ph
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 08:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=YWlC62c7DAz/I22X4+XvXG26Dc5RGWxSDd7vd4SoMS8=; b=zpPemaUPK/2wEocdFyBwaNM+nM
 m+kC2USRyXQL5lifqSSbRVJ7EoJ2G3kHaGHJaAPQZm5mVlm7dHGZA4kO8xuZp3yGDpQ+4EY+iAvOk
 9kZOXzQY6pY6vJLZ48PenZe3f71P3GGJE1IK6uCtOpUreN3OdKiTT0sD54PkP2kEqthaxLf5qcVSF
 3KkSBXWZHwv9DFznvE9ygt9R/eWt87GwE9bV6yDXggkCZqxiKGH1i+iUY6qqMxitP4ELMEp9YCEPj
 kx1WDxwzlkcGN6EVnmJQGLX+WCUVsFx2i403xwZRGNp8KE319p2pFwnv4qWlmh5/tZdviX0zmdKcS
 rzHhSMVw==;
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUJs-00DTTy-2M
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 08:04:17 +0000
Received: by mail-pl1-x635.google.com with SMTP id p16so19161705plf.12
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 01:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YWlC62c7DAz/I22X4+XvXG26Dc5RGWxSDd7vd4SoMS8=;
 b=nECFGkUnuMA97cO4jFw6MkWT0VTZ+D++wHKToxONZChi9Szu0DRsAc+OXs8JNw4RTh
 HUBuC9wkFhKagZnlolDThR07Bl7gWSoMFTw806cO72Y4IO01F7LdR1rpo3YrbgMwv0Co
 KBq0oH1pgFRT7e6za0KODFWwtfpLo1CL5EOd8l2sK3+QK5RuI6p6MFcFarSjbiU8nMFU
 mnBSN26kWaPWgDEwiCIlzhWBZgggaM4LUSITIl7ReGySWIRIvgwEJYapvrdB2HMs5aZr
 MskzCQAUxcWldfh34Ge9sZ8oKaZndUTNOFMvIBLBBIiGZNyMTLs9HE3vOMwIaHSfoe6R
 luIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YWlC62c7DAz/I22X4+XvXG26Dc5RGWxSDd7vd4SoMS8=;
 b=Q3BjmxvhWPJJMaR0U3i7erd9w5l1PE1Zt/mz4O4h5gcVAATNxYdKErqApJ9+rnWA0R
 1uVNsSDszmv4cs5CSuTXOCPsP0fZOIWFKEzzSqjq3zG5cplsvfSRohwWZ6OmObX7G6kP
 aDQ+5kkRJ1qD5crs32kPg7X+hVKQaZznug1Y7QsdXHyQ6iHJf6RzDujSIHc6GqyRmn3G
 9Z8LScLR6G0ijrSntMl+k+nnchsbVa38fumT3L103D6xL13E6JmeT/zl5I22Z4UULSrp
 0bGgruPMDNo/vGPy5FZvqi+2Wrcoj8ZeJezshDL4Mu0m3SYHDFcDM0cgymIP5fqMGhuy
 iWCg==
X-Gm-Message-State: AOAM530oDHSpauVGbwAXu46KTKIIJc5RocUVbmRa7iH6lw5krcG0ghQJ
 VCWi6z1vR4bNo6M0wZIEXehQ1D3VdxNLBQ==
X-Google-Smtp-Source: ABdhPJxTAoYimA8HjXLsvkFjs2ZYJPoSx1lU4cBtpyEFS9US/5JTn2qcLZTdqyIb3NfG5Y3aouZ3SA==
X-Received: by 2002:a17:90a:f298:: with SMTP id
 fs24mr16309541pjb.176.1619078654717; 
 Thu, 22 Apr 2021 01:04:14 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id l35sm1447139pgm.10.2021.04.22.01.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 01:04:14 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V2 1/1] nvme: fix controller ioctl through ns_head
Date: Thu, 22 Apr 2021 17:04:07 +0900
Message-Id: <20210422080407.62999-2-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422080407.62999-1-minwoo.im.dev@gmail.com>
References: <20210422080407.62999-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_010416_133648_81F1ED0E 
X-CRM114-Status: GOOD (  21.94  )
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

In multipath case, we should consider namespace attachment with
controllers in a subsystem when we find out the live controller for the
namespace.  This patch manually reverted the commit 3557a4409701
("nvme: don't bother to look up a namespace for controller ioctls") with
few more updates to nvme_ns_head_chr_ioctl which has been newly updated.

Fixes: 3557a4409701 ("nvme: don't bother to look up a namespace for
controller ioctls")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c  | 22 -------------
 drivers/nvme/host/ioctl.c | 65 ++++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h  |  1 -
 3 files changed, 41 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f45e8fcdd7c..f6db097ad776 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2009,28 +2009,6 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-#ifdef CONFIG_NVME_MULTIPATH
-struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
-{
-	struct nvme_ctrl *ctrl;
-	int ret;
-
-	ret = mutex_lock_killable(&nvme_subsystems_lock);
-	if (ret)
-		return ERR_PTR(ret);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (ctrl->state == NVME_CTRL_LIVE)
-			goto found;
-	}
-	mutex_unlock(&nvme_subsystems_lock);
-	return ERR_PTR(-EWOULDBLOCK);
-found:
-	nvme_get_ctrl(ctrl);
-	mutex_unlock(&nvme_subsystems_lock);
-	return ctrl;
-}
-#endif /* CONFIG_NVME_MULTIPATH */
-
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 {
 	unsigned long timeout =
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 502f8e4a2a1f..9557ead02de1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -370,41 +370,45 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_NVME_MULTIPATH
-static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
-		unsigned int cmd, void __user *argp)
+static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
 {
-	struct nvme_ctrl *ctrl = nvme_find_get_live_ctrl(head->subsys);
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
-	if (IS_ERR(ctrl))
-		return PTR_ERR(ctrl);
-	ret = nvme_ctrl_ioctl(ctrl, cmd, argp);
-	nvme_put_ctrl(ctrl);
-	return ret;
-}
+	nvme_get_ctrl(ns->ctrl);
+	nvme_put_ns_from_disk(head, srcu_idx);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
 
-static int nvme_ns_head_ns_ioctl(struct nvme_ns_head *head,
-		unsigned int cmd, void __user *argp)
-{
-	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
-	int ret = -EWOULDBLOCK;
-
-	if (ns)
-		ret = nvme_ns_ioctl(ns, cmd, argp);
-	srcu_read_unlock(&head->srcu, srcu_idx);
+	nvme_put_ctrl(ctrl);
 	return ret;
 }
 
 int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	struct nvme_ns_head *head = NULL;
 	void __user *argp = (void __user *)arg;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
+	if (unlikely(!ns))
+		return -EWOULDBLOCK;
 
+	/*
+	 * Handle ioctls that apply to the controller instead of the namespace
+	 * seperately and drop the ns SRCU reference early.  This avoids a
+	 * deadlock when deleting namespaces using the passthrough interface.
+	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(head, cmd, argp);
-	return nvme_ns_head_ns_ioctl(head, cmd, argp);
+		ret = nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+	else {
+		ret = nvme_ns_ioctl(ns, cmd, argp);
+		nvme_put_ns_from_disk(head, srcu_idx);
+	}
+
+	return ret;
 }
 
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
@@ -414,10 +418,23 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	struct nvme_ns_head *head =
 		container_of(cdev, struct nvme_ns_head, cdev);
 	void __user *argp = (void __user *)arg;
+	struct nvme_ns *ns;
+	int srcu_idx, ret;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (!ns) {
+		srcu_read_unlock(&head->srcu, srcu_idx);
+		return -EWOULDBLOCK;
+	}
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(head, cmd, argp);
-	return nvme_ns_head_ns_ioctl(head, cmd, argp);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+
+	ret = nvme_ns_ioctl(ns, cmd, argp);
+	nvme_put_ns_from_disk(head, srcu_idx);
+
+	return ret;
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 773dde5b231d..c1e086a0bc3f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,7 +664,6 @@ struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
-struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys);
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 		const struct file_operations *fops, struct module *owner);
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
