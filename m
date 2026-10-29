Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0823606A31F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3dTrFgjP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cyj7xo3V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Ve4P/af0YMON2eW8s3CRyy2aQgdBXU6q9ZyvIcIdYyI=; b=3dTrFgjPWi7LGPntoNMZhWVz0I
	1HATHw+6YW/NHW7e80Z5H8NhtpM6EmzFIGj8G01ZVqRb/efpCbTae70MHG1gjjc+vFSCDZRKkCFCz
	Wp0aCIeX6XfyhTsE6aePbe4OLq4widNhLd+VmGnO3RJk+gw0OJa//UA/rcBwtSe+MFxkxyrluKrjp
	WpKcxs8URKmUlpbiHZeW3Of+0loJLW8KS6mU2pzBhn/qnUWzUWLHd/xSLbm4S39LWLXIaVItzaIgC
	f3WdgplpGACe+zBgHCeWFjHJThXlm+5Eppxx8CWNUBZStS0twH+nWYLsbPndbJtK2V8v1E6AdmWMU
	XBBf0vgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMJGv-00000008Qqq-2wFb;
	Thu, 29 Oct 2026 06:05:57 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMJGs-00000008QqV-36zl
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 06:05:56 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5ec3561ad39so627450e0c.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 23:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793253952; x=1793858752; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ve4P/af0YMON2eW8s3CRyy2aQgdBXU6q9ZyvIcIdYyI=;
        b=cyj7xo3VRvlcwvGgneeTqs07U0wvER8Y8EZHj/FsISLiXNyCS8fC8vv+iII9Noj46/
         3UIf7jQQ3FTHPhIxGKWKr+7K1/LeTmbp+fQ0yBfwNUlb7Olo7VjH78/v1laa4ybU92OH
         woh8PpoS8Oy2dfwftprfA9JQcY23PYBwamYzlU5FbIdIQwAkhaZL3bJgOEwWNRiq7RPK
         YW9Kdrn27ahf35U4IhflBBiaVeAkVxRJ1dUFgwrNkxptSSiQMNthuA9B+4Ldymz/3FeD
         /sYF06Own0yfgiwXinK6J7I8LQbK0v01k+Wn96t4zkFL13LRVXYilXipBzaADaGaRuw2
         2/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253952; x=1793858752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ve4P/af0YMON2eW8s3CRyy2aQgdBXU6q9ZyvIcIdYyI=;
        b=NpDd/cP5Qka2IFtKTqYcgflZYDpRT5VZqgQyoc7lz/UXFwfcziRwGdQARUpr0cAWil
         WaQDxZt51pUtog7BX5ofY9NeXTCJnFj8C1FsF+BIBAU9ZJu57o9cc9jkyhFHivvr+nAa
         Cgb3f1kbbuqYaT+JLrHtF6wBGdJOqk3DYbDLRa5h3vT43Mh8c+vbQIHkDLOACD/Gva0+
         h3Jzt2ydAtpLLul3zhODKxvYGz9p2xk7Dl1OYAJpFP7UAyfwkautigHdwCgl5WjQBNpR
         Qp7tmnr2+B3/lcBD/U6h1fldrOk4eXpZgmTxiPTKHcz4k8xkAVx65DyyX6gPqc+s9/oe
         1BnQ==
X-Gm-Message-State: AFq9FYKP/Mc1f8+6dVfhKURPNV/LPw+KxWvQ9KUi/clqMeRag0edoJra
	i9Ni61ZdFwayk0eXxN1faJRJtKD8MMFOTNPEtV2pIIBdx80R/WIq4BZNbnSlCv95kEc=
X-Gm-Gg: AYBFou1ae8Er7uaU2zZ5pBGKkgasEXwF04bNjJAxYt9MQWevlJ90Y7RYcDgDyXXnkcE
	G0JDDuZqu9VHf6WHOrPoNBopfBeKQkBF0EzpgG2tJ1XAQIClTY5UlBNS2Dkb6zgw02xH7n5LFhJ
	Jpr9X7g21RZ6C3AH+E/8UNt9w1aT1fycxGxxTw8dK94eQSWM4nNyzso6IAo8F5dtpXzpb57IUpf
	GHTV+SesWYFyzF6Ed3K4fSN9/O8ogj90ietNowpAYY2jDW0tLQTiWybegtSd78ACWKhAh54JrYz
	+tzkS85RssUpuKAGOQRaqGVOzt+zf4/F3rez+HFZlV9DC+BcernB+67ZLLKfY9QsjLf1lTaZNdp
	NJivQ6TnTF/ZWiy3bN6F6eflzdxngB3dLku2rd/TV/wyKlMUwRUaLNS9gwu7UMwYfwJarkToxtA
	NOZJR3Eq3ubzMHjkPTZSUpi+DAnuwltg0xXlD9Kqb+R8kVg/jZkNJokd493ZyNu30XySXsY3aGW
	qAp/342oDlaWvnHzzPbhmoOZCW3tXIhCiWTnYejYYJDPlE/mYZ4YvnZ3mi0iaUhTcXut2T5tbAb
	wwca9Qy3AS4YvSEmbhjoCi7t8YGWVTuj3TKXp4o=
X-Received: by 2002:a05:6122:4286:b0:5e9:6d96:aa38 with SMTP id 71dfb90a1353d-5ec4cbfd1c0mr2200118e0c.9.1793253952022;
        Wed, 28 Oct 2026 23:05:52 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:8b5e:397a:cdcb:e1d9])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec57d219f0sm2276999e0c.4.2026.10.28.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:05:50 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	sgogte@purestorage.com,
	hare@kernel.org,
	nilay@linux.ibm.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: fix NULL queue->ctrl dereference on reconnect
Date: Thu, 29 Oct 2026 03:05:21 -0300
Message-ID: <20261029060521.1690223-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_230554_806868_E128CDDC 
X-CRM114-Status: GOOD (  20.30  )
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

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup"), a reconnect that gets more I/O queues than before grows
the tag set before the new queues are set up. queue->ctrl is only set
by nvme_rdma_setup_io_queues(), so I/O submitted in between reaches
nvme_rdma_queue_rq() on a queue that was never allocated and
dereferences a NULL queue->ctrl:

  BUG: kernel NULL pointer dereference, address: 000000000000034c
  RIP: 0010:nvme_rdma_queue_rq+0x52/0xb90

Add nvme_rdma_init_queue() for the queue fields that do not depend on
the connection and call it for every queue when allocating the
controller. Such requests are then requeued like on any other queue
that is not live. queue_lock moves there as well, and
nvme_rdma_exit_queue() destroys it when the controller is freed.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4 (89480d137bf0), also applies to mainline and v7.3.
Same approach as "nvme-tcp: fix NULL queue->ctrl dereference on
reconnect" in nvme-7.4.

pi_support, cmnd_capsule_len, queue_size and cm_done are still set on
each connect, as they depend on the RDMA device or on the connect.

Reproduced in QEMU with nvmet-rdma over rxe and
CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
running on the CPUs that map to the new hw queues, then raise
attr_qid_max to 4. The window is short, so the readers run at
SCHED_FIFO with nvme-wq pinned to their CPUs. Without the patch the
host oopses within two tries in all six boots. With it, 64 of 64 tries
go live and 30 resets under I/O pass, with and without lockdep.

 drivers/nvme/host/rdma.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 07216890f75c..79ef8927d3f0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -90,6 +90,9 @@ enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_TR_READY		= 2,
 };
 
+#define NVME_RDMA_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
+	(opts)->nr_write_queues + (opts)->nr_poll_queues + 1)
+
 struct nvme_rdma_queue {
 	struct nvme_rdma_qe	*rsp_ring;
 	int			queue_size;
@@ -576,6 +579,19 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
+static void nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+{
+	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
+
+	queue->ctrl = ctrl;
+	mutex_init(&queue->queue_lock);
+}
+
+static void nvme_rdma_exit_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+{
+	mutex_destroy(&ctrl->queues[idx].queue_lock);
+}
+
 static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
@@ -583,7 +599,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	mutex_init(&queue->queue_lock);
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
 	else
@@ -600,8 +615,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 	if (IS_ERR(queue->cm_id)) {
 		dev_info(ctrl->ctrl.device,
 			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
-		ret = PTR_ERR(queue->cm_id);
-		goto out_destroy_mutex;
+		return PTR_ERR(queue->cm_id);
 	}
 
 	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR)
@@ -631,8 +645,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 out_destroy_cm_id:
 	rdma_destroy_id(queue->cm_id);
 	nvme_rdma_destroy_queue_ib(queue);
-out_destroy_mutex:
-	mutex_destroy(&queue->queue_lock);
 	return ret;
 }
 
@@ -660,7 +672,6 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 
 	rdma_destroy_id(queue->cm_id);
 	nvme_rdma_destroy_queue_ib(queue);
-	mutex_destroy(&queue->queue_lock);
 }
 
 static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -735,7 +746,6 @@ static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl,
 	for (i = 0; i < nr_queues; i++) {
 		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
 
-		queue->ctrl = ctrl;
 		queue->queue_size = queue_size;
 
 		ctxs[i].queue = queue;
@@ -798,7 +808,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	ctrl->queues[0].ctrl = ctrl;
 	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
 	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
@@ -1001,6 +1010,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	int i, nr_queues = NVME_RDMA_OPT_NR_QUEUES(nctrl->opts);
 
 	if (list_empty_careful(&ctrl->list))
 		goto free_ctrl;
@@ -1011,6 +1021,8 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	for (i = 0; i < nr_queues; i++)
+		nvme_rdma_exit_queue(ctrl, i);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -2284,7 +2296,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -2333,8 +2345,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
+	ctrl->ctrl.queue_count = NVME_RDMA_OPT_NR_QUEUES(opts);
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -2343,6 +2354,9 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_free_ctrl;
 
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		nvme_rdma_init_queue(ctrl, i);
+
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
 	if (ret)

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0


