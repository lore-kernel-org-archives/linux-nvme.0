Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B1C47DDB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBjr1PRHeWM0xSerDfMmnBng4xysPyyT7NLBK3E6yMo=; b=zpB2E68/SrVRemmTvHX1ByZdZw
	aC4jRBCQ0vzUZ0v/D+1lqCcs3rMb+Js3fQnqJDygqhWOhh6n/Q/4s8begivAkuZWbjmoY5QrqK138
	102w0nR2P3FxkkjdG8QzFRN19AYiLjnN+7g7+8SPFFNoxJLhmMMzL4RFq4QgZIFWf16hEhdf2gf4v
	Nm8h8bKndQT7+knADZv9WfWQ0k1x+xrv0hz2FaqZjQ1+na8//s/PntG1aMoQtexdIJ6YiFrnfewNC
	zwqVHNGTNXGdQpjylgTqGSvkmC8ATifjHk6hznLPdD8JgQ8XDtkFzzEmqsreWs8GYE2yvmLEv2xHV
	Sje9gbzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf2R-00000007FzA-24TX;
	Sat, 27 Jan 2024 09:31:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf24-00000007Fdt-22ZQ
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D88F260BEE;
	Sat, 27 Jan 2024 09:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC66C433F1;
	Sat, 27 Jan 2024 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347883;
	bh=p3CfUSk8z3KDTbvWZh1kBwZlWvRu1ltiM7wwS03rVrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDcUiMw5L5J2+H8ylMCi+e623sLZrMuNk4lWZt2mnPjDLO+9LUYvO+UBKGbKnFcOC
	 TImCLZFZacgd4+Ar/CXpjXZtBiBkN4jjZrZMWstJgJ4gRTGlh04seCGngAWFynFHF6
	 VS8sW1cU+6ckKrpieRWKIq1eCXkKU2MwlwCwTYHgAAvlqWfa3g7iWt27aoWbrXvH6K
	 Cetdy6afuvbA/OqilPGb5Q3CPr6gJwocxXyLzjxkd1GsduTSjA3LDEqZpEpledY7NW
	 U4OBXTHsUcsxDF+yUZNDmCl4jXRj4X2gz35S6yCQoLgbAXjOomliSwq+0nEQLlilh5
	 ZyOqH1VzyyKIA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/13] nvme-tcp: reset after recovery for secure concatenation
Date: Sat, 27 Jan 2024 10:30:57 +0100
Message-Id: <20240127093058.15699-13-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013124_841804_7D41F523 
X-CRM114-Status: GOOD (  15.81  )
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

With TP8018 a new key will be generated from the DH-HMAC-CHAP
protocol after reset or recovery, but we need to start over
to establish a new TLS connection with the new keys.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a46ab8370007..2e504fd9f616 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1834,6 +1834,18 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
 	mutex_unlock(&queue->queue_lock);
+	/*
+	 * If the TLS key has not been set
+	 * but the queue PSK serial is valid
+	 * we are in reset, and should invalidate
+	 * the PSK serial for this queue to ensure
+	 * TLS won't be started after reset.
+	 */
+	if (nvme_tcp_tls_enabled(queue) &&
+	    nctrl->opts->concat && !nctrl->opts->tls_key) {
+		dev_dbg(nctrl->device, "queue %d clear TLS PSK\n", qid);
+		queue->tls_key = 0;
+	}
 }
 
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
@@ -2263,6 +2275,21 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	if (nvme_tcp_setup_ctrl(ctrl, false))
 		goto requeue;
 
+	/*
+	 * Secure concatenation works in two steps;
+	 * the first connection is not encrypted, and
+	 * authentication generates the new TLS PSK.
+	 * Then the connection needs to be reset,
+	 * the TLS needs to be started with the generated
+	 * TLS PSK.
+	 */
+	if (ctrl->opts->concat && ctrl->opts->tls_key &&
+	    !nvme_tcp_tls_enabled(&tcp_ctrl->queues[0])) {
+		dev_info(ctrl->device, "Reset to enable TLS with generated PSK\n");
+		nvme_reset_ctrl(ctrl);
+		return;
+	}
+
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
 			ctrl->nr_reconnects);
 
@@ -2284,6 +2311,13 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
+	if (ctrl->opts->concat && ctrl->opts->tls_key) {
+		dev_dbg(ctrl->device, "Wipe generated TLS PSK %0x8\n",
+			key_serial(ctrl->opts->tls_key));
+		key_revoke(ctrl->opts->tls_key);
+		key_put(ctrl->opts->tls_key);
+		ctrl->opts->tls_key = NULL;
+	}
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
@@ -2320,6 +2354,14 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 
 	nvme_stop_ctrl(ctrl);
+	if (ctrl->opts->concat && ctrl->opts->tls_key &&
+	    to_tcp_ctrl(ctrl)->queues[0].tls_key) {
+		dev_dbg(ctrl->device, "Wipe generated TLS PSK %0x8\n",
+			key_serial(ctrl->opts->tls_key));
+		key_revoke(ctrl->opts->tls_key);
+		key_put(ctrl->opts->tls_key);
+		ctrl->opts->tls_key = NULL;
+	}
 	nvme_tcp_teardown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-- 
2.35.3


