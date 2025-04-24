Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332ECC369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1pkT0mT4REWvzaXED2te9m99S43Y5Lpy4oaDtXCXVw8=; b=0RlaZnKl0mbvqK5pzUsg34CDh8
	ki5Y2bh1kGaMyZtSpsv2fRA+zNdTcW/33Y2AzFxcs+LQkJBch6xgPhIE/f2SQnQtZr0AIm4JrY2y0
	8WQKcQe6g5OuCoKiRJumHHzvGir9SsHL1CQwftWgEXr+jJ9eHa6NcrjVzBzSD7VrmftErJGlbSBL/
	WjWpaneJxaYwaC8RcRTNYG0YftgOKowEKvPQb34nHZbfahGlY7CEZKzns7hMQJT1+N3NK4tOwDDOh
	RLmz8YCybD8W2lOGoVmo16RIv2FO6b33Vk92QFmEO648mbCuRJNgi4K6q0Z/RmbhYoOoMO7v2naYE
	zH1O8B7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81B1-0000000EztZ-2Z0L;
	Thu, 24 Apr 2025 18:19:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u81Ax-0000000Ezp1-2LZV
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 18:19:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D96BEA4D081;
	Thu, 24 Apr 2025 18:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF269C4CEF0;
	Thu, 24 Apr 2025 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518794;
	bh=ok6xPrZqMzj+pYA0b2w0oFvw0PB4VPK6RSYzfiVkDs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uBOlEZKBSib8YU5vBRS+rzjM30Tzh2DoF8SmxfVGZ40u4kG+z1iBuJ1YYa5TuzJ+E
	 K29lL3XrcN9mi/wlaQCz2p5XcvI0AEk4rqYIQj4Q0+1gfutkmTTAgFZfI7DDyXKOE2
	 oUpz/xbUodeoYK7oRUr7kcA4v2y3MJUwkNqPVA3TVDTSXki9wFUkhVN+BW6cIx9kqw
	 eLdDWGpof5wsS9ErUeSrom/DhdQ1S/5odHIVzYeceWhcEWbRs/kDb0u9h2mBL76cQA
	 WEZ4myBfmfOPbeVzlqzXY6DutFgxxU51roTLOh/LHFjsBcVgcnIhEf8lTnPIFSDCva
	 cMv9hQM3yn1tw==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 24 Apr 2025 20:19:42 +0200
Subject: [PATCH v6 3/9] nvme-pci: use block layer helpers to calculate num
 of queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-isolcpus-io-queues-v6-3-9a53a870ca1f@kernel.org>
References: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
In-Reply-To: <20250424-isolcpus-io-queues-v6-0-9a53a870ca1f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_111955_695931_4FD409B1 
X-CRM114-Status: GOOD (  13.72  )
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
when isolcpus=io_queue is set. This avoids that the isolated CPUs get
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
index b178d52eac1b7f7286e217226b9b3686d07b7b6c..2b1aa6833a12a5ecf7b293461a115026f97ea94c 100644
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
@@ -2448,7 +2448,8 @@ static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
 	 */
 	if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
 		return 1;
-	return num_possible_cpus() + dev->nr_write_queues + dev->nr_poll_queues;
+	return blk_mq_num_possible_queues(0) + dev->nr_write_queues +
+		dev->nr_poll_queues;
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)

-- 
2.49.0


