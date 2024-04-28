Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F4BC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AWZ7EPJFQ3BKcgYt4bEHO+PYb/ZIzVdFzlRa2rY4KYA=; b=I6W/eCUzq2HnBJ+m1c/rTMolzU
	Wf6Nhaf49HXa2zNIy6+6+rnzB/LnXpcSlrKYTgcq1RBRWdL1MMF13mBXRv+NvjA20dTf2sTAQCoBb
	dhapltsF2ZiXx68VrZ28tcqDavR4VNK3emMtJGg0irUL9g21YSWhU2qWbIiEHCHFd8TDuZkpqpBK/
	mBfFnfWip2gZhC29n3C8raxsGMFLvibhLJlliqN7QchzuXEbC1ICIeQ31ucT5kfHy9Bj2pFxtTeF1
	LQM0ymzjZXhpX8ivaj6tCcujUBZigTudmjoSuJ1Kg9HOWXGDOJnq7M0AWtPQFmh4uYC4HVgd1LE5y
	oIMQHG+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10EP-0000000HBhh-0lCN;
	Sun, 28 Apr 2024 08:49:57 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s10EM-0000000HBgM-1112
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 08:49:55 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-346a5dea2f4so610820f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 01:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714294192; x=1714898992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWZ7EPJFQ3BKcgYt4bEHO+PYb/ZIzVdFzlRa2rY4KYA=;
        b=DFmEwnQLbqS9Bcz6/EpuvMSidg9T8VgmXRbvrSOT+gePfAdulvi56esXnIN/YPi7RY
         pf05yrhUWsu7KAih8DdqPunGVkHKY2i6Q5q2xzKtuQ9DzqKO+4lvxI/VMTqnHFsXyKty
         plXxKwdPGpxzJKnvax4TRMrFfK1idn9mHgmu/gpVXMBQmBMWLBPRyFsr4XVHoGZPa1b5
         2ItnfIeCO+GV3iPyg0MBOwU+2SWKsPALybPezH/mQPRach57kuhuA64W8KPHTIdgNtF3
         pl9jm+ERfuQKOGvQLgwLh6PQ7pdoq9uIkbXSAlPwNFXUOj3tZXGBcmwwj4lOnWqQ3H1k
         IcbQ==
X-Gm-Message-State: AOJu0YzR+LF8HWQxcb1jQxdxNrDFd+LOGph8Cp3s6HdIzqffh8rsoRNm
	JwgugLl+xCsybmI4GJFndlXafBlIfSrvrqo0wJDViLaeGyE51UIvU5NKjg==
X-Google-Smtp-Source: AGHT+IEe+kBXfGx90QFXFbdI/V/zTrVIMfYO9KHpdcchccBcpDMEP6RDZeUvZBi//3KElkU+Jxaf8w==
X-Received: by 2002:a5d:6d04:0:b0:34d:b45:9b31 with SMTP id e4-20020a5d6d04000000b0034d0b459b31mr1060wrq.6.1714294191739;
        Sun, 28 Apr 2024 01:49:51 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b0034cf3001104sm731517wrt.33.2024.04.28.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:49:51 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvmet-tcp: fix possible memory leak when tearing down a controller
Date: Sun, 28 Apr 2024 11:49:49 +0300
Message-Id: <20240428084949.61931-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_014954_305642_140C32AF 
X-CRM114-Status: GOOD (  14.25  )
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

When we teardown the controller, we wait for pending I/Os to complete
(sq->ref on all queues to drop to zero) and then we go over the commands,
and free their command buffers in case they are still fetching data from
the host (e.g. processing nvme writes) and have yet to take a reference
on the sq.

However, we may miss the case where commands have failed before executing
and are queued for sending a response, but will never occur because the
queue socket is already down. In this case we may miss deallocating command
buffers.

Solve this by freeing all commands buffers as nvmet_tcp_free_cmd_buffers is
idempotent anyways.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a5422e2c979a..380f22ee3ebb 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,6 +348,7 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+/* If cmd buffers are NULL, no operation is performed */
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
 	kfree(cmd->iov);
@@ -1581,13 +1582,9 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
 
-	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_free_cmd_buffers(cmd);
-	}
-
-	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-		nvmet_tcp_free_cmd_buffers(&queue->connect);
+	for (i = 0; i < queue->nr_cmds; i++, cmd++)
+		nvmet_tcp_free_cmd_buffers(cmd);
+	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
-- 
2.40.1


