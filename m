Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62221D16271
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e4Ps0LTNWtpOzvACDoK7yZclpZ1vctpZNJbAJ5EHjQQ=; b=Z5rsOjL/tqE7j5C4NZhfmPowI0
	Jrl4deRnCIrwlDJ7rOSLoqfhIyqJaDQR62RcLE18gXvXBAOOsCWiwscDoZV88XQPRrhomkq4Ev23E
	rBCufFUPCz2HkKrkwuNVuO5lJIMrk7Z8vjnT9+IJSMKSMv7QfJoucVlnTFfXEO9XW9PPrrbfVjIvh
	c9cO+O6OuRRWzwvBado6mIAabCUb8IdRoDlfzKZClwFie0qOih2/mKemY8xnCI53NTNb9609P8YBf
	R3oB4Tq9do/ZTQnjwNrxMIppP+SMQCBxGl5Qjp3pH6/+IsM0MLS5jmKo1dG4J2ZhySNhBp/mIc0Yu
	CtMzm6yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Lcj-00000005P3i-2n7M;
	Mon, 14 Oct 2024 14:00:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0L1P-00000005EpL-1EJT
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 13:22:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728912121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e4Ps0LTNWtpOzvACDoK7yZclpZ1vctpZNJbAJ5EHjQQ=;
	b=eaUrgKMCAsm0pll+n6x5QO5l5MayfTJ16B5hrP8jdVOoXa2f907LTyxnq0lVI2Pt2olj/X
	DRzBXnK+uWYSg1aqT6RSUt+IZ4uRyBnzXduPuFsYJ0P/qQUtM1klT28zt/0BEmwj44sD8N
	Zy4FVSlfLD/ZLZ+dI/fxVLbg3Uml4tg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-sMN7R9TJPKK2x2-5yYVx3Q-1; Mon,
 14 Oct 2024 09:20:19 -0400
X-MC-Unique: sMN7R9TJPKK2x2-5yYVx3Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C113219560A5;
	Mon, 14 Oct 2024 13:20:17 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.143])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 580D43000198;
	Mon, 14 Oct 2024 13:20:15 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: fix race condition between reset and nvme_dev_disable()
Date: Mon, 14 Oct 2024 15:20:13 +0200
Message-ID: <20241014132013.786770-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_062204_130203_5E73565F 
X-CRM114-Status: GOOD (  13.88  )
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

nvme_dev_disable() modifies the dev->online_queues field, therefore
nvme_pci_update_nr_queues() should avoid racing against it, otherwise
we could end up passing invalid values to blk_mq_update_nr_hw_queues().

 WARNING: CPU: 39 PID: 61303 at drivers/pci/msi/api.c:347
          pci_irq_get_affinity+0x187/0x210
 Workqueue: nvme-reset-wq nvme_reset_work [nvme]
 RIP: 0010:pci_irq_get_affinity+0x187/0x210
 Call Trace:
  <TASK>
  ? blk_mq_pci_map_queues+0x87/0x3c0
  ? pci_irq_get_affinity+0x187/0x210
  blk_mq_pci_map_queues+0x87/0x3c0
  nvme_pci_map_queues+0x189/0x460 [nvme]
  blk_mq_update_nr_hw_queues+0x2a/0x40
  nvme_reset_work+0x1be/0x2a0 [nvme]

Fix the bug by locking the shutdown_lock mutex before using
dev->online_queues. Give up if nvme_dev_disable() is running or if
it has been executed already.

Fixes: 949928c1c731 ("NVMe: Fix possible queue use after freed")
Tested-by: Yi Zhang <yizhan@redhat.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7990c3f22ecf..7e3a2844891b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2506,17 +2506,29 @@ static unsigned int nvme_pci_nr_maps(struct nvme_dev *dev)
 	return 1;
 }
 
-static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
+static int nvme_pci_update_nr_queues(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.tagset) {
 		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
 				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
-		return;
+		return 0;
+	}
+
+	/* Give up if we are racing with nvme_dev_disable() */
+	if (!mutex_trylock(&dev->shutdown_lock))
+		return -ENODEV;
+
+	/* Check if nvme_dev_disable() has been executed already */
+	if (!dev->online_queues) {
+		mutex_unlock(&dev->shutdown_lock);
+		return -ENODEV;
 	}
 
 	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 	/* free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, dev->online_queues);
+	mutex_unlock(&dev->shutdown_lock);
+	return 0;
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2797,7 +2809,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dbbuf_set(dev);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-		nvme_pci_update_nr_queues(dev);
+		if (nvme_pci_update_nr_queues(dev))
+			goto out;
 		nvme_unfreeze(&dev->ctrl);
 	} else {
 		dev_warn(dev->ctrl.device, "IO queues lost\n");
-- 
2.43.5


