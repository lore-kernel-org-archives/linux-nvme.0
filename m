Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02639C001DF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iGtorTA0kjRNV2Phl2DD03tnYBkdZmLFseL/YSDbmIg=; b=YivGOa5bts93JVByFvav9pIK1/
	JMm0O3xxEMCLrsnQoVHl6csxYJ9cgV5PnpBCtHCmKKFjc90fKxRVymb24LtYelvKCNcH+xP5vNkyd
	h6HKnUmhFFrImrJ8D9IiBbZ0O4FamVntP0nHaNZv4FYELBuNXVeokEgd7mK4qVM66egctewD5pCW8
	7RBLxl3TIZktmIOHJ5rW01Cgb/GLc8ZMXTTv01GDuYZxVUUBHDyYs6GLf2mmb69iWwOHrIkpRsBqq
	mRF1shvE+xDVRc3rP0T0M1vOcBSNXiAgay5QZlANNGjYxY4+JERloWGPsfPezSUdN5/djkk0NNiXa
	0t1A7PmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxm-007XfH-2y;
	Thu, 03 Aug 2023 10:53:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxG-007XDZ-2n
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:53:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 66192219A0;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691059989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGtorTA0kjRNV2Phl2DD03tnYBkdZmLFseL/YSDbmIg=;
	b=plXP7CBW877x4Zt6ImtwAgnktOFKMbaSGmZUjNA9kx6s3r/8cK4Q9ItpGF3z4vgKgEvz40
	qWa/qJR2HO0+OIAtU/mbvkugaOe9hpw8uBER/ZkyzJiFzAxBsdJ9h2lRHTBk5CO4WGPyGu
	W2/Z/KJvM5a5QvinIcs8gx/aKQwkE5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691059989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGtorTA0kjRNV2Phl2DD03tnYBkdZmLFseL/YSDbmIg=;
	b=J5Zx9GvoK7FKpb05Jf4Gna9JPfhuZYUvtYyBLSpUZffQcnQM7aTgD1/o7rnRp1muyj1A+Z
	CmtY8R5pDRlVSwAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 591CB2C14F;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 55C8D51CA7CD; Thu,  3 Aug 2023 12:53:09 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/14] nvme/tcp: allocate socket file
Date: Thu,  3 Aug 2023 12:50:55 +0200
Message-Id: <20230803105102.30949-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230803105102.30949-1-hare@suse.de>
References: <20230803105102.30949-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_035319_081736_736A627B 
X-CRM114-Status: GOOD (  13.73  )
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

When using the TLS upcall we need to allocate a socket file such
that the userspace daemon is able to use the socket.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9ce417cd32a7..c3b3b938c0f9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1338,7 +1338,9 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	}
 
 	noreclaim_flag = memalloc_noreclaim_save();
-	sock_release(queue->sock);
+	/* ->sock will be released by fput() */
+	fput(queue->sock->file);
+	queue->sock = NULL;
 	memalloc_noreclaim_restore(noreclaim_flag);
 
 	kfree(queue->pdu);
@@ -1512,6 +1514,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret, rcv_pdu_size;
+	struct file *sock_file;
 
 	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
@@ -1534,6 +1537,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_destroy_mutex;
 	}
 
+	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
+	if (IS_ERR(sock_file)) {
+		sock_release(queue->sock);
+		ret = PTR_ERR(sock_file);
+		goto err_sock;
+	}
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
@@ -1640,7 +1649,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 err_sock:
-	sock_release(queue->sock);
+	/* ->sock will be released by fput() */
+	fput(queue->sock->file);
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-- 
2.35.3


