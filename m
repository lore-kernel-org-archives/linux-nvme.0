Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A60CA1017
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jzlj72jiiXrOnH/EohMjTDz0SRT0MpfqDpZxzaCFKBI=; b=GZ6DpfmsvSki84snDC5NDvH//R
	MqoKRTvMProxuArybJgKG3sSPV7SpeyYbYgM0TRaVIv0Zo3FkWm7QVN1V1LT9gUU7JwQqR1+h/wzP
	00VND0ghdz+hP8RTJqopGNruv76woGG2zzxjFy7oyIWU0E8oGqHPB9icbnSUu5MLaRo/3OeBKZfA3
	bI5dBfVwIcfyabskVxFgR0XK4HTP11dft6nR2Lm6ZIrWEObyHX5e0SPkUpU8MltcRSePw7lrVGuT/
	HLpxBSdk2t4HCNnefDNm7nq68lmddR2hXFVFmpDjuqJFmhtE0eaYQBkUDqskcrDkB/ccb9Foh5uZN
	WVlT8TMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuc5F-0000000475e-17CG;
	Fri, 05 Sep 2025 19:26:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuXvD-00000002Yw1-2Q0N
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 15:00:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 52153448D2;
	Fri,  5 Sep 2025 15:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5288C4CEF1;
	Fri,  5 Sep 2025 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084415;
	bh=xQ0coLV1rItUOolPBiizTee/coH/W0d4cwoc/bXSQTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gnDRCPLfnelef8NHhTpOmzX7p/wXoMt7SPngNMbvXPu94iSoz9yUp1Ps1rlynyQO0
	 Djb/P2PdZwvidDz0nJA2K3jKkwrDo/KtevSizOYxzeGAGx5ZQPf2P60i3sgV10EFcf
	 OuCE28SBJ6LMYP8a6mUcF2JVMFXktpIBrWMvCBz9tWkaZJzCFypghf1uuq2T/jJAvs
	 Egdeen08e+nKE8RrrHIlrwJeamR+vvwr2VYq4R3p2vkV3WGI4H7+TPpNdqDU6/RkPk
	 bsnUuUJJSqLChW8lC8LCch076awqu459VELUHIuqZSfe8MORP4sP0mJl4fzGvnofhI
	 YegWFsnOwfGnA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 05 Sep 2025 16:59:54 +0200
Subject: [PATCH v8 08/12] virtio: blk/scsi: use block layer helpers to
 constrain queue affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-isolcpus-io-queues-v8-8-885984c5daca@kernel.org>
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
X-CRM114-CacheID: sfid-20250905_080015_659755_8FBADFF7 
X-CRM114-Status: GOOD (  14.16  )
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
constraints provided by the block layer. This allows the virtio drivers
to avoid assigning interrupts to CPUs that the block layer has excluded
(e.g., isolated CPUs).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/block/virtio_blk.c | 4 +++-
 drivers/scsi/virtio_scsi.c | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index e649fa67bac16b4f0c6e8e8f0e6bec111897c355..41b06540c7fb22fd1d2708338c514947c4bdeefe 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -963,7 +963,9 @@ static int init_vq(struct virtio_blk *vblk)
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
-	struct irq_affinity desc = { 0, };
+	struct irq_affinity desc = {
+		.mask = blk_mq_possible_queue_affinity(),
+	};
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 96a69edddbe5555574fc8fed1ba7c82a99df4472..67dfb265bf9e54adc68978ac8d93187e6629c330 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -842,7 +842,10 @@ static int virtscsi_init(struct virtio_device *vdev,
 	u32 num_vqs, num_poll_vqs, num_req_vqs;
 	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
-	struct irq_affinity desc = { .pre_vectors = 2 };
+	struct irq_affinity desc = {
+		.pre_vectors = 2,
+		.mask = blk_mq_possible_queue_affinity(),
+	};
 
 	num_req_vqs = vscsi->num_queues;
 	num_vqs = num_req_vqs + VIRTIO_SCSI_VQ_BASE;

-- 
2.51.0


