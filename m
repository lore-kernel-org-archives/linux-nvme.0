Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07638CD5BBF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B9Fkzv8xh+mjRYdUNhcrn9f1VUvL5Lhj6g9C/+YLO/A=; b=IFc49RGXZE+tYTgRY6KR7MU/wl
	t/T5ly/GE85u0vrZVaNPSEUMJaYlu6X07yNgz7Z+mVTn4rQIdgfbqrA8IxRw/RSVXFxrocWhzYw4L
	Uh3Lp0yu/t9/SqoEhdYR8965o1O8AyDKxUlXTnHykS3ZjtpuOVy84rmFAfntFetnHGuDhAQAqeLdt
	3GUpQYGTAmhiZmhehM4JsJOcTj37CKqhbY8iZFputScnCLpucJDguZb2vkxjBhbIvJb6kKW9Nx9kA
	ciJn72Ovq9HmaGqfVM+/T6QNrAM9bn1/6iCvTCYT8mm1iMjJrAtGL9mdNteFZtTs0abtnT5Bb5UYn
	CqwC7wvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRxB-0000000Gruc-0U2g;
	Mon, 25 May 2026 09:50:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRRx9-0000000Gru5-3cKe
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 09:50:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1AA39600BB;
	Mon, 25 May 2026 09:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A721F000E9;
	Mon, 25 May 2026 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779702630;
	bh=B9Fkzv8xh+mjRYdUNhcrn9f1VUvL5Lhj6g9C/+YLO/A=;
	h=From:To:Cc:Subject:Date;
	b=hBKelmejvrEodTrQhoE0KaiVY+hkJ2Vk+iQ8K/XXWAUBcm1MOTG+2I+yDREGXUeZJ
	 95ZolU471BEjMMH5lfzKPByKxsKZX+SC3j9p7iF7EOX80DwD//D8RNY1IhnSpkyey1
	 QIrkr1OctIvLdydWz9iBDZJz+x1GnjNcV818yfv1HhX5H0cGOkdpTUg6AKY3vBfgGs
	 zIO980GRs82S9pdj9sC1Tr1rAFAWSp6b61lFKI8TBwgx3M/cFZLDuseMvbV3ONvjQT
	 0q9CmZGoCZiFGJnryDI7jNqMgYxoJ4LZRUCVDcfe4ZThl7zUCcAyCdgPDpOBGxtEVD
	 CiN8Qcqg5/vjw==
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-tcp: fix page fragment cache leak in error path
Date: Mon, 25 May 2026 17:50:19 +0800
Message-ID: <39d57858464bb3933160d6f7583640db086fbb80.1779702494.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

In nvmet_tcp_alloc_queue(), when a connection is closed during the
allocation process (e.g., nvmet_tcp_set_queue_sock() returns -ENOTCONN),
the error handling jumps to out_free_queue without draining the page
fragment cache.

Although nvmet_tcp_free_cmd() is called in some error paths to release
individual page fragments, the underlying page cache reference held by
queue->pf_cache is never released. This results in a page leak each time
a connection fails during allocation, which could lead to memory
exhaustion over time if connections are repeatedly opened and closed.

Fix this by calling page_frag_cache_drain() before freeing the queue
structure in the out_free_queue label.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..8b8ec533e352 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2002,6 +2002,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 out_sock:
 	fput(queue->sock->file);
 out_free_queue:
+	page_frag_cache_drain(&queue->pf_cache);
 	kfree(queue);
 out_release:
 	pr_err("failed to allocate queue, error %d\n", ret);
-- 
2.53.0


