Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD70606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EB5bFMfi;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=M0lSZGKH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ji1QhwR8iZK1OZuFfDLxUOs67xjpwLTd5TjqlEl0nQ4=; b=EB5bFMfiuk8x1lAiJW8/vFokfx
	1KbvUFz3x/0uKO+NWpIkL9JhaL3SHLGXDvsMLOmOczvhc0jr1JlWYpB7WGOuhjgFkUoa9SUPTdtaq
	jGnGkfQJRryuzVc1wFh6O3BbTt0QX+Q0rS5/w19seaStaf+O1aj4ygJo2Bc0EkURLKpfZywHzGBnl
	qgyfUtupQQBI6kbO9aCX5AByiI1XOsYTSgqAC/g5n4uFGLdU+y7Hqzhdk4KUMVq8yWvX/o/OP+5W7
	PArRo0Eif/0ea9LAafNo3l/xXyJcgaJ/nU8TRukaTCwh95niQ21A9NU4DaZGVpwvhHkomsfKsJdsR
	WhXcMR/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMH2r-00000008G77-3hcU;
	Thu, 29 Oct 2026 03:43:17 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMH2o-00000008G5q-1Cuh
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 03:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793245391; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ji1QhwR8iZK1OZuFfDLxUOs67xjpwLTd5TjqlEl0nQ4=;
	b=M0lSZGKHkPE4gG3rSYPawuegYiuXxs9I+MZo/rZb7+U6WU0SLHbZRgncFwdXcahe7X6qN5M3zSqvAwZjWOVQvS+b0NN20H6AbUUaVL90XTYvKhvjZx3zqjinEvZzpKxmVzK3fRis+b92Ei7KESsvSAVGxhQocUzHf8MU1Ee4HDE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDiCixf_1793245390;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDiCixf_1793245390 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 11:43:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: Handle a NULL admin queue in nvmet_queue_tls_keyid()
Date: Thu, 29 Oct 2026 11:43:06 +0800
Message-ID: <20261029034306.3626274-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_204314_506165_B2B97E58 
X-CRM114-Status: GOOD (  10.75  )
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

The admin queue is not necessarily installed when the tls_key debugfs
entry is read: it may not have been created yet, or it may have been
destroyed already.  nvmet_queue_tls_keyid() then dereferences a NULL
sq.

Guard the helper and return 0 instead, which also covers the read
racing with admin queue teardown.

Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Changes since v1:
- Simply return 0 when the admin queue is absent in
  nvmet_queue_tls_keyid() instead of dereferencing it, covering the
  not-yet-created and already-destroyed windows (Hannes Reinecke)
 drivers/nvme/target/nvmet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e315f1c24e73..4e988488497b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -957,6 +957,8 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
 {
+	if (!sq)
+		return 0;
 	return sq->tls_key ? key_serial(sq->tls_key) : 0;
 }
 static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
-- 
2.43.7


