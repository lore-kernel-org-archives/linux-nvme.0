Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B2EC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I4XnYycdquzis/+ePbON22tD7JOvA6qICn4JRWHRdcA=; b=YoC4HNZhq3j6I+hc0ecAkOwRtv
	c3gtdGOYAaMDx/zCquoxgBMkh99GvkhsEQa4xo4VwagYMvPUnf3QhKU09GA7rjberYhCDwpVeVMrJ
	sm91O0w0cOTpJkgYQfF9HPBTujZdf7PlGFocL1AYlSd0kwf0i0RS0C6IgfdOyBlfg0ZPhVmYIcpdP
	/ocQXhTpHi7ehUj5xsnsaH7ttOMfx/ztjc1B+IMix5ulznuTa3FyuE2BICG7gaw2o5V+Iaq9I/nuF
	O+CMagKiFkrvQW/eeF+2VvVH+Nuz+vLGQvyp8osN0TbAsc3/0NAq/0iK4Cyr0jA9GRoN2ablShX2Z
	aa1r0bGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9hIz-000000099Dp-3nWq;
	Tue, 29 Apr 2025 09:31:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9gA4-00000008thv-3Xuh
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 08:17:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C83644ED4;
	Tue, 29 Apr 2025 08:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFC3C4CEED;
	Tue, 29 Apr 2025 08:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745914672;
	bh=k9DgTOwc+Yzf2cMlt8Xq+DNd/bhvKnTYbhakSHmlIo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2LJkzn/csl9z38it0yltX3dXhnBJl1o8iC8oJOBehOBnG4artb6Qym+u81lp6enJ
	 c9EWcgWorjSqtLj5ux70pp8aEKgd7hwxTM/fmKNRgNPEWE2E8+daJxpBEUYdF0k01Y
	 SxvwcnB5JJjUuZ4e330dXOdBrO2eRArM1uDSXAXJqmohtj/KZBb1Ox8tsAJS9FpDAh
	 OjR6K9yOf5jz1ujUTOYuKPCbUXbr4rDCdVWmUAqGo1V6ZJqtIH9QArGAgGa9xHZ69t
	 /QTNl1zON6NH6V9ad+OPxCq5oREIl/h0wglKB+4pZorQEfAox06XUlsRY9I12YkJgT
	 cq5Va264Ej75w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-tcp: sanitize request list handling
Date: Tue, 29 Apr 2025 10:17:38 +0200
Message-Id: <20250429081739.44820-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250429081739.44820-1-hare@kernel.org>
References: <20250429081739.44820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_011752_906125_36ABA3AB 
X-CRM114-Status: GOOD (  11.28  )
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

Validate the request in nvme_tcp_handle_r2t() to ensure it's not
part of any list, otherwise a malicious R2T PDU might inject a
loop in request list processing.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a9d455c39652..1c39a307456c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -452,7 +452,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -560,6 +561,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -764,6 +767,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (llist_on_list(&req->lentry) ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -2611,6 +2622,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
-- 
2.35.3


