Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE014C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50IOrkwRZ9IMcXg6LPwVhmVaN9YoFH2odmRUtJdVPNA=; b=GtWGqyblVwgDjQdAG2LfYZcNnr
	Gcv1X+7rfJIXLgjNOLULBeedQQSB7YPO037+xx+DQCDNQRbjPqjfw5wUWBYEnHe5O6nwJY9mErTDc
	GPQFd8oQ2SSnmunu94b1N9pseTgpuyFvMDg7JgOVJRmxIC3p+ZS6DnP0lDtOwLegWKppU07mRQ7mS
	3KwW72/3hTee3E1k5odir6DDeqLEkratFRSTWYvTYCAgJDntSU742w4lNQ+AcQFGux36d4up8iTmz
	SwIOOo/LGCGCXb3sdl5ZX9nyAokY2oiL9e8tVKQWGvhT/cfxmyeKDHXtfjzk0fd5xnK8Txa6aZ4dA
	2MisEk6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJXUn-00ECuj-Gm; Mon, 14 Feb 2022 09:18:09 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJXKc-00EAIs-E8
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:07:40 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 az26-20020a05600c601a00b0037c078db59cso5903232wmb.4
 for <linux-nvme@lists.infradead.org>; Mon, 14 Feb 2022 01:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=50IOrkwRZ9IMcXg6LPwVhmVaN9YoFH2odmRUtJdVPNA=;
 b=UgODQwb3zZnAlHPSdu6PK4/oX/DCmmkATp7o6xDKETND0/GGh5vl8UnbWm6GSpjnrQ
 qvt0jn7RUAaO9Y5ZiJxW0O/Tme8enhu88fExTH2CrHZPDP+BiZNys5w2VUyTrfcgRMHU
 9bWAQi/C6GLPWc4DRdtpVvtUSr16iAZ79cqPXjJt47we+oWMTLalkyFF6k6W8ZzAjeBi
 ZN7Q9X7lFbCYlw/eplsVl6WwSRR+pBTErJomRkfkRyexpUqgEcJW+K3/hZ3OUz59nAss
 i8zeqUhThUZj44IGtHkAUVT0Vzb3o3spv0c9gGQxAR1hcCRyiC9UEP2TAjU54kGFGTXH
 Ua9g==
X-Gm-Message-State: AOAM531KC3G5m0RjQbqZkvIntZonEhwZThdKQO/y3M+Y6mp48qi7Obvh
 KnlFy5eq20aoF+XWp9jBtNZ22IKl9Aw=
X-Google-Smtp-Source: ABdhPJz3qhiWsCGML9/8HJ7EMJk4wom2NOf6SnkF0M0RKg0hjSE4CGXz0jO9nBS0IqLvJIyzHDw7Hg==
X-Received: by 2002:a05:600c:2d86:: with SMTP id
 i6mr10051262wmg.130.1644829655986; 
 Mon, 14 Feb 2022 01:07:35 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h4sm34595498wre.0.2022.02.14.01.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Feb 2022 01:07:35 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 2/7] nvme: replace ida_simple[get|remove] with the simler
 ida_[alloc|free]
Date: Mon, 14 Feb 2022 11:07:27 +0200
Message-Id: <20220214090732.479193-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214090732.479193-1-sagi@grimberg.me>
References: <20220214090732.479193-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_010738_513787_71CEE951 
X-CRM114-Status: GOOD (  13.19  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ida_simple_[get|remove] are wrappers anyways.

Also, use ida_alloc_min with the ns_ida as namespace
enumeration starts with 1.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c11cd3a814fd..84c5f84d7a8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -561,7 +561,7 @@ static void nvme_free_ns_head(struct kref *ref)
 		container_of(ref, struct nvme_ns_head, ref);
 
 	nvme_mpath_remove_disk(head);
-	ida_simple_remove(&head->subsys->ns_ida, head->instance);
+	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head);
@@ -2565,7 +2565,7 @@ static void nvme_release_subsystem(struct device *dev)
 		container_of(dev, struct nvme_subsystem, dev);
 
 	if (subsys->instance >= 0)
-		ida_simple_remove(&nvme_instance_ida, subsys->instance);
+		ida_free(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -3616,7 +3616,7 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 
 static void nvme_cdev_rel(struct device *dev)
 {
-	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
+	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
 }
 
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
@@ -3630,7 +3630,7 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 {
 	int minor, ret;
 
-	minor = ida_simple_get(&nvme_ns_chr_minor_ida, 0, 0, GFP_KERNEL);
+	minor = ida_alloc(&nvme_ns_chr_minor_ida, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
@@ -3693,7 +3693,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head = kzalloc(size, GFP_KERNEL);
 	if (!head)
 		goto out;
-	ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
+	ret = ida_alloc_min(&ctrl->subsys->ns_ida, 1, GFP_KERNEL);
 	if (ret < 0)
 		goto out_free_head;
 	head->instance = ret;
@@ -3732,7 +3732,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
 out_ida_remove:
-	ida_simple_remove(&ctrl->subsys->ns_ida, head->instance);
+	ida_free(&ctrl->subsys->ns_ida, head->instance);
 out_free_head:
 	kfree(head);
 out:
@@ -4431,7 +4431,7 @@ static void nvme_free_ctrl(struct device *dev)
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
 	if (!subsys || ctrl->instance != subsys->instance)
-		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+		ida_free(&nvme_instance_ida, ctrl->instance);
 
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
@@ -4490,7 +4490,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		goto out;
 	}
 
-	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
 	ctrl->instance = ret;
@@ -4531,7 +4531,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
-	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+	ida_free(&nvme_instance_ida, ctrl->instance);
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
-- 
2.30.2


