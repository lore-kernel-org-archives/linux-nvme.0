Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CAFC5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TICx1S6M3SSE9LLwX9NrLNWIBAvmWSHkNpsaEs/JHlY=; b=vg3C4nFLU4Xv74YQ1knq8VzgXt
	u/e6prRVM5TiM9zk7YGJGtpXwgwhZj8ewwkUbZOPlLzqzEvfxxIW6bPSmjZ9GnOap3c1526vsoWHC
	mvClcL+WwJKGaV28fVNSO1EIgYWxvSvh9zOXOOW7LuhcCJaMO2UFhVsF7tKCqna2xNJf3JBEAu2+V
	58x4GEzcnPJZ/aKRVSyjrLgRYZLpd0JaHfDff20t4h8kfKoIgKY5eAYkWTAJt7cOv+aY33rvH+qLs
	UbMiqhdhh7K/V2sKnNjeAWloW/yq2ibBGn5uP5xaShij5oe+FSdOJwxcgf0om4wPiYLxKyrKEo6Yu
	rNeYoAEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww1c4-00000006dQw-1pEq;
	Mon, 17 Aug 2026 17:59:08 +0000
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww1c1-00000006dQX-1vOm
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 17:59:06 +0000
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-66c7a743cf8so259699d50.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989544; x=1787594344; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TICx1S6M3SSE9LLwX9NrLNWIBAvmWSHkNpsaEs/JHlY=;
        b=Nsh4yJjG3zU2INu63M6EQgsQnIEXGpToxMzy17pE0iAtvM8NUg3YZ+s4SGCYzM6zbI
         YewXEN56iFCVQhB60VaKQOPpGeQXrzowWxIDuQIGK+Zf7u6BR+0YmavQyeJITPZlSMB2
         bZzG/3Y55yzljCqxcIyU5kSeKsIjxfo2gOjRBNGrWKh2Ukvkgw+H5P6MKzNNcfoSxdmH
         ithWj4Kw6UgU5iREesLSvU+qFgAgjhWzq26poijcCqeLGC03/ppryKyfmVmp1emka8Ux
         KjdT7OznjhuPSta5orBcG4WBcmRO+0y/is81SM58Ji2POjud9Q7E3395Orx4UQuBwZ7g
         lHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989544; x=1787594344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TICx1S6M3SSE9LLwX9NrLNWIBAvmWSHkNpsaEs/JHlY=;
        b=J+QJnxvXKxENflfuRxTTiT3dz/jKIbiG3WUB8yJdYOXH9D9gwFXOeAskv7lVLLBVfQ
         /9/GGR0JEVUNElODPz6Uun1wUCEW2TZsTPwii+GfZK/AQKIfb245wuvWbnyp2Ru3uwSk
         s0nhTyw0SYTi219cZYT8GKddlmnExYr16Nn+Hsa30X+b7tPdAYNJ0EIUar2bTGrSC+1V
         hekQ53UN3NkJDynSLfCs/OBNvwbA4nP4CkMKdQkaeirfT3z6VaGO+iEuoJx4UsFIdOqx
         Wx8LdkZH/UoTcMDF4JrSuWbgYjO+61LldkFrqesaHFsw9eM0tNTGQmy2dMN/sePz3CY2
         1QZA==
X-Forwarded-Encrypted: i=1; AHgh+RoTqUhfYLGR0lRSzS4nAvE7bxEFVPN99SSsdSYfyQZNl9pBgQwItL71LEFIlMJ4qJPLZBoH2XkitI98@lists.infradead.org
X-Gm-Message-State: AOJu0YybMADaBS1Uo6Ni3JnYb+ANBsl1aPMEhEQ6P/7+bG8hrg0Se+k4
	cfpimYI84D0wJRKF3XOQIfvyxvVQTp4YgTNhw/dMaWQ5xFXja9TSjYC/
X-Gm-Gg: AR+sD119aQOsiTdKw/xUh1R0uDzWlfftf9D1TUzSz8jxyGtigoL8QIBLINabG9Rugls
	LXjsCUX9z4ICtw5qZcLsWhcqzwt8WR3TBHOayP1dKybeG74GcEKPIuffR5SYeTACDJJeHnmNdsL
	EgHh0K2Bx3fIALKDNj7UMm1XzJxJ9gYw1cC1BekR0BJL8oyRzEv3RHN6yAxLhXpt9s7jWsrOKdG
	IieGgYFpnqtViMLHUIAJeu7Y8ox0/0kZIrJZoE+8Ip6ybUMMqLHb/f297J0chG46KoU8w8VuJ8E
	3He+GOwyr0d9Dhs0+vVkM8APUVFnGEh1e3frF8Wf5TmhPsj28AR5qE3wH5IObNpyPBTZr1jQH0c
	buhc2r4oLvmAeDLS7egSw0u4Iw6a0Nu+Tvkog9vllSTcN7IDBIgosLoiti8ePfFquTy0zcPngXh
	pR4aNeKbMIcASYWOcNCx8WcIHqBdmSD5qyqIV+Q+VJsCDXUhH40HiKzt996Iye/Pzki4oCkhAZ0
	FEb1PQ=
X-Received: by 2002:a53:d94d:0:b0:664:c5f8:e342 with SMTP id 956f58d0204a3-66cbc0c01dcmr292247d50.3.1786989543723;
        Mon, 17 Aug 2026 10:59:03 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb3eb8374sm1136431d50.1.2026.08.17.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:59:03 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	dlemoal@kernel.org,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v3] nvme: skip the zoned limits update if the zone info query failed
Date: Mon, 17 Aug 2026 13:58:59 -0400
Message-ID: <20260817175859.2966055-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_105905_537716_E6F733E4 
X-CRM114-Status: GOOD (  18.10  )
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

nvme_query_zone_info() returns either a negative errno or a positive
NVMe status code, but nvme_update_ns_info_block() only tests for the
negative case:

	ret = nvme_query_zone_info(ns, lbaf, &zi);
	if (ret < 0)
		goto out;

If the device fails the Identify Namespace (I/O Command Set specific)
command, or the Identify Controller command issued by
nvme_set_max_append(), the positive status falls through and setup
continues with the zero-initialized zone info.  nvme_update_zone_info()
then marks the queue zoned with chunk_sectors and ns->head->zsze set to
zero.

blk_validate_zoned_limits() does not check chunk_sectors, so the limits
commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
size, but by then the limits are live and nothing rolls them back, so
I/O keeps being submitted to a zoned queue with a zero zone size and
disk_zone_no() shifts by ilog2(0):

  nvme0n1: Invalid non power of two zone size (0)
  UBSAN: shift-out-of-bounds in include/linux/blkdev.h:747:16
  shift exponent -1 is negative
   disk_zone_no include/linux/blkdev.h:747 [inline]
   bio_straddles_zones include/linux/blkdev.h:1058 [inline]
   blk_zone_wplug_handle_write block/blk-zoned.c:1423 [inline]
   blk_zone_plug_bio.cold+0x25/0x1c8 block/blk-zoned.c:1605
   blk_mq_submit_bio+0x18fb/0x2870 block/blk-mq.c:3196
   submit_bh_wbc+0x575/0x740 fs/buffer.c:2824
   __block_write_full_folio+0x728/0xdd0 fs/buffer.c:1933

Any device, firmware or NVMe-oF target that fails this one command
reaches this.

Skip the zoned limits update in that case, and log which of the two
things happened: during a revalidation the queue keeps the zone
geometry it was last validated with, and on a first scan the namespace
is registered without zoned limits, so that it is still available as a
handle for admin commands.  Neither of the paths in
nvme_query_zone_info() that return a positive status logs anything, so
the failure would otherwise be silent.

zi.zone_size is an exact indicator: every path that returns a positive
status returns before it is assigned, and after that the only failure
left is -ENODEV, which the caller already handles.

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Cc: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Suggested-by: Keith Busch <kbusch@kernel.org>
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
Changes since v2:
- Mention the revalidation case in the comment, and warn about which
  of the two outcomes happened.  Both per Christoph's review.

Changes since v1:
- Only skip the zoned limits instead of failing the whole update.
- Gate on zi.zone_size, not zi.max_open_zones, where 0 is legal.

v1: https://lore.kernel.org/linux-nvme/20260814160954.2839507-1-coshi036@gmail.com/
v2: https://lore.kernel.org/linux-nvme/20260816191729.2865523-1-coshi036@gmail.com/

 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..5ceab58e8e4d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2447,9 +2447,26 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, nvm, &lim))
 		capacity = 0;
 
+	/*
+	 * A failed zone info query leaves zi zero-initialized, so skip the
+	 * zoned limits update instead of configuring the queue from it.
+	 * During a revalidation that keeps the zone geometry the queue was
+	 * last validated with; on a first scan the namespace is registered
+	 * without zoned limits, so that it is still available as a handle
+	 * for admin commands.
+	 */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
-		nvme_update_zone_info(ns, &lim, &zi);
+	    ns->head->ids.csi == NVME_CSI_ZNS) {
+		if (zi.zone_size)
+			nvme_update_zone_info(ns, &lim, &zi);
+		else
+			dev_warn(ns->ctrl->device,
+				 "zone info query failed for nsid %u, %s\n",
+				 ns->head->ns_id,
+				 blk_queue_is_zoned(ns->disk->queue) ?
+				 "keeping the previous zone limits" :
+				 "not enabling zoned mode");
+	}
 
 	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
-- 
2.43.0


