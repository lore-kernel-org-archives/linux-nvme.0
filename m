Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF65C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j7PA7FAAH4Q8xvO+xLgGu0hJdJJaWl3qAfedkY2o//E=; b=C/aBlrAdGBBttnjfvyrr8CFRHw
	bW7/NWOPqYSsqJrDpmC1lkdxNgZ0h4AZ78ljkhruCEhNckYQo/jN2XYQKIBAplhCrt02V3nKOCybs
	DPGV1JHjI70aBy4uFnuGJmUpUbcmPERt1KOU+bKvFu4TzAcGr9lbY9nfHentUp1VvcYpTd7TaXHpx
	4bzOoWx4HwkAQ5DJSuUbEp004bI0lJlPFtjmoC1XuQ44RzgWg0NxhNi+xz8lWJgfBHHf5FDcMxQrS
	5e1Y3vWBtg01zikxQlwgWKoy4SpdTEGCXvbQp5940JK82AETspGulnZXijUIEWtiuW0Uffa+m3jST
	Zg8wTsmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLQkD-00EhtZ-0O;
	Thu, 04 Jan 2024 16:38:57 +0000
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLQkA-00Ehs1-1a
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 16:38:55 +0000
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-203fed05a31so373777fac.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 08:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704386331; x=1704991131; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7PA7FAAH4Q8xvO+xLgGu0hJdJJaWl3qAfedkY2o//E=;
        b=D2zBX7gUp/YXd/mAhQagx04C7J+7QIIduOvB3vcvJiNbctsNxLYtopxeGLh3eNpT98
         okxpRUDTI4cGYxC6GvG65M37pNp91qTsOG+iv0h7QL52HtGEXvIFF4kPRbfn0Eshgpqi
         M9ElCL/PdwNWKNDorsz7jc2AiBip+zmATAyS/SkiwrRMGUcHrFqWjUhz3fXzgaSB2/OO
         kWlZa2Df1CGzxax9v6WYcFr+sf7uxPkrE8yGYFCVBRtskx+26H5bV4O6HzeF+ifQ7ja8
         LBqWcFJ7DB87wVx95DNMTDJyz/gZZI/VzBv8/jHCnubhpDh+yND7z+FpkXY1+8WO41+t
         h8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386331; x=1704991131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7PA7FAAH4Q8xvO+xLgGu0hJdJJaWl3qAfedkY2o//E=;
        b=GlAPbg7/WXooKBcknm6R12bBLDCif6/c/0yG/YEcHoReheBoAVXHsazMD46j4R0u2J
         ompotQRZa8UGm5v6upD461+RP/izVU/bGxUdBZMppGP/mtwD2VArv7B6YA1hR5vkrS8T
         3bCl8b1/bLFZ91dAXFSf9Ij3UaF/t3uG5ba8yfxoY0VvXX45T7RKtkYpXBj1pb2truaZ
         6affw+/QK2fmDsLO7OlxO04c8w0erXwGIzJOavjpC9IyEO9Tjw1BMpCmBkgP68RkfKry
         Sq5JzkWMMSbi1Zk+mgjC/bSWVXbJr6/WZqJcMNlG7UAYmp0SMmODLARmYM5EFKE88j5z
         opKg==
X-Gm-Message-State: AOJu0YzD4Kdpn1pm3GEddGKxMseB+9jaUu+gG8EEJu4KIwtMeZi3dvVh
	Og3o8zjASPmHkn3KzagK8sZNPIctmuY=
X-Google-Smtp-Source: AGHT+IFvm5Vaw8ZvXn8hmLaIFW8pSESAVF6qOvMg/t+fd/ZYYfmFOb72qe2rx5auzyLBR+pwjMcGRA==
X-Received: by 2002:a05:6870:cb41:b0:204:42cc:e144 with SMTP id oz1-20020a056870cb4100b0020442cce144mr987518oab.26.1704386331528;
        Thu, 04 Jan 2024 08:38:51 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id sf6-20020a056871230600b00203fa5d55fbsm6489915oab.34.2024.01.04.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:38:51 -0800 (PST)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] nvme_core: scan namespaces asynchronously
Date: Thu,  4 Jan 2024 10:38:26 -0600
Message-Id: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_083854_529092_7C52B43B 
X-CRM114-Status: GOOD (  20.32  )
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

Currently NVME namespaces are scanned serially, so it can take a long time
for all of a controller's namespaces to become available, especially with a
slower (fabrics) interface with large number (~1000) of namespaces.

Use async function calls to make namespace scanning happen in parallel,
and add a (boolean) module parameter "async_ns_scan" to enable this.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60f14019f981..aeda60469872 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -88,6 +89,10 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
+static bool async_ns_scan;
+module_param(async_ns_scan, bool, 0644);
+MODULE_PARM_DESC(async_ns_scan, "allow namespaces to be scanned asynchronously");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -3780,12 +3785,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
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
 
@@ -3849,11 +3880,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
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
@@ -3869,19 +3904,30 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
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
+
+			if (async_ns_scan)
+				async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
+			else
+				nvme_scan_ns(&scan_state, 0);
+
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
@@ -3890,14 +3936,26 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
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
+		if (async_ns_scan)
+			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
+		else
+			nvme_scan_ns(&scan_state, 0);
+	async_synchronize_full_domain(&domain);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.39.3


