Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD43AC3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jul 2024 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nPy1Prb3o/wWG7uB8U3QbnRbpD5QzxAKY8DdzWegWFo=; b=mzNubA1gnyTHOg8xy3uzLUxNKh
	qRPxYqftdjYkpDHAvZyR+VVl3f/uh508xUn7pjZURsGzJG/Y7z2XhtVlNSabXy8sJlF+Zl24+KAdb
	41uZihsMEURtzBLRIdzkhdpWqkLQ7qZ7uJZiecjw/QJ8kgPfaWBrAzr5heEDMaPohe9glYg7mSi58
	EnCdSeKwHcNarkEmCzcjZU98kGPUBE/N1mduCWllRGy+BUrTNvkJ97Fa4h+jgghCeOYV1kRs4GlzV
	4bF9w+xNGpegRaGfahAqfRtsvcYRcQymyg/05rf9vBgXHKFS1f7dl+eL+4jLxob1mDBxoqLuJCZwB
	dNoamfWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSPV-00000008Jg9-2O4l;
	Mon, 15 Jul 2024 20:35:01 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTSPQ-00000008JcI-1cRv
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jul 2024 20:34:59 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-25e0d750b73so1947531fac.3
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jul 2024 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721075694; x=1721680494; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPy1Prb3o/wWG7uB8U3QbnRbpD5QzxAKY8DdzWegWFo=;
        b=mXYkaVRY8QpVRCbzluUZ6axEOlv2aEjUpIw+ToSAhnaM6Yts2XDbbeM4zJK6mlgOmv
         fGNc8BEZNi/5mJ4TZM46DhPuYv6y7uTzRJldRMR39o9O34GkthlwPEBFEh4DFrsdzBTb
         5rX+Eg6OMlGOTQbsySzv8uMhj68xEhtJ/ocAZocAhlZWSZrbdCMcNwOCploaxGrqV86g
         nhJIM8nOGRa7sHVep/nK6SrrUqEizpAQtZ8DpEKGiZLtw1WgSC8uiTWs8dBcg6awPZVz
         m3Gf8xytNMuqVOQazYDIHopRnJMDIyGOU8K0L/gq0x7L4pcdGEGAF6kvqIrX3b04Wxm8
         aSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721075694; x=1721680494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPy1Prb3o/wWG7uB8U3QbnRbpD5QzxAKY8DdzWegWFo=;
        b=UOZlX55qfww45HDPnVfkvzri4vxvfIkx76wzgL4/vyG7nkfqH0RBvHvG3o9XAGIPNr
         GvL2dWW/XwH1978cuQje3EQJdcEeWy9Vx95x28mAvniX1JGx8bVCVT/5ilvE2oxSOJru
         nnfjwXczoGkBdvW6kqSwIMmGdVMtAXH+hicnimnH2DxvdlpmH/GDFfqy8EeAddN1p1EL
         ZTIuqsvjgR6qpKaIu59q4auOPq3JUZmIpfsEhdEvZGKFsz0X2vKcF5M6p8Qsk5y+n0UA
         KRjNuhMNkIRt92Fg/5lL1lVwOvvB01fe3369jXJsiIhks5E6m8VdTJiW+WlgkMZ2XHpB
         4Fvg==
X-Forwarded-Encrypted: i=1; AJvYcCVlHMcIQ3iFT6N1M2lHbfk/PRhpwlvwdynDf6BEIARMxHOfyyc/T+8QK/UHmOVILjhxFKrOI7prhpdq6T++42hyHYHbjoXoBNRx7MdiD5I=
X-Gm-Message-State: AOJu0YxXmK5KSzzIQ8ugWcHPckM3Pv4Fvh9zuKk/voZh381aiaeLLwrC
	9F92OfxG64oicpWgnrxxfepHLQLyStdy3Ii3tjdXS8tS6dPMuyBB
X-Google-Smtp-Source: AGHT+IE6XxAFdXsCIWG6g2uleZwXjz/PFwt6XjQ9OINa09RHACSB+Iu7+vdSuK+BT1XoIF2MZkuHXg==
X-Received: by 2002:a05:6870:8881:b0:25e:11f4:f694 with SMTP id 586e51a60fabf-25eae7f7a46mr17565601fac.21.1721075694251;
        Mon, 15 Jul 2024 13:34:54 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-260752a9036sm1099316fac.38.2024.07.15.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:34:53 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v3] nvme_core: scan namespaces asynchronously
Date: Mon, 15 Jul 2024 15:34:34 -0500
Message-Id: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_133456_484423_A91DC77A 
X-CRM114-Status: GOOD (  24.05  )
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

Use async function calls to make namespace scanning happen in parallel.

Without the patch, NVME namespaces are scanned serially, so it can take
a long time for all of a controller's namespaces to become available,
especially with a slower (TCP) interface with large number of
namespaces.

It is not uncommon to have large numbers (hundreds or thousands) of
namespaces on nvme-of with storage servers.

The time it took for all namespaces to show up after connecting (via
TCP) to a controller with 1002 namespaces was measured on one system:

network latency   without patch   with patch
     0                 6s            1s
    50ms             210s           10s
   100ms             417s           18s

Measurements taken on another system show the effect of the patch on the
time nvme_scan_work() took to complete, when connecting to a linux
nvme-of target with varying numbers of namespaces, on a network of
400us.

namespaces    without patch   with patch
     1            16ms           14ms
     2            24ms           16ms
     4            49ms           22ms
     8           101ms           33ms
    16           207ms           56ms
   100           1.4s           0.6s
  1000          12.9s           2.0s

On the same system, connecting to a local PCIe NVMe drive (a Samsung
PM1733) instead of a network target:

namespaces    without patch   with patch
     1            13ms           12ms
     2            41ms           13ms

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
changes from V2:
  * make a separate function nvme_scan_ns_async() that calls
    nvme_scan_ns(), instead of modifying nvme_scan_ns()
  * only scan asynchronously from nvme_scan_ns_list(), not from
    nvme_scan_ns_sequential()
  * provide more timing data in the commit message

changes from V1:
  * remove module param to enable/disable async scanning
  * add scan time measurements to commit message


 drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc1..dbf05cfea063 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 }
 
+/*
+ * struct async_scan_info - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @next_idx:	Index of next NSID to scan in ns_list
+ * @ns_list:	Pointer to list of NSIDs to scan
+ */
+struct async_scan_info {
+	struct nvme_ctrl *ctrl;
+	atomic_t next_idx;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
+{
+	struct async_scan_info *scan_info = data;
+	int idx;
+	u32 nsid;
+
+	idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
+	nsid = le32_to_cpu(scan_info->ns_list[idx]);
+
+	nvme_scan_ns(scan_info->ctrl, nsid);
+}
+
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
@@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 {
 	const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
-	__le32 *ns_list;
+	struct async_scan_info scan_info;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
 
-	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
-	if (!ns_list)
+	scan_info.ctrl = ctrl;
+	scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
+	if (!scan_info.ns_list)
 		return -ENOMEM;
 
 	for (;;) {
@@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			.identify.nsid		= cpu_to_le32(prev),
 		};
 
-		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
-					    NVME_IDENTIFY_DATA_SIZE);
+		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
+					   scan_info.ns_list,
+					   NVME_IDENTIFY_DATA_SIZE);
 		if (ret) {
 			dev_warn(ctrl->device,
 				"Identify NS List failed (status=0x%x)\n", ret);
 			goto free;
 		}
 
+		atomic_set(&scan_info.next_idx, 0);
 		for (i = 0; i < nr_entries; i++) {
-			u32 nsid = le32_to_cpu(ns_list[i]);
+			u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_scan_ns(ctrl, nsid);
+			async_schedule_domain(nvme_scan_ns_async, &scan_info,
+						&domain);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
+		async_synchronize_full_domain(&domain);
 	}
  out:
 	nvme_remove_invalid_namespaces(ctrl, prev);
  free:
-	kfree(ns_list);
+	async_synchronize_full_domain(&domain);
+	kfree(scan_info.ns_list);
 	return ret;
 }
 
-- 
2.39.3


