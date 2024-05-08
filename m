Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC6BC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FuJ5r1nOajcKntiPa6M5KJeAVfDvJ+npQDxfIVwBTQU=; b=cdD7lFAH6uTg0fl6ksRFB70oHq
	0+8+p4eHspH5YeXDW5sC3uOyAv+p5kb1lQQpN1rpTl90lJ2EEPbA8IPORncFJeYKC+j7h0e4UBIlE
	+LsHCY+TCmYk3u15FwfMHYA+ys6incXUskI7L7BX3lFZhMNRtwPIRW0YzgJ5wYIZPlK3pjScyUGB3
	PuRJT+l25dB840TRGCMw7BPD+WympwQ06v9cW86XsDszu8bTYpaIlTgkOAqq6Jn2AG3RvXE2Rcr+1
	71FuVJCHDMO6BG7qYGT8Slfk1WWgfDGklUEs/x7oClsZrGGOd3v2/KCnJTrLCcSKm14XlSXpcF01N
	fKeKYqMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4bO8-0000000EL7r-0cPr;
	Wed, 08 May 2024 07:06:52 +0000
Received: from mail-lj1-f178.google.com ([209.85.208.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4bNz-0000000EL2s-2en4
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 07:06:48 +0000
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dac627e62dso3052941fa.3
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 00:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715151998; x=1715756798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuJ5r1nOajcKntiPa6M5KJeAVfDvJ+npQDxfIVwBTQU=;
        b=gU5S1NrR7bA8vtlSBwPgi6ggI8yMBtCtqiW1Xzr5v+3cPme7nKpf2LU3hv9B3RoQq8
         wx2yr18fKaiZWGeaLJthVxZI1iwxXwBfQS2zz6ZwJ8aoNHhNeO841ofHJagH5mu2Gr8Q
         gbttx3T7EgblYXKHjYUmdRAwiTThb1QIbll4+mAI3RxOpAVjkFutTlQZy73goJx71OWy
         EVwvelGqmTkQQQSoaZiXfCNgs+PCyLZbaaeINuXCBGbftrhvoYzh0wq7Cb4A24Zr0iYY
         aY4zEPV+A1ZPbFSFlgfqzZyLjde23p1QgfJvMF/KSlBIa3yGOtXTrplsq0f6hYXecW4k
         rJfQ==
X-Gm-Message-State: AOJu0YwU6IzPsLolBJZjFoPwa/pL3X4WIRvj+iNf8WRfdioSQgn6zokW
	Cb2jaD85JI/7Td5syPjJkODrK0gUlRF7WsPqAYNLtkXxYx4Q4Yv3q5ei+A==
X-Google-Smtp-Source: AGHT+IHWl4G2fXL8ECd+ubYcx4lNeXAl8Oo5xDkDYE4FXoT7pDv3dngFWORKpsiFDNujetkqbnWfqw==
X-Received: by 2002:a05:6512:619:b0:518:ccf4:bd0e with SMTP id 2adb3069b0e04-5217cf3eb4amr875889e87.3.1715151998254;
        Wed, 08 May 2024 00:06:38 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110ff8sm11811105e9.38.2024.05.08.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:06:37 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-rdma: fix possible bad dereference when freeing rsps
Date: Wed,  8 May 2024 10:06:36 +0300
Message-Id: <20240508070636.1815945-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_000643_757659_11E95EFC 
X-CRM114-Status: GOOD (  16.50  )
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

From: Sagi Grimberg <sagi.grimberg@vastdata.com>

It is possible that the host connected and saw a cm established
event and started sending nvme capsules on the qp, however the
ctrl did not yet see an established event. This is why the
rsp_wait_list exists (for async handling of these cmds they move
to a pending list).

Furthermore, it is possible that the ctrl cm times out, resulting
in a connect-error cm event. in this case we hit a bad deref [1]
because in nvmet_rdma_free_rsps we assume that all the responses
are in the free list.

We are freeing the cmds array anyways, so don't even bother to
remove the rsp from the free_list. It is also guaranteed that we
are not racing anything when we are releasing the queue so no
other context accessing this array should be running.

[1]:
--
Workqueue: nvmet-free-wq nvmet_rdma_free_queue_work [nvmet_rdma]
[...]
pc : nvmet_rdma_free_rsps+0x78/0xb8 [nvmet_rdma]
lr : nvmet_rdma_free_queue_work+0x88/0x120 [nvmet_rdma]
 Call trace:
 nvmet_rdma_free_rsps+0x78/0xb8 [nvmet_rdma]
 nvmet_rdma_free_queue_work+0x88/0x120 [nvmet_rdma]
 process_one_work+0x1ec/0x4a0
 worker_thread+0x48/0x490
 kthread+0x158/0x160
 ret_from_fork+0x10/0x18
--
Signed-off-by: Sagi Grimberg <sagi.grimberg@vastdata.com>
---
 drivers/nvme/target/rdma.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 955296ac377f..689bb5d3cfdc 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -474,12 +474,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 	return 0;
 
 out_free:
-	while (--i >= 0) {
-		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
-		list_del(&rsp->free_list);
-		nvmet_rdma_free_rsp(ndev, rsp);
-	}
+	while (--i >= 0)
+		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
 out:
 	return ret;
@@ -490,12 +486,8 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 	struct nvmet_rdma_device *ndev = queue->dev;
 	int i, nr_rsps = queue->recv_queue_size * 2;
 
-	for (i = 0; i < nr_rsps; i++) {
-		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
-		list_del(&rsp->free_list);
-		nvmet_rdma_free_rsp(ndev, rsp);
-	}
+	for (i = 0; i < nr_rsps; i++)
+		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
 }
 
-- 
2.40.1


