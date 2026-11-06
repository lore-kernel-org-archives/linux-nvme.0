Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA99D606A32C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k/w2ZjF5;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TOvXcPMZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4fjD1QjXQoURvRCFGFMBDygDUaT3GsURsRxFKbZhGHU=; b=k/w2ZjF5YlOHI5
	gl1bxkCEmFrkJMe5kxREwwwdlbBB26EfypqbQH/bJFUjpcxleLExImxNipaLfLvjuMbRZTzAJdXcT
	wcvYV+5wrKXqIu0q8h2k4hhQjnd4+hVr+aC8PqJerIeYy6cvM49I2v+dmyJ0vFjW9ebPtDXyRikwx
	ArjrNHEjWNA8zc/rSy396xMt4WCiEy/1JIRv30PD11W8xF92VLezz4qHRUHqKWrq/fuDSwBXZ3040
	Nw13wPhICjd/GG8X4gSDnCwtYfr2RVO3n28Fs1gpp+exRUOh8A5GfvDkC2ITMB+AkK2CV4BxTVotb
	GEe/zCVvLRurelZln/FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gF-0000000B3yt-1ERd;
	Fri, 06 Nov 2026 02:27:51 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9gD-0000000B3uS-0EFT
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:27:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793932063; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4fjD1QjXQoURvRCFGFMBDygDUaT3GsURsRxFKbZhGHU=;
	b=TOvXcPMZsLtfqIMi5mumAzG2JsCHaLSXYv8aaXaHTD8sG2Izvt/SBBgSI8/3iX6pAB/RZDls/SLB2Nzw2rwUhah/KjGcUYo6gUIvrFle1iti9/QMYe38kMcUk1VjHNQcsaGoiekUrR3wPE0u4cSlzJrMkNdYTue9uLAAw4zalOU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2NsG_1793932061;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2NsG_1793932061 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 10:27:42 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/9] nvme-pci: remove write-only NVMEQ_DELETE_ERROR flag
Date: Fri,  6 Nov 2026 10:27:28 +0800
Message-ID: <20261106022736.3582824-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106022736.3582824-1-kanie@linux.alibaba.com>
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_182749_240084_3DC9B7B0 
X-CRM114-Status: GOOD (  12.50  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit fa46c6fb5d61b ("nvme/pci: move cqe check after device shutdown")
removed the only reader of the NVMEQ_DELETE_ERROR flag, but left the
flag and its two writes behind. Without a reader the flag carries no
state, and nvme_del_cq_end() degenerates to a plain wrapper around
nvme_del_queue_end(), which the SQ deletion path already uses directly.

Remove the flag, its writes, and the now redundant wrapper.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8a90639789c9..6f6bb9a2486c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -388,7 +388,6 @@ struct nvme_queue {
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
-#define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
@@ -2238,8 +2237,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	int result;
 	u16 vector = 0;
 
-	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
-
 	/*
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
@@ -3101,18 +3098,6 @@ static enum rq_end_io_ret nvme_del_queue_end(struct request *req,
 	return RQ_END_IO_NONE;
 }
 
-static enum rq_end_io_ret nvme_del_cq_end(struct request *req,
-					  blk_status_t error,
-					  const struct io_comp_batch *iob)
-{
-	struct nvme_queue *nvmeq = req->end_io_data;
-
-	if (error)
-		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
-
-	return nvme_del_queue_end(req, error, iob);
-}
-
 static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 {
 	struct request_queue *q = nvmeq->dev->ctrl.admin_q;
@@ -3127,10 +3112,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 		return PTR_ERR(req);
 	nvme_init_request(req, &cmd);
 
-	if (opcode == nvme_admin_delete_cq)
-		req->end_io = nvme_del_cq_end;
-	else
-		req->end_io = nvme_del_queue_end;
+	req->end_io = nvme_del_queue_end;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
-- 
2.43.7


