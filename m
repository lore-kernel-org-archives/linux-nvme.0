Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7912606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v376FOva;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uXJFvogX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=F/WfE2jXMlkojBwbA0yKnBZ4DWTZiQqhyC361jSv/6s=; b=v376FOvaTjUlln
	ErRvaBpMVfta1afWjj1WXBd3KaVXrMR1Xx1Att707IxQZ8rhLCMYTq3AQ8nGLAi2Ruu2BYS+JRvcJ
	12ox8HadUQUhiMV1wC6nY/yFf+oa6kNBxojPOJovxVi79wr9LvkvWZOIzmng3+Ym/BEDttrfdX59J
	AaMa1W7P6Ic7fqB9qYK69Uyp458jwY94VeO6caZL+fOZHvDnYUOJeT9tJ/FKQJVEEEEh8CL813w5U
	gvgJUDu2Bl2+/QH3O5Wl+S3CEOZfYvq5wZlsLfzraw1tfTldAlRHE8BURYA5kjJV+K5p4UWpN8T+5
	vTg78OUsy7JLf6i0TaZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EG-0000000B1FV-2S4O;
	Fri, 06 Nov 2026 01:58:56 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9EC-0000000B1CH-3G0F
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 01:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793930330; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F/WfE2jXMlkojBwbA0yKnBZ4DWTZiQqhyC361jSv/6s=;
	b=uXJFvogX2iBmPRuSNX/J4hQUPSyQdO/FWlCuwhi+BQFVwoC+xGwswl6TLY8T5lw/3yM2NWgxVoTprB7IwDz6BhX0iCv8hAWlCSErjh6SRxZVW/lE01NdFeT4zhyvnIcLSVYTVRUS+eDBeg56kOfTkTWZ30tNRg0/I9tH9NRS5i0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEA2CR9_1793930329;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEA2CR9_1793930329 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:58:50 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] nvme-auth: fix data race on ctrl->transaction
Date: Fri,  6 Nov 2026 09:58:39 +0800
Message-ID: <20261106015842.3534898-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106015842.3534898-1-kanie@linux.alibaba.com>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_175852_988376_F8357FB3 
X-CRM114-Status: GOOD (  12.30  )
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

nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
on nvme-auth-wq without waiting for them, so multiple
nvme_queue_auth_work() instances run concurrently and all increment
ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
data race, and the lost updates hand the same transaction id to
concurrent queues.

The controller side only echoes the transaction id within a queue, so
the race has no functional impact today, but the increment is still
unsynchronized and KCSAN reports it. Use an atomic_t.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/auth.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 85f005a5efd0..107355ee9ef1 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -765,7 +765,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		return;
 	}
 
-	chap->transaction = ctrl->transaction++;
+	chap->transaction = (u16)atomic_fetch_inc(&ctrl->transaction);
 
 	/* DH-HMAC-CHAP Step 1: send negotiate */
 	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 92c048002ecd..1fb676dade12 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -446,7 +446,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_queue_context *dhchap_ctxs;
 	struct nvme_dhchap_key *host_key;
 	struct nvme_dhchap_key *ctrl_key;
-	u16 transaction;
+	atomic_t transaction;
 #endif
 	key_serial_t tls_pskid;
 
-- 
2.43.7


