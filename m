Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0FC11F68
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BECB61420
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 15:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BECB61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oDWg7BvXzB13CG5Nd2c1cDnEBKZXUTkfRnBS69yCcOA=; b=M4a3p3R4z/k+9c
	zy3jiBKKifxux34X1BCGrJuve4iYhM8MnssFx/TSXqyD1yVF1Ad+lH0Yz1ZFpdjX+ndC0smKcjE2c
	F8GwZ0G8AXXncbFY88zkCzA9N20aEysbJlHbpY68sdZomtTqDqXOo5C+EodFS55TCRr4pzBzB4dFu
	fYGhBO23T1fVLe7YE7GgtsqsJ8milkUC81LeC2EuQzX0Nb9HMAAotBlEG9phGv4uLgUpc6N4RoTLd
	qGhqJAV7muBC7rubtq8l0qEx4JNPNodbtxv0qWCpqrUUUV4M4zb+MbRL5ROSScPVyS7Ewi0jN/hWn
	xULXuR+/aedAY102msCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzKmW-003MkN-5e; Fri, 02 Jul 2021 15:08:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzKmT-003Mj3-7F
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 15:08:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625238516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y04IGpEIuHWMLumE8xaIZ2YQoEhf+/Y+QUQ98ZodQ58=;
 b=SgCXYwN+JKj1tLykhrPLD9H7bxcakO48UeuZLKt5PI53bu00RLHBPsBn0uN9TxU3EMQqXk
 batKWV8awQCwpLJwviT91RNiydURKQCO0XklpE7TIc8wcfQgQKuAU+eIiCSdfKiL2qCFlt
 rMazsP+kCxfTndPJbT41o6bmLvjAdeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-OlnH2h_QM2Ogz1hG4Sz1sg-1; Fri, 02 Jul 2021 11:08:33 -0400
X-MC-Unique: OlnH2h_QM2Ogz1hG4Sz1sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD941023F44;
 Fri,  2 Jul 2021 15:08:31 +0000 (UTC)
Received: from localhost (ovpn-12-40.pek2.redhat.com [10.72.12.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92F7B60853;
 Fri,  2 Jul 2021 15:08:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org
Subject: [PATCH V2 5/6] virtio: add one field into virtio_device for recording
 if device uses managed irq
Date: Fri,  2 Jul 2021 23:05:54 +0800
Message-Id: <20210702150555.2401722-6-ming.lei@redhat.com>
In-Reply-To: <20210702150555.2401722-1-ming.lei@redhat.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_080837_414874_BC845940 
X-CRM114-Status: GOOD (  16.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk-mq needs to know if the device uses managed irq, so add one field
to virtio_device for recording if device uses managed irq.

If the driver use managed irq, this flag has to be set so it can be
passed to blk-mq.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/virtio_blk.c         | 2 ++
 drivers/scsi/virtio_scsi.c         | 1 +
 drivers/virtio/virtio_pci_common.c | 1 +
 include/linux/virtio.h             | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index e4bd3b1fc3c2..33b9c80ac475 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -764,6 +764,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
 	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	if (vdev->use_managed_irq)
+		vblk->tag_set.flags |= BLK_MQ_F_MANAGED_IRQ;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * sg_elems;
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index b9c86a7e3b97..f301917abc84 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -891,6 +891,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	shost->max_channel = 0;
 	shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
 	shost->nr_hw_queues = num_queues;
+	shost->use_managed_irq = vdev->use_managed_irq;
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (virtio_has_feature(vdev, VIRTIO_SCSI_F_T10_PI)) {
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 222d630c41fc..f2ac48fb477b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	if (desc) {
 		flags |= PCI_IRQ_AFFINITY;
 		desc->pre_vectors++; /* virtio config vector */
+		vdev->use_managed_irq = true;
 	}
 
 	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..85cc773b2dc7 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -109,6 +109,7 @@ struct virtio_device {
 	bool failed;
 	bool config_enabled;
 	bool config_change_pending;
+	bool use_managed_irq;
 	spinlock_t config_lock;
 	struct device dev;
 	struct virtio_device_id id;
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
