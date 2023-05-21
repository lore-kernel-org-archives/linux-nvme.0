Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0876C77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 02:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=; b=ZmJLvFxI8GP/dIox7LqkL1QZZb
	ug67KE4SkE63cAUOTYXO/KicMdFo49wHkLS0KN60yrC6nEk35OP8kynZIfWoal6Z2DbgX+EMXFN+t
	lrw+2Kx1wwx6FIdY05rJIv1cspfLfTwDU9OoqpkQLup3dKqJ/hQcl+sL11nXvbBOS3haIUfyUZtf9
	k7ulFUfLil9AzS5yY7iTuouMHsugrygtdU/3fSgfVrqIv96bLQG6qwsr0hO9u/hUd9Gk6NCnEYHgl
	R3oZBppm3qy6qjhp0aLamEN4x4ybyFHwzJ/YLakdJjCoXXlpeO3NHWm7DdWrnjcSM8xNCRKu8McAz
	ZRhnmpqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ZAs-002tY1-0U;
	Sun, 21 May 2023 02:51:58 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ZAo-002tXY-2E
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 02:51:55 +0000
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af6b5cf489so367074a34.3
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 19:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684637512; x=1687229512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=RLydYIK2NIRVJAHF2XLvdi9BF1c1RigDUZfGV4x/3byr7CLu35YC2rYthOkOmv0qA6
         W8sgt/Oc1UjtNve6T6d86qOvNfzrXPi7wGumYqaH+7RI0x9XJeCtcaYmd0gykr1txLe9
         KsmVjPqMmGh/PlTN0auRM5MuvG8giiD18QUJXpRDYxRnOe7W5bryhtq0Qr8JWs0LBto5
         /ZgtFOY0y/Z0oDxXiAyx7T+RfPBvCtGk4imM8A7z9PhmlaeooN7YYwixEBddi/+8wraC
         CBvop87MlvD4GpwoHlV8YNFIHfU1y9QZTH2o8T1v9Nr109XKLNFoROeDkV2LIGRWWali
         havA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637512; x=1687229512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=WSgRm89Rs2aPYzQ6p/RivnnDCkNVV2YjW4Z/KDAFE29EPjRVjh74OEn06UOPefC8Lg
         PKEtdS6/u/CJtpx9ySlpGaxxiMPLzA9p5RzSVi6iD30jEU5YMmRzFN8QiDpLrmyTvNPE
         887tMHP+bJRnh35+bniCZbIQHAMj5A56+78Gt1WqFc5/UJQ/bOJ/qVgqDGPKLpYWqfDI
         nMv2nfOjVtLRkEdKfKaaEeYvM3/htx0a5zItjdhLOQFajckmeOcgeF3lhC847vO4KuRA
         WMsctanS+MStOhxYXNjcOw2vZPrsjCgj64NqhTy8bzV3L7uBSF5jsqCBomcRZX2aUwkH
         SgrA==
X-Gm-Message-State: AC+VfDxyYImkl6yC1BnTAd9KpiqOGo1RLoT8WQw2d4PlZmhbFXylidJy
	q2uoMne5Iu0TnxPE0ajdaewb/qRsnkiPPmzCd4k=
X-Google-Smtp-Source: ACHHUZ439g6ys0MHhjrvzn331/IfqoHLn8llkejddh7uFbQkb3N9e2NdMq3IkdcYwuuP8oCHo4vrxg==
X-Received: by 2002:a05:6830:1607:b0:6a5:e673:1251 with SMTP id g7-20020a056830160700b006a5e6731251mr4017037otr.36.1684637511918;
        Sat, 20 May 2023 19:51:51 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id z10-20020a9d65ca000000b006aca3e710desm1115039oth.2.2023.05.20.19.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:51:51 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci: redundancies in nvme_alloc_queue and nvme_init_queue
Date: Sat, 20 May 2023 23:51:18 -0300
Message-Id: <20230521025118.103457-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_195154_749094_42E799B9 
X-CRM114-Status: UNSURE (   7.72  )
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


