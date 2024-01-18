Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD9C47DB7
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 21:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hZuonEw3eedxFWRIJ3FPhNOWVoihKIZ04zTqPK6ckUU=; b=jd9pNa+57KHqaDpKWxls4ivXs1
	KH7vtla9WY+5T6se8GtHeAirBtGimd/4dCoY5qaCXb+2giuZbRBPMXNfZxiiPdU0dB/OW8PDHYFL4
	ngPNDBlHwtskbGe47R1TGn4wk0cFOODpVMkCCy0xRXtMEuiMbG5NDZlRIGw+xoRXCLPGfhwtaKIie
	bZB0WewAORBHfU/DfOqDDmX8g+iZ6qfzlQM3Yu7//J25vMxKnE09t6aJWAmIMwaH6HMHiUZOU9Cco
	4HSpmv3nDtL52yoNpIr/6WBdSYxrbbSCLvN5vSp/KUgdk/APD0vuc2mps/CcY95XxH34HvyXe3Bon
	imw+77wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQZYi-003rHn-06;
	Thu, 18 Jan 2024 21:04:20 +0000
Received: from mail-oi1-f179.google.com ([209.85.167.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQZYf-003rGt-2N
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 21:04:19 +0000
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd5c4cffefso130208b6e.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 Jan 2024 13:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705611794; x=1706216594; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZuonEw3eedxFWRIJ3FPhNOWVoihKIZ04zTqPK6ckUU=;
        b=WqEzL0K8dKVy5772u3qL0pkY4EqP0yuNc+h17jTSmAmorls0Z4qvB6GUaaxjPES0Ng
         8fhFZtX8bkSUJYbjkpaZN2CqYGFK2De7Id1WpS2j9B5Yr27gzvLPmptGnV92rLyLNC2b
         jlUiUfvlh1yP3qnOAhwR1IwHQJJzJhcrhX5GgQvg8MOVuOhz76iMmCQq/fsU5rW0WlgH
         i35xe9NHXubJ688NGdGKqH8a4V1voad/uTUZvFSWpfsJzXZUUsIy2frIWYeSmlEou/en
         vHA+KifFs6IJYAkO9NX7c0oO4uuHvUokH6UbpJzqkDdo9ft8G9MHx0KlfId5AT7dqPaW
         gBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705611794; x=1706216594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZuonEw3eedxFWRIJ3FPhNOWVoihKIZ04zTqPK6ckUU=;
        b=nBe/3+3wKwa6sS1poIiOn6ddYE1Gw0HKjcjGHJRCoBaX2tnovuuhjo4PFn1unNHMLB
         yML3ybK6804GYsV+K3zZejfHQep+YuPG/9pMP5GOPhHP8K7B2ItOWaFo2hFC7pIu6lDr
         nWfpL3fPNqCN1sYj1l936TFzXP8fJvZ5zE71AoPeHQBOre9+aozqMNj6G2lA3bNMQDj+
         B7khfjIS6yCLdTVEIydY1F2qnPJ3WcBx3YlhNMbGAqfKvTNHKqhzqi67jAeqj2vyEogC
         APf/6+P1ijOA+9bezR4b7x5JBNbk71y/ozpUF2De3uVdbrV1jcHL7YpaFnDc6bDfNXBT
         GaPQ==
X-Gm-Message-State: AOJu0Yynmq94VkaitTVOZ5NH+y2BeJV7Qq8KTlMZxiO/qciBJw+9wpk3
	78L9lyoDXNSyBZ0Z//3hhhWTSzv9vjTJ+gNYMhIPBExj9S0Vbglz
X-Google-Smtp-Source: AGHT+IGVklt9g4h7KihbkN8RM4qlKc68kUyLYgwQyhhb0nsrUkqiwhDB8iyrlbOXVNVP2f27h7ty3Q==
X-Received: by 2002:a05:6870:7099:b0:210:aec0:e8ed with SMTP id v25-20020a056870709900b00210aec0e8edmr1429121oae.73.1705611794473;
        Thu, 18 Jan 2024 13:03:14 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id gu27-20020a056870ab1b00b00206516474f3sm561572oab.38.2024.01.18.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:03:14 -0800 (PST)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2] nvme_core: scan namespaces asynchronously
Date: Thu, 18 Jan 2024 15:03:03 -0600
Message-Id: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_130417_779098_B766F808 
X-CRM114-Status: GOOD (  20.16  )
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

Without the patch, NVME namespaces are scanned serially, so it can take a
long time for all of a controller's namespaces to become available,
especially with a slower (TCP) interface with large number of namespaces.

The time it took for all namespaces to show up after connecting (via TCP)
to a controller with 1002 namespaces was measured:

network latency   without patch   with patch
     0                 6s            1s
    50ms             210s           10s
   100ms             417s           18s

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

--
V2: remove module param to enable/disable async scanning
    add scan time measurements to commit message

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0af612387083..069350f85b83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -3812,12 +3813,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+/*
+ * struct nvme_scan_state - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @count:	Next NSID to scan (for sequential scan), or
+ *		Index of next NSID to scan in ns_list (for list scan)
+ * @ns_list:	pointer to list of NSIDs to scan (NULL if sequential scan)
+ */
+struct nvme_scan_state {
+	struct nvme_ctrl *ctrl;
+	atomic_t count;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns(void *data, async_cookie_t cookie)
 {
-	struct nvme_ns_info info = { .nsid = nsid };
+	struct nvme_ns_info info = {};
+	struct nvme_scan_state *scan_state;
+	struct nvme_ctrl *ctrl;
+	u32 nsid;
 	struct nvme_ns *ns;
 	int ret;
 
+	scan_state = data;
+	ctrl = scan_state->ctrl;
+	nsid = (u32)atomic_fetch_add(1, &scan_state->count);
+	/*
+	 * get NSID from list (if scanning from a list, not sequentially)
+	 */
+	if (scan_state->ns_list)
+		nsid = le32_to_cpu(scan_state->ns_list[nsid]);
+
+	info.nsid = nsid;
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
 
@@ -3881,11 +3908,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	__le32 *ns_list;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
+	struct nvme_scan_state scan_state;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
+	scan_state.ctrl = ctrl;
+	scan_state.ns_list = ns_list;
 	for (;;) {
 		struct nvme_command cmd = {
 			.identify.opcode	= nvme_admin_identify,
@@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			goto free;
 		}
 
+		/*
+		 * scan list starting at list offset 0
+		 */
+		atomic_set(&scan_state.count, 0);
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_scan_ns(ctrl, nsid);
+			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
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
@@ -3922,14 +3959,23 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
 	u32 nn, i;
+	ASYNC_DOMAIN(domain);
+	struct nvme_scan_state scan_state;
 
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 	nn = le32_to_cpu(id->nn);
 	kfree(id);
 
+	scan_state.ctrl = ctrl;
+	/*
+	 * scan sequentially starting at NSID 1
+	 */
+	atomic_set(&scan_state.count, 1);
+	scan_state.ns_list = NULL;
 	for (i = 1; i <= nn; i++)
-		nvme_scan_ns(ctrl, i);
+		async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
+	async_synchronize_full_domain(&domain);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.39.3


