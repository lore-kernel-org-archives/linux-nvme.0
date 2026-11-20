Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7A606A6A6
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hoRgV7EG;
	dkim=pass (2048-bit key, unprotected) header.d=hudson-trading.com header.i=@hudson-trading.com header.a=rsa-sha256 header.s=postfix-20201111 header.b=bDkrRHWS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=a9D/kK9gQlIjVthHwRyaiRqGMNCncfyL071uR14t4wU=; b=hoRgV7EG6QvKmR55k3WJFX6Nbj
	b3hcYrenpKRkgXyW4m0ALiW3lHLxP/F2myLN9vsXvBlakMy75oqOrxMIMhxjoZ1wEGJCK5XJU03i0
	QO3vp3UeTHHBNUMR8fUL0sQ0XXTbYRGJb5BmaCtaqn3i6/S8IjDejNSlsWENvSXdIdFEAClqe28EU
	w/ZQmA0h8hU6FP9xpNLXhngb3TQwKKGG18AZy3U8WRaJWj2ApXwbUyjB8ohrsBqdcLTX+fMzCLODY
	QrmqoO9YXBqSWvx8bn3BZHY2u3n1wFXFZd5SslTou67H72POWgY0I/dGlcStireG6dvVn0AguA0cs
	feYfpu6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUY8W-0000000GQTD-2Lzc;
	Fri, 20 Nov 2026 23:35:20 +0000
Received: from [38.105.238.108] (helo=smtp.hudson-trading.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUY8T-0000000GQRX-2crs
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 23:35:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hudson-trading.com; i=@hudson-trading.com; q=dns/txt;
 s=postfix-20201111; t=1795217713; h=from : to : cc : subject : date :
 message-id : mime-version : content-transfer-encoding : from;
 bh=a9D/kK9gQlIjVthHwRyaiRqGMNCncfyL071uR14t4wU=;
 b=bDkrRHWS3s6BioS0yCRuDxfDLUv20Qe10TRCKue/PiaK5oFNnpVEEl+tOkWAhi5wfhz9U
 nXzj+y3kSIVf5swLh/4jeXofaQ2M8pZJK4Gi69toJ6oAWhX7YDTfOOc4WDUL4eNJpG/hVQn
 fCjtvWYcRmdoJ1wJN7iLU6GD9YPRBckIvbnQXlg+ZHtzKvH9D3PTBihrChukBdWRSXa9Lb2
 0+BpPQ1PrjqRhOwZ8PHTvlOXwhOMco2yrvCtdMiSYmi1Ovk1vx2r4zLxEgO2azhQSSS7GtE
 F7Raif2PbuHFGeT0LahGTjjqkgYbmYzjvQsqTazoLM6hOKvZsqb3j0yF0Leg==
Received: from shauser-sthiell1.hudson-trading.com (shauser-sthiell1.hudson-trading.com [10.20.74.239])
	by smtp.hudson-trading.com (Postfix) with ESMTP id A800421E57C;
	Fri, 20 Nov 2026 18:35:13 -0500 (EST)
From: Stephane Thiell <sthiell@hudson-trading.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	sgogte@purestorage.com,
	Stephane Thiell <sthiell@hudson-trading.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: don't free I/O queues before cancelling requests
Date: Fri, 20 Nov 2026 18:35:08 -0500
Message-ID: <20261120233508.379363-1-sthiell@hudson-trading.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_153517_757067_82E64F52 
X-CRM114-Status: GOOD (  14.81  )
X-Spam-Score: -1.3 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup"), the error path of nvme_rdma_setup_io_queues() frees the
queues of the batch. The caller cancels the outstanding requests only
afterwards.

This matters on a reconnect. Error recovery leaves the I/O queues
unquiesced, so a queue that went live can have requests in flight when
another queue of the same batch fails. The QP and the MR pools of the
live queue are then freed under those requests. When
nvme_cancel_tagset() completes them, each request with a registered MR
ends up in ib_mr_pool_put() on the freed QP.

Only stop the queues in the unwind, as nvme_rdma_start_io_queues() did
before that commit. The caller already calls nvme_rdma_free_io_queues()
after it has cancelled the requests.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Stephane Thiell <sthiell@hudson-trading.com>
---
Found by code review, not reproduced. Build-tested (W=1) on
v7.4-rc3-602-g5f22fb20497f only.

 drivers/nvme/host/rdma.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 32189fdfc0f5..c45e45dec287 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -748,19 +748,13 @@ static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
 
 	ret = READ_ONCE(err);
 	if (ret)
-		goto out_free_queues;
+		goto out_stop_queues;
 
 	return 0;
-out_free_queues:
-	for (i = 0; i < nr_queues; i++) {
-		struct nvme_rdma_queue *queue =
-			&ctrl->queues[first + i];
-
-		if (test_bit(NVME_RDMA_Q_LIVE, &queue->flags))
-			nvme_rdma_stop_queue(queue);
-		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
-			nvme_rdma_free_queue(queue);
-	}
+out_stop_queues:
+	/* don't free here: requests may still be outstanding */
+	for (i = 0; i < nr_queues; i++)
+		nvme_rdma_stop_queue(&ctrl->queues[first + i]);
 
 	return ret;
 }

base-commit: 5f22fb20497f4983094131f00a734362300d22d2
-- 
2.39.1


