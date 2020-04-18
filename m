Return-Path: <SRS0=7Vx6=6C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B267C3A5A0
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2020 13:48:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF1421D6C
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2020 13:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NNQ7LaTj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm41ULvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF1421D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0eCpoqXKLk1YdEmMCFk25HJDjJXozq9xX/8NyNSFXHA=; b=NNQ7LaTjDD+d62
	qrfUc2Z+WuR+qz/5dE5gNxvXmQ4JLkQ+QpW2JyAlJRd0aYcxuk9rk2WQntjH1VzbXMSq7qKbmlgKJ
	1Hdr4200/gWDYMqzYtUEzG7tx2rUzblUfGT75SzvTYqSeBUFkvPzhtMLhWY90uasWuxqRPXDyA1br
	Zz15cTKVSrWUWD5MhJWnRJboTNkIzXzllFfGGXyb4pPkaTAUO9SKFWNLnJAb42w+fgXfu8kZkTw+p
	eBNnmSGaVZruKjDgo8oPZL9KX7m76iNkbGY7KFwFsR86S/NIhQOtPd713rUnYoZCivtufOKQEU79f
	jWCtgpWYd54nBLaCNLNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPnpu-0004aK-O9; Sat, 18 Apr 2020 13:48:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPnpk-0004Pv-QU
 for linux-nvme@lists.infradead.org; Sat, 18 Apr 2020 13:48:38 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9232422202;
 Sat, 18 Apr 2020 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587217716;
 bh=emCtJ33z/m5pfLdFAGdxdHQ4439wBNBlCSZF5CWCU9Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Qm41ULvokLlKS1OQ+dND0L+w+oL4Tta1sixjMVwuCppI4tpsG3Yzh1HLqiSimpwkv
 DYN4GzNI9qNDwYxYzM0/qiu/NGPpAb/D3hd54CDTejp+Bc0Twq6ZOUvOdqNTUAvAGi
 iBD0RND7aksie2rzww1mto8fLY/FwVkZZvmRRQj8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 17/73] nvme-tcp: fix possible crash in
 write_zeroes processing
Date: Sat, 18 Apr 2020 09:47:19 -0400
Message-Id: <20200418134815.6519-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200418_064836_873900_CD0EAC3D 
X-CRM114-Status: GOOD (  12.23  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Tony Asleson <tasleson@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 25e5cb780e62bde432b401f312bb847edc78b432 ]

We cannot look at blk_rq_payload_bytes without first checking
that the request has a mappable physical segments first (e.g.
blk_rq_nr_phys_segments(rq) != 0) and only then to take the
request payload bytes. This caused us to send a wrong sgl to
the target or even dereference a non-existing buffer in case
we actually got to the data send sequence (if it was in-capsule).

Reported-by: Tony Asleson <tasleson@redhat.com>
Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 49d4373b84eb3..00e6aa59954d4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -164,16 +164,14 @@ static inline bool nvme_tcp_async_req(struct nvme_tcp_request *req)
 static inline bool nvme_tcp_has_inline_data(struct nvme_tcp_request *req)
 {
 	struct request *rq;
-	unsigned int bytes;
 
 	if (unlikely(nvme_tcp_async_req(req)))
 		return false; /* async events don't have a request */
 
 	rq = blk_mq_rq_from_pdu(req);
-	bytes = blk_rq_payload_bytes(rq);
 
-	return rq_data_dir(rq) == WRITE && bytes &&
-		bytes <= nvme_tcp_inline_data_size(req->queue);
+	return rq_data_dir(rq) == WRITE && req->data_len &&
+		req->data_len <= nvme_tcp_inline_data_size(req->queue);
 }
 
 static inline struct page *nvme_tcp_req_cur_page(struct nvme_tcp_request *req)
@@ -2090,7 +2088,9 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (rq_data_dir(rq) == WRITE && req->data_len &&
+	if (!blk_rq_nr_phys_segments(rq))
+		nvme_tcp_set_sg_null(c);
+	else if (rq_data_dir(rq) == WRITE &&
 	    req->data_len <= nvme_tcp_inline_data_size(queue))
 		nvme_tcp_set_sg_inline(queue, c, req->data_len);
 	else
@@ -2117,7 +2117,8 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_sent = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
-	req->data_len = blk_rq_payload_bytes(rq);
+	req->data_len = blk_rq_nr_phys_segments(rq) ?
+				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
 
 	if (rq_data_dir(rq) == WRITE &&
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
