Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF1ED68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fj6pRS0k8KalVY5quSVu37t0+w+16oVaBMbmyua5TZs=; b=Q7O0WjDCD1UBE25TpZxhuEG/B2
	XD8QcBnIphX2fd3Cf138pLXD3KCUKJOp+h755dpUAHqp4IJDbaUogJ1AhVi306qUtrAzwB1S701CQ
	ZByHbcn9L1CngTM1GovnJVAOcQQxia4ViZj/YYHC1h9DujrsM6x9vmyjS62OhSXkQRqCmtzDjxMCS
	no95ahDCBEFNjxEjK/0LwvGy4lovoN4BC8ikvKQVfeKb9ogknfpEU2A11Qa1c5I9V2LHalh+tgBCU
	IFZd7ejY5CsImmj4lY1TrhQ23zs2MWYMXpq1UMWWIL+sKGPOo+dV3tokvUsYtgf3ux4/GJpWx0THS
	gkbBHjWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzKe-00000003My6-3hPM;
	Fri, 15 Nov 2024 16:38:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzKa-00000003Mto-2Z0I
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 16:38:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C340F5C647E;
	Fri, 15 Nov 2024 16:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C13DC4CED5;
	Fri, 15 Nov 2024 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688679;
	bh=qXsBQKaaXXoMUamCldA2c8GUcVaBojXc/vUNvwmptL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vHBXTkMowrwLS5I3GCofVVTYd8rQ+MIOgobnCbKJrEk0avo16uv4mzS8VMyNH9JJU
	 WbTcjv0BrcmvbhOvqUqEFXFUDecVuFrJHRXeifZ7N9dNMdkZivcSCm4irrQ+kQeG7P
	 JpN/JXt4EPw1Yd+/nRNQsfwDRovXyECC94rzbJwvhGn/wtlvc45UNSM2d8duDYFi/F
	 l8SngySUHIiVqcubLWdED3FPR6FljGDW4Ez0RV5Xmun7nfenSZDVi9t7Fky0s+JrM3
	 yyap6vCqvgfiBteC12PYKG/tvEYyJl8a3Y909JNLTB9ILf5MeYK92UvH90vPS/xGAH
	 tPKRbZQe7MlKA==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:47 +0100
Subject: [PATCH v5 3/8] virtio: hookup irq_get_affinity callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-3-c472afd84d9f@kernel.org>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
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
X-CRM114-CacheID: sfid-20241115_083800_703583_E537D49E 
X-CRM114-Status: GOOD (  13.10  )
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
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/virtio/virtio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..4ca6ec84cb092eac7ddf4b86b4eacac099b480cf 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,24 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+/**
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


