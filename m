Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DFEC3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+IQ7UXBZQjRagkDEIhU0WEdC+fZWkr8yfVFv8Dl1exQ=; b=AMoUqX1QmevepUeMzBicHXKFnK
	IJBNKUaKRQE+sFsMoSsrminPiI30FXhhzwTmnNViKl3UANoNVD80Zqzv2/7kQJSX4K1TUH0KRp7QQ
	zyB1spYtH6NmbGPUgGnDbiTpJFz1LyzqhJD7+A+fJ/bEBp25kzbYHnwwD22zz8HPrfxdxrJCp6bbF
	S1ey/b7McoO6oFm5T00p5nrsC0wg6w+mVtFopkHl9bA0NiqsLBHAqwsYfTh75C5jL4d1EruOkxd7y
	a1PeEibYMeZhxHXkwGuM3oF0IqxdxSpK8WC4oXd73e5NJc0HA5BAHNlyVe8ff5g2tNIAgvfwdojyY
	7FHR4NVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjv-00000009by7-1IJw;
	Tue, 16 Jul 2024 07:36:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjp-00000009bt3-2MSe
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D118660ADE;
	Tue, 16 Jul 2024 07:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A4C4AF0B;
	Tue, 16 Jul 2024 07:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115400;
	bh=/N+7MVvKP10etEt+ADpxL61ETf4IN8GtuELMRoAETdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGQmtNDuOVXRQ6J8zgfD70vK/+BUpUijSxwINyMw8fampCLqhB35oTegOxQ+qCVas
	 HWjir8SbtwHskbtO2K/ot0eTXhO+rSCTJWEJ6whafRXlM7Tk2kxLsXS3R7A/Yq8A4W
	 kUfG2hMP+K5V02T/LBVm6YBdYVQgZP/GVBGwa3ZZZtMFs8LQgC5wKvbRfDRt0lkh3X
	 T1zVo0YJ30OYAhupQfF9WH8CDVrw4svXMQb97hWPHbCqslvIGZvs61/Lj+CNaNycPB
	 IYw3MtDgf5UF8Po3S3EHKmC5BiT3WfIqVT400EjJ+eNvgmjDcesXe5jaS01zFIgTPW
	 TraTSoVF7zffQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/8] nvme-tcp: debugfs entries for latency statistics
Date: Tue, 16 Jul 2024 09:36:13 +0200
Message-Id: <20240716073616.84417-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003641_780169_905925E7 
X-CRM114-Status: GOOD (  22.56  )
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

From: Hannes Reinecke <hare@suse.de>

Add debugfs entries to display latency statistics:
'send_lat' displays the average latency for sendmsg() calls,
'recv_lat' the average latency for '->read_sock()' calls,
'write_space' the number of 'write_space' callbacks,
'data_ready' the number of 'data_ready' callbacks,
and 'queue_busy' the number -EAGAIN returns from sendmsg().

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 253 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 249 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9caee99955c2..a758fbb3f9bb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -21,6 +21,8 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#include <linux/debugfs.h>
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -139,6 +141,13 @@ enum nvme_tcp_recv_state {
 	NVME_TCP_RECV_DDGST,
 };
 
+struct nvme_tcp_stat {
+	u64 samples;
+	u64 batch;
+	s64 mean;
+	u64 sqmean;
+};
+
 struct nvme_tcp_ctrl;
 struct nvme_tcp_queue {
 	struct socket		*sock;
@@ -164,6 +173,14 @@ struct nvme_tcp_queue {
 	/* send state */
 	struct nvme_tcp_request *request;
 
+	/* statistics */
+	struct dentry		*debugfs_dir;
+	u64			data_ready_cnt;
+	u64			write_space_cnt;
+	u64			queue_busy_cnt;
+	struct nvme_tcp_stat	send_lat;
+	struct nvme_tcp_stat	recv_lat;
+
 	u32			maxh2cdata;
 	size_t			cmnd_capsule_len;
 	struct nvme_tcp_ctrl	*ctrl;
@@ -198,6 +215,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct dentry           *debugfs_dir;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -207,10 +225,163 @@ struct nvme_tcp_ctrl {
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
+static struct dentry *nvme_tcp_debugfs;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
+static void nvme_tcp_stat_add(struct nvme_tcp_stat *stat, u64 start)
+{
+	u64 usec;
+	s64 delta, delta2;
+
+	usec = ktime_to_us(ktime_get());
+	if (usec < start)
+		return;
+	usec -= start;
+	/* Count in nanoseconds to improve precision */
+	usec *= 1000;
+	stat->batch += usec;
+	/* Welford's algorithm */
+	stat->samples++;
+	delta = (s64)usec - stat->mean;
+	stat->mean += div_s64(delta, (s64)stat->samples);
+	delta2 = (s64)usec - stat->mean;
+	stat->sqmean += (u64)(delta * delta2);
+}
+
+#define NVME_TCP_DEBUGFS_ATTR(field)				       \
+       static int field##_open(struct inode *inode, struct file *file) \
+       { return single_open(file, field##_show, inode->i_private); }   \
+								       \
+       static const struct file_operations field##_fops = {	       \
+	       .open = field##_open,				       \
+	       .read = seq_read,				       \
+	       .release = single_release,			       \
+       }
+
+#define NVME_TCP_DEBUGFS_RW_ATTR(field)					\
+	static int field##_open(struct inode *inode, struct file *file) \
+	{ return single_open(file, field##_show, inode->i_private); }	\
+									\
+	static const struct file_operations field##_fops = {		\
+		.open = field##_open,					\
+		.read = seq_read,					\
+		.write = field##_write,					\
+		.release = single_release,				\
+	}
+
+static int nvme_tcp_queue_data_ready_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_queue *queue = m->private;
+
+	seq_printf(m, "%llu\n", queue->data_ready_cnt);
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_queue_data_ready);
+
+static int nvme_tcp_queue_write_space_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_queue *queue = m->private;
+
+	seq_printf(m, "%llu\n", queue->write_space_cnt);
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_queue_write_space);
+
+static int nvme_tcp_queue_queue_busy_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_queue *queue = m->private;
+
+	seq_printf(m, "%llu\n", queue->queue_busy_cnt);
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_queue_queue_busy);
+
+static int nvme_tcp_queue_recv_lat_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_queue *queue = m->private;
+	struct nvme_tcp_stat *st = &queue->recv_lat;
+	u64 var = 0;
+
+	if (st->samples > 1)
+		var = div_u64(st->sqmean, st->samples * 1000);
+
+	seq_printf(m, "%llu %llu %u\n",
+		   st->samples, div_u64(st->batch, st->samples * 1000), int_sqrt64(var));
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_queue_recv_lat);
+
+static int nvme_tcp_queue_send_lat_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_queue *queue = m->private;
+	struct nvme_tcp_stat *st = &queue->send_lat;
+	u64 var = 0;
+
+	if (st->samples > 1)
+		var = div_u64(st->sqmean, st->samples * 1000);
+
+	seq_printf(m, "%llu %llu %u\n",
+		   st->samples, div_u64(st->batch, st->samples * 1000), int_sqrt64(var));
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_queue_send_lat);
+
+static int nvme_tcp_ctrl_recv_lat_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_ctrl *ctrl = m->private;
+	struct nvme_tcp_stat *st, lat;
+	u64 mean = 0, var = 0;
+	int i;
+
+	lat.samples = 0;
+	lat.mean = 0;
+	lat.sqmean = 0;
+	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+		st = &ctrl->queues[i].recv_lat;
+		lat.mean += st->mean;
+		lat.sqmean += st->sqmean;
+		lat.samples += st->samples;
+	}
+	if (lat.samples > 1) {
+		mean = lat.mean;
+		var = int_sqrt(div_u64(lat.sqmean, lat.samples));
+	}
+
+	seq_printf(m, "%llu %llu %llu\n",
+		   lat.samples, mean, var);
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_ctrl_recv_lat);
+
+static int nvme_tcp_ctrl_send_lat_show(struct seq_file *m, void *p)
+{
+	struct nvme_tcp_ctrl *ctrl = m->private;
+	struct nvme_tcp_stat *st, lat;
+	u64 mean = 0, var = 0;
+	int i;
+
+	lat.samples = 0;
+	lat.mean = 0;
+	lat.sqmean = 0;
+	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+		st = &ctrl->queues[i].send_lat;
+		lat.mean += st->mean;
+		lat.sqmean += st->sqmean;
+		lat.samples += st->samples;
+	}
+	if (lat.samples > 1) {
+		mean = lat.mean;
+		var = int_sqrt(div_u64(lat.sqmean, lat.samples));
+	}
+
+	seq_printf(m, "%llu %llu %llu\n",
+		   lat.samples, mean, var);
+	return 0;
+}
+NVME_TCP_DEBUGFS_ATTR(nvme_tcp_ctrl_send_lat);
+
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
 	return container_of(ctrl, struct nvme_tcp_ctrl, ctrl);
@@ -985,8 +1156,10 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
-	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
+	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue->data_ready_cnt++;
+	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -999,6 +1172,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue->write_space_cnt++;
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1067,6 +1241,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		bool last = nvme_tcp_pdu_last_send(req, len);
 		int req_data_sent = req->data_sent;
 		int ret;
+		u64 start;
 
 		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
 			msg.msg_flags |= MSG_EOR;
@@ -1079,7 +1254,9 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		bvec_set_page(&bvec, page, len, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 		queue->nr_send++;
+		start = ktime_to_us(ktime_get());
 		ret = sock_sendmsg(queue->sock, &msg);
+		nvme_tcp_stat_add(&queue->send_lat, start);
 		if (ret <= 0)
 			return ret;
 
@@ -1124,6 +1301,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
 	int ret;
+	u64 start;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
 		msg.msg_flags |= MSG_MORE;
@@ -1136,7 +1314,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 	queue->nr_send++;
+	start = ktime_to_us(ktime_get());
 	ret = sock_sendmsg(queue->sock, &msg);
+	nvme_tcp_stat_add(&queue->send_lat, start);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1165,6 +1345,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
+	u64 start;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
@@ -1175,7 +1356,9 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 	queue->nr_send++;
+	start = ktime_to_us(ktime_get());
 	ret = sock_sendmsg(queue->sock, &msg);
+	nvme_tcp_stat_add(&queue->send_lat, start);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1202,6 +1385,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 		.iov_base = (u8 *)&req->ddgst + req->offset,
 		.iov_len = NVME_TCP_DIGEST_LENGTH - req->offset
 	};
+	u64 start;
 
 	if (nvme_tcp_queue_more(queue))
 		msg.msg_flags |= MSG_MORE;
@@ -1209,7 +1393,9 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 		msg.msg_flags |= MSG_EOR;
 
 	queue->nr_send++;
+	start = ktime_to_us(ktime_get());
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
+	nvme_tcp_stat_add(&queue->send_lat, start);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1263,6 +1449,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 		ret = nvme_tcp_try_send_ddgst(req);
 done:
 	if (ret == -EAGAIN) {
+		queue->queue_busy_cnt++;
 		ret = 0;
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -1281,13 +1468,16 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	struct sock *sk = sock->sk;
 	read_descriptor_t rd_desc;
 	int consumed;
+	u64 start;
 
 	rd_desc.arg.data = queue;
 	rd_desc.count = 1;
 	lock_sock(sk);
 	queue->nr_cqe = 0;
 	queue->nr_recv = 0;
+	start = ktime_to_us(ktime_get());
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	nvme_tcp_stat_add(&queue->recv_lat, start);
 	release_sock(sk);
 	return consumed;
 }
@@ -1331,11 +1521,18 @@ static void nvme_tcp_io_work(struct work_struct *w)
 check:
 	overrun = ktime_to_us(ktime_get()) - start;
 	if (overrun > 10 * deadline) {
+		u64 slat = 0, clat = 0;
+
+		if (queue->send_lat.samples)
+			slat = queue->send_lat.mean;
+		if (queue->recv_lat.samples)
+			clat = queue->recv_lat.mean;
 		dev_dbg(queue->ctrl->ctrl.device,
-			"queue %d: stall (%llu msecs) send %u sqe %u recv %u cqe %u%s%s\n",
+			"queue %d: stall (%llu msecs), send %u lat %llu %u sqes, recv %u lat %llu %u cqes%s%s\n",
 			nvme_tcp_queue_id(queue), div_u64(overrun, 1000),
-			queue->nr_send, queue->nr_sqe, queue->nr_recv, queue->nr_cqe,
-			list_empty(&queue->send_list) ? " empty" : "", queue->request ? " pending" : "");
+			queue->nr_send, slat, queue->nr_sqe, queue->nr_recv, clat, queue->nr_cqe,
+			list_empty(&queue->send_list) ? " empty" : "",
+			queue->request ? " pending" : "");
 	}
 	if (pending)
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
@@ -1408,6 +1605,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
+	if (queue->debugfs_dir) {
+		debugfs_remove_recursive(queue->debugfs_dir);
+		queue->debugfs_dir = NULL;
+	}
+
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
@@ -1696,6 +1898,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
+	char queue_name[32];
 
 	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
@@ -1756,6 +1959,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	queue->ddgst_remaining = 0;
 	queue->pdu_remaining = 0;
 	queue->pdu_offset = 0;
+	queue->write_space_cnt = 0;
+	queue->data_ready_cnt = 0;
+	queue->queue_busy_cnt = 0;
+	memset(&queue->recv_lat, 0, sizeof(struct nvme_tcp_stat));
+	memset(&queue->send_lat, 0, sizeof(struct nvme_tcp_stat));
 	sk_set_memalloc(queue->sock->sk);
 
 	if (nctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
@@ -1802,6 +2010,19 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		goto err_crypto;
 	}
 
+	sprintf(queue_name, "%d", nvme_tcp_queue_id(queue));
+	queue->debugfs_dir = debugfs_create_dir(queue_name, ctrl->debugfs_dir);
+	debugfs_create_file("recv_lat", S_IRUSR, queue->debugfs_dir,
+			    queue, &nvme_tcp_queue_recv_lat_fops);
+	debugfs_create_file("send_lat", S_IRUSR, queue->debugfs_dir,
+			    queue, &nvme_tcp_queue_send_lat_fops);
+	debugfs_create_file("data_ready", S_IRUSR, queue->debugfs_dir,
+			    queue, &nvme_tcp_queue_data_ready_fops);
+	debugfs_create_file("write_space", S_IRUSR, queue->debugfs_dir,
+			    queue, &nvme_tcp_queue_write_space_fops);
+	debugfs_create_file("queue_busy", S_IRUSR, queue->debugfs_dir,
+			    queue, &nvme_tcp_queue_queue_busy_fops);
+
 	dev_dbg(nctrl->device, "connecting queue %d\n",
 			nvme_tcp_queue_id(queue));
 
@@ -2420,7 +2641,14 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
+	struct nvme_tcp_ctrl *nctrl = to_tcp_ctrl(ctrl);
+
 	nvme_tcp_teardown_ctrl(ctrl, true);
+
+	if (nctrl->debugfs_dir) {
+		debugfs_remove_recursive(nctrl->debugfs_dir);
+		nctrl->debugfs_dir = NULL;
+	}
 }
 
 static void nvme_reset_ctrl_work(struct work_struct *work)
@@ -2890,6 +3118,13 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_put_ctrl;
 
+	ctrl->debugfs_dir = debugfs_create_dir(dev_name(ctrl->ctrl.device),
+					       nvme_tcp_debugfs);
+	debugfs_create_file("recv_lat", S_IRUSR, ctrl->debugfs_dir,
+			    ctrl, &nvme_tcp_ctrl_recv_lat_fops);
+	debugfs_create_file("send_lat", S_IRUSR, ctrl->debugfs_dir,
+			    ctrl, &nvme_tcp_ctrl_send_lat_fops);
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		WARN_ON_ONCE(1);
 		ret = -EINTR;
@@ -2910,6 +3145,10 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	return &ctrl->ctrl;
 
 out_uninit_ctrl:
+	if (ctrl->debugfs_dir) {
+		debugfs_remove_recursive(ctrl->debugfs_dir);
+		ctrl->debugfs_dir = NULL;
+	}
 	nvme_uninit_ctrl(&ctrl->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&ctrl->ctrl);
@@ -2951,6 +3190,10 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	nvme_tcp_debugfs = debugfs_create_dir("nvme_tcp", NULL);
+	if (!nvme_tcp_debugfs)
+		return -ENOMEM;
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
@@ -2961,6 +3204,8 @@ static void __exit nvme_tcp_cleanup_module(void)
 
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
+	debugfs_remove_recursive(nvme_tcp_debugfs);
+
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
 		nvme_delete_ctrl(&ctrl->ctrl);
-- 
2.35.3


