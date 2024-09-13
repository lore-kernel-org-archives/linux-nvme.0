Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D6CEEE245
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UreZcli4Fx6w8I8yVByocuzW2gBfgkNOof6cJpvayfg=; b=s2SvFA0HeXeAwCNUp4sr6gS1Io
	Rf/LYe3lgot2WlIo0TWJZnU4rdEn3Dmgrd7WV0i452K23aVjq7rHpr9WhQHp0P2eAGLD2AlGUyWec
	jkD3hp5a0iUfAapFrRPHOAi2KjG6yY8DDlNsGEyIMfbaZoBOgj76YJ4P0HzLX606gzzr9WnRho9Rp
	eEsskc2BCSmKYmAq7KwXPLjOSue6T3kPwsfg0Tsad2pLDrCvw/s1Ynv/ehZK6ei8tOE4TcgLqQCCl
	1KyCKwI1oHxFA6vm4V+mpXAIpI50KGKIouavk+uvRc44I9ysgMjzID643SMMflVZcGYqzgb8kt6kM
	L9nEH+jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0x1-0000000FBcK-1uie;
	Fri, 13 Sep 2024 07:42:43 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp0ws-0000000FBVS-30Jm
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 07:42:37 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 962A4DAD40;
	Fri, 13 Sep 2024 09:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UreZcli4Fx6w8I8yVByocuzW2gBfgkNOof6cJpvayfg=;
	b=QYcoD5lOq5miIjgASYtgJ1k9mSIbUv1+n/ykip9v56vX/uP8M1YiAmy7ar1hfq3JJ8+ql5
	CYcgvU3Khw9bKSHwcHpuow+L4sp4ZTodwoSx3KX5jJXgNcrcSTAkATudG2irqfsHBIMhhG
	h3BvGGVYpHTMG1jhgIvrfdY1gum/CiyTu4oFkZxATZ0Ur64opPf4NABoDEeuiJ2QahTiEn
	Ga3FzGegiuN8Oehw+0CA4RNJU4GqYiyyuw67yryPzPD+IWJ2f9imH3MB7o9rlNyNLl1qHm
	37TMwuvez5SbilXeVfImp0QN9eUTykoU0rUhYnywP0KOHEEziY9dsJS/PMXIfQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:42:02 +0200
Subject: [PATCH 4/6] nvme: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-4-8e058f77af12@suse.de>
References: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
In-Reply-To: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
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
 Daniel Wagner <dwagner@suse.de>, 
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_004234_944656_9D8CD1EA 
X-CRM114-Status: GOOD (  11.97  )
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
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c  | 1 -
 drivers/nvme/host/pci.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94..094be164ffdc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -16,7 +16,6 @@
 #include <linux/nvme-fc.h>
 #include "fc.h"
 #include <scsi/scsi_transport_fc.h>
-#include <linux/blk-mq-pci.h>
 
 /* *************************** Data Structures/Defines ****************** */
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec..4af6931af19f 100644
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
@@ -457,7 +456,8 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL && offset)
-			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+			blk_mq_hctx_map_queues(map, to_pci_dev(dev->dev), offset,
+					       pci_get_blk_mq_affinity);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;

-- 
2.46.0


