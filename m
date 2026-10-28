Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D642606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MfuXJ8VV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fkyKxepH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cMHMerKcPZRARUSKynguHBDpnKNX+DmYSxphWjqk6bI=; b=MfuXJ8VVnriK0kHg6AB+mVDold
	wAkltQrawiKQrxNXA/f3cTAN8OzWll5Q+muqsCcD3tsaBwSM8XZBDUMZ0oZXe9omk1EXw7+gxxe34
	aSPMEleYoJfh8xvW+4Y1n9fSidbqYhjwPecdPDw4Q+GX/QbkAvbO44eYoe3ON5chQ1TlbYVf+hcWx
	xQV0GBz/7l5AGmkLblN23SIZBZHAeXDWYP3RXGsImWAK4EiD4N1lWh8f2UuAEW8OQzF4DLWYdEOBD
	PN0RPRUMhGmdJ1/zyaviDmgYDtfz6mksAlZH5T/Px68TlwFEsMyRb/GhO/iwFnEHMUlW4xyqfgYe7
	dOGlcupA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLtdS-000000066oc-3pj3;
	Wed, 28 Oct 2026 02:43:30 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLtdQ-000000066o1-1ZDP
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 02:43:29 +0000
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-78fb1fb9508so1232019137.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 19:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793155407; x=1793760207; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cMHMerKcPZRARUSKynguHBDpnKNX+DmYSxphWjqk6bI=;
        b=fkyKxepHtlOc3Gv/0y0KtT+n9V6Nyrj8MPwp/WD2WkqQZ587LvzJ4pRI+GBxuI+CDk
         uZUPZBYBNzGHIJX5MY+GIv9OicRNPfOLbQ5kN9iZ/3i6jH52CYS/gFyK6txNp5Jc+K4C
         bsXfldLDSdXbmtvRvgJgfLfm7aEilaXYixAfXEFHE1tcIVP+GaxURsJFaLvlF6riizkh
         PwYzu7l+5BrfPCBcxJsvt3tCwY00IiUYmqIWZdgVXzkZPPPSd/mk9f80XIU/ISyYEqVq
         XhJdwuG5mvTqoa5zGn4xxlWHFth/AkQRuYooIAIgv4AizI+VL+6QYMwFiVy27aD5/qPY
         xHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793155407; x=1793760207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMHMerKcPZRARUSKynguHBDpnKNX+DmYSxphWjqk6bI=;
        b=tCFV5olslhBosI1dggkp0J9y6ceEcffMRolED/xtbn0zdc91VHO7VJvgK3oOIyTmJY
         s89dcVsN6T0taMbLvqA96w2UJ4El3uP9cMvsy7RdxaDp9d+8f1Ct++U+M5ZhMhiyc9bD
         Lyz9VJ531YHOFI+Rt6LePtnLq9h7MnISW1QUNYam939adfUVgHX/1kFiAynA5iMft6WW
         az0ICuaDi4tTXzg6q0APluuRpuVS7yoj0dMl5W4GNTV2SFxefe1JdDiW6XJshl0ljA1o
         D94twvRoUnb0QlayibjigQh7suz/RAW1dFZE+IQLH0GK8ST9ybdY97hiUrE8wu/2ijyk
         SxkA==
X-Gm-Message-State: AFq9FYKAYl47Ekuk6DVQ4lxPmCOALk1WmQZXc2CuJr5UeQr1vrKphy58
	nmDlsAVf8d58Ve13av4ywxmDSi4xiX6qHTDMW1GMpf5bMt1tSC29PP55A1IpfwnKQ70=
X-Gm-Gg: AYBFou2OXJm7vGUmq2pYd1J1ZzvU8xG3VyTuUkG3TOhBNAsDrJhthJjav44pNYwBFSU
	6ZxH2Cacu+jzFCGo82N0y3e2o2bxObLw7yBIapfTqoe344f1pF6P3COwk+zX0SW5xAjPW8huq7j
	yahyznBEMCajs0bCRCOavNFedc1NKA8+6EehFf+eoqMaLOMNhWUa6O2nCMI2Yc3dIDEtP+UVnCR
	EqangdNBviSn2G4ceNJWFAhHh5DbHdBTjQqmsSZbqE1Skv0mhhpck+0xjevDeZGwhwuBlAZDvzX
	UVH4ByMj9Okc0/PRHLuL9UbdazXVeUNFKYB1rrUM+UAKByPYZzZGteFzRLwQj8mlUTGtYm4y19L
	FkWOkG5AVp9ym5hnzQ7LECPIIo6v+Xl+NZ8RNAqnqec3mifMIcTfmU+rU0ZxASZjlelksIOmIXN
	LSCVXO8c6K1X7eC8PsILyZCGy6BnYaqGBPIU6LQQNJIhGVCwW+A/YcTPh6u2Z/sfx1pYkH7OGv0
	qQ2dWoo3gRWFOvSXAeweO8/sKLIOFyhZ5nhHctiQ6wjX7DgFtMxwh3ZG/wDjIoq0tE+KHdm+DX5
	lnm2qfNINpTB/7bQO6BI8pFLYOTIR9lpgLSR53w=
X-Received: by 2002:a05:6102:6e8a:b0:7cb:cfcf:3d01 with SMTP id ada2fe7eead31-7cea15c6056mr1537851137.33.1793155406886;
        Tue, 27 Oct 2026 19:43:26 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:260a:a9d6:ce02:aaa8])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9912589778fsm4765241241.0.2026.10.27.19.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 19:43:25 -0700 (PDT)
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
Subject: [PATCH v2] nvme-tcp: fix NULL queue->ctrl dereference on reconnect
Date: Tue, 27 Oct 2026 23:43:09 -0300
Message-ID: <20261028024309.1398623-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_194328_435650_77E67587 
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
that is not live. send_mutex and io_work move there as well, and the
helper's mutexes are all destroyed when the controller is freed, like
queue_lock already is.

Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
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
attr_qid_max to 4. Before the patch the host oopsed as above within two
tries in each of three boots; with v2, 8 of 8 tries went live, with and
without lockdep. 30 resets under digest I/O, with a reader looping on
the address attribute, also pass and are clean with lockdep.

 drivers/nvme/host/tcp.c | 58 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ada1ff120e2..77bc530ae0a6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1559,7 +1559,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	memalloc_noio_restore(noio_flag);
 
 	kfree(queue->pdu);
-	mutex_destroy(&queue->send_mutex);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1987,6 +1986,26 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1995,11 +2014,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
-	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
-	mutex_init(&queue->send_mutex);
-	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -2013,14 +2029,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
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
 
@@ -2088,8 +2102,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		}
 	}
 
-	queue->data_digest = nctrl->opts->data_digest;
-
 	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
 			nvme_tcp_hdgst_len(queue);
 	queue->pdu = kmalloc(rcv_pdu_size, GFP_KERNEL);
@@ -2136,8 +2148,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
 	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
 #endif
-err_destroy_mutex:
-	mutex_destroy(&queue->send_mutex);
 	return ret;
 }
 
@@ -2838,8 +2848,11 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
 	put_net(ctrl->net);
-	for (i = 0; i < nr_queues; i++)
+	for (i = 0; i < nr_queues; i++) {
 		mutex_destroy(&ctrl->queues[i].queue_lock);
+		mutex_destroy(&ctrl->queues[i].send_mutex);
+		mutex_destroy(&ctrl->queues[i].pf_cache_lock);
+	}
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -3238,21 +3251,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
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


