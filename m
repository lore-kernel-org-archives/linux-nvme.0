Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886DAC5DF66
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2026 19:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AISqMB6CvA0Lb35Q0jRjNWDuiHxCP9fPg6wK9jXO2X8=; b=xfXqIE5XiJPsKBPgCZmgT3bsg3
	MgzSYV0sFTruOGroRmH3rlfLyD+7Jct8HUDbZcPQK561glC38aba3WR5qvGKfzJb0XuwRJLyC0gv4
	wRxEXOm2YqWJQf8aDa6pVDZKIp45WCjHAzWYduk6eDSVN+80l0sPA2OJX+TEdVXPU2ZrJWsdg/cjM
	6MIeNaGa7srvSq8YNOjHi/oKiZVp6MYqCbSCd/oVvOW1bwFT7D05InFm0JisM+KqdEYuann/p/i7F
	JwYQ7bkGPttxe5umC48bn3s1X6QGvoCHXxUecmYm88pSznmyrKDYbwfNFiYMZaNuIkSL6iiVClSoh
	HuTkrLzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvgMW-0000000517o-1lyV;
	Sun, 16 Aug 2026 19:17:40 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvgMT-0000000517I-1idf
	for linux-nvme@lists.infradead.org;
	Sun, 16 Aug 2026 19:17:38 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-836c436a6b3so37046657b3.0
        for <linux-nvme@lists.infradead.org>; Sun, 16 Aug 2026 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786907856; x=1787512656; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AISqMB6CvA0Lb35Q0jRjNWDuiHxCP9fPg6wK9jXO2X8=;
        b=B3mC1JH09MBXSaMO1qTrICWCpA+sD2bwnBoxpe5R0B+nr6N68B/q6vJ1uosLFo/AVU
         ri9DLGKZZk968EqmCb/+viGErtPIx5pguurVIHCdSi737XJInudqTA2Gd4VSVL+K9ZUq
         +roG6gCwf9dfXycPniXoldbHeL75K2NMJBHLHFH81KhmlfIA9FvpdgOmcMKTiALEJxn+
         zPufH0GCHSJUVl2wAVk3gb3qnuhxUso4fzNI9bdkcCKyfZP6pb8rtXPLV9CAugCxI44p
         sZ97c8oQmlvzMe/ZJNMKsbsU4YwMM2XE/pw36H3ClWeIUiYMQXsWZ/1m6I3K4GJFjT16
         BwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786907856; x=1787512656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AISqMB6CvA0Lb35Q0jRjNWDuiHxCP9fPg6wK9jXO2X8=;
        b=GO4eZOBbV3Jsg0COPMGAP9TNkvgdd9R86EIn8bAF6KbicxLRRGkLFbMftLM7NrE2tR
         PTgHW+U+ptG7LKMcXKnqUZV5oWhLQGFssf0/eamcelPn7dzn2F5jhCcGh9P12WiFFcGa
         FuKvq61y2p6MJhze38GY2jdQGd1OUcb6kuRtKR3R+koI2dRw2xzj1de+3bDSR6MCZVZz
         tkRfYS5pTZddvy2Zl1zFXs7iHzISv+CQGqBRWXYhAGySFAoiwsThjp/QRcH5Z8Pr+t27
         wTFR464qxLJXbPQuS1sR+98r5bPsiYnkwtG+5YD3r4aAmZ+wxT3GkQJV361v21feWrzX
         PybQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEGqzToumwYOzrFEB2750cDb//7epweIW2O6XhfmNAUFnz/XHjyEx53b7E974y/bwfLEg1yWE0QTnt@lists.infradead.org
X-Gm-Message-State: AOJu0YzTyxdOrzpN0WCGS6TTOh3CbHFDIpysKztuI7+CObWd74eTKkmf
	X9uNbq3VD+dDPVbnB5bWc3f9iLK74s/ESBnibM/J6tB3dW9S8eaX3lnB
X-Gm-Gg: AR+sD123l4SGJizWnfA81zFb71YdxcdL75MGBWcg/U0FQs9GYnilqeaVB4wOJ7DovBc
	rQdBH45KpB9he4DD+mzGIFvVt6jsG8sJgf747oKABuBBduzjUgUvcQYFgKmKbK3OTh0yPsmS/RL
	r82IxQDTZBHrYAvTNdosXuCg3MakEnMkT9LD7vX1Ca5y2yimMTPzQA+w3NCqYNRtdtE5ORdWad8
	oZPqYsALlgCfhWazwHfgcBNTTpdyroVQ0Rg2FU6W48IuYiddg3IiDFvPjDGixj18Zl9rY46Qqjq
	7K86pnretRagJ7FGezvoUOQhkl7nDuLeOKXEiiiGzZVWwneVPas20DfNu91V1gLM2mZ4dBR7xFm
	imiNHWNhQHCpvEXi0lZOQH0D60BwPBbZonTiN/gZOAJQruN/rlomt7rR04I8WKKnGGJnDAzB/kk
	0uh2DGR5oYKHSHZO79Ivv078z27VXF1hTBQOQy9sMtDvpkcdXin3Y+Nz7YOgsnopLtboxNebWMG
	+wKzkg=
X-Received: by 2002:a05:690c:e292:b0:827:b35:9d5e with SMTP id 00721157ae682-83714123a7fmr56142987b3.33.1786907855860;
        Sun, 16 Aug 2026 12:17:35 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c17784f2sm38580437b3.32.2026.08.16.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:17:34 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2] nvme: skip the zoned limits update if the zone info query failed
Date: Sun, 16 Aug 2026 15:17:29 -0400
Message-ID: <20260816191729.2865523-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_121737_488732_084180D8 
X-CRM114-Status: GOOD (  16.51  )
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

Skip the zoned limits update in that case.  The namespace stays
registered and usable for admin commands, but the queue is not
configured from zone info that was never read.

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
Changes since v1:
- Only skip the zoned limits instead of failing the update, as
  suggested by Keith.
- Gate on zi.zone_size, not zi.max_open_zones, where 0 is legal
  (reasoning in my reply on v1).
- Drop the "malicious device" wording.

v1: https://lore.kernel.org/linux-nvme/20260814160954.2839507-1-coshi036@gmail.com/

 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..87e0534cde1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2447,8 +2447,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, nvm, &lim))
 		capacity = 0;
 
+	/*
+	 * A failed zone info query leaves zi zero-initialized.  Leave the
+	 * namespace registered so that it can still be used as a device
+	 * handle, but do not configure the zoned limits from it.
+	 */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
+	    ns->head->ids.csi == NVME_CSI_ZNS && zi.zone_size)
 		nvme_update_zone_info(ns, &lim, &zi);
 
 	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
-- 
2.43.0


