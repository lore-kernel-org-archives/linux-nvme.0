Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C5BC3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gVgkRl5AhJ2SUFgxgB2iVGZTZ3mEQr8KMCr4SQK3Lvg=; b=IGXZtPeAgQhOcyvRJD94jsBKjw
	xfhjjfYIW4cDXxZB7kw6xkaspd7uu4sSEFYofWCGgMDuys00+uXfxKLAf1Z/dIV5JZnqd3lYWbSxR
	MV5TTLWiXx59b5kF5wPHIQYZdEnprtglrcLtCTKIdwQwa8xKPLlni0d41smSL764BF1ibQkQ7ospo
	eP7QVGpYwHiv6zMhores+weS+S3DaL0mLT5Odq784erytPwrP6w9FndZi+FXtkV+aFeo8P3Yxq7lj
	qDAc5e3eh57z0Q+tI5JFbPC9+ikcxJifl2I1MNZqY7EF3x7IlRjakkNLdO9CMgqx/ghKhALWaodG/
	gOEv0Fkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbLXd-000000023AI-1AHP;
	Tue, 06 Aug 2024 14:52:01 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIyM-00000001Qyt-2T44
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 12:07:28 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5C37DAE1B;
	Tue,  6 Aug 2024 14:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1722946044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gVgkRl5AhJ2SUFgxgB2iVGZTZ3mEQr8KMCr4SQK3Lvg=;
	b=bFdE/NdFUoVI4UlUon6XqoqWP9OBF+fswKi6sC7ewaa6hDnyd6cb4gcxoW08Z4sUJwyODS
	nEQCyq0gLQO8jOWcDPSkBLkNMRRFF0Igz8k96gwVTIIE36SlEQuegnqXwYfCosf5iG0EET
	GGQAwhus3zKZ0CZcVjF3LksgKUPhz30xTsnuidOADNtaAP4F4hz7i88yFuH7WZ++mEt0nd
	6/ELgpGqN9MeZTc/FyY/2UEg0EpkQtL/gTpgD2RJP208PLgoSc1eyeri6rhNa6VpAaNJ3h
	Ie85NDQER96b9WCwSFopN6+wfk1aoco5YVUmB0DmWDalIhyYwhu90vT4+eB5Bg==
From: Daniel Wagner <dwagner@suse.de>
Date: Tue, 06 Aug 2024 14:06:38 +0200
Subject: [PATCH v3 06/15] virtio: blk/scs: replace blk_mq_virtio_map_queues
 with blk_mq_dev_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-isolcpus-io-queues-v3-6-da0eecfeaf8b@suse.de>
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
X-CRM114-CacheID: sfid-20240806_050726_817475_DF73E5BA 
X-CRM114-Status: GOOD (  10.05  )
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

Replace all users of blk_mq_virtio_map_queues with the more generic
blk_mq_dev_map_queues. This in preparation to retire
blk_mq_virtio_map_queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/block/virtio_blk.c | 3 ++-
 drivers/scsi/virtio_scsi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc105..8f68037da00b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1186,7 +1186,8 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(&set->map[i]);
 		else
-			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+			blk_mq_dev_map_queues(&set->map[i], vblk->vdev, 0,
+					      blk_mq_virtio_get_queue_affinity);
 	}
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8471f38b730e..8013a082598b 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -746,7 +746,8 @@ static void virtscsi_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(map);
 		else
-			blk_mq_virtio_map_queues(map, vscsi->vdev, 2);
+			blk_mq_dev_map_queues(map, vscsi->vdev, 2,
+					      blk_mq_virtio_get_queue_affinity);
 	}
 }
 

-- 
2.46.0


