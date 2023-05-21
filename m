Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6944C77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=; b=rGtUpUKHiN9tRds61XQMUTpU3W
	kE8x0ZBRcHgSMigGvPTb59wZdPcO9Bns/y7dYjEdtvN7emytIAbzNMA0dCzevpUOV8fuxf3Vg41+3
	mUi6I2/y0BjvZAZ4FGfC+mKYhfSNJh0UV3iL2KSRB3l4ZBaj8uV9nksAA7jvnq2DVydgJK/Cqa9LR
	bTeMqlVdV5LnScYh970g/JeE1VkXY+2AUR1s02QOemklA6dETYGaaunnqTNTri6WBY0njyYZMDp2X
	Av8fZ7p/fMVCJ73oPwS437Dvx0ihvtfUcw6uGzIYBBfYvu4kh2BCfjthLO5buSh8wZi4IKinCW0W2
	12Pn7j7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Z5W-002shh-2d;
	Sun, 21 May 2023 02:46:26 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Z5U-002shG-2O
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 02:46:25 +0000
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3940f546923so3499114b6e.2
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 19:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684637183; x=1687229183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=hHGRidzcNGDolt+TxyyHFzGHbdRzau0l4kEOkrAsL409fU3jkEZ0e4n1VtZmXOV+rV
         yckzbw65M0exprgp3awGSFInWwX+Jj5jpwezuXHPDGXp8O/CBgx8dc69mKqcX7Jcj/ps
         Sc8hBgBvjClihhhvDgyU8DqLT+HrMPsgIjeCMnt7L+6aHbusX0naDySc+GJaBmcNAgd1
         Gp2wzjUc6qR2OEvCXPsALdPrBrq37k37vQVFHpXIOybKSauB1v1YR1UR/oTjVOw0+Laa
         +ehep4znZ2p04B0cco+KuXMHjI6pmYFa6GJb4v6IkTD1DpKxhsTiVUtaygwzNYP8sDtb
         tPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637183; x=1687229183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=Dr3rhlWCQ1wwEeHyjSuJmoH7am7jMnezgGFU2FB8vaAYktla7sPClivE9yCR7TqR3h
         Hrg+vQRq9d+HQqWr3cACe4sUMAcmu2DgqTX/uaSy2VqkJsLN/E0myWiHqJwrnFOjfmda
         j0uM5udBpakT6Lmct3PkGvb0kVqTuvHF/8nNnQ0qnFYNONG1pfc4l8kvI+zQudRg/YdI
         yFhsYUb3ikfbu8zOnqTGO/NUAv+3R46jYoOq58lnZ2ZkHZOXJ/6LQf+X0NhQQvoValJs
         c8ypAtgK8MIsXk0IsjVCMPHDz44O5uDEfa8vWVdEfFapC+dOgyuco07uKTCz1r9lyWBQ
         oWjg==
X-Gm-Message-State: AC+VfDzE+IajpsezGzHXyAyDK5WRd4tG5RV4JNaVFA6bZs92SlzwyFJA
	MRwERtsymHyk+SF+yVookGs=
X-Google-Smtp-Source: ACHHUZ7oAtsAnE1Fz2AD0VVlLRW6toWRlHOu4hvhx7FbC17UUYxoc8bdB34A8rix59e3EfQWQnGYhg==
X-Received: by 2002:a05:6808:7c9:b0:394:6640:8304 with SMTP id f9-20020a05680807c900b0039466408304mr3355146oij.20.1684637183621;
        Sat, 20 May 2023 19:46:23 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id u13-20020a4a8c0d000000b00545442d89b3sm1242566ooj.23.2023.05.20.19.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:46:23 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and nvme_init_queue 
Date: Sat, 20 May 2023 23:46:18 -0300
Message-Id: <20230521024618.103138-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_194624_780262_793CE29F 
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


