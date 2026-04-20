Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8325EF5A8CA
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCLQ/Lu1vC09JUaQSedZPeC4FWOIebO+etPRCyfSe24=; b=fy5zdlKbLdlHJ8JiW6Oeb8GECz
	wid72Tm2zIyiIAqqrJ6GKPqWeelL2HEWRzgcYcK1r4DgfjMA3TYVZSg1alUE4Dpg2AG3ggxd1lxHd
	bpgGJCvlGmx2ztyj8W7BsMfjYtc6oNnSsJ5XqojEgUAVjp8QTCcBiGCmtx9sHm10R3JWBYLFDTNZl
	6i9+a/LkovSxLEoMEORBLRZOAM3qGXw3G0LwY6SSSFT6n4Al8ppbmOUmBIExeNe5A8/0KLtY5BQve
	vOI0VlMx4LlhKUZIWyBaf0eaDvSFIRYCqpZqS5aqgrciWdarMiyndkMuX2TGqXIqwsv0fgw7gZ6YU
	xxBexnHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wExrJ-00000007oK3-2zDP;
	Mon, 20 Apr 2026 23:16:53 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wExrH-00000007oJR-2ey4
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 23:16:52 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-56d9ed609d2so1102167e0c.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Apr 2026 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776727010; x=1777331810; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCLQ/Lu1vC09JUaQSedZPeC4FWOIebO+etPRCyfSe24=;
        b=d9zf0MibnPrE/LmECoFsO2wDPQi+V6jtpJ5RaKh7RNO/yc9ACB+eXCnj6UNxkRByYt
         2M03akWqR81Dox+xd1WCjGbw+Ye3mZXcNbXShtxJh6t6fgUZkY20xhEbCj2SlM0HOAyt
         KMHVfzKv0JS6OM1WVQdVxHoIxbkX6nZzjl6DQmx2bLBL6axlw3DzGovL3aOBcHArLHR6
         YOHls+OSQUwgzvweaMHP7cKqg9eLKFou7IZMxPs/mLXUZg+b2lEhcyRAwjgxo1/Lg+Vx
         nEp8do0MYPluhZAdaGICDzXlbNo62rNnVcdl1mfI6Y0AjW3OsCK57FPJtT4jbFijPtbY
         aeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776727010; x=1777331810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCLQ/Lu1vC09JUaQSedZPeC4FWOIebO+etPRCyfSe24=;
        b=loikTQ5Z+ir19FZTvyEk+jz0e1k/XH4lWPyyiwZQHGmcP4og9X4MS72H015KNQZEmg
         /0i7f90YEYwPuj0TCcCkv9tCzVrXVIm4sfuRr7hOQUmXdxvsJoPMjYp/ADXbeVaxKffq
         8HFklXbkg0OXqzUsKMaXTzrJDdUJGTus9zWrR55ErnQxayVjnhC+mmRi/H+4oOVHD1hK
         rki0pNENjtWABE03GneUvycaA5cPl6ZLSD3qEEJ+16p70uifyzWB/v/bHBqZhwqwn+iE
         bmaXe068qzY0kJkAKiDa7x98SIDr2UXxB1dnfxLCJ3c6k1lurc0bG37WtWY12MiSoBvd
         azLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HoTkF9JrKYt0hyYl9p4CVM6w4XYiHaH3uI3/jIHh/aIJeGOUrhKkGHFfmLoP+81v9ya71Jk3POFVd@lists.infradead.org
X-Gm-Message-State: AOJu0YxeufS0jNt5t93UjlYIL0mE/2j8yanYub4FhS2CrG8z7zq+M8H/
	9gOQDahWUTXWSNRX3w99QhPrmRUuccc5orsaC5dJutYjk4FTjqHVzIAa
X-Gm-Gg: AeBDiesixpgG1A1XHmvn86dWIZCPEDpI3wunSvashKv1NmynxzSrkoXBWLpACzQVhb1
	/qUeFwVASfx45baRiOFbkqmTaBdOlA6XJyqxwBC3gHAgVpjkgqX1gCHXC+wcFGIZsaVufNGCqDp
	nGLrz65emKQGGlOLe7FXY81X3UroyzeW9Je7BrzAZ1sJjndxxK3yaSIAOahwSzoNNADBkfmAwZ6
	8K3tenu6RSu/sGExX+wogbuDJQbeHqTAs/in+TD419M8zia5I9+9GUI7huXmsDI2PE2XkKy7983
	1tjioL+NPcksLaYk2JofhREz78kPOFnQhjC0m0H5a++eRgoOG+JlpCMkgTGhdpNrHtiAXGnOaOj
	xBRLj8tvo9a70kdfihOCnQJSH5/Y9aNMppfcQogEt/0GDTzFX4mNJxKBjhi1npnrnvioLsRflrw
	9DERAkvcx/QhCqXNCTddnsXX1K0L0Q759LV3gP8YduDW1ubNScxnZf
X-Received: by 2002:a05:6122:218e:b0:56c:d34e:bb1a with SMTP id 71dfb90a1353d-56fa5828722mr7648855e0c.4.1776727010282;
        Mon, 20 Apr 2026 16:16:50 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa93253aesm6835593e0c.14.2026.04.20.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:16:49 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombardi@redhat.com>,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 1/1] nvme: core: reject invalid LBA data size from Identify Namespace
Date: Mon, 20 Apr 2026 19:11:14 -0400
Message-ID: <20260420231116.748204-2-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420231116.748204-1-coshi036@gmail.com>
References: <20260418042835.420281-1-coshi036@gmail.com>
 <20260420231116.748204-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_161651_684839_6F76043F 
X-CRM114-Status: GOOD (  13.96  )
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

nvme_update_ns_info_block() trusts id->lbaf[lbaf].ds from the
controller and assigns it directly to ns->head->lba_shift without
bounds checking.  nvme_lba_to_sect() then does:

    return lba << (head->lba_shift - SECTOR_SHIFT);

When called with lba = le64_to_cpu(id->nsze) to compute the device
capacity, an attacker-controlled controller can choose ds < 9 or a
combination of (ds, nsze) that makes the left shift overflow
sector_t.  The former is a C undefined behaviour that UBSAN reports
as a BUG; the latter silently yields a bogus capacity that the
block layer then trusts for bounds checking.

Validate ds against SECTOR_SHIFT and use check_shl_overflow() to
compute capacity so that any (ds, nsze) combination that would
overflow sector_t is rejected.  The namespace is skipped with -ENODEV
instead of crashing the kernel.  This is reachable by a malicious
NVMe device, a buggy firmware, or an attacker-controlled NVMe-oF
target.

Stack trace (UBSAN, ds < 9 variant):

  RIP: nvme_lba_to_sect drivers/nvme/host/nvme.h:699 [inline]
  RIP: nvme_update_ns_info_block.cold+0x5/0x7
  Call Trace:
   nvme_update_ns_info+0x175/0xd90 drivers/nvme/host/core.c:2467
   nvme_validate_ns drivers/nvme/host/core.c:4299 [inline]
   nvme_scan_ns drivers/nvme/host/core.c:4350
   nvme_scan_ns_async+0xa5/0xe0 drivers/nvme/host/core.c:4383
   async_run_entry_fn
   process_one_work
   worker_thread
   kthread

Found by Syzkaller.

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24..d1711ef59fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2407,9 +2407,28 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	lim = queue_limits_start_update(ns->disk->queue);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
+	if (id->lbaf[lbaf].ds == 0) {
+		dev_warn_once(ns->ctrl->device,
+			"LBA format not available, skipping namespace\n");
+		ret = -ENODEV;
+		queue_limits_cancel_update(ns->disk->queue);
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		goto out;
+	}
+	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
+	    check_shl_overflow(le64_to_cpu(id->nsze),
+			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
+			       &capacity)) {
+		dev_warn_once(ns->ctrl->device,
+			"invalid LBA data size %u, skipping namespace\n",
+			id->lbaf[lbaf].ds);
+		ret = -ENODEV;
+		queue_limits_cancel_update(ns->disk->queue);
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		goto out;
+	}
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
-	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
-- 
2.43.0


