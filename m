Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF2FC77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 02:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=; b=dPDfR3mPeVH0xYRIy7zI9jt516
	FGIZDoMzPRQtiqTOFtcp1kcsM5DJRtKCmyYO/Vuel2ur+35rHVEvJMxHKKIvRogQ0yIgmwOaBnVqW
	i48rprTnfmGWbLqhYyA6NnMt+SNtVvAX1xHBLdSv4Ugc/tTMbXV7/gTiaH0sJT8nkKHOdzr4FpiQT
	M2EX7qxq/ii+8eIPuWsfOYyn2KCfxNLcczjL9tkO3xbQKtNRsaqQRDBkyDEF0pM1JEiWTCqWTZwVh
	LRl/c9MXSRXzn2+atT9WZ/xJIKCdsI1ni9622Md0MYAfrOE3+kwmAmBgrrDTfE8A1uLRSfnhVcTSr
	VQQa4pzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Z3n-002sPn-1G;
	Sun, 21 May 2023 02:44:39 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Z3k-002sP9-0n
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 02:44:37 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-397f13944f2so382290b6e.0
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684637075; x=1687229075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=KjDxFJb4LtkE2ylMOzwIxzvVdMumSE83YhQqlyekrXsP+kd8zHbwALdFaZ73YGMwUI
         EarAY56FcdTBxFwO0kz1tH8tBIoyfQZ6Yh5wp1qm+cr7pieAwyqwNzWDohjAZPSkpR6v
         V9trNSuu/1ZhARz1vP7RaV/f/5qdg2tIiv3Rwj5mqYaX9RtBMkjIPZ47WTYRrPye3TWk
         DiYTBgqJlDf1Vpe3Zg3PN2g02qbzeS18ZCWd+0DIrHulwPCOpV6Ln66bKjyBfPSCidZF
         /52QTu/YwqaY4zUArjSzHZCFSUNe67oIte1ZMgxPjzq/37iUtA8o2er/3LcgZl9sFlJe
         6jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637075; x=1687229075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=cjYb7NilNFeMh4BnRUloX0K3iTvw5L8dafcCsISaJ8IZeRXDdYXzm9Nu9w2OmY6zpW
         7Dsvbu4rqSsm7NdY+PSL5oc4OH2S5bYx8EWu5oMSWt3609A5p3E2AFIg3g4t3EbNDa6T
         IUXXWka4jn8fGMwrvWojuEDG6ofI0QSR1Whbzhjee8exoxg4dK6TCtvMi38g/BPdlnz1
         MakwJv1RKQ7Ql2QC2bLXmGH2NDk2dFbmHl9zEOyVGF2MJqczmxrpS9NEOz3Z/g2r5MUc
         RkzC/uZ7ErpbmgJoEB963FCRCJsEb84JVj+2nrn4DADuDAsc9P2Alb1PBTlY0hgs0x1s
         m7jA==
X-Gm-Message-State: AC+VfDwzoWxHbPUEjssN+qGq+AWvOQ8qYB54G5TjL8sL8WBl/uDOn64N
	XLiUUq79vUrDj5L3wCeY0rc=
X-Google-Smtp-Source: ACHHUZ7yoV9RuhNmrWcCn6Ry29rcWDw1wZi++oYZZXFjp+rROVMX6X50Hzkys1ZmUaI0r1HfL3o7yg==
X-Received: by 2002:a54:4892:0:b0:394:25de:4538 with SMTP id r18-20020a544892000000b0039425de4538mr3958231oic.42.1684637074799;
        Sat, 20 May 2023 19:44:34 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id v2-20020a4aa502000000b005553d90ae17sm15161ook.38.2023.05.20.19.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:44:34 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and nvme_init_queue 
Date: Sat, 20 May 2023 23:44:30 -0300
Message-Id: <20230521024430.102962-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_194436_309277_5F0061EE 
X-CRM114-Status: UNSURE (   7.51  )
X-CRM114-Notice: Please train this message.
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

cq_head cq_phase and q_db are getting set in nvme_alloc_queue
and in nvme_init_queue, make it so that they are only set once in
nvme_init_queue.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32244582fdb0..49ae26980a0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1533,9 +1533,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
-	nvmeq->cq_head = 0;
-	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->qid = qid;
 	dev->ctrl.queue_count++;
 
-- 
2.39.2


