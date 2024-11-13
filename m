Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D738D462AC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SR3HhRmAZzLI5EhUyQ4eBA6cDBU2TPEbXu5hgBieBf0=; b=daYZDPmKesR3c0sevf5RUofk9z
	TmgFL6KJrGvELtmYZeB+PHmLRcDwrqPTQqVd+lDA1k1Cso+kxjU6wn3G1F30dtxDXzC9KyuFCx99k
	uYwP68V1EEsj034XbKaHKC8s1BnunADNHQKOE5nMoSzu4TSklbSrLoRUaU/OqUSBvkrJtUa1jPYIr
	tuNk0Cs9tgNkYtbQNu6FHTLxRs4h1YchsLxM4KOkLAYNm4w6aWHzu+F0ZHHrw8svFzEmesRSQV+Lj
	jseOAQfzGOwFh7zobzNXCOPGRbFc7cT/GkrINwqcWi+a8Mg4BbqsDSsaK//HPGwq1yolyXZSyTnxp
	yTHyrepg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKT-000000077wm-1vzy;
	Wed, 13 Nov 2024 14:26:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKO-000000077sN-1uxU
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:26:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6828A5C02FC;
	Wed, 13 Nov 2024 14:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77ABC4CEDC;
	Wed, 13 Nov 2024 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507999;
	bh=ykozEZT9S6rCqtY4BFNlhiPo2SLAkwdyL9yKIvPlm0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LAho7g8Sx8pHXhA/A3+lvNmYwqWF+/vwwUcpNhr3BWcFrfmNTwXtjzxd6yOX4o7Y4
	 tlsFNFiKqjYsnb/6akmCJklODLLX1AqfWoXw9txNJxXqYmc43UPiq3SNf0AQTm7NYx
	 Mhp2CCSTlXRmixLyVraAtqo+2DvTGJ5MMrdXQhKgWWtcUPVx98jfMWeu+CXkhGV0vI
	 OY49Zwyp0wqAkzwSWmIFbG5k8QlVtFpp6c6FoecbOVWcKjbHW4JMi1rFtwLu3fPpbG
	 hP3SLoDnOCW5sIHtv4D3MpKltXNgTOND7b+nRzY8D4RSI2qhCKYpMXqYmKIpiq2jbX
	 ZgyB9+whkOReg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:18 +0100
Subject: [PATCH v4 04/10] virtio: hookup irq_get_affinity callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-4-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062640_723930_F89B5562 
X-CRM114-Status: GOOD (  12.44  )
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


