Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C89BC47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4OJBefeOqKsrhWYI7kNKDVNxoZUFaAHH5bIIn/h7t8=; b=dA1HB25ZA9etVUtHEsAilrbSFu
	qaiiUHr85KXlt5N9zPAs2pNR+Q0ktpFKdlAfOFesASO600y5CFNQxwAAYPJImUdWChlT9xV891UgF
	bSjTNsq0RjkOjJcpoOyhrXnFqAOTKG9sa2aEGOgKLvn5xP+fQ1YGlELe+b98hiZAFiobPrE2kB0NG
	wtRg3xODuSgpycBy601fjgSsZSdBpyAoB2hY5ox1p2rxXIqV/RhqiVp62G5NHLc6qctlO1cvW2LEz
	IeUKC0TFXMEn3qBZdNGKlw2wzLTn9UOMPB+G6jZQeLqYgH6GXUCXohiYudoOTMwacYYLI7ZY9tjSr
	9yrkpIZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJW-0000000BWah-1gU5;
	Mon, 29 Jan 2024 06:40:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJT-0000000BWZe-37gG
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:40:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4EDA2CE1000;
	Mon, 29 Jan 2024 06:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FBC433F1;
	Mon, 29 Jan 2024 06:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706510406;
	bh=bGFFdxNuAg+uT6JvP0fbni7TjSfH0AwUR8lfp1SfEvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHFZYk5uxcNVoEDYAN8mDj/2BEgEvCAluyyeSjiKqhSyhtmkfPWfgzxhqXhHvwqBa
	 6vvZwvmKQCmQmSyGpOYYsjcUi0WNOUw9vrPz+a24XTtDTvwkG9Sukopv9o44PQFOcG
	 ScM/il6TCg4JG7vKgXpAII7cJ8iyIHQPUq5MmgmMcRTp62r6ZVR8cfYt6EZh2C86Vb
	 nnU31InE5fOiNT4c5Mps1GbaK9EsX+a3oegzrSixKP/IGmYjpmpdkwtR5uWyW80kpE
	 9iuUZNGnb4EdDJfCvG4QGGAQBFqiSh2gSr3nDT5VY9BMAzCb8o/c+JPQfR8eiG69Bk
	 Os3DEWk3VTmNA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvme-auth: open-code single-use macros
Date: Mon, 29 Jan 2024 07:39:45 +0100
Message-Id: <20240129063948.3105-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240129063948.3105-1-hare@kernel.org>
References: <20240129063948.3105-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_224012_001383_7849F189 
X-CRM114-Status: GOOD (  12.29  )
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

From: Hannes Reinecke <hare@suse.de>

No point in having macros just for a single function nvme_auth_submit().
Open-code them into the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/auth.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 72c0525c75f5..9aa2325f9a98 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -48,11 +48,6 @@ struct nvme_dhchap_queue_context {
 
 static struct workqueue_struct *nvme_auth_wq;
 
-#define nvme_auth_flags_from_qid(qid) \
-	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
-#define nvme_auth_queue_from_qid(ctrl, qid) \
-	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
-
 static inline int ctrl_max_dhchaps(struct nvme_ctrl *ctrl)
 {
 	return ctrl->opts->nr_io_queues + ctrl->opts->nr_write_queues +
@@ -63,10 +58,15 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			    void *data, size_t data_len, bool auth_send)
 {
 	struct nvme_command cmd = {};
-	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
-	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
+	blk_mq_req_flags_t flags = 0;
+	struct request_queue *q = ctrl->fabrics_q;
 	int ret;
 
+	if (qid != 0) {
+		flags |= BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED;
+		q = ctrl->connect_q;
+	}
+
 	cmd.auth_common.opcode = nvme_fabrics_command;
 	cmd.auth_common.secp = NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
 	cmd.auth_common.spsp0 = 0x01;
-- 
2.35.3


