Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C175D78325
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cpLMQ9UUakXEja3e78DP4kkqPh47K3ImwNUxXaHJlYM=; b=KVxURml7MWgFDdsfgu2EJvksrT
	XaTrD9BAJ+QZ7iRMrubHpeeC1c7iSfqwb/ZmD7JYoyhTB9mFLECS4q03xzU+D80tKsHeaIyNLUENT
	Cn9NWCLov3oWJsosw5w+D/I51KPgW06uLXlsyp9bgD+riJt59TzbvbLKMGT/5aXFlYsEsOq+rbgur
	t//9u8Qyx+8nFXju5L6+QhjxJt4XkrKasMCKRTj9nSerSwr1OJnRPREitHjlBOqIh73hVohhH4ETx
	DmpLG7l05IuslQguQSvUDmhV0djDFrU6ZgiH8APB3Ep+DlIiTbo24ZdpjSfng0WMZLfjQJWoTqqzU
	4mPcl0PQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI70f-00000006Kxb-03V0;
	Mon, 02 Dec 2024 14:02:45 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI6yj-00000006KTL-1jIg
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:00:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5B05AA40CE1;
	Mon,  2 Dec 2024 13:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB82C4CED1;
	Mon,  2 Dec 2024 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148044;
	bh=1qmzsHGz+F9jFUsodxYPNL3VhVdPzjmOvQGIGXzUi9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bcMNbPqGAYoch4VzGMhprcovwyRobcFbRWNY1Y+WOztyE4eZtXoKeE99Xsv7lP8QO
	 aXYmt8vZPaRGb8UhTwiuCrbMQ8q10CnwyyHomtJQa1WuuHSXiHbj1POEk7gMqWle5p
	 2dRrIefQNG6XkT8kMzyB+riP+t9pEQZYR7o7gTXWIMuQFam9L8EAaTDHyTd9GIshDH
	 5HD2uV1bJy6Wnp/Uz+LxerkBr8BsQNINfjEXsb3GMHF9iEP8alPpNDMfSkoT3VFBxC
	 FxrYM23xdWkjO05BnZNLeJkKTxWiPnXRdaEkauyA3tZUjD/+DZJfWQM62/A6Y89+VP
	 eD7b748F55+6g==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:15 +0100
Subject: [PATCH v6 7/8] virtio: blk/scsi: replace blk_mq_virtio_map_queues
 with blk_mq_map_hw_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-7-27211e9c2cd5@kernel.org>
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
X-CRM114-CacheID: sfid-20241202_060045_579451_477E9425 
X-CRM114-Status: GOOD (  13.02  )
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
blk_mq_map_hw_queues. This in preparation to retire
blk_mq_virtio_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/block/virtio_blk.c | 4 ++--
 drivers/scsi/virtio_scsi.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c0cdba71f43640ccff96d83f9e63620bebdda2ab..4c82bd1ea38e444e2118a1cfbe9a3ac37de9b6da 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -13,7 +13,6 @@
 #include <linux/string_helpers.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
 #include <uapi/linux/virtio_ring.h>
@@ -1181,7 +1180,8 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(&set->map[i]);
 		else
-			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+			blk_mq_map_hw_queues(&set->map[i],
+					     &vblk->vdev->dev, 0);
 	}
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8471f38b730e205eb57052305c154260864bee95..60be1a0c61836ba643adcf9ad8d5b68563a86cb1 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -29,7 +29,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
-#include <linux/blk-mq-virtio.h>
 
 #include "sd.h"
 
@@ -746,7 +745,7 @@ static void virtscsi_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(map);
 		else
-			blk_mq_virtio_map_queues(map, vscsi->vdev, 2);
+			blk_mq_map_hw_queues(map, &vscsi->vdev->dev, 2);
 	}
 }
 

-- 
2.47.0


