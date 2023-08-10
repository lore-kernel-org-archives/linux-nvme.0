Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D441C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3PwYKTRmpJjhAIZl8R6wBIWaQc/qwL6eOlr+D7VNGm8=; b=T+/PFWyd9L6BxHbDhhr66DBGkr
	8RXYdsWmvddG0bst/qupxJWSFnpmwcmYF5mdOLoX8pr4SM2aJqkWRP3+6I35DgRHktSV4x6wvYkwt
	sufbyJLJBmmKz9JaecPpNhATkLkMDq/8PpfAWbr0ZEGxLcbn/2ARlqGPjHr4+HUGGljfxhNADkD6/
	CWV3tuMgGuM5ienuG3dsZYyXE7bYKdQy2r6UA87X2yCNhDiW/eNL0jDXUIxgOHt+CM7eloxlG6cgf
	S84fNJlF1sYcwPo80PG+QAsD2O8HO5gnu030QigtTVQ0QNuQ3IeF3jDeuCCnNSMNcVfFQx9ehBFZr
	lP4w3JmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5aI-007iCu-11;
	Thu, 10 Aug 2023 13:20:14 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5aF-007iBH-18
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:20:12 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C63F921846;
	Thu, 10 Aug 2023 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691673607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3PwYKTRmpJjhAIZl8R6wBIWaQc/qwL6eOlr+D7VNGm8=;
	b=EMCjK7F7Aj/i026RoYnoPaFOkakH+uxhc8Viu/xsBuv0aIbugUw0Ud4q1YR6MCKtubPXIX
	F8rZ4fBZhmDbg678nnIZtAHn7ri3LDifQBbqmxrAh+hJQYtd23PGE3xCsMaln7WXvoww3s
	B2QgO9U2Sk/BMmmsM0Q0tTC6WGO5PbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691673607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3PwYKTRmpJjhAIZl8R6wBIWaQc/qwL6eOlr+D7VNGm8=;
	b=OWY8tq7s4bJLjf8jFJ8vbYO6CR5TU4Yjtlw/uPIA+VvlRHdEI0WL1PYaCTD2F0v216Ll9k
	kT/zAvin0exExVDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B537F2C142;
	Thu, 10 Aug 2023 13:20:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id AC2C551CAE2F; Thu, 10 Aug 2023 15:20:07 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet-tcp: avoid circular locking dependency on install_queue()
Date: Thu, 10 Aug 2023 15:20:06 +0200
Message-Id: <20230810132006.129365-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_062011_525166_CCEE3C67 
X-CRM114-Status: GOOD (  12.49  )
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

nvmet_tcp_install_queue() is driven from the ->io_work workqueue
function, but will call flush_workqueue() which might trigger
->release_work() which in itself calls flush_work on ->io_work.

To avoid that check for pending queue in disconnecting status,
and return 'controller busy' until all disconnects are completed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f131b504aa01..97d07488072d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1845,8 +1845,18 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
 
 	if (sq->qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
+		struct nvmet_tcp_queue *q;
+		int pending = 0;
+
+		mutex_lock(&nvmet_tcp_queue_mutex);
+		list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
+			if (q->state == NVMET_TCP_Q_DISCONNECTING)
+				pending++;
+		}
+		mutex_unlock(&nvmet_tcp_queue_mutex);
+		/* Retry for pending controller teardown */
+		if (pending)
+			return NVME_SC_CONNECT_CTRL_BUSY;
 	}
 
 	queue->nr_cmds = sq->size * 2;
-- 
2.35.3


