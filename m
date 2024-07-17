Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EFDC3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1lxHl2np1Jk3+/gNwG5PlAzWq2/ygmTvCtMhCUVxRYk=; b=TvSUsmJKfPxOVzvCJpCd+WWlyy
	BeP5ZpjtAebdlP6chaN4CZho81uGlHWenya35mh72kyZQhK2iJF+ewPRgT1WyBjvfV8WggQsI0qwt
	3rdY8vKVcfB27SDyxRu4xbeqFf3IDvXoZsa2/D7rA07o49R1NvsOfNUDKXnC61TsPcS+BSGzpiSOe
	LwFnznHZ+FZZl7K4wjhAdtTJ8xM4O2scOSWe6RjLZrb84xuzvEaXjdUzb1+Tc7ckyVhjPyCVI7sZB
	5ySRh8W128R7CuNNyk5jn3YgENlGlTzw4touPiy4ynZ73XjDYZUh31E4iDdSetQujPzpjJQCxBBkX
	8xmn5q5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU9p3-0000000EfH7-156t;
	Wed, 17 Jul 2024 18:56:17 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU9oo-0000000EfBh-3io5
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 18:56:07 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-79f02fe11aeso510210085a.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721242561; x=1721847361; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lxHl2np1Jk3+/gNwG5PlAzWq2/ygmTvCtMhCUVxRYk=;
        b=a47hw5j+L941AsghYHGUTO/heU3PnPTjLheZiudHH4lO3hAZEfA+Vxvu7wyI6CEe/r
         G3O6zHtQfJoI1tx7vE8+4m3eHrZm3lLIuk/AGJdo9ntfANeghUcMnLUGXOXKEtz+nqfk
         AZzm2XgE+0H16v/bQp2s64+Z7gRqjjGwOual1znHFOd7mFyNcQIE2ISFJF1S87GWrIoO
         jbcqIM2F5VZ1cexIBVzoohTV7My5FU6n0vVbd4Y4f8NAtWsJ8GoJDPdDaE/+BFodh1WR
         2rJLJ5wXK4Dk2WjUavdg1l7zUQWq5NaFSXYrEsczOp370YJEJVzyRPyCwlp8uU0qkJDn
         JikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242561; x=1721847361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lxHl2np1Jk3+/gNwG5PlAzWq2/ygmTvCtMhCUVxRYk=;
        b=MXCZaTafpoTqZkvjbNc34Ul84R/iffL3xj6GEUp67OxlvRe5gp66OHwGNQIjqWEvMJ
         /rNQKuiq081nxTpcPotY2jdZleIrmlZ3q0zrOA2o4ONeWyfPaUWZopy2euqyPwubUeDV
         Yz2PkYCGNSRbGP77iQUN/S34PvlcSR3ugC9BrT9ug6l7+GGSNW+/ha+nGv4c7TrNAgaD
         IzoLYcySDNRmHXrcHq+mFFJOv9Umi2v9IpWCBX3wWK0jc4xhEwnuFBwMDaz+zcGr0RZu
         VnEo6uTyfxPZ1gE7fDJvRyTUWExXWdfyefBHR8qzPLUbEJZ3ZYCKfbZIQalxuN1Mlxtg
         oezA==
X-Forwarded-Encrypted: i=1; AJvYcCVhAgZi5NpD1a9pvlNVHuuPs0OllN7LlbpNSg+QcCaA00f1jZH9jUBHg0Cz6AjYfHxOMAtmz931nRQr0xpkVWx6Afd6eIKGw5/odE6UVSg=
X-Gm-Message-State: AOJu0YzEng+T+7+GwM4WnIpAcXOot3bGOjp8hQi93e+EG7rLa0kTpLuc
	r+FJAIrsdZyrJ8sKU55NL3tRw/jMyuV1wdmo6HL8iW0LoodPCo4j
X-Google-Smtp-Source: AGHT+IGoc0+gXThdh0a0Sq8yiIPMuEdi0Rv91IXt00KGyTz1QiLvxPhmEU1NFjOQjUAszTxS6GBqxQ==
X-Received: by 2002:a05:620a:3954:b0:79f:502:5ac0 with SMTP id af79cd13be357-7a187504355mr268587985a.73.1721242560491;
        Wed, 17 Jul 2024 11:56:00 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f1f98sm51792761cf.43.2024.07.17.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:56:00 -0700 (PDT)
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
Subject: [PATCH v4] nvme_core: scan namespaces asynchronously
Date: Wed, 17 Jul 2024 13:55:50 -0500
Message-Id: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_115602_953928_8455929E 
X-CRM114-Status: GOOD (  24.39  )
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
changes from V3:
  * changed "next_idx" to "next_nsid" in async_scan_info (cosmetic)
  * added comments to struct async_scan_info
  * changed nvme_scan_ns_list() to use local ns_list pointer

changes from V2:
  * make a separate function nvme_scan_ns_async() that calls
    nvme_scan_ns(), instead of modifying nvme_scan_ns()
  * only scan asynchronously from nvme_scan_ns_list(), not from
    nvme_scan_ns_sequential()
  * provide more timing data in the commit message

changes from V1:
  * remove module param to enable/disable async scanning
  * add scan time measurements to commit message

 drivers/nvme/host/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc1..dc43146dc03d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -3952,6 +3953,35 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 }
 
+/*
+ * struct async_scan_info - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @next_nsid:	Index of next NSID to scan in ns_list
+ * @ns_list:	Pointer to list of NSIDs to scan
+ *
+ * Note: There is a single async_scan_info structure shared by all instances
+ * of nvme_scan_ns_async() scanning a given controller, so the atomic
+ * operations on next_nsid are critical to ensure each instance scans a unique
+ * NSID.
+ */
+struct async_scan_info {
+	struct nvme_ctrl *ctrl;
+	atomic_t next_nsid;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
+{
+	struct async_scan_info *scan_info = data;
+	int idx;
+	u32 nsid;
+
+	idx = (u32)atomic_fetch_add(1, &scan_info->next_nsid);
+	nsid = le32_to_cpu(scan_info->ns_list[idx]);
+
+	nvme_scan_ns(scan_info->ctrl, nsid);
+}
+
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
@@ -3978,11 +4008,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	__le32 *ns_list;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
+	struct async_scan_info scan_info;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
+	scan_info.ctrl = ctrl;
+	scan_info.ns_list = ns_list;
 	for (;;) {
 		struct nvme_command cmd = {
 			.identify.opcode	= nvme_admin_identify,
@@ -3998,19 +4032,23 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			goto free;
 		}
 
+		atomic_set(&scan_info.next_nsid, 0);
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
 
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
+	async_synchronize_full_domain(&domain);
 	kfree(ns_list);
 	return ret;
 }
-- 
2.39.3


