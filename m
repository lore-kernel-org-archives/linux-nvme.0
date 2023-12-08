Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40FDC4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4fCPwAt+tgapIj7tK5eOKU4efOYEXl6Po9CgBeCobQ=; b=EibWwo+NWF9N5opvEwSe6xphoI
	Tf81o417oWQphTpXGltEaYSOi2a1zKHKpude9pIe1q4wpn2GXMQAu5vGzlpwK4HyrMl6pda46upA/
	rXikQROIugHNV8ugk49MSRNxNEhs/3yj8Ms7YMUV/joKz/k0S5p5HshosCnOgH+Cuwkc/mTwQBa5w
	mevq7EBAD/hz7Xj0akt0LtG9g2zKWf/p2+R8gYxcPQxNFSrZ1Lxk144qwxOqZv0JzQG/QOqjlMbvz
	0DUyy7R4ORm0agvIxl3jFA72QsaRO9/07TiNXcEtrNoZI9AlOt0if8//BMI/na/j1kXcUc3DZXIdS
	inBwUztw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaMF-00Fdp9-0a;
	Fri, 08 Dec 2023 12:53:31 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBaMC-00FdoO-0x
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 12:53:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id D017BB82C95;
	Fri,  8 Dec 2023 12:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB50C433C9;
	Fri,  8 Dec 2023 12:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702040006;
	bh=m6mFx3doqbEDPzLRyEgWgm6GcXOd3la5s54rncs/Ubg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7V127bhPj7cxvKXswHE4q11UCM+UPMf1SnK71xtc7mntttruL677TtW2chDSZAC/
	 cQnHI8UjASHC8ettzJXKrdSGjecstesk2WwI8WOD7Wr/NZ08EWloZasJDrUZlls/Uz
	 78LsfVdQnTO43CCdogLqg/+GivBC3oq/mH23TJPNRl3YaLgYeBvu80vyo1Kdbzfblo
	 QVrRdNMHVHbXx5hOTxpZoZaIpAudXSuNQxnny5a8dwN819uhzKYx6yC2iDBvHzQYDO
	 HsMlZxcDVW+mw1r5J0/JJEF6CtZG19+Hw7oxnS2yMZo6CmJBvuJIucmsQk+SGdXhij
	 ba7YjiI/8kbrA==
From: hare@kernel.org
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] nvmet-tcp: avoid circular locking dependency on install_queue()
Date: Fri,  8 Dec 2023 13:53:20 +0100
Message-Id: <20231208125321.165819-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231208125321.165819-1-hare@kernel.org>
References: <20231208125321.165819-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_045328_484901_DC1AF3DC 
X-CRM114-Status: GOOD (  14.35  )
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

nvmet_tcp_install_queue() is driven from the ->io_work workqueue
function, but will call flush_workqueue() which might trigger
->release_work() which in itself calls flush_work on ->io_work.

To avoid that check for pending queue in disconnecting status,
and return 'controller busy' when we reached a certain threshold.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/target/tcp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4cc27856aa8f..2be0eb6cdb23 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -24,6 +24,7 @@
 #include "nvmet.h"
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
+#define NVMET_TCP_BACKLOG 128
 
 static int param_store_val(const char *str, int *val, int min, int max)
 {
@@ -2053,7 +2054,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_sock;
 	}
 
-	ret = kernel_listen(port->sock, 128);
+	ret = kernel_listen(port->sock, NVMET_TCP_BACKLOG);
 	if (ret) {
 		pr_err("failed to listen %d on port sock\n", ret);
 		goto err_sock;
@@ -2119,8 +2120,19 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
 
 	if (sq->qid == 0) {
-		/* Let inflight controller teardown complete */
-		flush_workqueue(nvmet_wq);
+		struct nvmet_tcp_queue *q;
+		int pending = 0;
+
+		/* Check for pending controller teardown */
+		mutex_lock(&nvmet_tcp_queue_mutex);
+		list_for_each_entry(q, &nvmet_tcp_queue_list, queue_list) {
+			if (q->nvme_sq.ctrl == sq->ctrl &&
+			    q->state == NVMET_TCP_Q_DISCONNECTING)
+				pending++;
+		}
+		mutex_unlock(&nvmet_tcp_queue_mutex);
+		if (pending > NVMET_TCP_BACKLOG)
+			return NVME_SC_CONNECT_CTRL_BUSY;
 	}
 
 	queue->nr_cmds = sq->size * 2;
-- 
2.35.3


