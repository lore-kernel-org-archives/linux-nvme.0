Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C75C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 13:13:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF5E6144B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 13:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF5E6144B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HSInxQoTYesAoHVFy7avIhEeN4GA4HnrCQiFQXOK/Z4=; b=hcxa2o3y1Jkmj8k6fUnqwGFkV4
	gQYc+1zzzxGjxiTNHN6YwQARo1xsItwOl5s4VjuB5hm7V7YFKsUuPRJGhoAbUojg6BAyy5aFTe+Mk
	9HV//GeKuTNmJ6hicU3esr8fDKX4jm33CiCo5hw95p9LnO1TL7yVe7d2yt9+yEPrUkQJ+dFfkZUg6
	J+I51lcOThVMFn33XKDsnCTWwQlbVLBlU4x9w2usB44w+pW0gYGrAtE/9vkqWZT5Aq1ZTCdRTa31N
	c2RsNs5DKIVFFZmE+kXvYwhDOabPoptiTPh0v4zznnhqslUYPgTvQ3lDBCQoCmnRrqhaLochZwqgu
	8BNz5akQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZCfR-00EQvg-Fd; Wed, 21 Apr 2021 13:13:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZCfB-00EQvN-Dh
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 13:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=nVBqbptXQmYnHipc+jr54QqM7MJybMw44HxavTTGXT4=; b=wzF7b97ylDWieEW6sWTvAJIuWK
 u7Z4ewYj/QorizoN+skktlEpHK3ibsmwrHRu7wnHQPDrO55qu5TJ9MNs/3rlXRlEyFMGU3OJJ6Hl1
 oxEaqrrSRpr20SjJkkzuBXXQ7w5ugW/YxCmB8hGVq8qVPakpjeIUe9GmDqf3ZMhqU4CCCDF4XAXOq
 ZOPQSIuU1b/GQgVBYFMjIiL9d3dkrvhHSbAaZrYi+7dS/yJHeOquMN/ltDEC+yoAdMrSZXox3yQtg
 j05VkRfqmkIvGjBrutaTj31sQMtK5MmwRulq0pqOQAMRfly4PlhjUKPFLrFjwlv9hGNHarYpFaQXI
 LJOg9UCw==;
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZCf5-00CtxT-SH
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 13:13:04 +0000
Received: by mail-pg1-x52e.google.com with SMTP id z16so29757224pga.1
 for <linux-nvme@lists.infradead.org>; Wed, 21 Apr 2021 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nVBqbptXQmYnHipc+jr54QqM7MJybMw44HxavTTGXT4=;
 b=YHJaPAAcAILVzgSDXx5O0VdKkIgZRp36Deh9g8V8vMP1D9h3Vr3cLkpbCBsoHIj//G
 /xyycegODscApHNgeWpPrY6dV+eyNAQXiCWocb2ogkZt56YFBsqVSPLanyBVHvm9pKWs
 DZ5F+gYyBC4FMhQhEDT0B8LseEMdPkEHRaBDJ4zcxTKPUumX74eUnl44wzAP2r+NYjHy
 0RBLlGpXRox8vvg09OQntYA9CFdxy3xT8z1v/PbjhVBSYy3onIkKcnT3gJKTHRhRFfo8
 0UPuAwap0z4gGgBoJvRvqRxiK9z0p6jJIMVVV5v7psUj105pmCT7ZvhDyWEOr4jxSnbl
 dzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nVBqbptXQmYnHipc+jr54QqM7MJybMw44HxavTTGXT4=;
 b=sMSja66W2MC0rmXq7DP21xShHwNilz70b2cNVAT2HsFnjmGvKYFsEXGvKsGxtKLRZu
 ReJh81s/e3gabNUCFPWeW1GneUTdFCbq6jwk+zLhhdWwo1WjvknrrkplDRbpWz2iTxAY
 fGFD+YFUwU+BsKDrLpbnibBdknt2GKXZHqRyEbXBkXVWS8lG2cNpwRz/tiVZvrSqzYeT
 PuuOWGpaHnZAU293ISj4vP82x25bTT3bDxkViTeBWgYoa8N4jLI1G8SmWdh5AgthH2+/
 4BZv/X9ofcLV+VBLfgAwAtgHCti56jimcxhOQHHGaiDwuMrbQmmKO+HciguzO++KfEFk
 iuPQ==
X-Gm-Message-State: AOAM533rcwqpdT2FLH/FP9+SWMmYWjrSvv2NtL42NTrjJqnVq2sxX8b5
 P2G+bZb3Q8H0RxfiMKGtzFznRXPKp9rf4w==
X-Google-Smtp-Source: ABdhPJxC1CQGhGY5f9jnhu/Jow8tSb7xVhHmX93gAYCJDj81muPhQhVRgCoAqR930S5I/cViI+R7Wg==
X-Received: by 2002:a05:6a00:b41:b029:261:fc0f:15f7 with SMTP id
 p1-20020a056a000b41b0290261fc0f15f7mr11882753pfo.30.1619010778454; 
 Wed, 21 Apr 2021 06:12:58 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id a1sm1849204pfi.161.2021.04.21.06.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 06:12:58 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] nvme: fix to find live controller based on namespace
Date: Wed, 21 Apr 2021 22:12:50 +0900
Message-Id: <20210421131250.105796-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_061259_953064_93E678BD 
X-CRM114-Status: GOOD (  20.51  )
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

If application issues admin command to the namespace head block device,
it will try to find out live controller instance inside of the given
subsystem without considering namespace attachment.

For example, Let's say we have ns1 and ns2 in the nvme-subsys subsystem.
Both are attached to the controller nvme0, and nvme1 controller has
ns2 attached in multipath case:

  nvme-subsys (instance=0)
    nvme0
     nvme0n1
    nvme1
     nvme0n1 nvme0n2

if we issue an admin command to nvme0n2,

  nvme id-ns /dev/nvme0n2

It might return all-zero as spec because nvme_find_get_live_ctrl() will
find out the controller instance regardless to namespace attachment,
which means it will find out the nvme0 instance first.  Then command
will be issued to nvme0 with nsid=2 which is detached.

In this example, the following two commands should have same result:

  nvme id-ns /dev/nvme0n2
  nvme id-ns /dev/nvme1 -n 2

But, the first one is heading to nvme0 controller, not nvme1.

This patch fixed nvme_find_get_live_ctrl() function by refactoring
nvme_find_get_ns() into two parts: find and get. The name of
nvme_find_get_live_ctrl() function may sound like it will return
live controller instance from a subsystem, but we don't have more
callers other than this use case, so keep the name and make it receive
`nsid` to consider namespace attachment.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c  | 43 +++++++++++++++++++++++++--------------
 drivers/nvme/host/ioctl.c |  3 ++-
 drivers/nvme/host/nvme.h  |  6 +++++-
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b905f91f14eb..98a4a1b19b13 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2005,8 +2005,27 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
+static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+{
+	struct nvme_ns *ns, *ret = NULL;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (ns->head->ns_id > nsid)
+			break;
+
+		if (ns->head->ns_id == nsid) {
+			ret = ns;
+			break;
+		}
+	}
+	up_read(&ctrl->namespaces_rwsem);
+	return ret;
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
-struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
+struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys,
+		unsigned nsid)
 {
 	struct nvme_ctrl *ctrl;
 	int ret;
@@ -2015,7 +2034,7 @@ struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 	if (ret)
 		return ERR_PTR(ret);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (ctrl->state == NVME_CTRL_LIVE)
+		if (ctrl->state == NVME_CTRL_LIVE && nvme_find_ns(ctrl, nsid))
 			goto found;
 	}
 	mutex_unlock(&nvme_subsystems_lock);
@@ -3544,21 +3563,15 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
-	struct nvme_ns *ns, *ret = NULL;
+	struct nvme_ns *ns;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->ns_id == nsid) {
-			if (!kref_get_unless_zero(&ns->kref))
-				continue;
-			ret = ns;
-			break;
-		}
-		if (ns->head->ns_id > nsid)
-			break;
+	ns = nvme_find_ns(ctrl, nsid);
+	if (ns) {
+		if (!kref_get_unless_zero(&ns->kref))
+			return NULL;
 	}
-	up_read(&ctrl->namespaces_rwsem);
-	return ret;
+	return ns;
+
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 8e05d65c9e93..8a829200997b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -361,7 +361,8 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
 		unsigned int cmd, void __user *argp)
 {
-	struct nvme_ctrl *ctrl = nvme_find_get_live_ctrl(head->subsys);
+	struct nvme_ctrl *ctrl =
+		nvme_find_get_live_ctrl(head->subsys, head->ns_id);
 	int ret;
 
 	if (IS_ERR(ctrl))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 49276186d5bd..15bd2000991a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -657,7 +657,11 @@ struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
-struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys);
+struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys,
+		unsigned nsid);
+int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
+		const struct file_operations *fops, struct module *owner);
+void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg);
 int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
