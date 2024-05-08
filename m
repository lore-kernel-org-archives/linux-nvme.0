Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39886C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 07:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MpSlmhWgEetLXGMOpxHofxLV96CF0SXrJNEONBjBBHY=; b=hi3fFO8dIneEbXfXNtBvHU7QcK
	e5Z9NeSvH7aCQvBvJSim1uKMDgAMtJ8YjmHstsroq2jDIjVbQoZF+RLrfTBXuHjvksCrxF9Gn+h+V
	eyOn+eXJ/UZ6OAZa2EUEeCZL0lLcR5UcqhMDp40mjaDaRRnT3yvpKoJ4aAwg6fiuQPOzZihFVVE8x
	5YUoa6Oi8JlxYl6dZMQwIuaL2hQNLfIzRH7sPVMCtqbbikMxZrrG0qmMDhd8jwWsTwreaRMeZ8Xdn
	ygwCRQ+qMYQdahBjT4BnNROALyhULSZtSfoBZgbn4a7pB6bal9Msmp5ZRyl2kegL+nJx5Pzz86tHA
	1sn4fW0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4c7B-0000000EVCP-0sO1;
	Wed, 08 May 2024 07:53:25 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4c75-0000000EV8I-2WAu
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 07:53:23 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e20088184cso7817251fa.1
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 00:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154790; x=1715759590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpSlmhWgEetLXGMOpxHofxLV96CF0SXrJNEONBjBBHY=;
        b=oNwCqyLgRpeyfpc9HsT5lW6Z/70qJx3TgS5bAmpqFb+WWdd/O730tkgYyVlej5twTS
         /h4gtUOuM9fCDlpF5Mxvll+IK1ndVRAcrUDjEO2fMF3vE2Wqk1X+h131VbfWl4gvvBfK
         /ToexWe/fTtSw9Fl1iaGZiw+qULsaW4+1wEqzZsBshy+zedknh2YxfVlVfgXyk4s+i89
         mNyeNPOAqCEH1ZAup0U4I+M8g+hTEAJSJJjPy8luZAjao2Ndihw5lA5dCulPSlDzonPQ
         lD91uA8yenLE+m1WGJ9mYXPiMYuz5h9nhhdX9Km+uywHrK/Pc9jptswOI+Y3u01HWn8f
         QyKg==
X-Gm-Message-State: AOJu0YzvvKK5zdlVFGvKt70bNLt9jHWjxm9jBe8rcHgEc1RYPV6Z7E85
	7Wd62539ManjP2Db/Cl9Ui21ZyNiHkBvb2HqGdJUuzUyV+uP7+acr6D2pA==
X-Google-Smtp-Source: AGHT+IFne1AuJEPkJ8AW/iVpIzYHrNBoC1hFOmW7koRO/jrOoF7uGNeOjRJ5VqesAxvHuKdcUV76NA==
X-Received: by 2002:a2e:350d:0:b0:2e2:714c:23d2 with SMTP id 38308e7fff4ca-2e446d839b5mr10872151fa.1.1715154789119;
        Wed, 08 May 2024 00:53:09 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b0041bd85cd3f2sm1317093wmq.19.2024.05.08.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:53:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvmet-rdma: fix possible bad dereference when freeing rsps
Date: Wed,  8 May 2024 10:53:06 +0300
Message-Id: <20240508075306.1835106-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_005319_763749_D7AD8D18 
X-CRM114-Status: GOOD (  16.47  )
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

It is possible that the host connected and saw a cm established
event and started sending nvme capsules on the qp, however the
ctrl did not yet see an established event. This is why the
rsp_wait_list exists (for async handling of these cmds, we move
them to a pending list).

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

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- minor changelog reword

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


