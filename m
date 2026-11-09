Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CA606A336
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TXs/nzmp;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aXGpDm+q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EWlCku388zkiJoDFJOVevRzaIAp+qsNflU0x74TRlZ4=; b=TXs/nzmpdLXX6m
	0Jw3myjoJue9UJRb+j8cZh3P8mC8Bqzc5H3it29izo9BBkgIMM+pnk1It4XGaebXJio50D9zbsRkv
	voVFQOX8qRl2Bcj9Tso37hTXJyLQS6KM237HwoKMhWKKIJxgqvpG9S5zkDpFR/Ef2aSZyTT1PYZKA
	PGLbsWAAiMwcniG7ytGEjX55PBUK2Dz0dIWXOfijfTs15gx+mEeHvHj/O+eck7xQGLWknyl0bMTsd
	tEDw+s2/hRumDFnp0CbJryzCEPzGDcmcinVyNWtFoayft2Zcit2Hpud00RvGQ2nEfFZ5G1r/7Nn3u
	PlQKkC3Enf+PxOce+ynw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF68-0000000H7gM-0pcz;
	Mon, 09 Nov 2026 02:27:04 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQF64-0000000H7d4-2lNz
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 02:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794191215; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EWlCku388zkiJoDFJOVevRzaIAp+qsNflU0x74TRlZ4=;
	b=aXGpDm+qR83m9yg2YEHSs+5ILRGW6INRDG1A94xbamHOze6V85ifhtsl4p/EGl/kQ9zVbg7RqDMG7tHVdBEUmkTBRj6C8Ruh2JmtxHAyU1yjg+YfXsgdqamA002dRsLNOe/WKD3eYNDFO9XS8qg8Jg/Q391AeMuJ83pIMS7LUAQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEI5jph_1794191214;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEI5jph_1794191214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 10:26:54 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 3/5] nvme-auth: fix data race on ctrl->transaction
Date: Mon,  9 Nov 2026 10:26:44 +0800
Message-ID: <20261109022646.290792-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109022646.290792-1-kanie@linux.alibaba.com>
References: <20261109022646.290792-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_182700_855517_261EB034 
X-CRM114-Status: GOOD (  12.90  )
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
unsynchronized and KCSAN reports it. Use atomic_inc_return(); the
first transaction id is now 1 instead of 0, which is immaterial as
the controller only echoes the id within a queue.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/auth.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 85f005a5efd0..c605e8f47e9a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -765,7 +765,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 		return;
 	}
 
-	chap->transaction = ctrl->transaction++;
+	chap->transaction = (u16)atomic_inc_return(&ctrl->transaction);
 
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


