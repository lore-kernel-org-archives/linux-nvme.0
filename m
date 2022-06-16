Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8603EC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AD4grlVJZtNLdcOBqtmGnxKslDq8DiEUE6JKJCOM9bQ=; b=3j7mra4wBDcWspcJaMQj5v/4jv
	TPmbnEFP2wsrfvWgADVnADYMph/7chpF4FJafDTu3sCOkovcD5kz/O3qz6FMoDCzH+Oft1PaaurqF
	BiU6OO/fS7bNGD/pDjB1T/JAHdfZitW5F0nXB9HJsHCCWn6SXmFcwgPULTlKfae6NOUfmTlaSbQVJ
	ajhjUKHmMGkun1QP97fWRLRrvXfRe8abUTsA/hpXv/Q6fh9pbwv9G7h3+FGCJwh5rBHCEMJL62VrZ
	6GgPm3VWhePprMhhdAW+ayRCGY9KNn3rqRIvG6CVOCTZIvRVgeWP4y8MbcRt7ziueH8RMVo4eSjqd
	om1yN/Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1qoe-00305M-Em; Thu, 16 Jun 2022 14:49:48 +0000
Received: from mail-oi1-x261.google.com ([2607:f8b0:4864:20::261])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1qoa-00304V-2V
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 14:49:46 +0000
Received: by mail-oi1-x261.google.com with SMTP id bd16so2128709oib.6
        for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AD4grlVJZtNLdcOBqtmGnxKslDq8DiEUE6JKJCOM9bQ=;
        b=WvFm3ZxdiOuWPFbHv7aqt+u9ai7nZvw3AHoTjFi1jnqpMXpgtkEIHz4VzvXhxdMXQe
         t2IsAV/RHqmiut78OgfbPtgihI80hTm3mo18Qe+QTuh+oTvXYOC/JyURZ0XVUBT/9xAf
         Hh3O/jLO589EMm2GvWJZKN3P3Oqo3A3bGG4wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AD4grlVJZtNLdcOBqtmGnxKslDq8DiEUE6JKJCOM9bQ=;
        b=BsB5wQEKHv08TT6zafJOfAKumltK1yw1CTP01tkxMszuMdO7UwwCuGDsaKvOQ5qJ3v
         d6yq2rv3SKD7pCHjaoNjunyoCzD6P3HS7zjCileq82EbWp31YElgzRw7HAbIVkTiCRJd
         cG4nS5eRL9BFsX16ktInhpuQ0sVJAw1brVedNc0ocG23yyIfeM0xId4c/ShqnxxU9XQ1
         Y3qngL8k22B9i/2zPdt/VRHBITObCXKMmjQIcg53JGM9yPNHn7W0iQ6LPftOMINHAnVu
         ITHIgMBQnvM4h8H3+DuCPKr2ttYlRW9mc4wy2q+dyt4gHwgRKCB4wlwPEcsmrF2/TWBh
         VDGw==
X-Gm-Message-State: AOAM532AJq/FZ0n223YOqr8rgciQlKmqf8iKdUZ+yJQZyvzSCICzCecu
	KoaIbRtL5O/M1mMoCyFEXpnIAJZtPiw6vLSfeVG2FZPkvyabDEHChN/CII2bzAVsQw==
X-Google-Smtp-Source: ABdhPJy+rtTSZObaGi35hERbPEc/3pe8E4YMJKx8ncrnU9T0OHARm0wxIbq+FXQlUzkJgSK56oe7WjVS6y6c
X-Received: by 2002:a05:6808:191d:b0:32e:8e4e:abbd with SMTP id bf29-20020a056808191d00b0032e8e4eabbdmr7864554oib.263.1655390980587;
        Thu, 16 Jun 2022 07:49:40 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id he19-20020a056870799300b00100ee8acf1asm266498oab.11.2022.06.16.07.49.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2022 07:49:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 93B36221D1;
	Thu, 16 Jun 2022 08:49:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8E14DE40EF0; Thu, 16 Jun 2022 08:49:36 -0600 (MDT)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>
Subject: [PATCH] nvme/tcp: use in-capsule data for fabrics commands
Date: Thu, 16 Jun 2022 08:49:15 -0600
Message-Id: <20220616144915.1004305-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_074944_239902_3E79DDCC 
X-CRM114-Status: GOOD (  14.43  )
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
needing a separate H2CData PDU.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/tcp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb67538d2..f1869ab3c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -207,12 +207,15 @@ static inline u8 nvme_tcp_hdgst_len(struct nvme_tcp_queue *queue)
 static inline u8 nvme_tcp_ddgst_len(struct nvme_tcp_queue *queue)
 {
 	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
 }
 
-static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_queue *queue)
+static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_request *req)
 {
+	if (nvme_is_fabrics(req->req.cmd))
+		return NVME_TCP_ADMIN_CCSZ;
 	return queue->cmnd_capsule_len - sizeof(struct nvme_command);
 }
 
 static inline bool nvme_tcp_async_req(struct nvme_tcp_request *req)
 {
@@ -227,11 +230,11 @@ static inline bool nvme_tcp_has_inline_data(struct nvme_tcp_request *req)
 		return false; /* async events don't have a request */
 
 	rq = blk_mq_rq_from_pdu(req);
 
 	return rq_data_dir(rq) == WRITE && req->data_len &&
-		req->data_len <= nvme_tcp_inline_data_size(req->queue);
+		req->data_len <= nvme_tcp_inline_data_size(req->queue, req);
 }
 
 static inline struct page *nvme_tcp_req_cur_page(struct nvme_tcp_request *req)
 {
 	return req->iter.bvec->bv_page;
@@ -2368,11 +2371,11 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
 	if (!blk_rq_nr_phys_segments(rq))
 		nvme_tcp_set_sg_null(c);
 	else if (rq_data_dir(rq) == WRITE &&
-	    req->data_len <= nvme_tcp_inline_data_size(queue))
+	    req->data_len <= nvme_tcp_inline_data_size(queue, req))
 		nvme_tcp_set_sg_inline(queue, c, req->data_len);
 	else
 		nvme_tcp_set_sg_host_data(c, req->data_len);
 
 	return 0;
@@ -2403,11 +2406,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->curr_bio = rq->bio;
 	if (req->curr_bio && req->data_len)
 		nvme_tcp_init_iter(req, rq_data_dir(rq));
 
 	if (rq_data_dir(rq) == WRITE &&
-	    req->data_len <= nvme_tcp_inline_data_size(queue))
+	    req->data_len <= nvme_tcp_inline_data_size(queue, req))
 		req->pdu_len = req->data_len;
 
 	pdu->hdr.type = nvme_tcp_cmd;
 	pdu->hdr.flags = 0;
 	if (queue->hdr_digest)
-- 
2.25.1


