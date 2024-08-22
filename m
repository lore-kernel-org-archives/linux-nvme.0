Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74245C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=; b=T4dKSbwusXVMhEQom+XQpQLJOh
	iix36i0PVEm/a+yCb7vrbzxQBPOarDzYVmBr1R99MZyB3lgREt/TrX2dtBADfZ4eEdvN0XFn7k1RW
	Dsh2jyk24bbO6cbyhBWlymMv0m0KBNNw8/13/yB3BEzqEMVxsfX1dKpCYUFbihgj2eMaaEa7AagkI
	Y3X9I3ueDCsNYYc+4FHk3JsVgvI/KZXp1hmlDFiYzSKawSMVEhwob/NxmorQ8FvJmDJAEKl9+lPSv
	bpCkgtd1wjaLIM7Bi2JypldbqmQvYOSVrK6eFEngR0zyqi3xdKqGumMvORRTubpXG8BiVExMqRY+S
	oeulXI+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCh6-0000000DyES-0Ndo;
	Thu, 22 Aug 2024 18:38:00 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shCgz-0000000Dy99-2Dn0
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 18:37:54 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-201ed196debso10602475ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351873; x=1724956673; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=;
        b=gLCQ9w+h98lgLcYGKyjc17PpceEc2CC28fcZL8ArcmMD30jfrjpZITWqB4HPKma9m2
         obr4uXKDUC59DHWvXTsub+iB+at8n3LYVrqQ/fZKgRSzrVQaWXl8VwLrPAksiaN++JGF
         zYVf67VP0OZ4rECkNWTylE7NBJOvfyhH54Sx6kA3bs9AJzcW1O3JBFhfaPELbrMkQGN0
         gX6ZTE2jqVGveJ4PcRLfoNX4AAMMYWQ0DTiAmJ+PapaiF0KLjL9jOJQsRDOXgQaRNIJP
         lWuj9sL0UeNTbPzqzYs4KwrEQHQQL3xPk6cTKVtkrWuyPBht7ShLRcjSENXPivjP4AgO
         JrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351873; x=1724956673;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/YtNwLPh5pTk6gSo6t/PeLiCmJLTlpJ+ybh0IcUxoY=;
        b=ob6VWYPrwl6gLwo1eEIqu5JZUkWsmQzXEgaQNZvVZPyyZPL+13mKdM9NuVKdfmjOTS
         p4YX/hUYxUCHqCUwsm+wVYcfeqNGDX76azMTF8a+ucdjP2i3o96XOHuApofxkQcjKdv7
         aO8ndg9J2uFhJvjdaQ1HRQJ+hryZTyqOst/Nv5H87HzKl4TdeXIFxtLUMtHnqPxgc5O0
         iltPtr8A7Wbpo6rTAkqBfnfeHkzvCfSUaQh8aNIlyC4pFjbGqsEKY1iqUQF4IRwZlSn5
         wZjGKWeHgKu8am2a7VkXFxwVHsNarG4srg65zRpc6JAbsgAnnorG3r3Zwhrz/asd2Nk/
         umyw==
X-Forwarded-Encrypted: i=1; AJvYcCUoLFY3GItIRlcb67SJha3LVGz9MJZu1wLiQfgRSe1RNtplrjE0TRuHffk8SXbHIlHRs79lgrzgID8Z@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0dC4KkIOiFUqYJGVH2tur4gqfSOL5PuAylgHko+0qZg3q7+U0
	mr4DpdGevadki+t5ZYFuivSFAavElpsLiP5OrEB2y0EVePprQ8qk
X-Google-Smtp-Source: AGHT+IHsbZYUaJ+JFNxFtzKvzmApZirKvGrVSmexHXzuMk4WrKRW/BVna5OKSIa9Rz2aGy+9FiDPnQ==
X-Received: by 2002:a17:902:e84a:b0:202:1529:3b01 with SMTP id d9443c01a7336-20367e651d0mr80002225ad.39.1724351872813;
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e4f9sm15667145ad.65.2024.08.22.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:37:52 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robin.murphy@arm.com,
	hch@lst.de,
	m.szyprowski@samsung.com,
	petr@tesarici.cz,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [RFC 6/7] nvme: Move BLK_MQ_F_BLOCKING indicator to struct nvme_ctrl
Date: Thu, 22 Aug 2024 11:37:17 -0700
Message-Id: <20240822183718.1234-7-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_113753_636278_0F084967 
X-CRM114-Status: GOOD (  15.89  )
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
Reply-To: mhklinux@outlook.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Michael Kelley <mhklinux@outlook.com>

The NVMe setting that controls the BLK_MQ_F_BLOCKING flag on the
request queue is currently a flag in struct nvme_ctrl_ops, where
it is not writable. A new use case needs this flag to be writable
based on a determination made during the NVMe device probe function.

Move this setting to struct nvme_ctrl, and update the only user to
set it in the new location.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/nvme/host/core.c | 4 ++--
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/tcp.c  | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33fa01c599ad..f1ce325471f1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4495,7 +4495,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
-	if (ctrl->ops->flags & NVME_F_BLOCKING)
+	if (ctrl->blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size;
 	set->driver_data = ctrl;
@@ -4565,7 +4565,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
-	if (ctrl->ops->flags & NVME_F_BLOCKING)
+	if (ctrl->blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
 	set->cmd_size = cmd_size,
 	set->driver_data = ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae5314d32943..28709f166cab 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -338,6 +338,7 @@ struct nvme_ctrl {
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
+	bool blocking;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
@@ -546,7 +547,6 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
-#define NVME_F_BLOCKING			(1 << 2)
 
 	const struct attribute_group **dev_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ea6be0b0392..6b9fdf7dc1ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2658,7 +2658,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.name			= "tcp",
 	.module			= THIS_MODULE,
-	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
+	.flags			= NVME_F_FABRICS,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
@@ -2762,6 +2762,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (ret)
 		goto out_kfree_queues;
 
+	ctrl->ctrl.blocking = true;
 	return ctrl;
 out_kfree_queues:
 	kfree(ctrl->queues);
-- 
2.25.1


