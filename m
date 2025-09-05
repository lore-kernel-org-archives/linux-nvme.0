Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A9BCAC586
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=09TrbRg8gApXt1A9OKlxxsnXoqXXPEHQHrjZCAX693E=; b=z/wMTbxMFKDqbk85BX91NRNT6C
	uLk2Lhy9hIX3P28MhI73AqhpUogM68/A0NYdkRWJvd5Q04+ZfgV7SOUBoB2SKtXR5KgqghGmTmn0R
	5bOUi3j80GcHj3Uxntl1B2qesihjbFhvFmnNfXevq9F5Q835lLx3vumrD0Y45szQZM/YleTXD8H6H
	lKtE+xkt/VId9aZgv98F2U65MwBRuYEBa8nFzNHL88Q0VKUQVYynHNhkgADk0Kb27F/14qpJC/AlO
	DOqZv6G/3Clo380SaSEoU4Sz9FGlMQE9Y6ak/uL+p9kosTTha3Zvo/3ufsT9EblJNHnlWyWl620rM
	NAsvCkfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuc5D-0000000473k-38Ew;
	Fri, 05 Sep 2025 19:26:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuXv8-00000002Ys9-1DRX
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 15:00:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0849A40471;
	Fri,  5 Sep 2025 15:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD56C4CEF4;
	Fri,  5 Sep 2025 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084409;
	bh=l0TS7kNWsBFisp5wVR6xD5H+1nN29rebF/xTWKzZjX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lkgBXAXocImjt2eAn/AdIFpsG0uxz1yt+IOnL9oyY772BW7AHt92SMDrVHMVSJ4ZS
	 7WQ0X514Pqa510sT9ogC5CURj2FpMhoYL6DY7hLT0c08LMm5oRKRt6LmNcPagcyeuX
	 dNrTUYCsorwjNGfx0zKnZyLJft9d0BqcqGfsVts++oB4OuE23Y4p0Czidbc2Xbuq8g
	 YhsaIfbNsb8k+z+WfpYrX+/g4XsjcBHhtXUUDI3klMSZ3FesNnvb/GrfuysVMfBA68
	 cSvRo0y6DXMlI19yauHccXucwSGqcyOSz5KfmDAVYxquFy3wb+1EqNi7Ldtl5ONNgK
	 1t4YkfcMT97sg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 05 Sep 2025 16:59:52 +0200
Subject: [PATCH v8 06/12] nvme-pci: use block layer helpers to constrain
 queue affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-isolcpus-io-queues-v8-6-885984c5daca@kernel.org>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
In-Reply-To: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_080010_358883_6B3745AC 
X-CRM114-Status: GOOD (  11.39  )
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

Ensure that IRQ affinity setup also respects the queue-to-CPU mapping
constraints provided by the block layer. This allows the NVMe driver
to avoid assigning interrupts to CPUs that the block layer has excluded
(e.g., isolated CPUs).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2c6d9506b172509fb35716eba456c375f52f5b86..1d9c13aeddb12fa39eef68b7288d1f13eb98a0d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2604,6 +2604,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.pre_vectors	= 1,
 		.calc_sets	= nvme_calc_irq_sets,
 		.priv		= dev,
+		.mask		= blk_mq_possible_queue_affinity(),
 	};
 	unsigned int irq_queues, poll_queues;
 	unsigned int flags = PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY;

-- 
2.51.0


