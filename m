Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC38C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e6BcCL3vOh9/llYOa6IFwVuoWFl+P/VnevUdKHS76T8=; b=Xds4rYk7KZWsR120zi7JLiE3gR
	JN4G84noLRwS+cugGTy+e6grvzIikghDyb3DYsig5+/6x5TjjgF1P+M7+v8KnUfaPdpAh84HaFEfT
	/7y3gfCS4GJmQvs2W/VUXXFSqz6vT32JvBgtXbVtDdwmAZqpOmc6Hng7/kCKd70UExgLNcR001ZnG
	34UqRMNv5/Zfro69cVUxX5a3H2R9gdJmFSF5r1vWeWAS9PJgqzanE9/ZTne6suc34T1hYycRLLg2X
	4ccMbS7EUle00C0GkU//v2zgl8M5dQprwiH8t2rb6ly7vUfy0e4A42tMh7uAFLuUEVhoje2SOG+G5
	RY7KU7cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO2S-00000005vfb-1xy5;
	Wed, 26 Jun 2024 08:30:00 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO2P-00000005ve2-1OFD
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:29:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e6BcC
	L3vOh9/llYOa6IFwVuoWFl+P/VnevUdKHS76T8=; b=AEUzDkzMSvOY7c2p4ShNY
	1GknHjIstMWAgbHJD8CsZ5X3b6NfHn1Mpv+aMOutS2z7ywkp7ux0j0cArTZo1ucn
	G3UxZhgy7KbTy92j7hi+/lONOU4JG/zJ0DJvKSqAc+MzfDzhSEnlUgvH+leti0az
	9/5sGOABferwD2KDj/NOPk=
Received: from localhost.localdomain (unknown [139.226.176.191])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3__Ve0XtmGuclAg--.42928S4;
	Wed, 26 Jun 2024 16:29:30 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 2/2] nvmet-tcp: add polling task for nvmet-tcp
Date: Wed, 26 Jun 2024 16:28:23 +0800
Message-Id: <20240626082823.48326-3-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240626082823.48326-1-jacky_gam_2001@163.com>
References: <20240626082823.48326-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3__Ve0XtmGuclAg--.42928S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWrAFWUAw13WrWxZr1rXrb_yoW8XF4DWo
	WfXF45Jr1kCw1rKayFvF13tFy8uan7ta9Yyrn8CF45WF17t3yru34akw13X34UWa18tr17
	XayxAF1Sqw4ktF1kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RGeHqUUUUU
X-Originating-IP: [139.226.176.191]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEA4KKWXAloDqVQAAsx
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012957_791721_ED2B5F5A 
X-CRM114-Status: GOOD (  23.24  )
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

To add dedicated polling tasks versus kworker to handle tcp's IO
for nvmet-tcp module. And we have three module parametes:
  task_num is to define number of polling task.
  core_affinity is to define which cpu core will be begun to use.
  idle_peroid is to define task's polling time before go to idle.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/tcp.c | 356 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 339 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..aa6d90f8d11c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -73,6 +73,20 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
+/* Define the target tcp polling thread's affinity cpu core.
+ */
+static int pt_affinity_core = -2;
+module_param(pt_affinity_core, int, 0644);
+MODULE_PARM_DESC(pt_affinity_core,
+	    "target tcp polling thread's affinity core, -1 for all online cpus");
+
+/* Define the polling thread number.
+ */
+static int pt_num;
+module_param(pt_num, int, 0644);
+MODULE_PARM_DESC(pt_num, "target tcp polling thread number");
+static bool tcp_polling_task;
+
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 /*
  * TLS handshake timeout
@@ -106,6 +120,25 @@ enum {
 	NVMET_TCP_F_INIT_FAILED = (1 << 0),
 };
 
+struct nvmet_tcp_pt_data {
+	struct wait_queue_head	wait_head;
+	struct mutex		queue_lock;
+	struct list_head	pt_queue_list;
+	struct list_head	pt_io_queue_list;
+	struct list_head	addon_queue_list;
+	struct mutex		addon_queue_lock;
+	u32		thread_idle;
+	int		affinity_cpu;
+	pid_t			task_pid;
+	pid_t			task_tgid;
+	atomic64_t		queue_cnt;
+	atomic64_t		io_queue_cnt;
+	struct task_struct *thread;
+	struct mutex	   thread_lock;
+};
+
+struct nvmet_tcp_pt_data **tcp_pt_data;
+
 struct nvmet_tcp_cmd {
 	struct nvmet_tcp_queue		*queue;
 	struct nvmet_req		req;
@@ -150,6 +183,9 @@ struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
 	struct work_struct	io_work;
+	struct nvmet_tcp_pt_data *pt_data;
+	struct list_head	pt_list_entry;
+	atomic64_t		req_cnt;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
 	struct kref		kref;
@@ -218,6 +254,46 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
 
+static void nvmet_tcp_wakeup_poll_thread(struct nvmet_tcp_queue *queue)
+{
+	smp_mb();
+	if (queue->pt_data && waitqueue_active(&queue->pt_data->wait_head))
+		wake_up(&queue->pt_data->wait_head);
+}
+
+static int nvmet_tcp_get_polling_task(void)
+{
+	int i = 1, ret = 0;
+	s64 min, tmp, totalq_min, totalq_tmp;
+	struct nvmet_tcp_pt_data *tptd;
+
+	tptd = tcp_pt_data[0];
+	min = atomic64_read(&tptd->io_queue_cnt);
+	totalq_min = atomic64_read(&tptd->queue_cnt);
+	while (i < pt_num) {
+		tptd = tcp_pt_data[i];
+		tmp = atomic64_read(&tptd->io_queue_cnt);
+		totalq_tmp = atomic64_read(&tptd->queue_cnt);
+		if (min > tmp || (min == tmp && totalq_min > totalq_tmp)) {
+			min = tmp;
+			totalq_min = totalq_tmp;
+			ret = i;
+		}
+		i++;
+	}
+	tptd = tcp_pt_data[ret];
+	atomic64_inc(&tptd->queue_cnt);
+	return ret;
+}
+
+static inline void nvmet_tcp_pq_clear_req(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_pt_data *tptd = queue->pt_data;
+	mutex_lock(&tptd->queue_lock);
+	list_del(&queue->pt_list_entry);
+	mutex_unlock(&tptd->queue_lock);
+}
+
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
 {
@@ -590,7 +666,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	if (tcp_polling_task) {
+		atomic64_set(&queue->req_cnt, 1);
+		nvmet_tcp_wakeup_poll_thread(queue);
+	} else {
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	}
 }
 
 static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
@@ -1598,13 +1679,21 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 
 	nvmet_tcp_restore_socket_callbacks(queue);
 	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
-	cancel_work_sync(&queue->io_work);
+	if (!tcp_polling_task)
+		cancel_work_sync(&queue->io_work);
+	else {
+		nvmet_tcp_pq_clear_req(queue);
+		if (queue->nvme_sq.qid != 0)
+			atomic64_dec(&queue->pt_data->io_queue_cnt);
+		atomic64_dec(&queue->pt_data->queue_cnt);
+	}
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
-	cancel_work_sync(&queue->io_work);
+	if (!tcp_polling_task)
+		cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	/* ->sock will be released by fput() */
 	fput(queue->sock->file);
@@ -1627,9 +1716,15 @@ static void nvmet_tcp_data_ready(struct sock *sk)
 	if (likely(queue)) {
 		if (queue->data_ready)
 			queue->data_ready(sk);
-		if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
-			queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
-				      &queue->io_work);
+		if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
+			if (tcp_polling_task) {
+				atomic64_set(&queue->req_cnt, 1);
+				nvmet_tcp_wakeup_poll_thread(queue);
+			} else {
+				queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
+					      &queue->io_work);
+			}
+		}
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1650,7 +1745,12 @@ static void nvmet_tcp_write_space(struct sock *sk)
 
 	if (sk_stream_is_writeable(sk)) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		if (tcp_polling_task) {
+			atomic64_set(&queue->req_cnt, 1);
+			nvmet_tcp_wakeup_poll_thread(queue);
+		} else {
+			queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		}
 	}
 out:
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1731,7 +1831,19 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 		sock->sk->sk_write_space = nvmet_tcp_write_space;
 		if (idle_poll_period_usecs)
 			nvmet_tcp_arm_queue_deadline(queue);
-		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		if (tcp_polling_task) {
+			int task_index = nvmet_tcp_get_polling_task();
+			queue->pt_data = tcp_pt_data[task_index];
+			write_unlock_bh(&sock->sk->sk_callback_lock);
+			mutex_lock(&queue->pt_data->addon_queue_lock);
+			list_add_tail(&queue->pt_list_entry, &queue->pt_data->addon_queue_list);
+			mutex_unlock(&queue->pt_data->addon_queue_lock);
+			write_lock_bh(&sock->sk->sk_callback_lock);
+			atomic64_set(&queue->req_cnt, 1);
+			nvmet_tcp_wakeup_poll_thread(queue);
+		} else {
+			queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+		}
 	}
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 
@@ -1883,7 +1995,8 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	}
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
-	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
+	if (!tcp_polling_task)
+		INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	kref_init(&queue->kref);
 	queue->sock = newsock;
 	queue->port = port;
@@ -2146,6 +2259,15 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 	}
 
 	queue->nr_cmds = sq->size * 2;
+	if (tcp_polling_task) {
+		if (queue->state == NVMET_TCP_Q_DISCONNECTING)
+			return 0; // if release worker schedule, directly return
+		if (sq->qid != 0) {
+			atomic64_inc(&queue->pt_data->io_queue_cnt);
+			list_del(&queue->pt_list_entry);
+			list_add_tail(&queue->pt_list_entry, &queue->pt_data->pt_io_queue_list);
+		}
+	}
 	if (nvmet_tcp_alloc_cmds(queue))
 		return NVME_SC_INTERNAL;
 	return 0;
@@ -2193,14 +2315,181 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
-static int __init nvmet_tcp_init(void)
+static int __nvmet_tcp_poll_thread(struct nvmet_tcp_pt_data *tptd)
+{
+	int rcv_ret = 0, snd_ret = 0, ops = 0;
+	bool need_repoll = false;
+	struct nvmet_tcp_queue *qreq, *tmp;
+
+	mutex_lock(&tptd->addon_queue_lock);
+	mutex_lock(&tptd->queue_lock);
+	list_splice_tail_init(&tptd->addon_queue_list, &tptd->pt_queue_list);
+	mutex_unlock(&tptd->queue_lock);
+	mutex_unlock(&tptd->addon_queue_lock);
+
+	mutex_lock(&tptd->queue_lock);
+	if (!list_empty(&tptd->pt_queue_list)) {
+		list_for_each_entry_safe(qreq, tmp, &tptd->pt_queue_list, pt_list_entry) {
+			if (atomic64_read(&qreq->req_cnt) > 0) {
+				rcv_ret = nvmet_tcp_try_recv(qreq, NVMET_TCP_RECV_BUDGET, &ops);
+				if (rcv_ret < 0) {
+					atomic64_set(&qreq->req_cnt, 0);
+					continue;
+				}
+				if (rcv_ret > 0)
+					need_repoll = true;
+				snd_ret = nvmet_tcp_try_send(qreq, NVMET_TCP_SEND_BUDGET, &ops);
+				if (snd_ret < 0) {
+					atomic64_set(&qreq->req_cnt, 0);
+					continue;
+				}
+				if (snd_ret > 0)
+					need_repoll = true;
+				else if (rcv_ret == 0)
+					atomic64_set(&qreq->req_cnt, 0);
+			}
+		}
+	}
+	if (!list_empty(&tptd->pt_io_queue_list)) {
+		list_for_each_entry_safe(qreq, tmp, &tptd->pt_io_queue_list, pt_list_entry) {
+			if (atomic64_read(&qreq->req_cnt) > 0) {
+				rcv_ret = nvmet_tcp_try_recv(qreq, NVMET_TCP_RECV_BUDGET, &ops);
+				if (rcv_ret < 0) {
+					atomic64_set(&qreq->req_cnt, 0);
+					continue;
+				}
+				if (rcv_ret > 0)
+					need_repoll = true;
+				snd_ret = nvmet_tcp_try_send(qreq, NVMET_TCP_SEND_BUDGET, &ops);
+				if (snd_ret < 0) {
+					atomic64_set(&qreq->req_cnt, 0);
+					continue;
+				}
+				if (snd_ret > 0)
+					need_repoll = true;
+				else if (rcv_ret == 0)
+					atomic64_set(&qreq->req_cnt, 0);
+			}
+		}
+	}
+	mutex_unlock(&tptd->queue_lock);
+	if (need_repoll)
+		return 1;
+	else
+		return 0;
+}
+
+static int nvmet_tcp_poll_thread(void *data)
 {
-	int ret;
+	struct nvmet_tcp_pt_data *tptd = data;
+	unsigned long timeout = 0;
+	DEFINE_WAIT(wait);
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
-	if (!nvmet_tcp_wq)
-		return -ENOMEM;
+	if (tptd->affinity_cpu != -1)
+		set_cpus_allowed_ptr(current, cpumask_of(tptd->affinity_cpu));
+	else
+		set_cpus_allowed_ptr(current, cpu_online_mask);
+	current->flags |= PF_NO_SETAFFINITY;
+	mutex_lock(&tptd->thread_lock);
+	tptd->task_pid = current->pid;
+	tptd->task_tgid = current->tgid;
+
+	while (!kthread_should_stop()) {
+		int ret = __nvmet_tcp_poll_thread(tptd);
+		if (ret > 0 || !time_after(jiffies, timeout)) {
+			cond_resched();
+			if (ret > 0)
+				timeout = jiffies + tptd->thread_idle;
+			continue;
+		}
+		prepare_to_wait(&tptd->wait_head, &wait, TASK_INTERRUPTIBLE);
+		mutex_unlock(&tptd->thread_lock);
+		schedule();
+		mutex_lock(&tptd->thread_lock);
+		finish_wait(&tptd->wait_head, &wait);
+		timeout = jiffies + tptd->thread_idle;
+	}
+	tptd->thread = NULL;
+	tptd->task_pid = -1;
+	tptd->task_tgid = -1;
+	mutex_unlock(&tptd->thread_lock);
+	kthread_complete_and_exit(NULL, 0);
+	//do_exit(0);
+}
+
+static int __init nvmet_tcp_init(void)
+{
+	int ret, i = 0;
+	char task_name[TASK_COMM_LEN];
+	struct task_struct *task;
+
+	tcp_polling_task = false;
+	if ((pt_affinity_core >= -1 &&
+		pt_affinity_core < (int)nr_cpu_ids) || pt_num > 0) {
+		if (pt_num == 0)
+			pt_num = 1;
+		else if (pt_num < 0) {
+			printk(KERN_ERR "bad parameter for task num\n");
+			ret =  -EINVAL;
+			return ret;
+		}
+		if (pt_affinity_core == -2)
+			pt_affinity_core = -1;
+		if (pt_affinity_core < -1 ||
+			pt_affinity_core >= (int)nr_cpu_ids) {
+			printk(KERN_ERR "bad parameter for affinity core \n");
+			ret =  -EINVAL;
+			return ret;
+		}
+		if (!(idle_poll_period_usecs > 0))
+			idle_poll_period_usecs = 1000; // default 1ms
+		tcp_pt_data = kmalloc(pt_num * sizeof(void *), GFP_KERNEL);
+		if (!tcp_pt_data)
+			return -ENOMEM;
+
+		for (i = 0; i < pt_num; i++) {
+			tcp_pt_data[i] = kmalloc(sizeof(struct nvmet_tcp_pt_data), GFP_KERNEL);
+			if (!tcp_pt_data[i]) {
+				ret = -ENOMEM;
+				goto err_free_pqtd;
+			}
+		}
+		for (i = 0; i < pt_num; i++) {
+			mutex_init(&tcp_pt_data[i]->thread_lock);
+			tcp_pt_data[i]->thread_idle = usecs_to_jiffies(idle_poll_period_usecs);
+			mutex_init(&tcp_pt_data[i]->queue_lock);
+			mutex_init(&tcp_pt_data[i]->addon_queue_lock);
+			INIT_LIST_HEAD(&tcp_pt_data[i]->pt_queue_list);
+			INIT_LIST_HEAD(&tcp_pt_data[i]->pt_io_queue_list);
+			INIT_LIST_HEAD(&tcp_pt_data[i]->addon_queue_list);
+			init_waitqueue_head(&tcp_pt_data[i]->wait_head);
+			atomic64_set(&tcp_pt_data[i]->queue_cnt, 0);
+			atomic64_set(&tcp_pt_data[i]->io_queue_cnt, 0);
+			if (pt_affinity_core != -1)
+				tcp_pt_data[i]->affinity_cpu = (pt_affinity_core + (int)i) %
+								((int) nr_cpu_ids);
+			else
+				tcp_pt_data[i]->affinity_cpu = -1;
+			snprintf(task_name, TASK_COMM_LEN, "nvmet-tcp-pt%u", i);
+			task = kthread_create(nvmet_tcp_poll_thread, (void *)tcp_pt_data[i], task_name);
+			if (IS_ERR(task)) {
+				ret = PTR_ERR(task);
+				goto err;
+			}
+			set_user_nice(task, -20);
+			mutex_lock(&tcp_pt_data[i]->thread_lock);
+			tcp_pt_data[i]->thread = task;
+			mutex_unlock(&tcp_pt_data[i]->thread_lock);
+		}
+		tcp_polling_task = true;
+		for (i = 0; i <  pt_num; i++)
+			wake_up_process(tcp_pt_data[i]->thread);
+	} else {
+		nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+		if (!nvmet_tcp_wq)
+			return -ENOMEM;
+	}
 
 	ret = nvmet_register_transport(&nvmet_tcp_ops);
 	if (ret)
@@ -2208,15 +2497,42 @@ static int __init nvmet_tcp_init(void)
 
 	return 0;
 err:
-	destroy_workqueue(nvmet_tcp_wq);
+	if ((pt_affinity_core >= -1 &&
+		pt_affinity_core < (int)nr_cpu_ids) || pt_num > 0) {
+		while (i > 0) {
+			kthread_stop(tcp_pt_data[i-1]->thread);
+			i--;
+		}
+		i = pt_num;
+err_free_pqtd:
+		while (i > 0) {
+			kfree(tcp_pt_data[i-1]);
+			i--;
+		}
+		kfree(tcp_pt_data);
+	} else {
+		destroy_workqueue(nvmet_tcp_wq);
+	}
 	return ret;
 }
 
 static void __exit nvmet_tcp_exit(void)
 {
 	struct nvmet_tcp_queue *queue;
+	int i = 0;
 
 	nvmet_unregister_transport(&nvmet_tcp_ops);
+	if (tcp_polling_task) {
+		for (i = 0; i < pt_num; i++) {
+			mutex_lock(&tcp_pt_data[i]->thread_lock);
+			if (tcp_pt_data[i]->thread) {
+				mutex_unlock(&tcp_pt_data[i]->thread_lock);
+				kthread_stop(tcp_pt_data[i]->thread);
+			} else  {
+				mutex_unlock(&tcp_pt_data[i]->thread_lock);
+			}
+		}
+	}
 
 	flush_workqueue(nvmet_wq);
 	mutex_lock(&nvmet_tcp_queue_mutex);
@@ -2225,7 +2541,13 @@ static void __exit nvmet_tcp_exit(void)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 	flush_workqueue(nvmet_wq);
 
-	destroy_workqueue(nvmet_tcp_wq);
+	if (tcp_polling_task) {
+		for (i = 0; i < pt_num; i++)
+			kfree(tcp_pt_data[i]);
+		kfree(tcp_pt_data);
+	} else {
+		destroy_workqueue(nvmet_tcp_wq);
+	}
 	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
-- 
2.26.2


