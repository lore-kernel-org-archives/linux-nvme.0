Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FC9CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QSi0U5scWG8acBST7RqnHrwKWntKtZB1nMVqsvrLh3w=; b=sscsB3ySRKLgFkJ1oRRVgp88Yu
	LTVj++hnUDZlG1x3eRub+v9YOm7CGFt+bFnI7SB7x7IsmzUc9H3iAwfQzmmMTyzXfMaqpU9h9Gbcw
	GH8VWNtsXhg1FDYYvWffvid9juZikveFN3exzW+e3kiH425YrVMRil+IIJmIAWSLC1YHIcwbD6+ya
	PQ1sH8qiD6eMfKvXmlWZvesfbKZx56+GM3l5+/zTmrnO/QgkKGCGH9kPqaJv3t0T0ul5dnZ6Z27E8
	uXkqNMOrk2qYznYXA35QtYpTUMjv5be2rYwt+g7JNkaV1szKyMM3yPA82GbtQLvX+L+9E1/rNcdUu
	FCMmkozQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNxkU-00000009ART-32DB;
	Fri, 15 May 2026 18:59:02 +0000
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNxkS-00000009AQu-04q7
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 18:59:01 +0000
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-6312d29596cso103807137.1
        for <linux-nvme@lists.infradead.org>; Fri, 15 May 2026 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778871539; x=1779476339; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSi0U5scWG8acBST7RqnHrwKWntKtZB1nMVqsvrLh3w=;
        b=WIGbFHqGvezR6hZ/eBiobKUQo3W8slcwsfHyo8AR3aiu4xzkjZ++fe1JUOKJePlaZR
         h1N7iGdp4HOLQRfnwWcSz12KsmSFSjzo/Vl2XSkc2Un8/uoaLvxqTw7cS0Vipq1XhHP0
         dCyXZZh9i7EcZAZc6wBhE/0b6y3AASjrx/acp8ZIkA9yMjLQhgHTFVduyxxiTDjfLUAs
         dLolg1c26em+ojxsGEqrbZbTlHKs0R/WEOTBWv71fQ/v04OVpJdc7lZVe9OdKJxRZ36Y
         ccVHlLzQeAxEDN0VpIbICLI0AWso4oEKajOqGjKyAzJkZpYlVe9OCSCa6hYjupJJY+fG
         d45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871539; x=1779476339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSi0U5scWG8acBST7RqnHrwKWntKtZB1nMVqsvrLh3w=;
        b=K+GVhKLKdFzJdb2ilVqmiytF2A9fn56uE1UCpgS0jn0lcpf2T7KqBRc+bfOuRqobJX
         /D2YM+nk/p80iOnfCc7vXCTVEqrHblgjGjxMD1hmvAxBKErsCs3h3sCprnfnYuNv0wca
         0Z1f7rZpv5FxcGDBczfa+ELyMbkv01x+2FLSnsvs/0mutPKTyDcGRTd7oOvSKUT0YsfG
         9QCaRHY9domGARhl9aDnm89Sjbw1xwRfum5KfKWp1htjhPLyUoNNEQgicJXga/khwaTq
         PZ1QQS3hBPMa/vbOOqrAL94uyQndRpNuGaicrgJF6aFxKUHlZT41Z2hh2MjW5FsvhVB0
         jEGA==
X-Forwarded-Encrypted: i=1; AFNElJ9iubpzLBCx+GNK44DHuH02+g3tERJVOrWLqMI3RrTiQRHdgEsWlO2sLkEglyYCc1tNJN9hlf5Aqz7U@lists.infradead.org
X-Gm-Message-State: AOJu0YwCp8r7jhUGSluBEdU8qStC6yE3TrdXAVA4iF2WYg6YBIt4dap+
	0Fn6maEh4ujuo2erA6e+AMnAEie65KeaBmleQN/n+i96c/1PyWmsGLWd
X-Gm-Gg: Acq92OEJaBPG/NJ9e7rP1hIV7yIHNSViSkoVpf43BzOWrdgZMgs33xY+CbWqatfiCmG
	P3pc0ym0fv+p+nK7NsYVYP9rdBAR8MMNAK7NzFvzxENc47PQ7N1nOqX3MJRD4FUbFwi2hU17U4O
	wK/JR+0k5/kKOagzcFkBc+ENsUCwvxMTIbwV2m0NXkzyvx1PDLwpZC/fzecmNMBLWiGI2M+sxhv
	eSk4VJQGAw29V7TmZHp5mxvzHEqGMX1aunyaclnabqu0yLcElNR+VyWBMbaTVloNtufhgZSqiwU
	bbRBVO0cxmg2zK1gCM+WZd787cou/AvStUSgoU/WQa3nFzMNHtq7eEYHmlpXMIw1DtseeIAXHEy
	WG2P8PSsyinuLkQxFqadbFAR59/NdSW7jTcKM/7GKdyds4k+Mt+z0T4bCmbpQQODSM1PNvlEZc+
	bNS6UpJDiTlVaV1ZuAnVNua/FrbTh3/izDtsKxuYsQ3XJcUcJvR8cG
X-Received: by 2002:a05:6102:3048:b0:604:f029:224c with SMTP id ada2fe7eead31-63a3d3257b8mr3530733137.8.1778871538584;
        Fri, 15 May 2026 11:58:58 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2cc387esm1588052241.4.2026.05.15.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:58:58 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v3] nvme: core: reject invalid LBA data size from Identify Namespace
Date: Fri, 15 May 2026 14:58:53 -0400
Message-ID: <20260515185853.2761456-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_115900_064985_6C9ABA6F 
X-CRM114-Status: GOOD (  13.98  )
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
overflow sector_t is rejected.  The namespace is skipped with
-ENODEV instead of crashing the kernel.  This is reachable by a
malicious NVMe device, a buggy firmware, or an attacker-controlled
NVMe-oF target.

The check is performed before queue_limits_start_update() and
blk_mq_freeze_queue(), so the error path is a plain `goto out` with
no cleanup needed.

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

Changes since v2:
- Hoist the validation above queue_limits_start_update() and
  blk_mq_freeze_queue(); error path is now a plain `goto out`.
- Merge the ds == 0 case into the general invalid check.

v1: https://lore.kernel.org/linux-nvme/20260418042835.420281-1-coshi036@gmail.com/
v2: https://lore.kernel.org/linux-nvme/20260420231116.748204-2-coshi036@gmail.com/

 drivers/nvme/host/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24b..12ff562dd142 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2404,12 +2404,22 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
+	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
+	    check_shl_overflow(le64_to_cpu(id->nsze),
+			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
+			       &capacity)) {
+		dev_warn_once(ns->ctrl->device,
+			"invalid LBA data size %u, skipping namespace\n",
+			id->lbaf[lbaf].ds);
+		ret = -ENODEV;
+		goto out;
+	}
+
 	lim = queue_limits_start_update(ns->disk->queue);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
-	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 	nvme_set_ctrl_limits(ns->ctrl, &lim, false);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
-- 
2.43.0


