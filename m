Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28F0CCF2C7
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Oct 2026 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aV4PEFO8HXcSLFHPWJY/xkEKmaktH6/TwcomPvx93io=; b=cSymny5/+zFc5bR68QsZFa0xGA
	psVqSoYvlK7qobWOnkCRHxTLZWrRXHWiBBiGH8eAe5XzQkSW3k+paTEs2M4BrnTMshdmQSRBN5R+4
	gqVx9bukO0CznmHuB/bhcEa5Hlp1tzpqur9xfK8/Ri+6zLCl4clYa5keDfdsdZKgEu274SDQ+Ttf0
	nht9q9vIQTg8zl4QXk54fj2Scu8HO869TmQWQFsqHCm56xwlBnIWSmN2x3290LfoV23KY227MaWFE
	0zeD9KyeI6XBkEpxD4zj8C6GhNgo8YbFyELyYePy98OYFGmnsNt6RcdTbEjva6Kx/NrCutU8HDGhq
	6nE/1Pdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFHD-00000005OAr-3KDR;
	Sun, 18 Oct 2026 01:01:27 +0000
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIFHB-00000005O9s-2U9e
	for linux-nvme@lists.infradead.org;
	Sun, 18 Oct 2026 01:01:26 +0000
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-30b6dad2382so2924593eec.0
        for <linux-nvme@lists.infradead.org>; Sat, 17 Oct 2026 18:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792285285; x=1792890085; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aV4PEFO8HXcSLFHPWJY/xkEKmaktH6/TwcomPvx93io=;
        b=HHZdtxkdct/+eBMb/8D8/sqAlTku2NoNsVAadcCbdj+N4V6bw84iSUNjngEO2T/rve
         1QFlvOCd3RYdkGVWRsPLW1swMOweRbSLiz4BRGqr/ytrvvUmuVSHHevqeLnlrwp+ORo9
         d9dTepSSumpkEs9noN/NjgPYsazQYcrKTDOvalqYQlKTS4M2XS98iUa7dGWCMwG5JEeF
         7HkuxnTYR+iLZahnrfZ6rZwpKkXwZkfWbZOOfWm6xxrmm7hU1F5ZsinNXBx/+sWy+ooH
         1+IoElaid8ZUVJTbzekUNgNM5b8RGsJvEJjD3UIaBoT4Ubib7VGzCTefMaKJA5/Gi6/P
         tkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285285; x=1792890085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aV4PEFO8HXcSLFHPWJY/xkEKmaktH6/TwcomPvx93io=;
        b=oV8i9HqyDDHSONEn270rPXKm/xSF9eoNn2LNcwlTKEJnnQuwlFX97Brry8CJ8tCR4D
         tbIggFeWBaU9aUVIRvVm4klYC34aA7uHPlPU1jECfP1tut/1pYIpFAplU1fB7ke6u6C5
         0JK+0b0/YUB7D0WEsUkO+OMbzxmHpMmYppo+mbXmNpUDQCYJemsxeMzPNUOYzxvtXpl+
         l7vvmFLarsiKu5oFrRjbjAC956MPXXFzXn0xdopy5LOeU+EapCoZ+x8SMFQ64wTjFNsS
         v2HzEHGZWHIKYBtHTLxygipNAaTujaFqctIUwFLhIVe8ezIuICBPNPlQNcTLTAQmiz2y
         tw9g==
X-Gm-Message-State: AFq9FYLTgqYpw7ZRO+p1G95jwVx41k9Ft4oq7QmPxpqVIby4E157BLmc
	9XRS8wl1oauZ40PqmmWxAp3YUJPt5Qh1VLMaWx7G4fN5VjvkUOBd9680mlvpVcau9ug3Pa4ZyAr
	oGUAMQSqszQ==
X-Gm-Gg: AYBFou2vRYPbrzAzuwFcgn73FD/VtxWm0+xP8EArNQN5+W8u1vQ/csvPf37wakekYJV
	ztKQgrUjuNmJ9TTfCXcJZg9B3lh06ZCQ4RsAZVabrZmTbUq3CamAP9q0MlZvs2yy/Qk2t+rMTz2
	ejUmrIBWB2KOJ9LmLTNWhCjtHuZN2nyt4CnEwDZaYNBMj6X3/XJar3/0WdO821EjIm9LWJwNUsi
	mtnvGuOkJw0XPpgOgG/rAio9bt+qK7H8UHhL0HNv6gslus/tnezC4/r5YVq5O9SM6M6EqyPgvPQ
	deE8zcBViCQf5BIGivpNwuy1Ms3Q0zZ+6I85PaMnUUBfEkhtOyNIzXNXjDeebbUWUYV0PzJMVY3
	LUKwd5xtg+hUwun586im0esD+bmHACXXImFu1UxYTD8WD9TN3aMeaNgS12oXcfpLylOExSlw/Ul
	z2kqG4hPHGAa3wWVEZ6tYb30TntyHBxBrcS9YWtTUFMQWLS6K8F4X5HUkKmtBhUGzylQdGTgMTQ
	67ClyyULyDkxCJCsk175Kzb10D2GA/2w9pvfQb4Vac=
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-3619ea236b5mr5075843eec.1.1792285284687;
        Sat, 17 Oct 2026 18:01:24 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm24198870eec.20.2026.10.17.18.01.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:01:24 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Sat, 17 Oct 2026 18:00:59 -0700
Message-ID: <20261018010059.83120-3-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018010059.83120-1-saravanand@crusoe.ai>
References: <20261018010059.83120-1-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261017_180125_652215_CC400695 
X-CRM114-Status: GOOD (  27.43  )
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

Expose the io_cpu in each I/O queue's directory

  /sys/class/nvme/nvmeX/queues/<qid>/io_cpu

so a control plane that owns CPU placement can set it directly instead
of relying on the driver's heuristic. The attribute accepts a decimal
cpu number, -1 or "unbound". A user assignment, unbound included, is
marked in the queue flags, persists across reconnects and is never
reselected by the driver. The read-only managed attribute reports 1
while io_cpu is driver managed and 0 once the user assigned it. The
accounting of nvme_tcp_cpu_queues applies regardless of who set the
io_cpu.

A queue's directory is added when the queue is allocated and removed
when it is freed, before the queue is torn down, so a sysfs store
never runs on a freed queue. The queues directory is created before
the I/O queues are set up in parallel. All io_cpu writes, from sysfs
and from the driver, serialize with the accounting under
nvme_tcp_cpu_queues_lock, while the I/O paths read io_cpu locklessly.
The queue stop now clears NVME_TCP_Q_IO_CPU_SET under that lock, since
a sysfs store may move io_cpu in between.

nvme_tcp_free_queue() now clears NVME_TCP_Q_IO_CPU_SET and drops its
count, because a queue can still be counted when it is freed. A sysfs
store may have run after the queue stop, or the connect may have
failed, and the setup error path frees such a queue without calling
nvme_tcp_stop_queue(), where the count is normally dropped.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Link: https://lore.kernel.org/linux-nvme/13c160d0-0657-47ce-9a16-58d348267ab0@grimberg.me/
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 Documentation/ABI/stable/sysfs-nvme |  29 +++++
 drivers/nvme/host/tcp.c             | 173 ++++++++++++++++++++++++----
 2 files changed, 182 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index 9291595f8102..4160589f7524 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -503,3 +503,32 @@ Contact:	Hannes Reinecke <hare@suse.de>
 Description:
 		Shows the subsystem type. Possible values: "discovery",
 		"nvm", "reserved".
+
+What:		/sys/class/nvme/nvmeX/queues/<qid>/io_cpu
+What:		/sys/class/nvme/nvmeX/queues/<qid>/managed
+Date:		October 2026
+KernelVersion:	7.4
+Contact:	Saravanan D <saravanand@crusoe.ai>
+Description:
+		Per I/O queue directories, populated by the transport
+		backing the controller. A directory exists while its
+		queue is allocated, so the directories follow the queue
+		count and are absent while the controller reconnects.
+		NVMe over TCP exposes:
+
+		io_cpu: (RW) The CPU that runs the socket work for I/O
+		queue <qid>, selected by the driver at connect time.
+		Writing a decimal online CPU number overrides the
+		selection, and writing -1 or "unbound" leaves the socket
+		work unbound. A written value persists across reconnects
+		for the life of the controller, also when its CPU goes
+		offline. Unbound socket work runs on the CPU that queued
+		it. When the nvme_tcp module is loaded with wq_unbound
+		set, the socket work runs on an unbound workqueue and
+		how closely it follows io_cpu depends on the affinity
+		scope of the nvme_tcp_wq workqueue. Reads return the
+		current CPU, or -1 when the queue is unbound.
+
+		managed: (RO) Shows who owns the CPU placement. 1 while
+		io_cpu is driver managed, 0 once the user assigned it,
+		for the life of the controller.
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ec678ed07af8..699997c0e8e2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -95,6 +95,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_IO_CPU_USER	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -142,6 +143,7 @@ struct nvme_tcp_queue {
 	struct completion       tls_complete;
 	int                     tls_err;
 	struct page_frag_cache	pf_cache;
+	struct nvme_queue_info	*qinfo;
 
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
@@ -230,6 +232,19 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+/* the I/O paths read io_cpu locklessly, writers hold the accounting lock */
+static inline int nvme_tcp_queue_io_cpu(struct nvme_tcp_queue *queue)
+{
+	return READ_ONCE(queue->io_cpu);
+}
+
+static inline void nvme_tcp_queue_change_io_cpu(struct nvme_tcp_queue *queue,
+						int cpu)
+	__must_hold(&nvme_tcp_cpu_queues_lock)
+{
+	WRITE_ONCE(queue->io_cpu, cpu);
+}
+
 static inline bool nvme_tcp_recv_pdu_supported(enum nvme_tcp_pdu_type type)
 {
 	switch (type) {
@@ -427,7 +442,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * lockdep reports circular locking via elevator_lock.  Defer TLS
 	 * sends to the io workqueue instead of inline from this path.
 	 */
-	if (queue->io_cpu == raw_smp_processor_id() &&
+	if (nvme_tcp_queue_io_cpu(queue) == raw_smp_processor_id() &&
 	    !nvme_tcp_queue_tls(queue) &&
 	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
@@ -435,7 +450,8 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	}
 
 	if (last && nvme_tcp_queue_has_pending(queue))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -844,7 +860,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	nvme_tcp_setup_h2c_data_pdu(req);
 
 	llist_add(&req->lentry, &queue->req_list);
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+		      &queue->io_work);
 
 	return 0;
 }
@@ -1131,7 +1148,8 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
 	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1146,7 +1164,8 @@ static void nvme_tcp_write_space(struct sock *sk)
 		/* Ensure pending TLS partial records are retried */
 		if (nvme_tcp_queue_tls(queue))
 			queue->write_space(sk);
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1469,7 +1488,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+		      &queue->io_work);
 }
 
 static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
@@ -1503,9 +1523,22 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	unsigned int noio_flag;
 
-	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	/* no io_cpu store runs once the directory is removed */
+	if (queue->qinfo) {
+		nvme_remove_queue_info(queue->qinfo);
+		queue->qinfo = NULL;
+	}
+	clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
+
+	/* a failed connect or a store after the stop left it counted */
+	spin_lock(&nvme_tcp_cpu_queues_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		nvme_tcp_cpu_queues[nvme_tcp_queue_io_cpu(queue)]--;
+	spin_unlock(&nvme_tcp_cpu_queues_lock);
+
 	page_frag_cache_drain(&queue->pf_cache);
 
 	/**
@@ -1725,8 +1758,18 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	unsigned int *mq_map = NULL;
 	int cpu, min_queues = INT_MAX, io_cpu;
 
+	spin_lock(&nvme_tcp_cpu_queues_lock);
+	/* a user assigned io_cpu is kept across reconnects */
+	if (test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags)) {
+		io_cpu = nvme_tcp_queue_io_cpu(queue);
+		if (io_cpu != WORK_CPU_UNBOUND &&
+		    !test_and_set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+			nvme_tcp_cpu_queues[io_cpu]++;
+		goto out_unlock;
+	}
+
 	if (wq_unbound)
-		goto out;
+		goto out_unlock;
 
 	if (nvme_tcp_default_queue(queue))
 		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
@@ -1736,10 +1779,9 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
 
 	if (WARN_ON(!mq_map))
-		goto out;
+		goto out_unlock;
 
 	/* Search for the least used cpu from the mq_map */
-	spin_lock(&nvme_tcp_cpu_queues_lock);
 	io_cpu = WORK_CPU_UNBOUND;
 	for_each_online_cpu(cpu) {
 		int num_queues = nvme_tcp_cpu_queues[cpu];
@@ -1752,14 +1794,14 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		}
 	}
 	if (io_cpu != WORK_CPU_UNBOUND) {
-		queue->io_cpu = io_cpu;
+		nvme_tcp_queue_change_io_cpu(queue, io_cpu);
 		nvme_tcp_cpu_queues[io_cpu]++;
 		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
 	}
+out_unlock:
 	spin_unlock(&nvme_tcp_cpu_queues_lock);
-out:
 	dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
-		qid, queue->io_cpu);
+		qid, nvme_tcp_queue_io_cpu(queue));
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1847,6 +1889,85 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static ssize_t io_cpu_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	struct nvme_tcp_queue *queue = nvme_queue_info_data(kobj);
+	int io_cpu = nvme_tcp_queue_io_cpu(queue);
+
+	return sysfs_emit(buf, "%d\n",
+			  io_cpu == WORK_CPU_UNBOUND ? -1 : io_cpu);
+}
+
+static ssize_t io_cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct nvme_tcp_queue *queue = nvme_queue_info_data(kobj);
+	int cpu, old, ret;
+
+	if (sysfs_streq(buf, "unbound")) {
+		cpu = WORK_CPU_UNBOUND;
+	} else {
+		ret = kstrtoint(buf, 10, &cpu);
+		if (ret)
+			return ret;
+		if (cpu == -1)
+			cpu = WORK_CPU_UNBOUND;
+		else if ((unsigned int)cpu >= nr_cpu_ids || !cpu_online(cpu))
+			return -EINVAL;
+	}
+
+	spin_lock(&nvme_tcp_cpu_queues_lock);
+	old = nvme_tcp_queue_io_cpu(queue);
+	nvme_tcp_queue_change_io_cpu(queue, cpu);
+	set_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags);
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		nvme_tcp_cpu_queues[old]--;
+	if (cpu != WORK_CPU_UNBOUND) {
+		nvme_tcp_cpu_queues[cpu]++;
+		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
+	}
+	spin_unlock(&nvme_tcp_cpu_queues_lock);
+
+	return count;
+}
+
+static ssize_t managed_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *buf)
+{
+	struct nvme_tcp_queue *queue = nvme_queue_info_data(kobj);
+
+	return sysfs_emit(buf, "%d\n",
+			  !test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags));
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
+static void nvme_tcp_add_queue_sysfs(struct nvme_tcp_queue *queue)
+{
+	struct nvme_ctrl *nctrl = &queue->ctrl->ctrl;
+	struct nvme_queue_info *qinfo;
+
+	qinfo = nvme_add_queue_info(nctrl, nvme_tcp_queue_id(queue),
+				    nvme_tcp_queue_groups, queue);
+	if (IS_ERR(qinfo)) {
+		dev_warn(nctrl->device, "queue %d: no sysfs directory: %ld\n",
+			 nvme_tcp_queue_id(queue), PTR_ERR(qinfo));
+		return;
+	}
+	queue->qinfo = qinfo;
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1917,7 +2038,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	queue->io_cpu = WORK_CPU_UNBOUND;
+	/* no store races here, the lock is for the write helper */
+	spin_lock(&nvme_tcp_cpu_queues_lock);
+	if (!test_bit(NVME_TCP_Q_IO_CPU_USER, &queue->flags))
+		nvme_tcp_queue_change_io_cpu(queue, WORK_CPU_UNBOUND);
+	spin_unlock(&nvme_tcp_cpu_queues_lock);
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1985,6 +2110,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
 
+	if (qid)
+		nvme_tcp_add_queue_sysfs(queue);
+
 	return 0;
 
 err_init_connect:
@@ -2033,11 +2161,10 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
-	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
-		spin_lock(&nvme_tcp_cpu_queues_lock);
-		nvme_tcp_cpu_queues[queue->io_cpu]--;
-		spin_unlock(&nvme_tcp_cpu_queues_lock);
-	}
+	spin_lock(&nvme_tcp_cpu_queues_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags))
+		nvme_tcp_cpu_queues[nvme_tcp_queue_io_cpu(queue)]--;
+	spin_unlock(&nvme_tcp_cpu_queues_lock);
 
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
@@ -2306,6 +2433,11 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	/* the parallel queue setup below adds the queue directories */
+	ret = nvme_queue_dir_create(ctrl);
+	if (ret)
+		return ret;
+
 	if (new) {
 		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
 				&nvme_tcp_mq_ops,
@@ -2893,7 +3025,8 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 
 	if (!llist_empty(&queue->req_list))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 }
 
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.55.0


