Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89968C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z86U4HajwRS+bO9fhPagrSAmcb5268+tFSMExzGmM3o=; b=B27SBkfjg//kCLVscEoALv+B2o
	Q4Vtvgei5fOBJxFK9tec25/JQSIhh3bNuA+iPAIwnsKKnkJP+iO6XeqFGQRD0OqPjqnRQqftrM6VD
	ho4TNhfvatVGMWU5f/XP37LCEVtKPHN7cjQguoEFfCG/Jasj6x6vY/bC99R+ghY6Hyf+1p6aMxe5o
	wwDCsiW/vOldg+zKyezWqHlP/3HFd2ZwckxT5SE5QsXP6K3CsCek3XpmIemR7Gr4zPrKIjjweEDLv
	XzzEjRXR8Cyrwvn1dq0bF1Vfjap6GjA+oJzFwZGzM6xlsExJHOTjkSNvN3HmaJ+MvkeIoywc0mb4x
	F95194uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMpqU-0000000Aad5-2e3w;
	Thu, 27 Jun 2024 14:11:31 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMpqM-0000000AaVy-1d4w
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 14:11:24 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45051DAD93;
	Thu, 27 Jun 2024 16:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1719497475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z86U4HajwRS+bO9fhPagrSAmcb5268+tFSMExzGmM3o=;
	b=vhoedez/x0GFd/0rEH5rsJdieqerjH6UHFIrRcjRCRxqfcRKPh9Fq8MKRusQ5urg+qLQ+8
	Fs/vQBnrxo4ep5baTF6EvSh7Hj6jNvclgrmUszFuhXembG/ToiKQ6lAigcnpL8oSO/u11p
	CB4Wuy3Kng2lBtcOBULI1QaFHcriMvSBT1tSZ7xCl4D9zMa2RZlyMHerXWmlmDDJW4jVII
	yozcdDh7LJrSK8TiBrZj1b6K5s7VYKuyErE842emuSlBpj0rEsqrGFGr+Q3g6eGuiTGFeZ
	7tkFQbS8H6IkK4Ka2557R+BlSI/YT2ZqURHjqpwgCNCnPuaVEbgKs8TfbmcJQw==
From: Daniel Wagner <dwagner@suse.de>
Date: Thu, 27 Jun 2024 16:10:52 +0200
Subject: [PATCH v2 2/3] nvme-pci: limit queue count to housekeeping CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
In-Reply-To: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_071122_856473_3EB7D6D2 
X-CRM114-Status: GOOD (  12.01  )
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

When isolcpus is used, the nvme-pci driver should only allocated queues
for the housekeeping CPUs. Use the blk_mq_num_possible_queues helper
which returns the correct number of queues for all configurations.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..193144e6d59b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -81,7 +81,7 @@ static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 	int ret;
 
 	ret = kstrtouint(val, 10, &n);
-	if (ret != 0 || n > num_possible_cpus())
+	if (ret != 0 || n > blk_mq_num_possible_queues())
 		return -EINVAL;
 	return param_set_uint(val, kp);
 }
@@ -2263,7 +2263,8 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_num_possible_queues() + dev->nr_write_queues +
+		dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)

-- 
2.45.2


