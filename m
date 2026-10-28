Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B01606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=srENcgPn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QURGiofn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Lnsy46Tk/2qSP0NGVnsKAYQcdnXJRqGYK3UfpyjKzYo=; b=srENcgPnZJxt8R/5yltsBdvxcf
	KDoEae+Y3+XOxPNSVpYbeoEgyOUkjDLCynvvuYyNTJsfFU/pnJSD4D9Ly6dfFTwQVgZloMOX5e06i
	ZTPUxzXndw3figQQf3eRa5Ux+WlI4xDpZskYzBraC6F8p7O38jwBg/v7rv/qmBNK0jGvQekDg97o4
	AlI99ewyxCD5Z0aqPRV2swNsUPIRAOwSf8THIx108cY6IA1DrdbfUmao1ETO3OqrA2W4r4m3eJRS5
	EUzLPamKEvxmK3x7isHYoMYpI8DDtf+JupB4E+SmiTwJbGVShnCFN8V6y8/c25A3PwHMH1RpC0hBk
	qf3At6TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4jE-00000007D8w-1E7C;
	Wed, 28 Oct 2026 14:34:12 +0000
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4jB-00000007D8J-01FX
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:34:11 +0000
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-7c33cc572e6so887128137.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198047; x=1793802847; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lnsy46Tk/2qSP0NGVnsKAYQcdnXJRqGYK3UfpyjKzYo=;
        b=QURGiofnA0cArwlvQb6TD+W+JOWzcr31hwp/BLSu+9i+2mO0VGhm20E0K1Y+7PkfWC
         KhU/JXgEdxyY07WgITW7kCuMMzCj7mkjRR2J9h9itTjj+33OZ7RKu8FhXmHt6NhCKGW/
         UA3lHLDNj8yVuSDSsy5YnznIg4R38blZsIbm9bjSXH+V9QLSgQVnVStzz/ValIgYyU9f
         kKSUak6jPHrgrzYrosCI1gLyUC2B6KTBxDrBRAOtzDYBFpSpNN+T8mYuZoIkcao4CKfq
         VgmMvhzKvxpSkskPI6Beoa9Be/1GgMwsLUlKhiyiZkUWoC0+GwmL72DNC/+nNYKBg2QN
         XbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198047; x=1793802847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lnsy46Tk/2qSP0NGVnsKAYQcdnXJRqGYK3UfpyjKzYo=;
        b=fOInpoeNiAA0IIjndfgu8kve2VIyTUCq6/peCV4Bq5bjwQpcHhrhQ2h2dmOjPH3JAu
         VMwpStc4sip/n5e4e9KTmLqEO189VagS4bEPxSfMoiSgPqlJwx4sxw3lhRvwKiQ65ALn
         DSl6i9FAhNEPnLvMoekJtgu22VTgJlreXXgJj4WcCPs57df1pgX5a+nXGb3UJEvH9gbP
         1QwBx8rB3TmmBjBzNcPP1fwFpvreiG8mbjiIjbjQDNJbYoswQiID6WxPqDjLAtOffXGp
         PSCvjoT8hHysnSpyCV+I2thJMi0Aadccy1VW2MeomUFxKdgT1C6pwLOQ8PiPMAfAnpnJ
         myPA==
X-Gm-Message-State: AFq9FYKm020rtlvvJrxClbMgAutIHWf4xmdsaXBYB9SRRrXXR78SE+I7
	iO3dZon8Z5I8CscLXKUaXnABq/NV5xt2LpH6L5eISn+WzrUonNhKTV4WXsHf4q1IdE4=
X-Gm-Gg: AYBFou2S+fLyzOMfZX3jV9SnUQ08B/WU8vYEjEyLOj7HGDAfiBz2QZ3EX9Ko+DdBqw7
	YvqNAAI3FakrqqA8VL9j0Aq357L6ze4z6dG0EstV6BL/jKpphGv3ugfnbregv6iJQL4qp3LpvCk
	qOp+i0DHBpuMRKGxvbMXWD5drVt0pdCq16eeKdbZ2LMZWbF6RpuNmYDfOgIKJeaRxyXyA4SvuRL
	LUxxdn54hUS7yfm0YNYAg4meEWcxketj/bKYn1PPA6JG4KJgogpXz3xchv7gNDcW7oU4QnoGbCn
	DOVzTS7kKSJtVu5vbv+xpt8fWXUQ3Ev4fOGW8Uww+W7uOy6GYPmB1qj4ePO5rVVpXtcWU5PRCaH
	0HdtP7/y6po4suEfnMAHbhahFSLteHFTR8UxUJaJoNDOLiO6dNt6OwwB1iRj6Y+EOi8noIzeTwC
	XQzPXmqfwY2z1G7vTGT39dDdkoQzhEOu+cVzBA2wVnEYfrItwl/PhVOZxSyfkZ+sEs1w/4cVYom
	cmlN2lMT9uyo4RKLF37ODsU+M5tiQHeAGvU1se4JBreeOSsNBICPoTNv8exXwlVcqlOmwAYGGJu
	WjfH7KE9cgHdsT4aClZ/yW24XHIFjXcU0YvoSjX+jrxZu9CL9uPpg36CwWdJ
X-Received: by 2002:a05:6102:3ec5:b0:7c0:115c:14ca with SMTP id ada2fe7eead31-7cea124bff8mr2043811137.5.1793198046891;
        Wed, 28 Oct 2026 07:34:06 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:8b5e:397a:cdcb:e1d9])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3caf553sm5653640137.7.2026.10.28.07.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:34:06 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@kernel.org,
	sgogte@purestorage.com,
	wagi@kernel.org,
	kanie@linux.alibaba.com,
	nilay@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Subject: [PATCH v3] nvme-tcp: fix NULL queue->ctrl dereference on reconnect
Date: Wed, 28 Oct 2026 11:33:43 -0300
Message-ID: <20261028143343.221936-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_073409_062788_F6803DAA 
X-CRM114-Status: GOOD (  24.50  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
and startup"), a reconnect that gets more I/O queues than before grows
the tag set before the new queues are allocated. queue->ctrl is only
set by nvme_tcp_alloc_queue(), so I/O submitted in between reaches
nvme_tcp_queue_rq() on a queue that was never allocated and
dereferences a NULL queue->ctrl:

  BUG: kernel NULL pointer dereference, address: 00000000000002ac
  RIP: 0010:nvme_tcp_queue_rq+0x33/0x3b0

Add nvme_tcp_init_queue() for the queue fields that do not depend on
the connection and call it for every queue when allocating the
controller. Such requests are then requeued like on any other queue
that is not live. send_mutex and io_work move there as well, and
nvme_tcp_exit_queue() destroys the helper's mutexes when the controller
is freed.

Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
Suggested-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
v3:
- Add nvme_tcp_exit_queue() for the mutex_destroy() calls in
  nvme_tcp_free_ctrl() (Hannes)
- Keep Nilay's Reviewed-by, as the change is mechanical

v2:
- Rebase on Guixin's v4 "nvme-tcp: Validate the queue state under the
  queue lock in the address attribute" and move its queue_lock init
  into the helper
- Also move send_mutex and io_work into the helper, and destroy
  send_mutex and pf_cache_lock next to queue_lock in
  nvme_tcp_free_ctrl() (Keith)
- Left in nvme_tcp_alloc_queue(): req_list and send_list, as resetting
  them drops entries left over from the previous connection, and the
  lockdep keys, which are per socket instance since commit 19bdb70c77d3
  ("nvme-tcp: lockdep: use dynamic lockdep keys per socket instance")

Based on nvme-7.4 (9afc1b71d963) with "nvme-tcp: fix request PDU size
when header digest is enabled" and Guixin's v4 on top. The last hunk
assumes the conflict between those two in nvme_tcp_alloc_ctrl() is
resolved by keeping both loop bodies and both comments. I can resend on
top of nvme-7.4 once both are there.

Reproduced in QEMU with nvmet-tcp over loopback and
CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
running on the CPUs that map to the new hw queues, then raise
attr_qid_max to 4. Without the patch the host oopses as above by the
second try; with v3, 8 of 8 tries go live, with and without lockdep.
30 resets under digest I/O, with a reader looping on the address
attribute, also pass and are clean with lockdep.

 drivers/nvme/host/tcp.c | 64 ++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ada1ff120e2..85f93b0238ce 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1559,7 +1559,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	memalloc_noio_restore(noio_flag);
 
 	kfree(queue->pdu);
-	mutex_destroy(&queue->send_mutex);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1987,6 +1986,35 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+/*
+ * The I/O tag set is allocated, and grown on reconnect, before the queues are
+ * connected, so blk-mq can initialize requests on a queue, and dispatch to it,
+ * before nvme_tcp_alloc_queue() has run for it. Set up the fields that do not
+ * depend on the connection once, when allocating the controller, and keep them
+ * until the controller is freed.
+ */
+static void nvme_tcp_init_queue(struct nvme_tcp_ctrl *ctrl, int qid)
+{
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+
+	queue->ctrl = ctrl;
+	mutex_init(&queue->queue_lock);
+	mutex_init(&queue->send_mutex);
+	mutex_init(&queue->pf_cache_lock);
+	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	queue->hdr_digest = ctrl->ctrl.opts->hdr_digest;
+	queue->data_digest = ctrl->ctrl.opts->data_digest;
+}
+
+static void nvme_tcp_exit_queue(struct nvme_tcp_ctrl *ctrl, int qid)
+{
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+
+	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->send_mutex);
+	mutex_destroy(&queue->pf_cache_lock);
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1995,11 +2023,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
-	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
-	mutex_init(&queue->send_mutex);
-	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -2013,14 +2038,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
-		goto err_destroy_mutex;
+		return ret;
 	}
 
 	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
-	if (IS_ERR(sock_file)) {
-		ret = PTR_ERR(sock_file);
-		goto err_destroy_mutex;
-	}
+	if (IS_ERR(sock_file))
+		return PTR_ERR(sock_file);
 
 	sk_net_refcnt_upgrade(queue->sock->sk);
 
@@ -2088,8 +2111,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		}
 	}
 
-	queue->data_digest = nctrl->opts->data_digest;
-
 	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
 			nvme_tcp_hdgst_len(queue);
 	queue->pdu = kmalloc(rcv_pdu_size, GFP_KERNEL);
@@ -2136,8 +2157,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
 	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
 #endif
-err_destroy_mutex:
-	mutex_destroy(&queue->send_mutex);
 	return ret;
 }
 
@@ -2839,7 +2858,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 free_ctrl:
 	put_net(ctrl->net);
 	for (i = 0; i < nr_queues; i++)
-		mutex_destroy(&ctrl->queues[i].queue_lock);
+		nvme_tcp_exit_queue(ctrl, i);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -3238,21 +3257,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	/*
-	 * The I/O tag set is allocated before the I/O queues, and initializing
-	 * its requests already allocates the PDUs from the page frag caches of
-	 * the queues, sized by their header digest setting, so set up the
-	 * locks and hdr_digest here.
-	 *
-	 * The queue locks are owned by the controller, not the queues:
-	 * they outlive the per-queue connect/disconnect cycles so that
-	 * sysfs readers can never race their destruction.
-	 */
-	for (i = 0; i < ctrl->ctrl.queue_count; i++) {
-		mutex_init(&ctrl->queues[i].pf_cache_lock);
-		ctrl->queues[i].hdr_digest = opts->hdr_digest;
-		mutex_init(&ctrl->queues[i].queue_lock);
-	}
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		nvme_tcp_init_queue(ctrl, i);
 
 	ctrl->net = get_net(current->nsproxy->net_ns);
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
-- 
2.43.0


