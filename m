Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5E8FF886F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2026 12:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u1rtTuY5BE7rdQoV+ciJbr7UnJ/IDuL1onVBT7GuRBM=; b=KF/ei6V3YmbdcpbKCUxv83gYRJ
	oEBKaV/ApajaJ7c8ZOlvWiBIrPjHRuwI7TTsYd7Z/E4vvTr6UeIqItyyo1otU2m8M8Lbf2dgnuwnA
	KPPGUQqTHKS84XTnysFH7JnzcYi+MaxHhHaMavrkofZsivD+AElZL6mbkKFvYh4AScSTXAxK+0MeR
	DoCESCPDYY2UDMgSiCNgdNRUB1Sw0dC4PcgENQKOtCsreJMWx1UyiCYYcQ7gu/3BzDo+cKAEoqApd
	2aUHeh0mIeQNl/tu+Qies/iFx7JUjvWIbnYxlJflxgHjtnddcchGQyWY3jVLHUvmMb72SRjWruQEJ
	BKErA+EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJsX3-0000000DAjv-3ZDK;
	Mon, 04 May 2026 12:36:17 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJsX0-0000000DAir-3jVi
	for linux-nvme@lists.infradead.org;
	Mon, 04 May 2026 12:36:16 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-364d72f2986so2633488a91.3
        for <linux-nvme@lists.infradead.org>; Mon, 04 May 2026 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898173; x=1778502973; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1rtTuY5BE7rdQoV+ciJbr7UnJ/IDuL1onVBT7GuRBM=;
        b=IpNUZTA6I+bVNW8Q6xnmqNVsGIuXrRZbGtD/DZUqChjubfHwLspkeMAl77RSxIaQn5
         BbBlnjHJ2nWQN4Bi/t022NkX0psDI6RT4mJz7e+RW9TxXLCJ144YZW5OSMq5EHNNJunb
         H/P5wG/zj+kXSBp1RHZOmHrEBAl+x9kUjotK9RWi+X+r/PXhFUoBUX3M5Pgev9qOubPu
         cnKv1L237hLqZCf4Rs+kKYX/eompGjdCHO5LZq4MPnDBc797oUxofzHTc/d1kU5UH19c
         gFkIU6vcvAGEHIIiGuurt9VF+ITStFeK+gpVMWHfL+bQa8Z1lwGIIT2e3B0tZi2fn8xm
         i24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898173; x=1778502973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1rtTuY5BE7rdQoV+ciJbr7UnJ/IDuL1onVBT7GuRBM=;
        b=LovaO3HRa6JvzSw0ryiGDZU+k0xpa4pV0q69S8dYe9S+L3aY8UinIue3+IsMyxG/LT
         JUOxfWIh/YpS549I/7TMsMEyYlQuCw9nTF8wT/L4VczuhVjzowVyWmEsP2TS4q4sAfrE
         kHZEs3dDO73HI/0Y/Mw9ffj4kNVyzCGvTRYrmg//hSvop8HtW1ClGqtbACGOWxoF5bIx
         AFQKx0l3dh7tlaFnfMu1/gsYhQNpjjGPh9JsLNF/p6beL0U048D7gcxsmlDtfz3XPG+z
         hEoFz8by9X4Lm2RLzTCB2A2syhx3zbh/ZgDEafO9TuFPEfKOzNpFxMW1XUDDr7aOK4k3
         Y9/A==
X-Gm-Message-State: AOJu0YziVlNbFQeNlckjXCRDp0/iqmnRilDNKp9w5SDkc9K4ocLhKrFX
	JcwVtKHpVmeW8G9fsmE0TqCiYulffTcLgDLS93cDvrWoGq8FC3R7Q6sBLV7JQB+uBqHQ2w==
X-Gm-Gg: AeBDieszQWdKqYZzt/Y/62NJi0BUJ30cpxMdULpAA7I3eYdxnmZ3XyJzpqnOc03Cowr
	TrgybAYy9MJVd7yFGRJhHvAbOmoIDvenhP6wCmL3G4X+TQ7GT76ItarNAiIXxW9tTfJ0kFPQ9x1
	/3oobSUgdpjHyiwXJgMyAEuViV/EH+Oo9mjNlawyawQGpxRDJzPS96cqpkZ69S3hSUratGFEOwq
	zr3nQDb65Lijkxcp80sHe007gqmcotGChvltz+YGJrsS2olAzR/Id+XsCgPpCndnRDCf7fErBJz
	Bw+p3CKQ1wxIFXsJ5V47qcrrwIRSI9ATw0p0COO/WhdgBQG5RctQ4j/YTz9kK0k8gJ7hCrfpQG9
	wMxOv+24dduDQWbns0nktbs+VxM0pWGcaD4EgoU89xWwkJ3cv8FRAA9dJ8p/mktpwrH2Hwx0KZ9
	ic0SSUNXAB4akVep27OUYdw2BP
X-Received: by 2002:a17:90b:4a4b:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-3650cdb749fmr9402918a91.7.1777898173329;
        Mon, 04 May 2026 05:36:13 -0700 (PDT)
Received: from dev.. ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3f684c3sm4298527a91.3.2026.05.04.05.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:36:12 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] nvme: use str_enabled_disabled() for digest mismatch messages
Date: Mon,  4 May 2026 18:05:55 +0530
Message-Id: <20260504123555.1741525-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_053614_979872_C92FE4A5 
X-CRM114-Status: GOOD (  10.13  )
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

Replace open-coded ternary expressions with str_enabled_disabled()
when printing data and header digest mismatch messages in
nvme_tcp_init_connection().

This makes the code more readable and consistent with existing
helpers used for boolean string representation.

No functional change intended.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/nvme/host/tcp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..b3165cd79a31 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/string_choices.h>
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
@@ -1550,8 +1551,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	    (!queue->data_digest && ctrl_ddgst)) {
 		pr_err("queue %d: data digest mismatch host: %s ctrl: %s\n",
 			nvme_tcp_queue_id(queue),
-			queue->data_digest ? "enabled" : "disabled",
-			ctrl_ddgst ? "enabled" : "disabled");
+			str_enabled_disabled(queue->data_digest),
+			str_enabled_disabled(ctrl_ddgst));
 		goto free_icresp;
 	}
 
@@ -1560,8 +1561,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	    (!queue->hdr_digest && ctrl_hdgst)) {
 		pr_err("queue %d: header digest mismatch host: %s ctrl: %s\n",
 			nvme_tcp_queue_id(queue),
-			queue->hdr_digest ? "enabled" : "disabled",
-			ctrl_hdgst ? "enabled" : "disabled");
+			str_enabled_disabled(queue->hdr_digest),
+			str_enabled_disabled(ctrl_hdgst);
 		goto free_icresp;
 	}
 
-- 
2.34.1


