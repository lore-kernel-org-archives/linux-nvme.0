Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CC5D3ABDD
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C1Y3XSWy/U6IsgMkHRqthr8giq+mZw7ttSUuo5rAsic=; b=BJZJqsbaxVhCnlf6MP3zlyp54M
	JOKUAy+i/YXNaMuQUjE0Zr+ju6fh0CHR0oyMnh8q5cr6yY1sxggwSaezTD6/fk53oS800b6Q7PkWe
	mW6g/s2yxlRHC4NoJlpgHC53gMw22valTRdfd0migaFR45vPy8DolGFxNP/FvDWjk5qSmgx3uuiCt
	CCUeP/TOhJnt68jKUEGfoaGNUWmVmRJlCynPI+X1EA3e1BbzTU+fii54bL6xUXrerHxTespR0Gez5
	EQ4+qzRSsyNZEc9LImJl0IElggDwPFuw2D6blZO/iKDP614EB3NpHti3897Rpxu+sI1dspdAxmPFz
	6cVypn7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYoc-00000000ppw-35Yp;
	Mon, 11 Nov 2024 18:07:06 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkT-00000000ohn-3Jfw
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 18:02:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C2430A41806;
	Mon, 11 Nov 2024 18:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7065AC4CECF;
	Mon, 11 Nov 2024 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348168;
	bh=Vx5p+m9iGWXTMeWxv2yXtAZl1YKL5LF17c7Lkr/9Yws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GhEe1LzwYPDX8CvUWizPCEN2/5myM/JyJnn3utEFqQyogUErU2NZix93wKpQr+B0k
	 8YmaoQ/7TydDCWb/HLg8C8dk510GXNhsd0L04rgSbZaUzruuJ4+1lxA4Ic2RI1P6Z5
	 kB0mt3LEDD6o6ITa/PnfLVEjHc6MAXN/CSp0EwsNH9WYxdBFMsACPhKrDa0VZqRwq5
	 0SvMzYv11+qyV27uLTzaEtc6EJRoJVG9pfrth8h00Mf9Ac+0W/xLsz7Sw8sKok4KBT
	 MtPJLgMUoVDhwYYKlWimFYYls3KWJiBCgw8oWsvnQEJhViCz1YqrGE381qCV7JkcT6
	 fXf1wyQk2wsAA==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:13 +0100
Subject: [PATCH v2 5/6] virtio: blk/scsi: replace blk_mq_virtio_map_queues
 with blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-5-f360ddad231a@kernel.org>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_100249_944846_C5DE73B3 
X-CRM114-Status: GOOD (  12.20  )
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

From: Daniel Wagner <dwagner@suse.de>

Replace all users of blk_mq_virtio_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_virtio_map_queues.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/block/virtio_blk.c | 4 ++--
 drivers/scsi/virtio_scsi.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0e99a4714928478c1ba81777b8e98448eb5b992a..3fa1e982e4f225ae1dcc02b413459b3578d9d9ca 100644
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
@@ -1186,7 +1185,8 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(&set->map[i]);
 		else
-			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+			blk_mq_hctx_map_queues(&set->map[i], &vblk->vdev->dev,
+					       0, NULL);
 	}
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8471f38b730e205eb57052305c154260864bee95..8fdac72212bd4864029231684bb4b297131cee31 100644
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
+			blk_mq_hctx_map_queues(map, &vscsi->vdev->dev, 2, NULL);
 	}
 }
 

-- 
2.47.0


