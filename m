Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3238CA550C
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 08:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LqGLJOXO5bR3TOdCilEfQtXqdvwCC4z7Oxex9EjtBO8=; b=rE8L94Zh0ZNXrGZ7hJw7rdI1QX
	6JCp3mTNxGclibfF6zVcP0P0ydjJGNm1iLlEm1V93/AB5wu8L2TyiY4JUOySxaELR+j1us9sPeZW0
	wKP/PIsYIL0SpfmiIfiPP0oc1Nr9sFnY2ByDkr/+ORznSsFX3f9PrGhKoGkZAgVMlNaNyBBgOj+Ti
	M+qLEXG08tpkszY+9dQIRJPw9tydt+hFgPYtPIonursMmMU3hpok6NXaCJzwuhPQuU7TzYXyN67d/
	roM2XfBx1zZ5LYhdlgUd3APDJmdgGcZzYsNRWgPAhCtqmbYX2xoe38XXyT9eHGphb8TJF3NcEElj6
	oVm4S+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgLOL-0058By-2f;
	Wed, 13 Sep 2023 08:38:33 +0000
Received: from m12.mail.163.com ([220.181.12.215])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgLOJ-0058AI-0J
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 08:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LqGLJ
	OXO5bR3TOdCilEfQtXqdvwCC4z7Oxex9EjtBO8=; b=YQ6g3k5/Re66qHo9slAZ1
	4QwceUzWNIqWFSJg63uHdIGdygqL6nWo7AZ6BAPIv2XeVk4LI8Py/BWZRvEysoN1
	74ugaDQCXjd4KDFE9d0xJRDLOp6GaRnzXB1nVGCJ0ewCRrgwZxHkfjE6IUEaeFUA
	iIYrTPYyTD0Ajak7JfjLYE=
Received: from localhost.localdomain (unknown [223.166.237.2])
	by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wAnln7QdAFli8i+Bw--.56942S6;
	Wed, 13 Sep 2023 16:38:00 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: ping_gan@dell.com,
	jacky_gam_2001@163.com
Subject: [PATCH 4/4] nvme-core: Get lowlevel disk for target polling queue task
Date: Wed, 13 Sep 2023 16:36:44 +0800
Message-Id: <006b6aefe94d73ee64931c769af4a908616439ad.1694592708.git.jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1694592708.git.jacky_gam_2001@163.com>
References: <cover.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnln7QdAFli8i+Bw--.56942S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4UWF48ZryrKw47Cw4xtFb_yoW8Xw4DpF
	yDXF98Ar4xGF12gFsrZF4UArsxKw10g3WUCF9rA3s0qr9xKrZ5uFySkF1YyFZ3tFWDWFW7
	Xa4UKr13Gr1rCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pio7KsUUUUU=
X-Originating-IP: [223.166.237.2]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/xtbBog7pKVaEJdIJmgAAsa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_013831_450905_F6A8D2D4 
X-CRM114-Status: GOOD (  10.77  )
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

When enabling multipath, if the block device of nvmet is
a nvme_ns_head disk, then we should get the lowlevel block
device to do bio split.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/host/multipath.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..f6063600e06e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -371,6 +371,25 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return false;
 }
 
+//for polling queue task to get lowlevel block device
+struct block_device *nvme_mpath_get_bdev(struct block_device *bdev)
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	int srcu_idx;
+	struct nvme_ns *ns;
+	struct block_device *ret = NULL;
+
+	if (!multipath)
+		return NULL;
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (likely(ns))
+		ret = ns->disk->part0;
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_mpath_get_bdev);
+
 static void nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
@@ -452,6 +471,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
+EXPORT_SYMBOL_GPL(nvme_ns_head_ops);
 
 static inline struct nvme_ns_head *cdev_to_ns_head(struct cdev *cdev)
 {
-- 
2.26.2


