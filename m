Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32231C30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/cXET2St5Z8IIkwJucSBod5ZKQXzHGuOYIljqwqLug=; b=bZ+BFxcQYWWouEPNCOr8VO7NGA
	hYi0PVGlkh9lzdoIQQMVdPemCvwKi8NpZCcuXNijiCpzmZrOqHl9bEslRcH2sb73dwjdrTKH5ZXcg
	iCbQFBXiz1J9ZdIXnStJSMDSFU9+eFmgfpfU2vHW2GWN2mFvNbZPmN/xLB3iBiPyFH7CMO0UmrjYV
	UcKyA3RldW8aIztXcZDs0NNwUXfoDuCbNUjQN6R4/gxCxgnPXUa5wzFUKKK7EMgxQoJabd9TiQAi9
	6vDcl0oHtSwnrdr5/LrU41hA+DJyuYK7zosdfe+ihiL04qfLnxN6aArDy7O43EuKUoCX50obumdke
	jbNuA3lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO2J-00000005vcj-3KE0;
	Wed, 26 Jun 2024 08:29:51 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO2G-00000005vbT-3alm
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=z/cXE
	T2St5Z8IIkwJucSBod5ZKQXzHGuOYIljqwqLug=; b=FayOYwZw/ZvRUilHqTqVd
	hS5XRjdB5mHzdaB9zavhqROJPRAGdORleA7x4pXfprFfzK/gMlL1LU91nZ25Z+zw
	0Zib8+qsrQi47zXaPQD3Aa+6v6K2nluHrSe50TftY1Y6GUH0lwKBTd0eHi8vOQdN
	yb4dDUwLszWr/iTEnfBu6o=
Received: from localhost.localdomain (unknown [139.226.176.191])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3__Ve0XtmGuclAg--.42928S3;
	Wed, 26 Jun 2024 16:29:27 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 1/2] nvmet-rdma: add polling cq task for nvmet-rdma
Date: Wed, 26 Jun 2024 16:28:22 +0800
Message-Id: <20240626082823.48326-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240626082823.48326-1-jacky_gam_2001@163.com>
References: <20240626082823.48326-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3__Ve0XtmGuclAg--.42928S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWrtr48ZF13Kw18ZFy5urg_yoW8GFy7to
	ZxXF45JFnYkw18Ja1FyanrtFy2va4qqFZ3ArsxCFs0gF1xJ3yrWr92kw15Xr18Ww1Iyr1U
	Wr4xuw1Sga1kXF1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTicTPRDUUUU
X-Originating-IP: [139.226.176.191]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKAAKKWXAl9atFAABsX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012949_280109_4E8E47C1 
X-CRM114-Status: GOOD (  24.29  )
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

To add dedicated polling cq tasks versus kworker for nvmet-rdma
module. And we have three module parametes:
 task_num is to define number of polling cq task.
 core_affinity is to define which cpu core will be begun to use.
 idle_peroid is to define task's polling time before go to idle.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
---
 drivers/nvme/target/rdma.c | 331 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 326 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1eff8ca6a5f1..83c03e088bf9 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -26,6 +26,28 @@
 #include <linux/nvme-rdma.h>
 #include "nvmet.h"
 
+/* Define a time period (in usecs) that poll thread shall sample an activated
+ * queue before determining it to be idle.
+ */
+static int idle_poll_period_usecs;
+module_param(idle_poll_period_usecs, int, 0644);
+MODULE_PARM_DESC(idle_poll_period_usecs,
+		"nvmet rdma cq thread poll till idle time period in usecs");
+
+/* Define the target rdma cq polling thread's affinity cpu core.
+ */
+static int pt_affinity_core = -2;
+module_param(pt_affinity_core, int, 0644);
+MODULE_PARM_DESC(pt_affinity_core,
+	    "target rdma cq polling thread's affinity core, -1 for all online cpus");
+
+/* Define the polling thread number.
+ */
+static int pt_num;
+module_param(pt_num, int, 0644);
+MODULE_PARM_DESC(pt_num, "target rdma cq polling thread number");
+bool rdma_polling_cq_task;
+
 /*
  * We allow at least 1 page, up to 4 SGEs, and up to 16KB of inline data
  */
@@ -39,6 +61,23 @@
 
 #define NVMET_RDMA_BACKLOG 128
 
+struct nvmet_rdma_pt_data {
+	struct wait_queue_head	wait_head;
+	struct mutex		queue_lock;
+	struct list_head	pt_admin_queue_list;
+	struct list_head	pt_io_queue_list;
+	u32		thread_idle;
+	int		affinity_cpu;
+	pid_t			task_pid;
+	pid_t			task_tgid;
+	atomic64_t		admin_queue_cnt;
+	atomic64_t		io_queue_cnt;
+	struct task_struct *thread;
+	struct mutex	   thread_lock;
+};
+
+struct nvmet_rdma_pt_data **rdma_pt_data;
+
 struct nvmet_rdma_srq;
 
 struct nvmet_rdma_cmd {
@@ -114,6 +153,10 @@ struct nvmet_rdma_queue {
 	int			send_queue_size;
 
 	struct list_head	queue_list;
+	//for cq poll thread
+	struct nvmet_rdma_pt_data *pt_data;
+	struct list_head	pt_list_entry;
+	atomic64_t		req_cnt;
 };
 
 struct nvmet_rdma_port {
@@ -176,6 +219,59 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
+static void nvmet_rdma_wakeup_poll_thread(struct nvmet_rdma_queue *queue)
+{
+	smp_mb();
+	if (queue->pt_data && waitqueue_active(&queue->pt_data->wait_head))
+		wake_up(&queue->pt_data->wait_head);
+}
+
+static void nvmet_rdma_ib_cq_handler(struct ib_cq *cq, void *private)
+{
+	struct nvmet_rdma_queue *queue = (struct nvmet_rdma_queue *)cq->cq_context;
+	atomic64_set(&queue->req_cnt, 1);
+	nvmet_rdma_wakeup_poll_thread(queue);
+}
+
+static int nvmet_rdma_get_pcq_task(bool io_queue)
+{
+	int i = 1, ret = 0;
+	s64 min, tmp;
+	struct nvmet_rdma_pt_data *tptd;
+
+	tptd = rdma_pt_data[0];
+	if (io_queue)
+		min = atomic64_read(&tptd->io_queue_cnt);
+	else
+		min = atomic64_read(&tptd->admin_queue_cnt);
+	while (i < pt_num) {
+		tptd = rdma_pt_data[i];
+		if (io_queue)
+			tmp = atomic64_read(&tptd->io_queue_cnt);
+		else
+			tmp = atomic64_read(&tptd->admin_queue_cnt);
+		if (min > tmp) {
+			min = tmp;
+			ret = i;
+		}
+		i++;
+	}
+	tptd = rdma_pt_data[ret];
+	if (io_queue)
+		atomic64_inc(&tptd->io_queue_cnt);
+	else
+		atomic64_inc(&tptd->admin_queue_cnt);
+	return ret;
+}
+
+static inline void nvmet_rdma_pq_clear_req(struct nvmet_rdma_queue *queue)
+{
+	struct nvmet_rdma_pt_data *tptd = queue->pt_data;
+	mutex_lock(&tptd->queue_lock);
+	list_del(&queue->pt_list_entry);
+	mutex_unlock(&tptd->queue_lock);
+}
+
 static int srq_size_set(const char *val, const struct kernel_param *kp)
 {
 	int n = 0, ret;
@@ -507,6 +603,10 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 
 	if (unlikely(ret))
 		pr_err("post_recv cmd failed\n");
+	else if (rdma_polling_cq_task) {
+		atomic64_set(&cmd->queue->req_cnt, 1);
+		nvmet_rdma_wakeup_poll_thread(cmd->queue);
+	}
 
 	return ret;
 }
@@ -740,6 +840,9 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 	if (unlikely(ib_post_send(cm_id->qp, first_wr, NULL))) {
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
+	} else if (rdma_polling_cq_task) {
+		atomic64_set(&rsp->queue->req_cnt, 1);
+		nvmet_rdma_wakeup_poll_thread(rsp->queue);
 	}
 }
 
@@ -816,6 +919,9 @@ static void nvmet_rdma_write_data_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(ib_post_send(cm_id->qp, &rsp->send_wr, NULL))) {
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
+	} else if (rdma_polling_cq_task) {
+		atomic64_set(&rsp->queue->req_cnt, 1);
+		nvmet_rdma_wakeup_poll_thread(rsp->queue);
 	}
 }
 
@@ -957,6 +1063,10 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 		if (rdma_rw_ctx_post(&rsp->rw, queue->qp,
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
+		if (rdma_polling_cq_task) {
+			atomic64_set(&queue->req_cnt, 1);
+			nvmet_rdma_wakeup_poll_thread(queue);
+		}
 	} else {
 		rsp->req.execute(&rsp->req);
 	}
@@ -1259,8 +1369,16 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
-				   queue->comp_vector, IB_POLL_WORKQUEUE);
+	if (rdma_polling_cq_task) {
+		queue->cq = ib_alloc_cq(ndev->device, queue, nr_cqe + 1,
+						queue->comp_vector, IB_POLL_DIRECT);
+		queue->cq->comp_handler = nvmet_rdma_ib_cq_handler;
+		ib_req_notify_cq(queue->cq, IB_CQ_NEXT_COMP);
+	} else {
+		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
+						queue->comp_vector, IB_POLL_WORKQUEUE);
+	}
+
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
@@ -1331,8 +1449,11 @@ static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
 	if (queue->cm_id)
 		rdma_destroy_id(queue->cm_id);
 	ib_destroy_qp(queue->qp);
-	ib_cq_pool_put(queue->cq, queue->recv_queue_size + 2 *
-		       queue->send_queue_size + 1);
+	if (rdma_polling_cq_task)
+		ib_free_cq(queue->cq);
+	else
+		ib_cq_pool_put(queue->cq, queue->recv_queue_size + 2 *
+			       queue->send_queue_size + 1);
 }
 
 static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
@@ -1340,6 +1461,13 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 	pr_debug("freeing queue %d\n", queue->idx);
 
 	nvmet_sq_destroy(&queue->nvme_sq);
+	if (rdma_polling_cq_task) {
+		nvmet_rdma_pq_clear_req(queue);
+		if (queue->host_qid > 0)
+			atomic64_dec(&queue->pt_data->io_queue_cnt);
+		else
+			atomic64_dec(&queue->pt_data->admin_queue_cnt);
+	}
 
 	nvmet_rdma_destroy_queue_ib(queue);
 	if (!queue->nsrq) {
@@ -1600,6 +1728,19 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		goto free_queue;
 	}
 
+	if (rdma_polling_cq_task) {
+		bool io_queue = queue->host_qid > 0?1:0;
+		ret = nvmet_rdma_get_pcq_task(io_queue);
+		queue->pt_data = rdma_pt_data[ret];
+		mutex_lock(&queue->pt_data->queue_lock);
+		if (io_queue)
+			list_add_tail(&queue->pt_list_entry, &queue->pt_data->pt_io_queue_list);
+		else
+			list_add_tail(&queue->pt_list_entry, &queue->pt_data->pt_admin_queue_list);
+		mutex_unlock(&queue->pt_data->queue_lock);
+		nvmet_rdma_wakeup_poll_thread(queue);
+	}
+
 	mutex_lock(&nvmet_rdma_queue_mutex);
 	list_add_tail(&queue->queue_list, &nvmet_rdma_queue_list);
 	mutex_unlock(&nvmet_rdma_queue_mutex);
@@ -2082,9 +2223,156 @@ static struct ib_client nvmet_rdma_ib_client = {
 	.remove = nvmet_rdma_remove_one
 };
 
+#define RDMA_POLL_BUDGET   8
+static int __nvmet_rdma_poll_thread(struct nvmet_rdma_pt_data *rptd)
+{
+	int rcv_ret = 0;
+	bool need_repoll = false;
+	struct nvmet_rdma_queue *qreq, *tmp;
+
+	mutex_lock(&rptd->queue_lock);
+	if (!list_empty(&rptd->pt_admin_queue_list)) {
+		list_for_each_entry_safe(qreq, tmp, &rptd->pt_admin_queue_list, pt_list_entry) {
+			if (atomic64_read(&qreq->req_cnt) > 0) {
+				rcv_ret = ib_process_cq_direct(qreq->cq, RDMA_POLL_BUDGET);
+				if (rcv_ret > 0)
+					need_repoll = true;
+				else {
+					atomic64_set(&qreq->req_cnt, 0);
+					ib_req_notify_cq(qreq->cq, IB_CQ_NEXT_COMP);
+				}
+			}
+		}
+	}
+	if (!list_empty(&rptd->pt_io_queue_list)) {
+		list_for_each_entry_safe(qreq, tmp, &rptd->pt_io_queue_list, pt_list_entry) {
+			if (atomic64_read(&qreq->req_cnt) > 0) {
+				rcv_ret = ib_process_cq_direct(qreq->cq, RDMA_POLL_BUDGET);
+				if (rcv_ret > 0)
+					need_repoll = true;
+				else {
+					atomic64_set(&qreq->req_cnt, 0);
+					ib_req_notify_cq(qreq->cq, IB_CQ_NEXT_COMP);
+				}
+			}
+		}
+	}
+	mutex_unlock(&rptd->queue_lock);
+	if (need_repoll)
+		return 1;
+	else
+		return 0;
+}
+
+static int nvmet_rdma_poll_thread(void *data)
+{
+	struct nvmet_rdma_pt_data *rptd = data;
+	unsigned long timeout = 0;
+	DEFINE_WAIT(wait);
+
+	if (rptd->affinity_cpu != -1)
+		set_cpus_allowed_ptr(current, cpumask_of(rptd->affinity_cpu));
+	else
+		set_cpus_allowed_ptr(current, cpu_online_mask);
+	current->flags |= PF_NO_SETAFFINITY;
+	mutex_lock(&rptd->thread_lock);
+	rptd->task_pid = current->pid;
+	rptd->task_tgid = current->tgid;
+
+	while (!kthread_should_stop()) {
+		int ret = __nvmet_rdma_poll_thread(rptd);
+		if (ret > 0 || !time_after(jiffies, timeout)) {
+			cond_resched();
+			if (ret > 0)
+				timeout = jiffies + rptd->thread_idle;
+			continue;
+		}
+		prepare_to_wait(&rptd->wait_head, &wait, TASK_INTERRUPTIBLE);
+		mutex_unlock(&rptd->thread_lock);
+		schedule();
+		mutex_lock(&rptd->thread_lock);
+		finish_wait(&rptd->wait_head, &wait);
+		timeout = jiffies + rptd->thread_idle;
+	}
+	rptd->thread = NULL;
+	rptd->task_pid = -1;
+	rptd->task_tgid = -1;
+	mutex_unlock(&rptd->thread_lock);
+	kthread_complete_and_exit(NULL, 0);
+	//do_exit(0);
+}
+
 static int __init nvmet_rdma_init(void)
 {
-	int ret;
+	int ret, i;
+	char task_name[TASK_COMM_LEN];
+	struct task_struct *task;
+
+	rdma_polling_cq_task = false;
+	if ((pt_affinity_core >= -1 && pt_affinity_core < (int)nr_cpu_ids)
+		|| pt_num > 0 || idle_poll_period_usecs > 0) {
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
+		if (idle_poll_period_usecs == 0)
+			idle_poll_period_usecs = 1000; // default 1ms
+		else if (idle_poll_period_usecs < 0) {
+			printk(KERN_ERR "bad parameter for idle poll period\n");
+			ret =  -EINVAL;
+			return ret;
+		}
+		rdma_pt_data = kmalloc(pt_num * sizeof(void *), GFP_KERNEL);
+		if (!rdma_pt_data)
+			return -ENOMEM;
+
+		for (i = 0; i < pt_num; i++) {
+			rdma_pt_data[i] = kmalloc(sizeof(struct nvmet_rdma_pt_data), GFP_KERNEL);
+			if (!rdma_pt_data[i]) {
+				ret = -ENOMEM;
+				goto err_free_pqtd;
+			}
+		}
+		for (i = 0; i < pt_num; i++) {
+			mutex_init(&rdma_pt_data[i]->thread_lock);
+			rdma_pt_data[i]->thread_idle = usecs_to_jiffies(idle_poll_period_usecs);
+			mutex_init(&rdma_pt_data[i]->queue_lock);
+			INIT_LIST_HEAD(&rdma_pt_data[i]->pt_admin_queue_list);
+			INIT_LIST_HEAD(&rdma_pt_data[i]->pt_io_queue_list);
+			init_waitqueue_head(&rdma_pt_data[i]->wait_head);
+			atomic64_set(&rdma_pt_data[i]->admin_queue_cnt, 0);
+			atomic64_set(&rdma_pt_data[i]->io_queue_cnt, 0);
+			if (pt_affinity_core != -1)
+				rdma_pt_data[i]->affinity_cpu = (pt_affinity_core + (int)i) %
+								((int) nr_cpu_ids);
+			else
+				rdma_pt_data[i]->affinity_cpu = -1;
+			snprintf(task_name, TASK_COMM_LEN, "nvmet-rdma-pt%u", i);
+			task = kthread_create(nvmet_rdma_poll_thread, (void *)rdma_pt_data[i], task_name);
+			if (IS_ERR(task)) {
+				ret = PTR_ERR(task);
+				goto err_free_pt_data;
+			}
+			set_user_nice(task, -20);
+			mutex_lock(&rdma_pt_data[i]->thread_lock);
+			rdma_pt_data[i]->thread = task;
+			mutex_unlock(&rdma_pt_data[i]->thread_lock);
+		}
+		rdma_polling_cq_task = true;
+		for (i = 0; i <  pt_num; i++)
+			wake_up_process(rdma_pt_data[i]->thread);
+	}
 
 	ret = ib_register_client(&nvmet_rdma_ib_client);
 	if (ret)
@@ -2098,15 +2386,48 @@ static int __init nvmet_rdma_init(void)
 
 err_ib_client:
 	ib_unregister_client(&nvmet_rdma_ib_client);
+err_free_pt_data:
+	if ((pt_affinity_core >= -1 && pt_affinity_core < (int)nr_cpu_ids)
+		|| pt_num > 0 || idle_poll_period_usecs > 0) {
+		while (i > 0) {
+			kthread_stop(rdma_pt_data[i-1]->thread);
+			i--;
+		}
+		i = pt_num;
+err_free_pqtd:
+		while (i > 0) {
+			kfree(rdma_pt_data[i-1]);
+			i--;
+		}
+		kfree(rdma_pt_data);
+	}
 	return ret;
 }
 
 static void __exit nvmet_rdma_exit(void)
 {
+	int i = 0;
+
+	if (rdma_polling_cq_task) {
+		for (i = 0; i < pt_num; i++) {
+			mutex_lock(&rdma_pt_data[i]->thread_lock);
+			if (rdma_pt_data[i]->thread) {
+				mutex_unlock(&rdma_pt_data[i]->thread_lock);
+				kthread_stop(rdma_pt_data[i]->thread);
+			} else  {
+				mutex_unlock(&rdma_pt_data[i]->thread_lock);
+			}
+		}
+	}
 	nvmet_unregister_transport(&nvmet_rdma_ops);
 	ib_unregister_client(&nvmet_rdma_ib_client);
 	WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));
 	ida_destroy(&nvmet_rdma_queue_ida);
+	if (rdma_polling_cq_task) {
+		for (i = 0; i < pt_num; i++)
+			kfree(rdma_pt_data[i]);
+		kfree(rdma_pt_data);
+	}
 }
 
 module_init(nvmet_rdma_init);
-- 
2.26.2


