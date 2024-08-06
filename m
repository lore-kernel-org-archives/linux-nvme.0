Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8685C49EA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJMIfdHHQBNU04oVVQ3gVXM9JbI7qZNMNerTEV2zluI=; b=m34n8qrWcKq1ZGAXW3AoPU2BeM
	+BDT299+hVQOt6qbp5MeUdyOoPpvFX/t1OCNXeSUxqSKcjYqBdNMO6Bz3aRLuW3JyhBnVZexyCSe4
	h0q3EXazn16ZFAhUwWDvH1AVGQdos1i3xP4Bk4UZFh+CRI6r0svwpmY8tswYgLvHHfLJNvvScy8iE
	06AMkWJQtijrEtlNLzXfeRiSEpdp80gKjpqiVK95yQ+vDsuvjFHi2YGfOH8kgD+EQGEU6KhxJ2Zvg
	5Gtd5aE2QpKtGlhPPPoXOmcIe0sDGzicuopB58vXA8YKvC0n9ntJwnPNtL7KZCfEyEA7PG4SDPVdu
	eWjvccWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXu-000000023RF-32P1;
	Tue, 06 Aug 2024 14:52:18 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyb-00000001R9R-1jwT
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:43 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56242DAE24;
	Tue,  6 Aug 2024 14:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946059; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZJMIfdHHQBNU04oVVQ3gVXM9JbI7qZNMNerTEV2zluI=;
	b=gb4GR8drrpvILcdgJztb/yWP3UWYo1PxrWyTdGyuQdTHud68XMxzqNrJYnym5o0NKtmgQB
	biHfHWhOOFB7R8dbj87RCembE6BvE/0kK6byhPBkfnB0X+8aO7F/yuS/iPYmXBNE2iCSOr
	xZSiyEdv0++H5pNTiRWm9Z8ALv8lJzPlkNEtD4QMjwUnMkOsScDhAND1pHSLHNAVzG4e9i
	sXbn9HtwNu2sE7Vgan8EA+J+bFcQu6qlsIXOBCjcvA65wyjtYtjewaNsI5+1JClFnoACjl
	ztGbsyvQPy7idFyBbS5BBQBag0IqwLoTbxWSyg7K9F7t4yc8S0UBec75xT6/qg==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:45 +0200
Subject: [PATCH v3 13/15] virtio: blk/scsi: use block layer helpers to
 calculate num of queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-13-da0eecfeaf8b@suse.de>
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
X-CRM114-CacheID: sfid-20240806_050741_639134_F1513014 
X-CRM114-Status: GOOD (  12.83  )
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

Multiqueue devices should only allocate queues for the housekeeping CPUs
when isolcpus=io_queue is set. This avoids that the isolated CPUs get
disturbed with OS workload.

Use helpers which calculates the correct number of queues which should
be used when isolcpus is used.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/block/virtio_blk.c | 5 ++---
 drivers/scsi/virtio_scsi.c | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8f68037da00b..3584a1e00791 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -982,9 +982,8 @@ static int init_vq(struct virtio_blk *vblk)
 		return -EINVAL;
 	}
 
-	num_vqs = min_t(unsigned int,
-			min_not_zero(num_request_queues, nr_cpu_ids),
-			num_vqs);
+	num_vqs = blk_mq_num_possible_queues(
+			min_not_zero(num_request_queues, num_vqs));
 
 	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8013a082598b..1c1feec59781 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -921,6 +921,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	/* We need to know how many queues before we allocate. */
 	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
 	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
+	num_queues = blk_mq_num_possible_queues(num_queues);
 
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 

-- 
2.46.0


