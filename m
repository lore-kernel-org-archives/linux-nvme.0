Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A22C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7FE206A5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MuhqWZvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7FE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=M+l0y4NxV98JKUItAXNmCZFFg5eiUfsufvf3ypfzFNw=; b=MuhqWZvIdJVB3d8USATFz5ErZP
	DEV0VvB9MIiR1Qlzx2mML+meLeXpWGZYjRSd1fWyhArMBcoyCgCd97Rfb7k6AuMZagBDYpQ465sz5
	dxqrX9r5QYW5cZbQ5bJkNdZQz+wXZ87CszCCN8nbE8LFT/+mHClCpX3Ki0MR1vpl3A4r7vVBcCn5U
	OMZDCCClo4t2MQfZp7gVq/9gJUx1UNIwmpfV1fPMSPaBG5mUp2dQ/70bDHjZ+r8+OVVsmuLcG3HC4
	Fr4FKTueodn4oqmhctyXjh8gpljPxe6K1fNY0ZAe81u3biH00dzUR5jWM2HQMDk4XsxQQ1rVqpRrC
	UqGhmV+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5skJ-0007XA-Uh; Thu, 05 Sep 2019 14:28:23 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5sjt-0007Cr-IE
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 14:27:58 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 07:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; d="scan'208";a="187991056"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
 by orsmga006.jf.intel.com with ESMTP; 05 Sep 2019 07:27:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/5] nvme-pci: Free tagset if no IO queues
Date: Thu,  5 Sep 2019 08:26:05 -0600
Message-Id: <20190905142607.24897-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190905142607.24897-1-kbusch@kernel.org>
References: <20190905142607.24897-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_072757_612775_39F05074 
X-CRM114-Status: GOOD (  11.83  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If a controller becomes degraded after a reset, we will not be able to
perform any IO. We currently teardown all previously created request
queues and namespaces, but we had been keeping an unusable tagset. Free
it after all queues using it have been released.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5c3732fd02bc..ef6c31c20571 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2489,14 +2489,20 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
+static void nvme_free_tagset(struct nvme_dev *dev)
+{
+	if (dev->tagset.tags)
+		blk_mq_free_tag_set(&dev->tagset);
+	dev->ctrl.tagset = NULL;
+}
+
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
 	nvme_dbbuf_dma_free(dev);
 	put_device(dev->dev);
-	if (dev->tagset.tags)
-		blk_mq_free_tag_set(&dev->tagset);
+	nvme_free_tagset(dev);
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
@@ -2615,6 +2621,7 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
+		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-- 
2.14.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
