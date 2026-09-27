Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A2C9830E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2026 07:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HK2zmqCHh0xDqP3HVCbTRprntu2C3xUCOIeZly28qHM=; b=Z8PyWfJsGATXMMbiI2l46J3T5J
	uOpKUliTbnU/2/KEjmbfdUaHTugylSpCpX59LCkU2fI8czpeQF1T226z7g5vPhrGU7ZjmeiaDWSfI
	mLiBu8yn0PCAvECVGkV7o8M2BHLDbOGmYv6BjuF1Wen5mDC4HJnYZObjdr5YmtIZl4u4Qyqm83YaK
	WZW6dwc3J+B5aY3zS9zMm4prYX23/BTTJpBX/tDsvxsFuT6KXeJxnMfROqaxd3VVfhLixXNB7C4w8
	ejg4NQ3ZRS5tH6RfB5bn/aU4CdJDEIuZziXj9Fi230llnFPf1hBaxvfM3UKLbMWGFFgyiRhdycaO+
	ChzVw8vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAj14-0000000G5iQ-12Da;
	Sun, 27 Sep 2026 07:09:42 +0000
Received: from mail-dl2-x10.google.com ([2607:f8b0:4864:38::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAj0z-0000000G5hK-1nXJ
	for linux-nvme@lists.infradead.org;
	Sun, 27 Sep 2026 07:09:38 +0000
Received: by mail-dl2-x10.google.com with SMTP id a92af1059eb24-142dd025d06so1429819c88.1
        for <linux-nvme@lists.infradead.org>; Sun, 27 Sep 2026 00:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790492976; x=1791097776; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HK2zmqCHh0xDqP3HVCbTRprntu2C3xUCOIeZly28qHM=;
        b=SQ6JfkpLNIUuP/4fhrjh8249NSbU6EiBWbSFNRGI3bI53kvZV/llvFmn98PAmpa7B9
         WmQwENFNKzvinnWbrfA8jXuUGGsX9EeL/ZuIBcbhzY/pwJlb/stvmcWsMe4dcP6LBuRw
         i3fliW5BnvoeA0GnA6kBRVNjeSlorgbZiEiTqgfXMAzGuT/vCFaSWAison9MMHn5AKVD
         x8GDpHsBmSiRPVxrrJ6XnArE4xAuZcxTbpN8bFxT78UEWVOCl1ggAQCCyfpYvqZswctt
         g/KNQfkREBAzjowIeoNoKu4t0DTmmM8kKHe0tuRYqeiOEGpsSWLmM3R3pOd+3z0Bc0UQ
         6NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790492976; x=1791097776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HK2zmqCHh0xDqP3HVCbTRprntu2C3xUCOIeZly28qHM=;
        b=ZuTDlUwHQuLwDaz+EEiYqVYLcvihLJovcJbubCJs7ObfX0S/bHEoHsCf8lizO5ubYc
         Y0A4B1YRTmUSakC1YaLU8TjpNC2NbYHcd89cOS+RpRTMY2dF9mvbdKC+gA8Hp7vVRdI5
         7vAuYJ13P3zK+bMEgYukSFtLWmGTnwPnt9PZ5WE8vxqtJ5qG9uBJYkBCasHYOZS3stP/
         6qri4oS8Oba06CZCHxiRcRzKwNxqkZjCirnI2pz/FduoHWGxDYLXJU5UzKe+/0IWD7nq
         yuNnow6ZpEXtE1NvVGnAkBhs8lyTdnlT0wXy2Mp3KEVSDKxyuyYAc4TNTFO3uXeMT6k1
         6u9A==
X-Gm-Message-State: AFuF++nqxhy+dm2191wKFjDoYGbIRUXeMiZFeen5AmwQ/oOs78soG2uU
	XXAmZ0FwHXnCylNbTjQzc3kVSDEHeXjVURxRBX8UjL3upAbSzjFuyICsZ8kJcnTZHqStaUxDuKg
	J6EBY64I=
X-Gm-Gg: AYBFou2kDPLoPnJPcwFHSRMfnkQmxzE8N4+83go7c/uAP3QTXfeM2Mv0mb0IfHaSIK5
	3rs1Kb5jguSlZdKAz2co2xEipA4gUVN2Mhowfofv2nO263BZHn5U8MMkbTMJT2+hjoB1/Be3jRE
	p8dxKw8wIa3t1xDkuNO3q/BYuiWsB+OD4lImSMV/4Q2Om45MvAXzJk1fyjsX4hlf3I6uK6baC99
	44K53eSlr+TOsyCebZkEyDlxf1nR82iCjfQqYRUQMWoluU2k3djLUXNifgD5nhLy0BzJ4KOemir
	Tw2tJVABxSmfHqosZVfz7hTFgzIPxXqJgmI35JjMSmwJf+OCN9HxWHOxuGl98HN0tOr7eBWu6Wo
	RuYm/ZjPUzUaBcG7a0DO8V6huSWXsMteRTv2uI+p75u2ErtfAsUijwPwv2aL/IQzxDjR2g6dwAP
	MedxK9MUcg5dy7LfUNIi0U/k1cKx+RryAscK2Y60v7i3qF11ZVTay8iPOx7a4hbWp+TOOcBQU7F
	EYb0vpbHHCPQw37OdyAg3gncWm2Eidk7SYndpLNvTky2UVKZobkuxOB0khAgDM3
X-Received: by 2002:a05:7022:ea8b:b0:13f:c02f:60b1 with SMTP id a92af1059eb24-146ce67f53amr5479644c88.15.1790492975145;
        Sun, 27 Sep 2026 00:09:35 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:cdfd:5309:3fdc:3b4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm10322371c88.9.2026.09.27.00.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 00:09:34 -0700 (PDT)
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
Subject: [PATCH v4 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Sun, 27 Sep 2026 00:09:25 -0700
Message-ID: <20260927070925.47209-3-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927070925.47209-1-saravanand@crusoe.ai>
References: <20260927070925.47209-1-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_000937_499642_97E673FC 
X-CRM114-Status: GOOD (  25.66  )
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

Embed the nvme_queue_info in the tcp queue and expose the io_cpu
through the controller's queues directory

  /sys/class/nvme/nvmeX/queues/<qid>/io_cpu

so a control plane that owns CPU placement can set it directly instead
of relying on the driver's heuristic. The attribute accepts a cpu
number, -1 or "unbound", where -1 and "unbound" leave the socket work
unbound, running each invocation on the cpu that queued it. A user
assignment is marked in the queue info flags, persists across
reconnects and is never re-picked by the driver. The read-only
managed attribute reports 1 while io_cpu is driver managed and 0 once
the user assigned it. The accounting of nvme_tcp_cpu_queues applies
regardless of who set the io_cpu.

The queue directories register on the first connect and persist while
the queues cycle across reconnects, so a write can arrive while a
queue is torn down. The io_cpu changes and their accounting therefore
serialize under a controller level lock rather than the queue lock,
which is destroyed with the queue, and the controller teardown waits
for the last kobject release before the queue array is freed.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
Assisted-by: Claude:claude-opus-4-8 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 Documentation/ABI/stable/sysfs-nvme |  21 ++++
 drivers/nvme/host/tcp.c             | 153 +++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a0bb88ca1694..4d0c7688e8f7 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -472,3 +472,24 @@ Contact:	Hannes Reinecke <hare@suse.de>
 Description:
 		Shows the subsystem type. Possible values: "discovery",
 		"nvm", "reserved".
+
+What:		/sys/class/nvme/nvmeX/queues/<qid>/io_cpu
+What:		/sys/class/nvme/nvmeX/queues/<qid>/managed
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Saravanan D <saravanand@crusoe.ai>
+Description:
+		Per I/O queue directories, populated by the transport
+		backing the controller and persistent across controller
+		reconnects. NVMe over TCP exposes:
+
+		io_cpu: (RW) The CPU that runs the socket work for I/O
+		queue <qid>, selected by the driver at connect time.
+		Writing a CPU number overrides the selection and persists
+		across reconnects. Writing -1 or "unbound" leaves the
+		socket work unbound, running each invocation on the CPU
+		that queued it. Reads return the current CPU, or -1 when
+		the queue is unbound.
+
+		managed: (RO) Shows who owns the CPU placement. 1 while
+		io_cpu is driver managed, 0 once the user assigned it.
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b..567c839e92a4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -141,6 +141,8 @@ struct nvme_tcp_queue {
 	int                     tls_err;
 	struct page_frag_cache	pf_cache;
 
+	struct nvme_queue_info	q_info;
+
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
 	void (*write_space)(struct sock *);
@@ -171,6 +173,11 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+	/* serializes io_cpu changes and their nvme_tcp_cpu_queues accounting */
+	struct mutex		io_cpu_lock;
+	unsigned int		nr_queue_infos;
+	atomic_t		qinfo_refs;
+	struct completion	qinfo_release;
 };
 
 static struct workqueue_struct *nvme_tcp_wq;
@@ -1497,6 +1504,12 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	/* settle accounting a write racing the queue stop may have left */
+	mutex_lock(&ctrl->io_cpu_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+	mutex_unlock(&ctrl->io_cpu_lock);
+
 	page_frag_cache_drain(&queue->pf_cache);
 
 	/**
@@ -1716,9 +1729,19 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	unsigned int *mq_map = NULL;
 	int cpu, min_queues = INT_MAX, io_cpu;
 
+	lockdep_assert_held(&ctrl->io_cpu_lock);
+
 	if (wq_unbound)
 		goto out;
 
+	/* A user assigned io_cpu is kept across reconnects */
+	if (test_bit(NVME_QUEUE_INFO_IO_CPU_USER, &queue->q_info.flags)) {
+		if (queue->io_cpu != WORK_CPU_UNBOUND &&
+		    !test_and_set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+			atomic_inc(&nvme_tcp_cpu_queues[queue->io_cpu]);
+		goto out;
+	}
+
 	if (nvme_tcp_default_queue(queue))
 		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
 	else if (nvme_tcp_read_queue(queue))
@@ -1836,6 +1859,114 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static struct nvme_tcp_queue *nvme_tcp_kobj_to_queue(struct kobject *kobj)
+{
+	struct nvme_queue_info *qinfo =
+		container_of(kobj, struct nvme_queue_info, kobj);
+
+	return container_of(qinfo, struct nvme_tcp_queue, q_info);
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
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+	int cpu, old;
+	int ret;
+
+	if (sysfs_streq(buf, "unbound")) {
+		cpu = WORK_CPU_UNBOUND;
+	} else {
+		ret = kstrtoint(buf, 0, &cpu);
+		if (ret)
+			return ret;
+		if (cpu == -1)
+			cpu = WORK_CPU_UNBOUND;
+		else if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu))
+			return -EINVAL;
+	}
+
+	mutex_lock(&ctrl->io_cpu_lock);
+	old = xchg(&queue->io_cpu, cpu);
+	set_bit(NVME_QUEUE_INFO_IO_CPU_USER, &queue->q_info.flags);
+	if (test_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
+		atomic_dec(&nvme_tcp_cpu_queues[old]);
+		if (cpu != WORK_CPU_UNBOUND)
+			atomic_inc(&nvme_tcp_cpu_queues[cpu]);
+		else
+			clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
+	} else if (cpu != WORK_CPU_UNBOUND &&
+		   test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags)) {
+		/* account a pin to a connected queue the pick left unbound */
+		atomic_inc(&nvme_tcp_cpu_queues[cpu]);
+		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
+	}
+	mutex_unlock(&ctrl->io_cpu_lock);
+
+	return count;
+}
+
+static ssize_t managed_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *buf)
+{
+	struct nvme_tcp_queue *queue = nvme_tcp_kobj_to_queue(kobj);
+
+	return sysfs_emit(buf, "%d\n",
+			  !test_bit(NVME_QUEUE_INFO_IO_CPU_USER, &queue->q_info.flags));
+}
+
+static struct kobj_attribute nvme_tcp_io_cpu_attr =
+	__ATTR(io_cpu, 0644, io_cpu_show, io_cpu_store);
+static struct kobj_attribute nvme_tcp_managed_attr =
+	__ATTR_RO(managed);
+
+static struct attribute *nvme_tcp_queue_attrs[] = {
+	&nvme_tcp_io_cpu_attr.attr,
+	&nvme_tcp_managed_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(nvme_tcp_queue);
+
+static void nvme_tcp_queue_info_release(struct kobject *kobj)
+{
+	struct nvme_tcp_queue *queue = nvme_tcp_kobj_to_queue(kobj);
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+
+	if (atomic_dec_and_test(&ctrl->qinfo_refs))
+		complete(&ctrl->qinfo_release);
+}
+
+static const struct kobj_type nvme_tcp_queue_ktype = {
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= nvme_tcp_queue_info_release,
+	.default_groups	= nvme_tcp_queue_groups,
+};
+
+static void nvme_tcp_register_queue_sysfs(struct nvme_tcp_queue *queue)
+{
+	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
+
+	if (test_bit(NVME_QUEUE_INFO_REGISTERED, &queue->q_info.flags))
+		return;
+
+	/* a failed registration drops the reference through the release */
+	atomic_inc(&ctrl->qinfo_refs);
+	nvme_register_queue_info(&ctrl->ctrl, &queue->q_info,
+				 nvme_tcp_queue_id(queue),
+				 &nvme_tcp_queue_ktype);
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1906,7 +2037,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	queue->io_cpu = WORK_CPU_UNBOUND;
+	if (!test_bit(NVME_QUEUE_INFO_IO_CPU_USER, &queue->q_info.flags))
+		queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1974,6 +2106,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
 
+	if (qid)
+		nvme_tcp_register_queue_sysfs(queue);
+
 	return 0;
 
 err_init_connect:
@@ -2022,8 +2157,10 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	mutex_lock(&ctrl->io_cpu_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
 		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+	mutex_unlock(&ctrl->io_cpu_lock);
 
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
@@ -2085,7 +2222,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_setup_sock_ops(queue);
 
 	if (idx) {
+		mutex_lock(&ctrl->io_cpu_lock);
 		nvme_tcp_set_queue_io_cpu(queue);
+		mutex_unlock(&ctrl->io_cpu_lock);
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	} else
 		ret = nvmf_connect_admin_queue(nctrl);
@@ -2650,6 +2789,14 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
+	if (ctrl->queues) {
+		unsigned int qid;
+
+		for (qid = 1; qid < ctrl->nr_queue_infos; qid++)
+			nvme_unregister_queue_info(&ctrl->queues[qid].q_info);
+		if (!atomic_dec_and_test(&ctrl->qinfo_refs))
+			wait_for_completion(&ctrl->qinfo_release);
+	}
 	kfree(ctrl->queues);
 	kfree(ctrl);
 }
@@ -3047,6 +3194,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		ret = -ENOMEM;
 		goto out_free_ctrl;
 	}
+	ctrl->nr_queue_infos = ctrl->ctrl.queue_count;
+	mutex_init(&ctrl->io_cpu_lock);
+	atomic_set(&ctrl->qinfo_refs, 1);
+	init_completion(&ctrl->qinfo_release);
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
-- 
2.55.0


