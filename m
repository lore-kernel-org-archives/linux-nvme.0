Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FE9C79FB7
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Tv2oRqdpdlLUKtY0QqcpmerRg/fnmUlmrAMrbFcMxgM=; b=wpYcIpKrPVOrGxWuFf4Ig782+4
	DJCobAwM0O50CBWOFMJkx8xZQaMas4hf6DPRN2vx4IQKqGVIDCvUIwJApZ8uL4acypDehVj2P9nwr
	Z6U0CAjKza8bXbN83yy0hT0aOa2vT5YeJSQk75P9+haxfXLWZU6frzv8jh1GAOMfZo9N+KbROoKhB
	KhnUTTQcRXYCVT2iXS6fOF75kPndkc7rOOVSXqimUBVfabQFvENuYnAX/dJXUreCIYhGJjfTwZdRR
	zTE0OsZ58dLQkJ6+j7HpQXPb3TxdzNL89bBUOCls9j5NMl1yE1Ckex8Vsqule3bY3oTdbhXvSp7iD
	gaWN1Umg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Pd5-0000000Crwq-1u8d;
	Wed, 09 Sep 2026 21:14:51 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Pd2-0000000CrwC-3f4y
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 21:14:50 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d4eb63f0aso17460307b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 14:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788988487; x=1789593287; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tv2oRqdpdlLUKtY0QqcpmerRg/fnmUlmrAMrbFcMxgM=;
        b=jUJmiIXFuM+Koexe8TZDxWaDSfIzyCIxldcXZ7Iq9QZM3j1oKkdRb+P9ngfw7UgPow
         16toncK4AG0hAe7E4gQ/Pnssn6MpKsM0cmXOlr8mC+hyGkJgXvai6NIfMihl9zat0OOv
         1aX4CccJ0PrzmonMkSCaqbL2PT+5fjXJIjuytdrwQsEcqlKimYHw4UEQpAa/BFZqThDR
         bUvXxw5bzX/tR6KCG8YUPu9BP/931o25yOu3khqJB8KMavXgZiTb3EZE0qUBVtSLtdu5
         Iifuj6p+GpWLCcWX1oNBYPDEAOCG31EMVg24UgXLtK72n0JJMLvm4dBd/l9J4/gMUG91
         pr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988487; x=1789593287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tv2oRqdpdlLUKtY0QqcpmerRg/fnmUlmrAMrbFcMxgM=;
        b=QCuhi0NIk5W+sBvDzDll/5bXxYXcn19Q5RuEd/rBuEYt8E9emJyKXcUHNqKzTK9CrD
         lbOPvLio5xNGI1PwXw+nrDUrLU0WApbXPwwTMngew/hpJi2sLPRh2nAlEE8kgWjrwEn5
         ieWtEh0y9LPUpkvm4CV2R8KNqSAQPMsu/GAJ/5fBROlVmr7PUP5UKpQ7ITIOKqNKcJbd
         5LILmXU8PtzZGvFiPELtKmz72Ly9H5V4Z+ezp3Y1Y98rgcTqx7pEFfM0Ix3E2odt2dAj
         w7ZSSvAd8OyKXVfIw4+QD6uPagG4jOb5bZobZD4bnIpxmRdFZnGabc5vzIopujvqAh80
         26PA==
X-Gm-Message-State: AFuF++lUBFAzp1NGJaAd3479dYf+T8VnTjo0YcGuS19lzACooHEKDJ1o
	vPGgTFcApsNxyOLqz0loJhbuJTVIWFcGhjs8pUJDDciNVvrdTjzjkTa8Kb8TzyakhlD7GsTwpYu
	jnnMrrJwqhw==
X-Gm-Gg: AYBFou28bRtxLAuCD5RAYYKJd1mQrGz5Avet5/FOjyZEfUc+MPZG7uYA6llGoeyklX4
	MOlMT6qYxsmX+4+4CSI3jIZCWbPIgGy2td7PCVyIhyum8SUCyL+lIUh7H591hR+z5zg2Pfk4NXJ
	9POoddjjOKHzrxduA/GtaUuUFPUc8O8sTfV93cREjFmqiR07Vpti8+932+A1WMBxWdlF6YiJQsU
	482RNOjY2aj9gbS/W3E6zmtImszbyKQkJiWNwKqxQ2rdU/yWKTI9NKpLg284ZUDc4GkpxF6Qa3G
	zeEnwKj4UJl26Q4bbBn5Oqz7lhqM3FWQpDSjC7uLjGHn1AkYaYQL2As0DpmO/Di+hBMlmVtcYnU
	eepJALSmar1bfhIMctzJTGYD/bcTfkfQ0KEbU7EfYv0S3E+LmE2nsA2RKlH4+3VFNmJP69Vawhu
	bgJ5CCYogNJrNFqP9+ORAgptZcHlu16Ij796VESE87TpN0xlqH1wdZ+L2vO/N6Ueci9diV3KjzG
	F+hvPXOquzwvjRmd+IZFHQwKo3lgbRMkhhIJ7c/FCJ2
X-Received: by 2002:a05:690c:c4e5:b0:873:5c6b:a31d with SMTP id 00721157ae682-882046660dcmr4607757b3.23.1788988486780;
        Wed, 09 Sep 2026 14:14:46 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b7255fbsm117133617b3.42.2026.09.09.14.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 14:14:46 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sj@kernel.org,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v3] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed,  9 Sep 2026 14:14:32 -0700
Message-ID: <20260909211432.6741-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_141448_970565_BDDD6F1B 
X-CRM114-Status: GOOD (  23.80  )
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

nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
as the least loaded CPU in the queue's blk-mq map group, and all socket
work runs there for the connection's lifetime. This decision falls
short when the host partitions its CPUs after connect time. On a 384
cpu multi tenant host with 128 queue controllers, blk-mq folds three
CPUs into every map group, some groups straddle two tenants' cpusets,
and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
cpuset, seen by the neighbor as steal time.

Expose each I/O queue's io_cpu as a writable sysfs attribute

  /sys/class/nvme/nvmeX/tcp_queues/<qid>/io_cpu

so a control plane that owns CPU placement can set it directly instead
of relying on the driver's heuristic. A written value persists across
reconnects, marked by NVME_TCP_Q_IO_CPU_USER. Writing -1 clears the
mark and re-runs the connect time selection. Reading returns the CPU,
or -1 when the queue is unbound.

The store, the connect time selection and queue stop serialize their
accounting of nvme_tcp_cpu_queues under the queue lock.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Link: https://lore.kernel.org/linux-nvme/220e9da3-f756-4a16-8de1-d4b171f15009@grimberg.me/
Assisted-by: Claude:claude-opus-4-8 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
Changes since v2 [1]:
- Replaced the io_cpu_adopt connect option and the submitter adoption
  heuristic with a per queue writable sysfs attribute, following Sagi's
  suggestion [2]. The control plane now sets each queue's io_cpu
  directly, the assignment is kept across reconnects and writing -1
  reverts to the connect time selection.
- Retitled from "nvme-tcp: pin io_cpu to submitter cpu".

The per queue directories follow the blk-mq mq/<hctx> sysfs pattern.

Tested on a 2 socket 384 cpu host with 128 queue controllers. Writing
a cpu number changed the queue's io_cpu to it. Writing an invalid
value was rejected. Writing -1 re-ran the connect time selection.
Pinned queues kept their io_cpu across a controller reset while
unpinned queues received a fresh pick.

The multiple queues per hctx RFC [3] found the same need to steer the
socket work cpu, so this attribute may gain a second user.

[1] https://lore.kernel.org/linux-nvme/20260820083634.71689-1-saravanand@crusoe.ai/
[2] https://lore.kernel.org/linux-nvme/1d56144d-6987-40c1-ac02-b15333db121e@grimberg.me/
[3] https://lore.kernel.org/linux-nvme/20260903152623.614951-1-kbusch@meta.com/

 Documentation/ABI/stable/sysfs-nvme |  12 +++
 drivers/nvme/host/tcp.c             | 153 +++++++++++++++++++++++++++-
 2 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a2f5d0710db4..2bbb5a0b7c2e 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -451,3 +451,15 @@ Contact:	Hannes Reinecke <hare@suse.de>
 Description:
 		Shows the subsystem type. Possible values: "discovery",
 		"nvm", "reserved".
+
+What:		/sys/class/nvme/nvmeX/tcp_queues/<qid>/io_cpu
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Saravanan D <saravanand@crusoe.ai>
+Description:
+		(RW) The CPU that runs the socket work for I/O queue <qid>
+		of an NVMe over TCP controller, selected by the driver at
+		connect time. Writing a CPU number overrides the selection
+		and persists across reconnects. Writing -1 reverts to the
+		driver's selection. Reads show the current CPU, or -1 when
+		the queue is unbound.
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b..22ad1fdf4a12 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -93,6 +93,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_IO_CPU_USER	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -102,6 +103,17 @@ enum nvme_tcp_recv_state {
 };
 
 struct nvme_tcp_ctrl;
+struct nvme_tcp_queue;
+
+/*
+ * Allocated per registration and freed by its kobject release, so a
+ * reconnect never reuses a kobject whose release is still pending.
+ */
+struct nvme_tcp_queue_kobj {
+	struct kobject		kobj;
+	struct nvme_tcp_queue	*queue;
+};
+
 struct nvme_tcp_queue {
 	struct socket		*sock;
 	struct work_struct	io_work;
@@ -141,6 +153,8 @@ struct nvme_tcp_queue {
 	int                     tls_err;
 	struct page_frag_cache	pf_cache;
 
+	struct nvme_tcp_queue_kobj *qkobj;
+
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
@@ -171,8 +185,11 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+	struct kobject		*queues_kobj;
 };
 
+static void nvme_tcp_unregister_queue_sysfs(struct nvme_tcp_queue *queue);
+
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -1497,6 +1514,8 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	nvme_tcp_unregister_queue_sysfs(queue);
+
 	page_frag_cache_drain(&queue->pf_cache);
 
 	/**
@@ -1716,9 +1735,19 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	unsigned int *mq_map = NULL;
 	int cpu, min_queues = INT_MAX, io_cpu;
 
+	lockdep_assert_held(&queue->queue_lock);
+
 	if (wq_unbound)
 		goto out;
 
+	/* A user assigned io_cpu is kept across reconnects */
+	if (test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags) &&
+	    queue->io_cpu != WORK_CPU_UNBOUND) {
+		if (!test_and_set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+			atomic_inc(&nvme_tcp_cpu_queues[queue->io_cpu]);
+		goto out;
+	}
+
 	if (nvme_tcp_default_queue(queue))
 		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
 	else if (nvme_tcp_read_queue(queue))
@@ -1836,6 +1865,118 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static struct nvme_tcp_queue *nvme_tcp_kobj_to_queue(struct kobject *kobj)
+{
+	return container_of(kobj, struct nvme_tcp_queue_kobj, kobj)->queue;
+}
+
+static ssize_t io_cpu_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	struct nvme_tcp_queue *queue = nvme_tcp_kobj_to_queue(kobj);
+	int io_cpu = READ_ONCE(queue->io_cpu);
+
+	return sysfs_emit(buf, "%d\n",
+			  io_cpu == WORK_CPU_UNBOUND ? -1 : io_cpu);
+}
+
+static ssize_t io_cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct nvme_tcp_queue *queue = nvme_tcp_kobj_to_queue(kobj);
+	int cpu, old;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &cpu);
+	if (ret)
+		return ret;
+	if (cpu != -1 &&
+	    ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu)))
+		return -EINVAL;
+
+	mutex_lock(&queue->queue_lock);
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
+		mutex_unlock(&queue->queue_lock);
+		return -ENODEV;
+	}
+	if (cpu == -1) {
+		if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags)) {
+			if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET,
+					       &queue->flags))
+				atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+			WRITE_ONCE(queue->io_cpu, WORK_CPU_UNBOUND);
+			/* a queue that is not live gets its pick at start */
+			if (test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+				nvme_tcp_set_queue_io_cpu(queue);
+		}
+	} else {
+		old = xchg(&queue->io_cpu, cpu);
+		set_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags);
+		if (test_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
+			atomic_dec(&nvme_tcp_cpu_queues[old]);
+			atomic_inc(&nvme_tcp_cpu_queues[cpu]);
+		}
+	}
+	mutex_unlock(&queue->queue_lock);
+
+	return count;
+}
+
+static struct kobj_attribute nvme_tcp_io_cpu_attr =
+	__ATTR(io_cpu, 0644, io_cpu_show, io_cpu_store);
+
+static struct attribute *nvme_tcp_queue_attrs[] = {
+	&nvme_tcp_io_cpu_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(nvme_tcp_queue);
+
+static void nvme_tcp_queue_kobj_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct nvme_tcp_queue_kobj, kobj));
+}
+
+static const struct kobj_type nvme_tcp_queue_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= nvme_tcp_queue_kobj_release,
+	.default_groups	= nvme_tcp_queue_groups,
+};
+
+static void nvme_tcp_register_queue_sysfs(struct nvme_tcp_queue *queue)
+{
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+	struct nvme_tcp_queue_kobj *qkobj;
+
+	if (!ctrl->queues_kobj)
+		ctrl->queues_kobj = kobject_create_and_add("tcp_queues",
+							   &ctrl->ctrl.device->kobj);
+	if (!ctrl->queues_kobj)
+		return;
+
+	qkobj = kzalloc_obj(*qkobj);
+	if (!qkobj)
+		return;
+
+	qkobj->queue = queue;
+	if (kobject_init_and_add(&qkobj->kobj, &nvme_tcp_queue_ktype,
+				 ctrl->queues_kobj, "%d",
+				 nvme_tcp_queue_id(queue))) {
+		kobject_put(&qkobj->kobj);
+		return;
+	}
+	queue->qkobj = qkobj;
+}
+
+static void nvme_tcp_unregister_queue_sysfs(struct nvme_tcp_queue *queue)
+{
+	struct nvme_tcp_queue_kobj *qkobj = queue->qkobj;
+
+	if (!qkobj)
+		return;
+	queue->qkobj = NULL;
+	kobject_put(&qkobj->kobj);
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1906,7 +2047,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	queue->io_cpu = WORK_CPU_UNBOUND;
+	if (!test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags))
+		queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1974,6 +2116,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
 
+	if (qid)
+		nvme_tcp_register_queue_sysfs(queue);
+
 	return 0;
 
 err_init_connect:
@@ -2022,10 +2167,9 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
 		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
-
-	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
 	/* Stopping the queue will disable TLS */
@@ -2085,7 +2229,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_setup_sock_ops(queue);
 
 	if (idx) {
+		mutex_lock(&queue->queue_lock);
 		nvme_tcp_set_queue_io_cpu(queue);
+		mutex_unlock(&queue->queue_lock);
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	} else
 		ret = nvmf_connect_admin_queue(nctrl);
@@ -2650,6 +2796,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	kobject_put(ctrl->queues_kobj);
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }

base-commit: fd9beb8870736e1c6a0b2351d88a161aaeb2b326
-- 
2.55.0


