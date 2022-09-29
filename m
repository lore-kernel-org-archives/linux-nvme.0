Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0A4C04A95
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PuBkx3mIKlCuv/Ez7uR3bYwFT5/uX/i3LGQCMtKRQ9A=; b=BezcrjNBYZTGyahY8AHrMthCXJ
	zL/N0Y4J30lytktQAxb3FtCBtD2b3h+9HZ0G+2u3K8oj+rVDkggy35Yj0DK4lK2cuxdGMJkqm+yqs
	psnGTmwWalnhm3m94UsylGZxkdyD0ZEgl6brH6IyNYoYVV0stmTfCFpLwgBPdXvpNXDfHKgNcdAtI
	SSR+3K/PTeladR+EfCGBJLawCF1ZDL67a+TbQhR+zbprbIlfoQHwjW/KyJKt8Zz6jjQJlCSalx7p4
	a6LBUxkcyE4sxpsxCiqXjsTx3dKxq1UZm023lZlyqGC9fDd7OGPZpHVdXUUgnlyPbgV7GEn49THeL
	mxKEv/wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odo6J-001bOY-2D; Thu, 29 Sep 2022 07:36:55 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odo6G-001bMl-5z
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 07:36:53 +0000
Received: by mail-wr1-f54.google.com with SMTP id c11so754433wrp.11
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 00:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PuBkx3mIKlCuv/Ez7uR3bYwFT5/uX/i3LGQCMtKRQ9A=;
        b=h8FL0KtV+1Rbv2goZdV72KGVwDkjsM1ma3RuRm3GCWePOgdfdFl2XCzKDFlnAPSoLu
         hNh3DrC67fn0ns9mLllcZ8U0iDvA83Ha2IQM8yWE5EbL1o6G3R3/VfqwTNFk3SiS2TX2
         cUXA+hoVANcLWHjVvPC7OqoMIzDeXhHI4206B0g3VxQsyK/4JevHPW95levpx0xgglKF
         719qL1SjOLKNFKbVWQJFGwfhs3DuTHgDtXgUM2PMFd2Wb/PuT2wtub2WupTFddtU8G+t
         wmx3YcQ5R3T3PDFq7SSLsX9tX7j5cpwaOFaXI0YkNEMp4DwhAdqlje7xRCB0wFlAjjwW
         YVXQ==
X-Gm-Message-State: ACrzQf1b4h62znT+eKYLBUTr8WaRisMAG7BAstWdxS8ye/1fDwdTYf6e
	2MmAxP6SPRAXEnfEwneW3ZIBFDN+1F0=
X-Google-Smtp-Source: AMsMyM5Eh4EAhONhGP+f3Ll9Pq13zlG1sAtU0ruf0WHyTUYVXCRbjPNo1xoHYywY/OxcEbEJ9yjP6g==
X-Received: by 2002:a5d:6b82:0:b0:22c:cf67:3c05 with SMTP id n2-20020a5d6b82000000b0022ccf673c05mr1172874wrx.497.1664437008944;
        Thu, 29 Sep 2022 00:36:48 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003b435c41103sm5350958wmb.0.2022.09.29.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 00:36:48 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: [PATCH v3] nvme-multipath: fix possible hang in live ns resize with ANA access
Date: Thu, 29 Sep 2022 10:36:47 +0300
Message-Id: <20220929073647.171775-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_003652_241313_C08D8B2D 
X-CRM114-Status: GOOD (  14.04  )
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

When we revalidate paths as part of ns size change (as of commit
e7d65803e2bb), it is possible that during the path revalidation, the
only paths that is IO capable (i.e. optimized/non-optimized) are the
ones that ns resize was not yet informed to the host, which will cause
inflight requests to be requeued (as we have available paths but none
are IO capable). These requests on the requeue list are waiting for
someone to resubmit them at some point.

The IO capable paths will eventually notify the ns resize change to the
host, but there is nothing that will kick the requeue list to resubmit
the queued requests.

Fix this by always kicking the requeue list, and if no IO capable path
exists, these requests will be queued again.

A typical log that indicates that IOs are requeued:
--
nvme nvme1: creating 4 I/O queues.
nvme nvme1: new ctrl: "testnqn1"
nvme nvme2: creating 4 I/O queues.
nvme nvme2: mapped 4/0/0 default/read/poll queues.
nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
nvme nvme1: rescanning namespaces.
nvme1n1: detected capacity change from 2097152 to 4194304
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
nvme nvme2: rescanning namespaces.
--

Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v2:
- just schedule head->requeue_work instead of calling nvme_kick_requeue_list

Changes from v1:
- fix commit msg body format
- follow reverse-xmas declaration pattern

 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6ef497c75a16..b9cf17cbbbd5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -182,6 +182,7 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 
 	for_each_node(node)
 		rcu_assign_pointer(head->current_path[node], NULL);
+	kblockd_schedule_work(&head->requeue_work);
 }
 
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
-- 
2.34.1


