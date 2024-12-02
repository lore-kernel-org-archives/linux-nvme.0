Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA72D78328
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4O0ycFXh8LXx1RVJasYMnLE6L/8uTR2bdb8yC1NxyKY=; b=u2gV9eze29IBWabddxx47iFmc4
	k/lGfuzFIdeoou2eAz+G9piNspRBHagsuMq9JfRlut13wYLzWn4CQYAmnvoZxUebh1IKK4GxdaoQd
	xil5tEUxoZUVOX0en8W9HhoqjhjurrGFtCRUPew/YRzWkDPG2fkMSVwwbaEa3Q06qR0eLRnshrvhd
	r7ZEZnRGk7bVsOoTzJHr0Y2cYh0nuOo+neTxgU7SBfF1zhNnDUbg6i05s/m9gwd3pw6V+498wsbtv
	Ch6W71Fjyah3toY094iBmSgJW4UVeG4w1bPMqTTzBFgI1fFzv5g7zK9Y6QvjMSqRA80k9f70Bav56
	EvhW0oTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI70b-00000006KuB-45Pb;
	Mon, 02 Dec 2024 14:02:41 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6yZ-00000006KP7-3Z55
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:00:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 872ECA40CE4;
	Mon,  2 Dec 2024 13:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46828C4CED6;
	Mon,  2 Dec 2024 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148034;
	bh=5fZ7EXrytyCpiro/tG84vBDeaW3vHOORuXZTueXikB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvqUQ/VS7hBSvNuY72vN7+D0BNoN1TYVsmReR+ugpZ4Mdb0jYb0ej/7yV7eOIyCOz
	 2vyGFHAq0Cp/KXp1N9aqU3fXXWqskEoP38lTPnAdwSbbjcXqNphjqbl8r453fSPfOn
	 2DSrFBiob05SZceAGX5gsWZYN8itXF0LNXYrt6kEwu/nezlxS4kiauOD1E4Rth0y5t
	 WO91U46MtvVHWmKMzWBfIUz4tXR2CzppISi5iWHYCQyc4tq26wsRcWAbXCWt3HA1hI
	 7mgyXBzHAmrZLF1iDjC50pvxQUvECe77FVv3jVC+Ag3fE0gvIDmMUEJkna7eFzV+NC
	 dZnqbKSfrQg/Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:11 +0100
Subject: [PATCH v6 3/8] virtio: hookup irq_get_affinity callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-3-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_060035_956752_C6B21946 
X-CRM114-Status: GOOD (  13.11  )
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

struct bus_type has a new callback for retrieving the IRQ affinity for a
device. Hook this callback up for virtio based devices.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/virtio/virtio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..b10ed9f5b5435ae0bf7ab52a6519a7fdc4d5920d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+/*
+ * virtio_irq_get_affinity - get IRQ affinity mask for device
+ * @_d: ptr to dev structure
+ * @irq_vec: interrupt vector number
+ *
+ * Return the CPU affinity mask for @_d and @irq_vec.
+ */
+static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
+						     unsigned int irq_vec)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, irq_vec);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -384,6 +402,7 @@ static const struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.irq_get_affinity = virtio_irq_get_affinity,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)

-- 
2.47.0


