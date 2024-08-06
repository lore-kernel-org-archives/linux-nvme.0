Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEC7C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osYY5nzy55CkrfzWmRIr1SR3q3EysjB9xRdYV7yd3hw=; b=vLcAkwJgVYZLi0KohJLIC8Ltnm
	PfW41RgHbqzArp4tNELFGYu5UJEJgD8nc3iJYWfOJ2Oak2dsjh0buXxaS+2tLzGiHydMe3YfEN1c4
	Kd4ZkXzBkBHS5dQNkrtlvyGyF1xvGeWjyjkcMiZLA6Dqna0TejN5hXBKi53iKxZ+d+37QSpqUQ8xE
	A1htuLVqmaYbG+yo+FEerRoLP8EFK+CvHbdnGyvTubTRTwdkV34cRwFT5ia7GvtP4ywf5dX7QGn8O
	/kBhOr7esmjagkh//bSXZzm/58iq2qAIJHg/NuaEWhkEjz4IPRGnR9rFDCumVPKlX826uiC8rkiAs
	/uNfnipA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXZ-00000002372-0wcE;
	Tue, 06 Aug 2024 14:51:57 +0000
Received: from mail.nearlyone.de ([2a01:4f8:1c1e:abde::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyK-00000001QxD-1nvL
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:26 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63821DAE16;
	Tue,  6 Aug 2024 14:07:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946035; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=osYY5nzy55CkrfzWmRIr1SR3q3EysjB9xRdYV7yd3hw=;
	b=c/vpvIkD6/xBTfCquyVI2tBGWfswjhFVVPKPVZEsAuzHu8fym6GW9S+IOVn8unfFHAA7Gl
	RNPd2WKjJFP5ONX9yTyJLnRD8LydEoWL8nSu2UbzQI+EwMUQrt0WZfM9WKQgVbV7v8mhDG
	brA6MvXTuH46yp2fFeC21vSXpBdJ/Ea7+EwynyNcMppx9Z51RDj7jcAfSGfLXi0yFM/GPl
	2HLkVbkt4hjHMgjQBOCjc2ZrVp4Fx1EjeOCBp1/6XKWNwoaqoqs3xERgIzccjXT/qQ0VxI
	PPEiGMbdC/a/nhzCffNDgwtmiBf2FEGgO0VvJJB2YNb0ZK03QWNT4kHsn6W9sw==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:34 +0200
Subject: [PATCH v3 02/15] virito: add APIs for retrieving vq affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-2-da0eecfeaf8b@suse.de>
References: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
In-Reply-To: <20240806-isolcpus-io-queues-v3-0-da0eecfeaf8b@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 John Garry <john.g.garry@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Kashyap Desai <kashyap.desai@broadcom.com>, 
 Sumit Saxena <sumit.saxena@broadcom.com>, 
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, 
 Chandrakanth patil <chandrakanth.patil@broadcom.com>, 
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, 
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, 
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, 
 Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 virtualization@lists.linux.dev, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-doc@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_050724_660073_CB08BB94 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 06 Aug 2024 07:51:53 -0700
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

From: Ming Lei <ming.lei@redhat.com>

virtio-blk/virtio-scsi needs this API for retrieving vq's affinity.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/virtio/virtio.c | 10 ++++++++++
 include/linux/virtio.h  |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a9b93e99c23a..c59a193ef337 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -592,6 +592,16 @@ int virtio_device_restore(struct virtio_device *dev)
 EXPORT_SYMBOL_GPL(virtio_device_restore);
 #endif
 
+const struct cpumask *virtio_get_vq_affinity(struct virtio_device *dev,
+		int index)
+{
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, index);
+}
+EXPORT_SYMBOL_GPL(virtio_get_vq_affinity);
+
 static int virtio_init(void)
 {
 	if (bus_register(&virtio_bus) != 0)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ecc5cb7b8c91..bab3858a4c8a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -170,6 +170,8 @@ int virtio_device_restore(struct virtio_device *dev);
 void virtio_reset_device(struct virtio_device *dev);
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
+const struct cpumask *virtio_get_vq_affinity(struct virtio_device *dev,
+					     int index);
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)

-- 
2.46.0


