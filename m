Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A07606A32C
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PELMkcko;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=iGyU+cLd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=m/8w58ySIKmCiZy/+4e3smLZvXWGxkmmnxT4ufJv2eI=; b=PELMkckoraZSgt
	29OFpRAYXMrdpbIxBc0rJu63V9HGL5DfO0yH04xuAcgHqqA/WSYlmMu0LdFAhH3QEfa8ke5rHqt9s
	OeAlB7+faU7Ad33omqCf7Kzi0Ro33y+ESoka3coXlem4y5UdWYY5cBG7yyYMtoLb1k/S0YZJX42zo
	MoBYGpO4AL5kitheTTS+Cv8k+EQOgnN0v3yz9slufNktJUYE3LvhcH6Ac5vBcQjovHQT9ZBlkGcaP
	88gcgyilzxYjLshZrO1LfUkopZT2SBn3GILl2Pn4tZonZCpR2jj6i/i+hoxeBHcM3O1mRZ02HoMrY
	RqIjNnlhtgI+k2gIf1Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPd7X-0000000ERQu-3Cty;
	Sat, 07 Nov 2026 09:53:59 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPd7Q-0000000EROz-1Z1H
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 09:53:53 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so13303045e9.2
        for <linux-nvme@lists.infradead.org>; Sat, 07 Nov 2026 01:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1794045230; x=1794650030; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/8w58ySIKmCiZy/+4e3smLZvXWGxkmmnxT4ufJv2eI=;
        b=iGyU+cLdjmHUpiG2SJ4G1g/g2Toq/YgP4pIm5VlTRLfxZCBM4fFCJd3kUlRB0SX++O
         75RKsvQetwbr4NkL+vt7pII94RjLU5RUrh1JfhlPU9LaSa34Hk9mHzadz6rWAdje04Vq
         N5tWzJ8exukT1oZALKZFltgvu25nwDdgSlIzrkFhgDYOX/pgzZMBobBM25+eY8z/2hBZ
         H5f5EDV9LGhdihM/86dljK9xCzEErv2vcZzY31Vp+FfkADwAcbNluy4ZlZKA2onNVN3B
         yV6RSjPMsML/+yICbLZlK6S1d1HoNYkSD0UHaVK5Zr8Jc9TRnRvvNAWO0dgUfiT3yBFG
         Wccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045230; x=1794650030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/8w58ySIKmCiZy/+4e3smLZvXWGxkmmnxT4ufJv2eI=;
        b=XUVzQwqKmU6LADzlMk/KnaY15OhVNEfhsyY/RYykeUWDR1hDscUFIxGZoiG1+tJ17Z
         L99jvp80H03fiP2ct/a8HUD705N4Bk04CwJddKCwoygexB1C+1tYj+Ti99Do4BWCtgtt
         0vddbzfscg3g0WJ/qRy95c1xsK+a5Ene5JkmsjMU8yjwXTXJ73Y4dylkGuBma0mc0Koi
         pQJuDTaM3GNfTdBZEoZOePOgrRYIuOKhIVk1dT2zIXB08jnrFM7p8InZ3i4zF12dDSpV
         OQvG11Ctzxw9+AwSaYt59OkTd/Gq8JABqxyQmVv3YRWm13t52jzIyuuw34CxGT9Fl9FN
         ud1w==
X-Gm-Message-State: APuU4Z9ImdIQNZWt1bO+7rRkU0ARqCmiPJbEGDtLrml/uGmd8ibecL+t
	Y9LOr8nV+GCmyP+NyKE6QwIiVTNH68rB74XnC5wwUB+q/dO1cOlgMEavJGSjuj+LhjhTWEjx9oY
	lpvepOXZfsQ==
X-Gm-Gg: AYBFou1w9sKYPz+UwtzmN4VabNkM2BbjpHK3EHQmbp2snmGU3HT8cs8l7xJ1s7YdbI2
	KY3Lq2fEal1+ppjnD+bDdlpclpxdTr/S90FTA9UkExjWDF8/0WHxtTKERrkR5zHi8Dqic1kgmdN
	KPc71Zm0SoSqEIfwRw2ltb6DlYC1lorjONDMa+yrRKiSdkRawtrMrrjOvyawdVsfNd5wn+aqoh/
	Nq3EOiQXqT9YdNCUfy+pGTqYkKsNPQqQ0XKshJ80Vu2RGQz3zX92t/OLbR0hfxzFmyBoG+VtUrq
	YoL6MN2E2cYdiPdK6NZ9KGwsIfRNFORXoZb6hOQ8+DJXrI2gLxmD0ni9xuw7Pega7JuIFrs9rrs
	ZArQLxl6L/LKkM+i2g92+A5iaM4jVm015AxYM7JSdbjfxE2bLd8b+m/VigpxsnLkoI+nL9oK4AA
	9sFZosiCadldbHWqdcvZkM3Pq5djB0/7nB08iOL3wHhi59Q2v/+Me6+hEZJwL7AGVP/GvFh6ZLR
	iguD9keqbaUau841ok2Ub8SypqUEyWTB6w31cEbaiuV077SqrqKaeTR0/a2MXcKyKi4HMRKv1A7
	brzIlAkC9Ri7aEOWK4XpHcNipl0s/KsTntBMOKIdTX4vaGv71gYh4bYRfvq3PyhADG0blp0yjA=
	=
X-Received: by 2002:a05:600c:c106:b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4b6ed5b8fe7mr65339295e9.23.1794045230493;
        Sat, 07 Nov 2026 01:53:50 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([185.57.101.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm37607545e9.4.2026.11.07.01.53.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 01:53:50 -0800 (PST)
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
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v8 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Sat,  7 Nov 2026 09:53:37 +0000
Message-ID: <394e47d486979175bc5ebb94c789db8bfacb1736.1794015622.git.saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794015622.git.saravanand@crusoe.ai>
References: <cover.1794015622.git.saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_015352_560377_13252A5F 
X-CRM114-Status: GOOD (  27.04  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

A queue's directory is added once the connect time selection has set its
io_cpu, so readers never see a placement that is about to change, and
removed when the queue is freed, before it is torn down, so a sysfs
store never runs on a freed queue. All io_cpu writes, from
sysfs and from the driver, serialize with the accounting under
nvme_tcp_cpu_queues_lock, while the I/O paths read io_cpu locklessly.
The queue stop now clears NVME_TCP_Q_IO_CPU_SET under that lock, since a
sysfs store may move io_cpu in between.

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
 Documentation/ABI/stable/sysfs-nvme |  31 ++++++
 drivers/nvme/host/tcp.c             | 167 ++++++++++++++++++++++++----
 2 files changed, 178 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index 1826df9161d2..b9d1d0f87686 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -502,3 +502,34 @@ Contact:	Hannes Reinecke <hare@suse.de>
 Description:
 		Shows the subsystem type. Possible values: "discovery",
 		"nvm", "reserved".
+
+What:		/sys/class/nvme/nvmeX/queues/<qid>/io_cpu
+What:		/sys/class/nvme/nvmeX/queues/<qid>/managed
+Date:		November 2026
+KernelVersion:	7.5
+Contact:	Saravanan D <saravanand@crusoe.ai>
+Description:
+		Per I/O queue directories, populated by the transport
+		backing the controller. A directory appears once the
+		driver has selected the queue's CPU at connect time and
+		is removed when the queue is torn down, so the
+		directories follow the queue count and are absent while
+		the controller reconnects.
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
index 2587db92a3a2..b681fb44ce42 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -117,6 +117,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_IO_CPU_USER	= 4,
 };
 
 #define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
@@ -167,6 +168,7 @@ struct nvme_tcp_queue {
 	struct completion       tls_complete;
 	int                     tls_err;
 	struct page_frag_cache	pf_cache;
+	struct nvme_queue_info	*qinfo;
 
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
@@ -256,6 +258,19 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
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
@@ -453,7 +468,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * lockdep reports circular locking via elevator_lock.  Defer TLS
 	 * sends to the io workqueue instead of inline from this path.
 	 */
-	if (queue->io_cpu == raw_smp_processor_id() &&
+	if (nvme_tcp_queue_io_cpu(queue) == raw_smp_processor_id() &&
 	    !nvme_tcp_queue_tls(queue) &&
 	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
@@ -461,7 +476,8 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	}
 
 	if (last && nvme_tcp_queue_has_pending(queue))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 }
 
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -870,7 +886,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	nvme_tcp_setup_h2c_data_pdu(req);
 
 	llist_add(&req->lentry, &queue->req_list);
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+		      &queue->io_work);
 
 	return 0;
 }
@@ -1157,7 +1174,8 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
 	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1172,7 +1190,8 @@ static void nvme_tcp_write_space(struct sock *sk)
 		/* Ensure pending TLS partial records are retried */
 		if (nvme_tcp_queue_tls(queue))
 			queue->write_space(sk);
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1515,7 +1534,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+		      &queue->io_work);
 }
 
 static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
@@ -1549,9 +1569,22 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1883,8 +1916,18 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
@@ -1894,10 +1937,9 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
 
 	if (WARN_ON(!mq_map))
-		goto out;
+		goto out_unlock;
 
 	/* Search for the least used cpu from the mq_map */
-	spin_lock(&nvme_tcp_cpu_queues_lock);
 	io_cpu = WORK_CPU_UNBOUND;
 	for_each_online_cpu(cpu) {
 		int num_queues = nvme_tcp_cpu_queues[cpu];
@@ -1910,14 +1952,14 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
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
@@ -2030,6 +2072,84 @@ static void nvme_tcp_exit_queue(struct nvme_tcp_ctrl *ctrl, int qid)
 	mutex_destroy(&queue->pf_cache_lock);
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
+	qinfo = nvme_add_queue_info(nctrl, nvme_tcp_queue_id(queue), queue);
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
@@ -2087,7 +2207,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
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
@@ -2194,11 +2318,10 @@ static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
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
@@ -2261,6 +2384,8 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
+		/* expose io_cpu only once the driver has selected it */
+		nvme_tcp_add_queue_sysfs(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	} else
 		ret = nvmf_connect_admin_queue(nctrl);
@@ -3057,7 +3182,8 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 
 	if (!llist_empty(&queue->req_list))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(nvme_tcp_queue_io_cpu(queue), nvme_tcp_wq,
+			      &queue->io_work);
 }
 
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -3160,6 +3286,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.name			= "tcp",
 	.module			= THIS_MODULE,
 	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
+	.queue_attr_groups	= nvme_tcp_queue_groups,
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-- 
2.56.0


