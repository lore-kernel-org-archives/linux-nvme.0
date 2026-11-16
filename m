Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B59606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c9oRQu3w;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=d8IQ+hiV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=t5D61W8AhPWLgKcfiZxMecGgf9hMX29ytNdixlV4XWk=; b=c9oRQu3w9Evc//0OW8+Ms84+2z
	xhL+aq8GVNJJYwEfZNb0rid8Z9+J2WY0GzuZx5n+tcUh6fX/a4OcVtOFFWSvKUM9IjMQwBU6kaCNx
	jJ38sUCm60fj/nu6rs86H/7jZrlliMw6WO+OpG274OoMkxZzszJv61vT3szNCFvhPEnP7eynqtCwC
	NeXyIrANusHjW52Bjh65Dypi8UkdlKz1gsAWjhXWXBAqTnstyUTu1PqNfiE+wKiWTbTbb0x9Q6/Cp
	jdl+yBqWb3piGu9thvbctzR8SgAa3XfAUGqV3JT8FALAjmgJDQ+sycTXQmzXaQq8p0Z0MmrsJbaEy
	jfr180hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrYN-00000001TZ0-2AnY;
	Mon, 16 Nov 2026 07:55:03 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSrYJ-00000001TU5-0ItF
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:55:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794815692; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=t5D61W8AhPWLgKcfiZxMecGgf9hMX29ytNdixlV4XWk=;
	b=d8IQ+hiVPOy5noEywjOPY2g0Vp6hh+h3X/T9aFguCR5gg8mjhJ7H69QxOelZ7YdE86M+TesJ0AwwuiqNe7IajMcpv9TR4bzX3YxRX+0AboJbDGfFsQFsfBffZWXYFq++wuQ3h2QJR/Dt9RYC2IYbXJOLslgEiaAqc2M4XCBGfxQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEoad4I_1794815691;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEoad4I_1794815691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 15:54:51 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3] nvmet: Synchronize the TLS key debugfs read with admin queue teardown
Date: Mon, 16 Nov 2026 15:54:47 +0800
Message-ID: <20261116075447.1713255-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_235459_744414_EDD25977 
X-CRM114-Status: GOOD (  14.27  )
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

nvmet_ctrl_tls_key_show() dereferences ctrl->sqs[0] and its tls_key
without any synchronization.  The admin queue may not be installed
yet or be destroyed concurrently, and nvmet_sq_put_tls_key() can drop
the key reference while a reader is looking at it, leading to NULL or
use-after-free dereferences.

Take the admin queue's percpu reference for the duration of the read
so the queue cannot be torn down, and use ctrl->lock to serialize with
nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.

Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---

Changes since v2:
- Take the admin queue's percpu reference during the read and use
  ctrl->lock to serialize with nvmet_sq_put_tls_key(), so the queue
  and its key cannot go away mid-read (Christoph Hellwig)
Link: https://lore.kernel.org/all/20261029034306.3626274-1-kanie@linux.alibaba.com/

Changes since v1:
- Simply return 0 when the admin queue is absent in
  nvmet_queue_tls_keyid() instead of dereferencing it, covering the
  not-yet-created and already-destroyed windows (Hannes Reinecke)
Link: https://lore.kernel.org/all/20261028064417.548948-1-kanie@linux.alibaba.com/
 drivers/nvme/target/debugfs.c | 15 +++++++++++++--
 drivers/nvme/target/nvmet.h   |  4 ++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index e85fe1d4c9f8..cc451e25ea1d 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -136,8 +136,19 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
 static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
 {
 	struct nvmet_ctrl *ctrl = m->private;
-	key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
-
+	struct nvmet_sq *sq = ctrl->sqs[0];
+	key_serial_t keyid = 0;
+
+	/*
+	 * Pin the admin queue against teardown, and serialize with
+	 * nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
+	 */
+	if (sq && percpu_ref_tryget_live(&sq->ref)) {
+		mutex_lock(&ctrl->lock);
+		keyid = nvmet_queue_tls_keyid(sq);
+		mutex_unlock(&ctrl->lock);
+		percpu_ref_put(&sq->ref);
+	}
 	seq_printf(m, "%08x\n", keyid);
 	return 0;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e315f1c24e73..24df9e4a1e1c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -957,13 +957,17 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
 {
+	if (!sq)
+		return 0;
 	return sq->tls_key ? key_serial(sq->tls_key) : 0;
 }
 static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
 {
 	if (sq->tls_key) {
+		mutex_lock(&sq->ctrl->lock);
 		key_put(sq->tls_key);
 		sq->tls_key = NULL;
+		mutex_unlock(&sq->ctrl->lock);
 	}
 }
 #else
-- 
2.43.7


