Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qtWxVYPYFFCX8G2PwLXHUw6qhRFCTgriIKLN14V2yyA=; b=RPH33NhxF/HA8HT/DKnASrjeWG
	TPqQAPspCZwjzXGbEiqSrNf6f0kIFYjHbEJBGoYQr/cGvgIT+E32FBlGiljEq5D92nkePJ4TQWzaC
	Kvz3rHp0nWBA057SkeeBtrKjg301btk815wWocB3feNz9KBjkhJBPtBYu9D6fIZQuzYTjZRjZTfrL
	MIKUsra4POnSrLKDytduwHvGQqe80E/fRodAFTP3170aZbMLNJU7rL8v6qL8TtVKwx/RQfS73Qdu2
	81SL968WFpROaUVm/bvQhp7Epz7C5CweHsXgMqf/Q6dIMu16KI5CQhFnpTejWyXesH2aix1Q7NDpy
	kptHvoaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8Wa-007C8e-2K;
	Wed, 01 Nov 2023 10:32:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8WV-007C7b-0j
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 10:32:35 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id CC4781F74A;
	Wed,  1 Nov 2023 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698834749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtWxVYPYFFCX8G2PwLXHUw6qhRFCTgriIKLN14V2yyA=;
	b=WxCPhxhB0gkLmr+RXmWN3MqtPIvzfdl21kaKnuGnO+hiBo/P24yuw2oA9OcRivBJd0R38+
	eeB8LGuhznIVws6AdopkJK912w8zcihi4sdj99L6K8okwgcoauUHA5IA3obeH6SkjkfiUF
	45gXRQI85g/HbaTuu6OairuXZdRg4oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698834749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtWxVYPYFFCX8G2PwLXHUw6qhRFCTgriIKLN14V2yyA=;
	b=b9UQoe1d5ZzXbLjTQXTWesCPjOUW0AWyviruxKUK1LYvxvbFfk8YeJ8/CTu5vIS1PycrP5
	w1XYL5R285daB2Cg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8871B2D09C;
	Wed,  1 Nov 2023 10:32:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id BC94451ECA0B; Wed,  1 Nov 2023 11:32:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvmet-tcp: avoid circular locking dependency on install_queue()
Date: Wed,  1 Nov 2023 11:32:28 +0100
Message-Id: <20231101103228.136570-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231101103228.136570-1-hare@suse.de>
References: <20231101103228.136570-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_033231_433387_1E3197B6 
X-CRM114-Status: GOOD (  13.58  )
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
index b3c1cc6690f6..ecc9ccfac823 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2121,8 +2121,18 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
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


