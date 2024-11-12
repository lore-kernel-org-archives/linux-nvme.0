Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E21FD3ABFB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 13:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wE8CEzttDNLlizHvq4BaCGsg1OiZT2VCBPWrTko35WU=; b=jXV0BZvsJVxamoYye9jPqugWB8
	jbOGE9Q15GluLPw0opUbx0yJfhzyl2yRvrH0Qwgt/r2Hej7L0hPekknCUnMvRf3IlumGX7AiiGb6u
	aSUMAIJDPuhh2RXHvqMlpifAw3ybUYpthbx08YOvMFA9uIJYbN+q4ef7s7zSmvBUB4lZSsUKfU0Zm
	HjZ+KPtzS28+Akf7pkIZWMrXpJTR7/WZ3MbQQYx8bZtS9dbJGew9BubIVHup2DgCpcMyszxW6bO8v
	WF+YPfAJDRIenUwfNRZJGNkLnVsvTWKE9gjcYPfRd9RJUSBLT3Qa8LhLmvhYiYXArkh9tRcFABk5S
	HUIqsIog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAr0O-00000003a3R-47cD;
	Tue, 12 Nov 2024 13:32:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAquy-00000003Yc5-1jSR
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 13:26:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 944715C57A3;
	Tue, 12 Nov 2024 13:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FEFC4CECD;
	Tue, 12 Nov 2024 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418011;
	bh=hDUMtbUF9lOGt8Tp8509IEDUATl8eXb+DFyldkZ3kIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fijMChNmQC22mU/W+WLWR9c87pxD4L/Erddapj4nz4qucP4TLyvN9Uvv7CDW1Yd40
	 KtAaVTdJhQ1rr3RbEiGOjLIy2569PJMmDobq0UQ0uGF+jROxW6GE4oce7WSnuq/v+O
	 isV0N0hM2eFhGO0vXfX6JBVahgHI2R8wH8q6NkM6dCnC8xMSfKMU+tQ0AkPgncM44V
	 v9hjvC3076NRGKOUi+SrjTmfdFKCRLSPycFwfgmGMZ/rG38Wiys2ucqNHyAcuXZLsY
	 H04IO5uRWhiCGtABl013IommV/Zx7uVsfog6IEYDlh5Ndjt4QpOPxD2aqf+0zJ/d4X
	 CUW2tXLVxXuYw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 12 Nov 2024 14:26:22 +0100
Subject: [PATCH v3 7/8] virtio: blk/scsi: replace blk_mq_virtio_map_queues
 with blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-refactor-blk-affinity-helpers-v3-7-573bfca0cbd8@kernel.org>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_052652_637060_724C54D7 
X-CRM114-Status: GOOD (  12.37  )
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
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_virtio_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/block/virtio_blk.c | 4 ++--
 drivers/scsi/virtio_scsi.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0e99a4714928478c1ba81777b8e98448eb5b992a..fd997e3381526eb3d7a21eda296b3a8a2998c696 100644
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
+			blk_mq_hctx_map_queues(&set->map[i],
+					       &vblk->vdev->dev, 0);
 	}
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8471f38b730e205eb57052305c154260864bee95..dcb83c15f90825bd7bdb3a5f541108b934a308f3 100644
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
+			blk_mq_hctx_map_queues(map, &vscsi->vdev->dev, 2);
 	}
 }
 

-- 
2.47.0


