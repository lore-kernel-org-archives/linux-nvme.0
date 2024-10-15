Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D1ACFC28B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cYMh5spqxBzFwVt4eOER8kYg02j3hG421gfzxexCzwc=; b=QO/Lrgb5kSbC7Moaj1Ma5E37j0
	wvglevbq6ts3UAZ/Tai/KNrL+mvZQRoDros7JfQs+het/tZ5SDYTfA888MecBYqPT09nMAOnxEsv7
	eLPY2Qm3B/jkH4VJPDhO//HKfAb0rjfSs48wfKffr1cpwyNrK2B0GCEJYV0SX1dmaU/dNO1Lwh4s2
	T2Pc1EMXfB4RYzvNSkUAo7u27eVWpBtNy24rJZD6y/rCkahiJqVZjLwmBI0hcWarY+pjMNA8G6vaD
	WEQMpL9WRgcAjlWtDpjYEGEiBL/Q7CZpzhmoCMQ3NeUAzCLk0GIN9cv+jNAyId7szfoQrpbpFy6+F
	P2mI7Ujg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0fea-000000080eT-315T;
	Tue, 15 Oct 2024 11:23:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0fby-00000007zze-20PX
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 11:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728991269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cYMh5spqxBzFwVt4eOER8kYg02j3hG421gfzxexCzwc=;
	b=b8ZPD29CS5xoMyfDm1YARkzIZXM6vNhVxnb/LiuMVSXvjwPGe/L1a/YcFQsCEZE3FKuJpV
	obvE8DedhzHrXFCz1icxZqHOueugj/mgfnX2JtZCqZx6dlEg4jOBGXJtzgk1/p0GWoydds
	p5ur4/Qyve6ammluyiuZMpjnf+KPHhE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-IllXHmKJMKiuJA3Da6WZWA-1; Tue,
 15 Oct 2024 07:21:06 -0400
X-MC-Unique: IllXHmKJMKiuJA3Da6WZWA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F17119560AD;
	Tue, 15 Oct 2024 11:21:04 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.143])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CBAB1956056;
	Tue, 15 Oct 2024 11:21:01 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvme-pci: fix race condition between reset and nvme_dev_disable()
Date: Tue, 15 Oct 2024 13:21:00 +0200
Message-ID: <20241015112100.824193-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_042110_672665_C6871EAF 
X-CRM114-Status: GOOD (  14.05  )
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
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v2: return true in case of success, false in case of failure

 drivers/nvme/host/pci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7990c3f22ecf..4b9fda0b1d9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2506,17 +2506,29 @@ static unsigned int nvme_pci_nr_maps(struct nvme_dev *dev)
 	return 1;
 }
 
-static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
+static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.tagset) {
 		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
 				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
-		return;
+		return true;
+	}
+
+	/* Give up if we are racing with nvme_dev_disable() */
+	if (!mutex_trylock(&dev->shutdown_lock))
+		return false;
+
+	/* Check if nvme_dev_disable() has been executed already */
+	if (!dev->online_queues) {
+		mutex_unlock(&dev->shutdown_lock);
+		return false;
 	}
 
 	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 	/* free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, dev->online_queues);
+	mutex_unlock(&dev->shutdown_lock);
+	return true;
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2797,7 +2809,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dbbuf_set(dev);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-		nvme_pci_update_nr_queues(dev);
+		if (!nvme_pci_update_nr_queues(dev))
+			goto out;
 		nvme_unfreeze(&dev->ctrl);
 	} else {
 		dev_warn(dev->ctrl.device, "IO queues lost\n");
-- 
2.43.5


