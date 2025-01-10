Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE3E7719E
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JnJa63Q/VRxh1EfsNS4Pwgun/9csnBwfnev/Lf/vXR8=; b=aTHwv/xCTQsQoB9NEblhmRjTSI
	1YJOzE+OjCmI+LQt6x+nWlnxKkdIJMsBMWdnClHdEmqxXVZIezvfv2hSQqQxc1dg1bzNJFiN3nUDu
	YEyP6wYGWMjEVC0Sr5iUvFpEVL+vAGQ/AzrCa3pE4lBHPe/eBlHt6O/UW5owQCRDJV1twXAhSZkgy
	e0yuN/eQId1pI9A6Bxmqq78TXg2UKCkQdgcUULSVL9A+YP7FChBbq1Lj0MM8MeBj6xBA9ZDkvYk/m
	3SDFXxVGXYTpj1ArQ6LfhspalSF16mmIDWiEVC1QCC99aO13Od8PegWAFg4hd7PVv4OjI8iVTAbTz
	EZUN7ZKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHv4-0000000GGds-1FV5;
	Fri, 10 Jan 2025 16:31:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHqY-0000000GEv4-2nrj
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 16:26:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 41ED9A426B5;
	Fri, 10 Jan 2025 16:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B95DC4CEE3;
	Fri, 10 Jan 2025 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526413;
	bh=7KONgCPE9Ymk0Paeq6W03Cji817hrNEc4cLzoY7jtxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SGoFF60hidDrBhvkwkP8fKG8mLcaHrEmpWtnixxZbRQUiS0yRmkrcUIHLLaoui3FV
	 nECZr9rjjMWh4IqgtKgkMBe1c9PIdin5yS91ubVuSfXL3zgNLme4+EW+9ytOOi2CC9
	 dPEbEgjithMuJxvTEtj00f3fNmual//ZkRU9mITN5v9fNZw2ytIQ3JySeJygM+2YI/
	 qGSiu3DHHk2fbuoxJbm+05Mno1bHLVUCYEivSEuEElxAFXmZPwZ9fXKbjCUJglbso2
	 qWYj6SewkNywxo9CAOOMWTYPzD9mTcX+6YF8OPzX4x0EaG0pkOb5JIgWGR9C4hzKjt
	 Ea08Eym1qoH2g==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 10 Jan 2025 17:26:41 +0100
Subject: [PATCH v5 3/9] nvme-pci: use block layer helpers to calculate num
 of queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-isolcpus-io-queues-v5-3-0e4f118680b0@kernel.org>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
In-Reply-To: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_082654_780165_04D30685 
X-CRM114-Status: GOOD (  14.37  )
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

Multiqueue devices should only allocate queues for the housekeeping CPUs
when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Use helpers which calculates the correct number of queues which should
be used when isolcpus is used.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 709328a67f915aede5c6bae956e1bdd5e6f3f1bc..4af22f09ed8474676edd118477344ed32236c497 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -81,7 +81,7 @@ static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 	int ret;
 
 	ret = kstrtouint(val, 10, &n);
-	if (ret != 0 || n > num_possible_cpus())
+	if (ret != 0 || n > blk_mq_num_possible_queues(0))
 		return -EINVAL;
 	return param_set_uint(val, kp);
 }
@@ -2439,7 +2439,8 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_num_possible_queues(0) + dev->nr_write_queues +
+		dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)

-- 
2.47.1


