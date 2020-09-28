Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478D8C4727F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B8721531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uu+6S7FX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5klDSwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B8721531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yZX1J0Re4CRp0RhVIsTqMEv+T61B3gKTLER2KYuYOQ8=; b=Uu+6S7FXH2/OhxD+cLUfSovXl
	ggZiq2OCuun7yMe/8diMCV1hkE2JpaMj7rrJaJn5EnFRRBPbQixIn+sXNIR9SougDxeEhd2Rgdk8M
	5YdbhvaGqjW/K0gs64NyJC782CmYwdmvZZd3HEnVntV15HcfL4EPSFdz4/CHZPRI8681nK/Whm9py
	ZcoAxuN6nDMx44DvyPSxzW14NYfPUgzt23K6ftwMZatWviyw+bU8qDV4+4E5m6bOb6PDhIcG7mVhP
	lXe4xfpJQuFD4NDAcgXFoG2StMs3Tn6edvgzIrcKSx+xR+4tW3SoEPoNjGrgTtBAlRBVj0N6M0Ohr
	WhPSfwYUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNX-0002Uz-6k; Mon, 28 Sep 2020 12:35:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsND-0002Nj-Ei
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MO4Y38pyTr/6rH77slh8ktgo4ZZE06TPs7d+AObtUfg=; b=I5klDSwz3iMhBv/Ru+vOCRGhAU
 dyBowxnJedav7A1gJsmZoG83V73YjQhWkJugf2vNUxShyPtv2mtaKXh1LW0yievv1DYdAMLi2S08z
 C7V7a3icVIlJ9y6QF3/jwqrOfZs0/iBh51prGWvXTlK8MycaYxWBbxGt8hxLHkWwV/FWrtFi2jMlN
 65KDN6bPL+Xyxu94j2ZtPL5zKMaNYXnPlj3ajHbNlixrBXIfNyBiPlMgKBJel3GXEnMnWjxS19UzT
 v+u+kJ8FRy5PuNsM0Jz2Bz4xcQ0KXMyDdjxruzA/W5I+de8mw2ZHGKc3rDhfshEV3OGNhniHJxMl4
 y5gALYAg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNC-0004kM-4d; Mon, 28 Sep 2020 12:35:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 10/20] nvme: freeze the queue over ->lba_shift updates
Date: Mon, 28 Sep 2020 14:34:52 +0200
Message-Id: <20200928123502.435373-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ensure that there can't be any I/O in flight went we change the disk
geometry in nvme_update_ns_info, most notable the LBA size by lifting
the queue free from nvme_update_disk_info into the caller

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 443aba9c9fdd11..82cd03c0ba21ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2021,7 +2021,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		/* unsupported block size, set capacity to 0 later */
 		bs = (1 << 9);
 	}
-	blk_mq_freeze_queue(disk->queue);
+
 	blk_integrity_unregister(disk);
 
 	atomic_bs = phys_bs = bs;
@@ -2086,8 +2086,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		set_disk_ro(disk, true);
 	else
 		set_disk_ro(disk, false);
-
-	blk_mq_unfreeze_queue(disk->queue);
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
@@ -2133,6 +2131,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
+	blk_mq_freeze_queue(ns->disk->queue);
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
 	 * block layer can use before failing read/write for 0 capacity.
@@ -2150,30 +2149,39 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 			dev_warn(ctrl->device,
 				"failed to add zoned namespace:%u ret:%d\n",
 				ns->head->ns_id, ret);
-			return ret;
+			goto out_unfreeze;
 		}
 		break;
 	default:
 		dev_warn(ctrl->device, "unknown csi:%u ns:%u\n",
 			ns->head->ids.csi, ns->head->ns_id);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_unfreeze;
 	}
 
 	ret = nvme_configure_metadata(ns, id);
 	if (ret)
-		return ret;
+		goto out_unfreeze;
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
+	blk_mq_unfreeze_queue(ns->disk->queue);
+
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
+		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
 		blk_queue_update_readahead(ns->head->disk->queue);
 		nvme_update_bdev_size(ns->head->disk);
+		blk_mq_unfreeze_queue(ns->head->disk->queue);
 	}
 #endif
 	return 0;
+
+out_unfreeze:
+	blk_mq_unfreeze_queue(ns->disk->queue);
+	return ret;
 }
 
 static int nvme_validate_ns(struct nvme_ns *ns)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
