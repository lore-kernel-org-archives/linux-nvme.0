Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751A606AD9C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wZPvZJVe;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e4vJb+AX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=zT69dOKI+tL8sMiSURAMyeJawlF+atv7ZSY3yp65Kgo=; b=wZPvZJVeNoO89diYpV+otxm7yk
	NlQQaUWpWnyneXvfhJKtJWBEcu0hj8VuWpp/4WwlB78K4W05L2G9YEpWs8KvujSdONBRN0nUiLEsj
	XV/mbKnuobkHIBcW/Fu9UuApthLe3TL1RwlLUPvtYYiH1ic6bSFh5cwJ9ixheyELyXsmD+LQVaEaQ
	td4sK/FZDWNJvBKktf5AhMt54Z39a6uCalzYMgNYGdoTOMVdu3XhOHuYzDxq+tdbAcAFS7FYj3xU5
	vnGkJBlw3cfUI4ZRTQ/Jbhc8FhkmWKvqLDWxrAfrUu22AKO1n1zJzBxYg+YrjDJPtpSc+0D2imR9V
	K1qmGGSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbkY-00000003uYH-1IY1;
	Tue, 27 Oct 2026 07:37:38 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbkU-00000003uWy-1phg
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 07:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793086651; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zT69dOKI+tL8sMiSURAMyeJawlF+atv7ZSY3yp65Kgo=;
	b=e4vJb+AXU4NLhKmx5sGE79TUxNsBjuMVhtPqBd4ZvlK6mKVDwAZQJfPIHLesPYMz9Aj3jlq2+9ZGwh29CTF9dzr5eP3zRDPKoXauGrRzMfVhTFDjGoykB9EPbcDBxFfgZj2CIF94DTCRnLpqSPniOIAaDU4cto1tMmggfsj/MYo=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDd1wbw_1793086650;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDd1wbw_1793086650 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 15:37:30 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-tcp: Validate the queue state under the queue lock in the address attribute
Date: Tue, 27 Oct 2026 15:37:25 +0800
Message-ID: <20261027073725.2292265-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_003734_988496_62F1ECD0 
X-CRM114-Status: GOOD (  20.74  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reading the "address" sysfs attribute calls kernel_getsockname() on the
admin queue socket, which can race with the queue teardown during
connection error recovery: a reader can observe NVME_TCP_Q_LIVE set,
then block on the queue lock while nvme_tcp_free_queue() releases the
socket and clears queue->sock without holding the lock.  Once the
reader acquires the lock it dereferences the NULL socket pointer.

Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
error recovery") had the queue liveness check inside the lock.
Commit 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock
and destroy") moved it back out because the lock itself is destroyed
in nvme_tcp_free_queue(), so a reader arriving late trips
mutex_destroy().

Check the queue liveness inside the queue lock, and clear queue->sock
under the same lock.  The teardown clears NVME_TCP_Q_LIVE under the
lock well before the socket is released, so a reader either sees the
bit cleared or a socket that cannot be released while it holds the
lock.  To also close the lock lifetime race, the queue locks are now
owned by the controller: they are initialized with the queue array and
only destroyed when the controller is freed, which cannot happen while
a sysfs attribute read is still in progress.  The opts-derived queue
count is used for both initialization and destruction, as reconnects
may shrink ctrl->queue_count.

Fixes: 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/tcp.c | 46 +++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a15ed49871ea..6c8a569d5c48 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1514,14 +1514,21 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	 * nvme_reset_ctrl_work(), queue teardown is immediately followed by
 	 * re-allocation. fput() defers socket cleanup to delayed_fput_work
 	 * in workqueue context, which can race with new queue setup.
+	 *
+	 * Clear queue->sock under the queue lock so that a sysfs reader in
+	 * nvme_tcp_get_address() either observes the NVME_TCP_Q_LIVE bit
+	 * cleared or a still valid socket.  The queue lock itself is owned
+	 * by the controller and only destroyed when the controller is
+	 * freed, so readers blocked on it cannot race its teardown.
 	 */
+	mutex_lock(&queue->queue_lock);
 	__fput_sync(queue->sock->file);
 	queue->sock = NULL;
+	mutex_unlock(&queue->queue_lock);
 	memalloc_noio_restore(noio_flag);
 
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
 }
 
@@ -1839,7 +1846,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
-	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
@@ -1977,7 +1983,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
@@ -2627,6 +2632,10 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	/* the same count used to size and initialize the queue array */
+	unsigned int nr_queues = nctrl->opts->nr_io_queues +
+		nctrl->opts->nr_write_queues + nctrl->opts->nr_poll_queues + 1;
+	unsigned int i;
 
 	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
@@ -2637,6 +2646,8 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	for (i = 0; i < nr_queues; i++)
+		mutex_destroy(&ctrl->queues[i].queue_lock);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2889,17 +2900,18 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return len;
-
 	mutex_lock(&queue->queue_lock);
 
-	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
-	if (ret > 0) {
-		if (len > 0)
-			len--; /* strip trailing newline */
-		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
-				(len) ? "," : "", &src_addr);
+	if (test_bit(NVME_TCP_Q_LIVE, &queue->flags)) {
+		ret = kernel_getsockname(queue->sock,
+				(struct sockaddr *)&src_addr);
+		if (ret > 0) {
+			if (len > 0)
+				len--; /* strip trailing newline */
+			len += scnprintf(buf + len, size - len,
+					"%ssrc_addr=%pISc\n",
+					(len) ? "," : "", &src_addr);
+		}
 	}
 
 	mutex_unlock(&queue->queue_lock);
@@ -2965,7 +2977,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -3035,6 +3047,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	/*
+	 * The queue locks are owned by the controller, not the queues:
+	 * they outlive the per-queue connect/disconnect cycles so that
+	 * sysfs readers can never race their destruction.
+	 */
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		mutex_init(&ctrl->queues[i].queue_lock);
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
 		goto out_kfree_queues;
-- 
2.43.7


