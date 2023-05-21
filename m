Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718F8C77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 02:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=; b=rFOa4hxbnrEM+doQpJzQdYhoj9
	DJRym8n6jazNNgY8ZUXcdpGksB9mc1Hs1qCPQD2Ld6MKGhDMGmydinUsmL+AVOr6lq1OEdRNAaVNL
	26WfXxvRw4GRcGMytROt58EMG+P3wNT+Zzech+0rvt3Eq+lNmcrk303t3zvUIjFvNOAG8EmlbkCzu
	eMaZHHW96MqsrTBPRhejyy3gP2EsmEu+Bo8Jz+zqcFoM5qQEJgpuraBKks3xJHTg9PJt98iMDepcN
	jjZpiYLPqSj1Z+L5ifyUP5TJm7C7CYW+BQYVRZIkdNkKWIPA+ZISzz4LRq7QeBw+HAYAVitic4aug
	3dt+mhog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ZCh-002tlR-29;
	Sun, 21 May 2023 02:53:51 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0ZCe-002tkr-22
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 02:53:49 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5523bd97c64so1475027eaf.0
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684637627; x=1687229627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=LoEZq/XoEKThNMeO/4fXBWNIb3sZ/Pd6MA7NkUEWAfXlEaDEI8lW3VaDjC9ZKinGKR
         mGqOrfREWpmGtWzM9fkfaPQRYhRlMcAJDqhTeoqM0zInPP5jhPqo+HhqDnP+hEj0oTOl
         1KpoOIrQlQrKJtvLqUxAtKoTl5KUcxdPu0scPT99AvbFfwCkG7uDCGuqdhyQNEZbHFGh
         1pGABJW8PdUcqPs8WWj7c4fvo35Q1U/YJjg1rtmhCVa3LJ21oozkpK1vvBFlGVXMhFVb
         KurF6Xz9rQspfcmTT/W1kqDjuoeEkiA6DJfflkD/NhldST03dEpY+o9kwnbqecKzqqaW
         1L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637627; x=1687229627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGN6B6La01Y7AqCb8P2zVKu0P83c8xVbGhhEUQAujvc=;
        b=FZqAlNAIDZ2HRZY/6ok4hzY6ueTZthFpNRPF2osQe0Ovu3TmLA7eFNGZXDCYPUvF07
         vunYHm36L8XEKBk8faOJjkOyLNk9jhcPMELDnlodh5U9YkuX7SCJ2EmpQQDPfKb4W55M
         fAWmSUc7Ztrr5PCg0qIGxNJu6la1ImfIRvaIGZJdH9L+Lyy0UZEcgD19wsF7e0bmkJ9E
         vNgqD3/H+ys+SfgOAIy7lfAXVh0+/zp50dGptMWuPI6qNyWjHCEACBVwRXA9uByPWMcg
         7mKHz5U4ETRMhMkmetJScnP+MSEU8XpEhQlVqKQWyF5/3gegbrP2PwZFbrnnrNu0sVWS
         4WKw==
X-Gm-Message-State: AC+VfDy/lay+aSeJqc21ITF2wyo1NK0ua3IHnrxWkHr1WV86iUbpbqnN
	cBSqB8czokbyRB4GS444LK4=
X-Google-Smtp-Source: ACHHUZ5cnvsgzMFpqJcBZJEHsCteqN3RjKkSAZ5y/hzrXvEEYXOsQ2EB5xIj+OJS+q/NoScaBTGp0A==
X-Received: by 2002:a05:6808:428a:b0:395:fb68:f280 with SMTP id dq10-20020a056808428a00b00395fb68f280mr3372988oib.0.1684637627167;
        Sat, 20 May 2023 19:53:47 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id s205-20020acaa9d6000000b00397f453aae6sm610566oie.38.2023.05.20.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:53:46 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci: remove redundancies in nvme_alloc_queue and nvme_init_queue
Date: Sat, 20 May 2023 23:53:41 -0300
Message-Id: <20230521025341.103572-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_195348_666612_FB868B66 
X-CRM114-Status: UNSURE (   7.76  )
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


