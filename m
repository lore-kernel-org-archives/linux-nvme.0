Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7EDC46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMP/IV4ETJeciu6aMMmUBbnIn/UnMK6rCQjPgHHEVz0=; b=VCFkAuAbTkWXfNWdKv1LJlSIcB
	W01fpWeNSyDnQ2bNplAZhk8p52VBG6bmh12gd+Z2FH1d2OBMSu0TQiwhXSGXc74j1ozOHM+gZluU/
	sjzOBw9Ds/xmj9YJp03z+0paf8lFiZJcXwVgSbqSgjNrLkORGqxnFZdansDLsqW29T/vdBrtHJyKv
	+OJw+szcNNZNxUoX2zYTkPsjQ2dw4uAFFA4b6KciA5mozT0bKnxlZxrn+MI8WctUh8/xD5cvXOedp
	wJ8byQiGL590m7m7ez03E8Ib7IOYYzRrK3oJyFOHHQOcPmSas3xB4Oj9MjiynvQPObZFLeGGp13OI
	1ie9MvMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf8v-00000007Hq5-2Frb;
	Sat, 27 Jan 2024 09:38:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf8t-00000007Hp8-0Zga
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:38:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8051660C4B;
	Sat, 27 Jan 2024 09:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCC2C433C7;
	Sat, 27 Jan 2024 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706348276;
	bh=hvn4xRkiyZqcN0V2egnCfg7DVxsfLVZ0525X3U2WW50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryhY5rJEoonH7f6zkSMgLFneTS0Y2lQWSl1d9uhFuQgmbhnDbHWp2oQE0FLzSx/g1
	 RUQhevJo+ia5iWCz70qx41ZMxautbVA6xqHwg+kFcRXXN249COSn/QeZ2EisXf3JWs
	 6u/7DA4ngJLmOXghVvmV6lgSf+a8Ms3kWva47CkUBQqBDQUDp/OG6LDeYPVOSQ7gzQ
	 c32p05gjT+B4amDJ5LMFFibxyCJGlyeVW1AFB3JdAdUQWNK/8v8TTF3+vSmTF8s1aV
	 RHO+Qg5DDkhO0KuhxZ07YeNbHdO56X5PEqd7LTsl6nGFhqFOKxB2zir5TmY9myDagu
	 kTbI5W3TAJ9IQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvme-auth: open-code single-use macros
Date: Sat, 27 Jan 2024 10:37:44 +0100
Message-Id: <20240127093746.40246-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093746.40246-1-hare@kernel.org>
References: <20240127093746.40246-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013827_243964_E06E7712 
X-CRM114-Status: GOOD (  11.93  )
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


