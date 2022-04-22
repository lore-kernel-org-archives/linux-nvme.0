Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C31EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Apr 2022 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tTS1fwCyWcSTDM00kDqDYTwl3V38LvGKu4+L/n+uQHg=; b=5BUGdVYupd3VVaL4A4F5fmFOJE
	E5sBGwrFgYFylNoZJost8RouHxQavp5PL46mDiqHW8SBa29GBil3SkBbWrMgFakgZISg1m7YWLPwW
	4Var8c++GsEJZdYfi2N+MLBCcUNQbFKmVF6GmtXZwJr6Xj+dzSaRZ1VZJ95qYo2Ec+nRCstrllr/F
	DUtrX3nL8a8HFqoDTs0w2OSZDnHlpFWLXfapCMgGzwJ9Sb4A6RcW+fD/HRpUboZ9ZYctQFq9XE6Qa
	fceLW4e92B58yakM/JIrJ3GecQJULlZ7tubCdk89Ojc6izA0Nt/VNIRLm1x/bbphqDKqhKk/kVOUl
	/+V8Mv2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhqzr-0007Ss-Pt; Fri, 22 Apr 2022 10:58:43 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhqzj-0007R2-AN
 for linux-nvme@lists.infradead.org; Fri, 22 Apr 2022 10:58:36 +0000
Received: by mail-pl1-x636.google.com with SMTP id u15so6667301ple.4
 for <linux-nvme@lists.infradead.org>; Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id;
 bh=tTS1fwCyWcSTDM00kDqDYTwl3V38LvGKu4+L/n+uQHg=;
 b=Xg+IIXfjMQSpe0okWvUQFcO35h06GEqp9hRY1NxEq+1v2LWi9BVgdutkKCa6MP8DQu
 5ZhH1vLN8iITPUztAK+jd8Iopzqdi+jjpzOtTgEZ5YlrtOzM5frTsP+wqFP3TNpnK8E6
 mRYPGTefo24/IYOHK+sbFfq8kXIZ05iqykpPY9Atyq3444pMHzfjCkh4spPdUAkx3el+
 VQusD2SW0BOfOG+AVZMZv6ItAmceKhT2EkXxfILsM7n7FVI54XxK52D8e5oVNhBc8lrm
 1uh7FMfNJX7GAaTYE8y+zEN8dztaMODwHOCBy+20vkO27lye74lgUxdjmY2GVEJZJS2M
 8sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=tTS1fwCyWcSTDM00kDqDYTwl3V38LvGKu4+L/n+uQHg=;
 b=Ba8kf77//TTu0hkBMD9GAeHFxYnepirVqo0q4ddA8pxQkJPwfp9VeEVvMmyllcVzRV
 FhRTu+cZJHzikK3MQhF0y3V9V+P4Qc8iznIrnieArybLmgh8kkirySDkftw4I42Z54RM
 x2nWsxUDmCuZ1fM70zqZJ/XbAxLzLKKmtTTqgarJhE2+7h218UV8dzHjTkv9QWISnwdR
 TzhLoVNIdeerIOQObBJFJHDTbKl4vqLuydOl0DOo4j4CLIaBqui8kp+vK3CEt13bT6gP
 FbyBsmi6GQNgYSDnSO2ajW4puz44oGdGqaZAU0+QysiloyEjyh9dkz0zxmLGPHSVKyAq
 3d1Q==
X-Gm-Message-State: AOAM530qt07xRGDObbHVW5P4fSNAZPqW9I7+MRmc178AEBj1Xl+Floxf
 yMkwzJ0J5yCp2alaKd7oV/g=
X-Google-Smtp-Source: ABdhPJxb9VMq1QKT5klc7y15hWNuMSlDDKP+3Cwwv6BbkmAD8Adbt25AXC7Rvg90uwyPj0R7MPkA/g==
X-Received: by 2002:a17:902:7244:b0:158:41d3:b79b with SMTP id
 c4-20020a170902724400b0015841d3b79bmr4026718pll.50.1650625113381; 
 Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
 by smtp.gmail.com with ESMTPSA id
 f128-20020a62db86000000b0050ce37eb56csm2313158pfg.90.2022.04.22.03.58.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme-pci: allowed to modify IRQ affinity in latency
 sensitive scenarios
Date: Fri, 22 Apr 2022 18:58:26 +0800
Message-Id: <1650625106-30272-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220422_035835_421130_5544A460 
X-CRM114-Status: GOOD (  21.15  )
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

From: Chunguang Xu <brookxu@tencent.com>

In most cases, setting the affinity through managed IRQ is a better
choice. But in some scenarios that use isolcpus, such as DPDK, because
managed IRQ does not distinguish between housekeeping CPU and isolated
CPU when selecting CPU, this will cause IO interrupts triggered by
housekeeping CPU to be routed to isolated CPU, which will affect the
tasks running on isolated CPU. commit 11ea68f553e2 ("genirq,
sched/isolation: Isolate from handling managed interrupts") tries to
fix this in a best effort way. However, in a real production environment,
latency-sensitive business needs more of a deterministic result. So,
similar to the mpt3sas driver, we might can add a module parameter
smp_affinity_enable to the Nvme driver.

By default, we use managed IRQ. When smp_affinity_enable is set to 0,
we alloc normal interrupts for Nvme. Therefore, users can modify the
interrupt affinity according to their actual needs when the managed IRQ
cannot satisfy them. This method is not a good choice in most scenarios.
But for users who clear what they are doing, it may be better than not
being able to do anything.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 drivers/nvme/host/pci.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..f8fd591b1839 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -74,6 +74,10 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
+static unsigned int smp_affinity_enable = 1;
+module_param(smp_affinity_enable, uint, 0644);
+MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
+
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int n;
@@ -471,7 +475,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL && offset)
+		if (i != HCTX_TYPE_POLL && offset && smp_affinity_enable)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
@@ -2293,7 +2297,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.calc_sets	= nvme_calc_irq_sets,
 		.priv		= dev,
 	};
+	struct irq_affinity *p_affd = &affd;
 	unsigned int irq_queues, poll_queues;
+	unsigned int flags = PCI_IRQ_ALL_TYPES;
+	unsigned int affvecs;
+	int nr_irqs;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one I/O queue
@@ -2317,8 +2325,24 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	irq_queues = 1;
 	if (!(dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR))
 		irq_queues += (nr_io_queues - poll_queues);
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
-			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+
+	if (smp_affinity_enable)
+		flags |= PCI_IRQ_AFFINITY;
+	else
+		p_affd = NULL;
+
+	nr_irqs = pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags, p_affd);
+
+	if (nr_irqs > 0 && !smp_affinity_enable) {
+		if (nr_irqs > affd.pre_vectors)
+			affvecs = nr_irqs - affd.pre_vectors;
+		else
+			affvecs = 0;
+
+		nvme_calc_irq_sets(&affd, affvecs);
+	}
+
+	return nr_irqs;
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
-- 
2.30.0


