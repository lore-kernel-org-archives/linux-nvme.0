Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83600D3ABDA
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJahdapqFJsCXyXBs57Cv5eeqt49xM98vSaxv2EwEeg=; b=NxxKeHipwRFBF1+uNRJQ7B8PFl
	mFvj8vJdoyeRc0ILLcaNL8mlL5vWEagL/4y8tYsk092qJi9DachbQXJdy8LDB5d8Ao25w5+dNmuc6
	ID+x7XVQGGV/H9ArHq6FzCOHfEA0b0T3wSL2zv67J+RYC83Xin27ishy6XaJGc1R6HYTY5NZGXJKH
	RXprVodRfCtMup9VoqHHFFvgyMiHjO4Zli3KcDW+sRruYRdGk8svXe+lFtheDEEBZZp1RcMpw0Bh3
	EWhrARbGTTh2A1ROApJpBFJ4wIPJHmUhNFauuJ7MvJjUGIWDcWEkw398ZxcnYhOeX1rN/Dl9BT8Kk
	nwl5a8RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYob-00000000poy-2AfM;
	Mon, 11 Nov 2024 18:07:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkR-00000000oge-1IkN
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 18:02:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3472AA417FA;
	Mon, 11 Nov 2024 18:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE5EC4AF09;
	Mon, 11 Nov 2024 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348166;
	bh=WAeDsicX+euuIW0kqweV/QZoBg2yhq9mlxveHEyExKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bq3mErFBO211kbc9/EzMp4ADTv5smrPyzd3ptoGPx7LmVPB72o7SOjlJqdOm7fwcN
	 aKEYn11CpLFPdaHYl/wY87SF+596lyMZL1e+7iu1AgxSVu58E3vLN47tFsIoghG7P0
	 wmKG/tT0QdZVcRuFS5amZr+dK+F7GgxkNmixF94bbXT2tbFO2IjrmXohOPoZ5qfRGC
	 0DJXez0cshPfRmG9ty0jnODhXB2VrwL9lmfYSQYKDzOrhpiKDPYbhRJWRNZ35I4Zqj
	 8V32Z37iwUQK5qi4OoLGgtpKckEz1/6J1ji/3hXzubojvP1LcfSSJpEFpE0zO5WINi
	 DSt/tpJroFktA==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:12 +0100
Subject: [PATCH v2 4/6] nvme: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-4-f360ddad231a@kernel.org>
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
X-CRM114-CacheID: sfid-20241111_100247_470976_C3A015B3 
X-CRM114-Status: GOOD (  12.38  )
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

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_pci_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c  | 1 -
 drivers/nvme/host/pci.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94c421387033bf8361a9cf8a867486..094be164ffdc0fb79050cfb92c32dfaee8d15622 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -16,7 +16,6 @@
 #include <linux/nvme-fc.h>
 #include "fc.h"
 #include <scsi/scsi_transport_fc.h>
-#include <linux/blk-mq-pci.h>
 
 /* *************************** Data Structures/Defines ****************** */
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a33af4d7030b72532835b205e9cbb..2180ad4797923422361615d1387c2b5d3181d0a4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -8,7 +8,6 @@
 #include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
@@ -457,7 +456,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL && offset)
-			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+			blk_mq_hctx_map_queues(map, dev->dev, offset, NULL);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;

-- 
2.47.0


