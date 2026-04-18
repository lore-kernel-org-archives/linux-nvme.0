Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3848F99C74
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2026 04:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LXgD7NclC9d98p10sskyzvFvooGgTAnqnSUCs8hQF7Q=; b=cdBuMLUlAXBFD1gr3BC0ZI5QLS
	woEVv7oU1WWKsq0OumtP0yazIiwSJo7cV6sK+N7xCxH5OHk49X2QWmB7NSf2/B7xsmU49Bsx4Pucj
	sJklJ98e0XIA+gdw3hSLO4kKbuoIn5d8+LK6OvVXmtTSaO31hp2FEP/olhzG4kZemQGJU5aOiC4ic
	uz12GzkkM0KWAvjjYNZ95G5inShmytLWQWXsC9hb3rTTWprlKMfm2u7G/XaoDwAyYzg0QUOcD0H5z
	QNzdvvEJjEgg1FUw5u7udYHNBd2Q0YlDn+ZOvUo8gouzqQk5DrMAbq6n2kNJTN4dRD/CDIBergvOY
	9pwaTZGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDxIV-00000004jK0-2gvo;
	Sat, 18 Apr 2026 04:28:47 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDxIT-00000004jJa-15sQ
	for linux-nvme@lists.infradead.org;
	Sat, 18 Apr 2026 04:28:46 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-60fbbac2938so549962137.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 Apr 2026 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776486523; x=1777091323; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXgD7NclC9d98p10sskyzvFvooGgTAnqnSUCs8hQF7Q=;
        b=ErbYLj/KkNZTEYPXzSrYTAGeu7qvYcmKK6gtIIGU8c+C2LcDjSPtdHZXn5MNLTDEHA
         BLKVRhAZjZR/FvDontFU1PjfBNrkaQUA6TANNcW3eaLMU/nvaOf9mW8uZ6X5L8SI3uRB
         QNRylMNWFEKNHMTHiKc2OPHDnicF4GzTeLRo1Wzxa3y8TmolcqccyH4mmhIcP1NS178t
         WU7+PqmRFVvoqPkRyOogWyD/1Z9VXH/p/JSaTK4Y1Jnh9y0Kdl/ToeX2gGKXeQWWwyf4
         95i4u0ALGY3qxGlMpi7U0QW86f3Z2yPCDWra/ycBvfYvJMf1Zpw93GKXK+QOBsoj8Zoc
         3ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776486523; x=1777091323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXgD7NclC9d98p10sskyzvFvooGgTAnqnSUCs8hQF7Q=;
        b=dD+238csh6HSedZIrOt1XUJ/UFa9bkcGszY9PGS/nTWipCrHLrU9L6Bv324yjBGzVh
         IA7QbiSWyjEQlQdwA6HHAtk121e00dWkWVmECDRA683C81DBE2PZp0wtK2k3ogdVWEEW
         Tw+soBbbkVIMzs0CsbTiSo38kakN2+lFJ3BjZmAtB1ht17GbizFAYZkzB/fILy8J+Fdl
         6OcVE0Ex8p6iUwtzgeyM7E+aHtvqFrSysQPuDRXi6mTWbM6bNRZA5BTJ9oyljPOv1msD
         YPJI4miRgRXTuGdLCNARuy9NH0ckK+dKPuXX8Z3Zn4hHtCdIFGcFgO3nXOro4XwObR8G
         +W8w==
X-Forwarded-Encrypted: i=1; AFNElJ/AN8XEYdMH9pdVwqxnmuwf/4dB3WJiq+sNKDUu2gKrIlm3zVpIg8a6jxSZLA0ECuRMVe4a4V1jX4g4@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7xhy9KIj4IKDZ5YLQg6x10TyKA6hQ8oZbMrlO9VJ9uy9t2pwc
	vf4aiqT/lX+5og6s0GbkCtStYtvdqG/P5UuZN3tamztuc4s/bRKJiedH
X-Gm-Gg: AeBDievcw32l/H600pTLr70UrmGUsPDVrG+ilHBZ/Hbb20nT2aTdwSQKBpkythEawul
	/V7PdlW9bfqrP3VI9hT/kNpfJ6FoUzlQwJstNaY7mcQ302F51gIGlZuh1scr3ywQGUipGKFrGGn
	SVViwEa6DZasq0x4FfmpUuMlV7qTCRNQrh8EfHfCdAboJGHyshHPAiHB6ygdfykYzfbrYxU5VcB
	150o/aeIbueUg99wI0TxhTVGa+7g7v4fP9yNdeQaafGrJwPjWJxqi/vIpXwo9fh+y+68vwXqqdQ
	LY84QkKvynYrNLFCYjlvaEcf51GVZ/FKCEPwwCV8Nkii4O4wYKMYqLD/3eLQXhoYA8IRC+cjqau
	3tSuz64SZch085JefGNfWOWi/3heSqWvnvtG12ZCtz/f0EmigalBO0z6fcK7YoiCSOrbc65azay
	ZzohNhbOLmHaUKSV7SSv953kXzOkz44Izb0jB0ofRgSFOmkupBdGQW
X-Received: by 2002:a05:6102:c93:b0:5ff:efdc:e225 with SMTP id ada2fe7eead31-616f53a7d34mr2809005137.3.1776486523112;
        Fri, 17 Apr 2026 21:28:43 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-61745d93542sm1697599137.6.2026.04.17.21.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:28:41 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH] nvme: core: reject invalid LBA data size from Identify Namespace
Date: Sat, 18 Apr 2026 00:28:34 -0400
Message-ID: <20260418042835.420281-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_212845_347719_D775CF34 
X-CRM114-Status: GOOD (  12.64  )
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
overflow sector_t is rejected.  The namespace is skipped with -EIO
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

Fixes: 9419e71b8d67 ("nvme: move ns id info to struct nvme_ns_head")
Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24..9b3bf3e4075 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2407,9 +2407,19 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	lim = queue_limits_start_update(ns->disk->queue);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
+	if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
+	    check_shl_overflow(le64_to_cpu(id->nsze),
+			       id->lbaf[lbaf].ds - SECTOR_SHIFT,
+			       &capacity)) {
+		dev_warn_once(ns->ctrl->device,
+			"invalid LBA data size %u, skipping namespace\n",
+			id->lbaf[lbaf].ds);
+		ret = -EIO;
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


