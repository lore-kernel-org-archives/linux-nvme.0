Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C14CC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54J6VXP4049vHs1bNV/tiTC4h9IJc9VKgMm+rBmU7Cc=; b=wrkk5jv48gIVkW1rfiznMyl3s7
	FQLfqXV+TMakgAgfSPl3Rpo8bnh4oE0/tFasA4LXOVpFk4HpHefEnNEspLUdJU/na3eAWbpTYhe6L
	5PecdFSt95TBuoK17LnJMR7x7+BQ4ABRIQ2aygCG5vO73KnCusGFe6h5j0yzomcQKWYJ5Le1aVKxS
	SO1HHW1StBALDObGF463Ww9zfels9h6kLUofQVmduJMBQDW84rfwMvZh7hvr5i8lIEqx2dmhpW4wZ
	iegbrwjb5MIDfwQPTAhAJ2zFuG1PbD29nwCiPVuD3WshY4z5X1DZKlyY9gPVH5Be5Jzb/ZPrtiU65
	lO9FyOwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Yo8-000Hdb-73; Thu, 07 Jul 2022 21:13:08 +0000
Received: from mail-ot1-x361.google.com ([2607:f8b0:4864:20::361])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Yo4-000HaH-O3
	for linux-nvme@lists.infradead.org; Thu, 07 Jul 2022 21:13:07 +0000
Received: by mail-ot1-x361.google.com with SMTP id e1-20020a05683013c100b0061c1a6b8d11so1866259otq.8
        for <linux-nvme@lists.infradead.org>; Thu, 07 Jul 2022 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54J6VXP4049vHs1bNV/tiTC4h9IJc9VKgMm+rBmU7Cc=;
        b=MlZFO0EkIFkPKYKaOc8yEqZbOv2IhaEaFgK9Ey3r+E3V7Jbt3k+AuVi5PCydJqXZ01
         rol+Y+Dsjpx1UJ2wqcNrts0wVG+ydG3vlQRfvhj9XSGgIy2YXzyLhw051Iwn2uEP8z0I
         gWPUZ1+ZtEP/2KDQqoha90seZAq56CQyjUNDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54J6VXP4049vHs1bNV/tiTC4h9IJc9VKgMm+rBmU7Cc=;
        b=feAMdrHOGLZBGYfcWk0aaeF6AYZS/IjwQNC6KOPaPcPFp1dKFuZ3qi+1gRar0Ers6G
         JJCduVR4DjKtFrngOBLcqZ0QLSEb2gp9FNF7Ey9thQuA/Ez3p8W+kCbOxinSWe4qG9dB
         cgcx3xSqIPbcr2b/LQ2J/R+oqEiIN6qrdcCFZu4A+Ek9ynajg1H5bG6rKJ4Bo6YyOxkz
         OsK00MnXv+lY0Kyc9lEA53LcyXDyRruF3J9pZBGBWAft2JpK8U9RxshHoVXhPjfUnPdF
         nNapmfbJKoDSGnFbwsqhPnBxR8GoTGjoZ13zIM88g/ipumwGqcr6MzcRN/EiyHC3ARTw
         cC2w==
X-Gm-Message-State: AJIora+QQ6yznlS7ryFgmJegTavD/RMUbTjFzIXrpc86VVX872Vxm57l
	VDftsn9OqPyif4721xPKaF+Gr5UcjkF+M7KRcmLSrUtkc2rNEQ==
X-Google-Smtp-Source: AGRyM1sOFse65d6pDbMKetGVQ78DyDOf3kgQyShKMkSUif6sKd0UC8p275VCsqetPHVG81Vt+CdBSeLjXcPL
X-Received: by 2002:a9d:51cf:0:b0:616:cc7a:82ed with SMTP id d15-20020a9d51cf000000b00616cc7a82edmr55318oth.244.1657228376975;
        Thu, 07 Jul 2022 14:12:56 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id cm8-20020a056870b60800b000edf58f87ccsm4936693oab.31.2022.07.07.14.12.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 14:12:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 402CE221A7;
	Thu,  7 Jul 2022 15:12:56 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 39EEAE4007F; Thu,  7 Jul 2022 15:12:56 -0600 (MDT)
From: Caleb Sander <csander@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Caleb Sander <csander@purestorage.com>
Subject: [PATCH v2] nvme-tcp: use in-capsule data for I/O connect
Date: Thu,  7 Jul 2022 15:12:45 -0600
Message-Id: <20220707211245.3989107-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me>
References: <4cfe8116-bb6c-735d-0bb3-ce5e2612505b@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_141304_942917_AB4CE15F 
X-CRM114-Status: GOOD (  17.07  )
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

From the NVMe/TCP spec:
> The maximum amount of in-capsule data for Fabrics and Admin Commands
> is 8,192 bytes ... NVMe/TCP controllers must support in-capsule data
> for Fabrics and Admin Command Capsules

Currently, command data is only sent in-capsule on the admin queue
or I/O queues that indicate support for it.
Send fabrics command data in-capsule for I/O queues too to avoid
needing a separate H2CData PDU for the connect command.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/tcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7a9e6ffa2342..307780d2787a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -207,13 +207,15 @@ static inline u8 nvme_tcp_hdgst_len(struct nvme_tcp_queue *queue)
 static inline u8 nvme_tcp_ddgst_len(struct nvme_tcp_queue *queue)
 {
 	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
 }

-static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_queue *queue)
+static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_request *req)
 {
-	return queue->cmnd_capsule_len - sizeof(struct nvme_command);
+	if (nvme_is_fabrics(req->req.cmd))
+		return NVME_TCP_ADMIN_CCSZ;
+	return req->queue->cmnd_capsule_len - sizeof(struct nvme_command);
 }

 static inline bool nvme_tcp_async_req(struct nvme_tcp_request *req)
 {
 	return req == &req->queue->ctrl->async_req;
@@ -227,11 +229,11 @@ static inline bool nvme_tcp_has_inline_data(struct nvme_tcp_request *req)
 		return false; /* async events don't have a request */

 	rq = blk_mq_rq_from_pdu(req);

 	return rq_data_dir(rq) == WRITE && req->data_len &&
-		req->data_len <= nvme_tcp_inline_data_size(req->queue);
+		req->data_len <= nvme_tcp_inline_data_size(req);
 }

 static inline struct page *nvme_tcp_req_cur_page(struct nvme_tcp_request *req)
 {
 	return req->iter.bvec->bv_page;
@@ -2370,11 +2372,11 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 	c->common.flags |= NVME_CMD_SGL_METABUF;

 	if (!blk_rq_nr_phys_segments(rq))
 		nvme_tcp_set_sg_null(c);
 	else if (rq_data_dir(rq) == WRITE &&
-	    req->data_len <= nvme_tcp_inline_data_size(queue))
+	    req->data_len <= nvme_tcp_inline_data_size(req))
 		nvme_tcp_set_sg_inline(queue, c, req->data_len);
 	else
 		nvme_tcp_set_sg_host_data(c, req->data_len);

 	return 0;
@@ -2405,11 +2407,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->curr_bio = rq->bio;
 	if (req->curr_bio && req->data_len)
 		nvme_tcp_init_iter(req, rq_data_dir(rq));

 	if (rq_data_dir(rq) == WRITE &&
-	    req->data_len <= nvme_tcp_inline_data_size(queue))
+	    req->data_len <= nvme_tcp_inline_data_size(req))
 		req->pdu_len = req->data_len;

 	pdu->hdr.type = nvme_tcp_cmd;
 	pdu->hdr.flags = 0;
 	if (queue->hdr_digest)
--
2.25.1


