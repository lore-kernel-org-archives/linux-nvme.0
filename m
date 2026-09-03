Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226F4C61DD3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XTDi0xyTPH8eeLeBZD/5BQ45qzAoeryEAVjalCqzLTQ=; b=DOHZcXliGoirmGMbE1LPIsQ7k3
	rCEs92wPLXpclmfAEYHjHBtUVkrf7BK/Khzwk9XrNvtPB07452OU8SZ49Oc7Qq3M90Ewvv2IXjdmf
	tnrI5gsEn+8jqAXzPg2zQ9F6+JvItMaL7Ujl5JBMip07oh8gRjSO22rsaWwMYtdshCxAvkUhNnEC9
	uifz0F5x2Gfe5camgWQhe38kIwYsxy/nmPhNnp+cUH1iXsfe+plTJD6YgnTiBFh+YxTz7YZ/x9M0K
	DWvKqmw0qC1V58Mczp0mJKe/xvu6pj+Sc+qwn0HsbkOVcwlcIF45VBtNkQPrTsmnNPMSeCv9wUqNX
	WuItDPvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x29Kx-000000000Wi-0wEb;
	Thu, 03 Sep 2026 15:26:47 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x29Ku-000000000VW-3AOx
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 15:26:46 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683D9RG2119460
	for <linux-nvme@lists.infradead.org>; Thu, 3 Sep 2026 08:26:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=XTDi0xyTP
	H8eeLeBZD/5BQ45qzAoeryEAVjalCqzLTQ=; b=E6EAMk2GNgMxh0Hm83lfe38TS
	wkryw92oM3WftmkMg/JZ7He8sP2lxEuN07HhCDpFOkyxA1/ocH5UUyaGyLg1odhU
	+g21bidjjT2lkcg6S8bZVkiLcJrEwy06qO7O6XdvJYJ9fv4qw1bGK+mwza9kmmz8
	VdlKOC0HH7UGsBBRunAM3gfJ7dWNBrSTSF29cakE0rjfsuejw9r79MleGx+MCtws
	ROvUT79SIoNpSs0TQIkIzsdcuVH7NIQOZW7O5sM48Xbakrvbus4gmGnNi8LB/Rct
	jONd26VdbDjCSExuIkYF+NUaGUvYuDpebg4qwVS9GwV7p1pFIF55ZRo7R1jCg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ge3dmewhu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2026 08:26:42 -0700 (PDT)
Received: from twshared23629.02.snb1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 3 Sep 2026 15:26:40 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A9DAF29E1B4D2; Thu,  3 Sep 2026 08:26:25 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
Date: Thu, 3 Sep 2026 08:26:23 -0700
Message-ID: <20260903152623.614951-1-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ifi3n2qa c=1 sm=1 tr=0 ts=6a9991b2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=nVwpz7-RfWlUkJvaclcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzNCBTYWx0ZWRfX32yb4vhIsfkk
 mdavP0c+lDlPNLFKWHswLfEA37i25qKRXHsUbnKY1zO0h58E+jgu7LOjgn0hxvGaaZX2AkvIXHX
 Jc6Lk1YAgO3A577eVCvI4JtgWz3QBa0=
X-Proofpoint-GUID: piR7bwTE_BVEu7BKiAZKm37Mt0bVrHtm
X-Proofpoint-ORIG-GUID: piR7bwTE_BVEu7BKiAZKm37Mt0bVrHtm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzNCBTYWx0ZWRfX3c1QWIJPc9KV
 E1GjSb7jRFXGh3+eT8mwE2uzOMQQkc8/BRJhtJP4VqNrUcsVhaF2Pa5bnBDcWGiZFr/Qzztz8Gv
 n4a8zGMNTsmxTtMTSEkrR0hNurMblp1eNTqcJoRgzjsMv3ahn3bBplb+G+/C3JZeUoFJoPHe7Ze
 UcqWiWnwR+EAbqmb6ZNrWVWvlQ6avb9VFaM9Ug7dpqTUwImh6nHBp3tP/m0alBBOOSMjT4xg3x3
 b8iGKWp+oN7nslNEDrVQ4/Cbf85JIUuNBZDMUQrVHlIEK6ABX4m9XzwR/T6L3666RuYogOgV3kB
 ws4Da60+oaNSJ1v6qyo+RhPmfB3KQGiaCYk6NZaLNH4n9nf8n5jGKwIlWYRt2Aw8bDBuu0+rJKI
 sj4o/ATlJsHUEIu3V77w7ZRK4VsXKk/g+PYEt4EFBIeZJyvEjXQ+70wx3ZdwNj/N/vJfOfwQvs6
 Cw8/JDL+PZmwDHQBNYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_082644_932324_829CC568 
X-CRM114-Status: GOOD (  31.11  )
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

From: Keith Busch <kbusch@kernel.org>

We've observed many workloads may burst large amounts of IO from a one
thread, which has the nvme tcp driver queue all the work onto a single
socket and serialized by a single CPU. We can hit a CPU bottleneck
before saturating the link when this happens.

Provide an option to ask for more queues for each blk-mq hctx. The
option is provided in the nvme-fabrics connection string by appending
"queues_per_hctx=3DN", where N is the number of queues you want to share
each hctx. The nvme tcp driver will group those queues under that hctx
and perform a simple round-robin to dispatch the requests and subsequent
work. The workqueue provided for this is always unbounded, and we
provide the CPU hint from the original dispatching CPU in order to
maintain locality for the completion side.

The default is the pre-existing 1 queue per hctx, so this patch should
be a no-op if you don't explicitly opt into this feature.

Testing with a very capable NIC, a high bandwith workload of QD16 1MB
reads improved from 7GB/s on the default settings to 24GB/s with 4
queues per hctx.

For a more IOPs intensive workload, a QD64 4k random read test improved
from 184k to 252k.

This also gets a tighter grouping on application observed latency,
significantly bringing in the P99 outliers.

On the down side, there is a minor regression on low depth workloads.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
One potential subtlety here, this relies on the tcp queue connection's
existing behavior today, which serializes the sequence. There is a
proposal to parallelize that process and would break this.

 drivers/nvme/host/core.c    |  13 +-
 drivers/nvme/host/fabrics.c |  15 ++
 drivers/nvme/host/fabrics.h |  11 +-
 drivers/nvme/host/nvme.h    |   2 +
 drivers/nvme/host/tcp.c     | 267 ++++++++++++++++++++++++++++--------
 5 files changed, 248 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 758245c799a10..e5e8e4609003d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1194,11 +1194,15 @@ int __nvme_submit_sync_cmd(struct request_queue *=
q, struct nvme_command *cmd,
 		blk_flags |=3D BLK_MQ_REQ_NOWAIT;
 	if (flags & NVME_SUBMIT_RESERVED)
 		blk_flags |=3D BLK_MQ_REQ_RESERVED;
-	if (qid =3D=3D NVME_QID_ANY)
+	if (qid =3D=3D NVME_QID_ANY) {
 		req =3D blk_mq_alloc_request(q, nvme_req_op(cmd), blk_flags);
-	else
+	} else {
+		struct nvme_ctrl *ctrl =3D q->tag_set->driver_data;
+
+		/* the command names a transport queue, not a blk-mq hctx */
 		req =3D blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), blk_flags,
-						qid - 1);
+				(qid - 1) / ctrl->queues_per_hctx);
+	}
=20
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -5063,7 +5067,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, s=
truct blk_mq_tag_set *set,
 		set->flags |=3D BLK_MQ_F_BLOCKING;
 	set->cmd_size =3D cmd_size;
 	set->driver_data =3D ctrl;
-	set->nr_hw_queues =3D ctrl->queue_count - 1;
+	set->nr_hw_queues =3D (ctrl->queue_count - 1) / ctrl->queues_per_hctx;
 	set->timeout =3D NVME_IO_TIMEOUT;
 	set->nr_maps =3D nr_maps;
 	ret =3D blk_mq_alloc_tag_set(set);
@@ -5232,6 +5236,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
 	ctrl->ops =3D ops;
 	ctrl->quirks =3D quirks;
 	ctrl->numa_node =3D NUMA_NO_NODE;
+	ctrl->queues_per_hctx =3D 1;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 59f823dfbbccb..43ad240586ec8 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -694,6 +694,7 @@ static const match_table_t opt_tokens =3D {
 	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=3D%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=3D%d"	},
+	{ NVMF_OPT_QUEUES_PER_HCTX,	"queues_per_hctx=3D%d"	},
 	{ NVMF_OPT_TOS,			"tos=3D%d"		},
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_KEYRING,		"keyring=3D%d"		},
@@ -727,6 +728,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_option=
s *opts,
 	/* Set defaults */
 	opts->queue_size =3D NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues =3D num_online_cpus();
+	opts->queues_per_hctx =3D 1;
 	opts->reconnect_delay =3D NVMF_DEF_RECONNECT_DELAY;
 	opts->kato =3D 0;
 	opts->duplicate_connect =3D false;
@@ -975,6 +977,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_optio=
ns *opts,
 			}
 			opts->nr_poll_queues =3D token;
 			break;
+		case NVMF_OPT_QUEUES_PER_HCTX:
+			if (match_int(args, &token)) {
+				ret =3D -EINVAL;
+				goto out;
+			}
+			if (token <=3D 0 || token > NVMF_MAX_QUEUES_PER_HCTX) {
+				pr_err("Invalid queues_per_hctx %d\n", token);
+				ret =3D -EINVAL;
+				goto out;
+			}
+			opts->queues_per_hctx =3D token;
+			break;
 		case NVMF_OPT_TOS:
 			if (match_int(args, &token)) {
 				ret =3D -EINVAL;
@@ -1078,6 +1092,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_opti=
ons *opts,
 		opts->nr_io_queues =3D 0;
 		opts->nr_write_queues =3D 0;
 		opts->nr_poll_queues =3D 0;
+		opts->queues_per_hctx =3D 1;
 		opts->duplicate_connect =3D true;
 	} else {
 		if (!opts->kato)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d08332..69fccecd4901b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,8 +67,12 @@ enum {
 	NVMF_OPT_KEYRING	=3D 1 << 26,
 	NVMF_OPT_TLS_KEY	=3D 1 << 27,
 	NVMF_OPT_CONCAT		=3D 1 << 28,
+	NVMF_OPT_QUEUES_PER_HCTX =3D 1 << 29,
 };
=20
+/* Upper bound on transport queues backing a single blk-mq hctx. */
+#define NVMF_MAX_QUEUES_PER_HCTX	16
+
 /**
  * struct nvmf_ctrl_options - Used to hold the options specified
  *			      with the parsing opts enum.
@@ -109,6 +113,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @queues_per_hctx: transport queues backing each blk-mq hctx
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
  */
 struct nvmf_ctrl_options {
@@ -138,6 +143,7 @@ struct nvmf_ctrl_options {
 	bool			data_digest;
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
+	unsigned int		queues_per_hctx;
 	int			tos;
 	int			fast_io_fail_tmo;
 };
@@ -212,9 +218,10 @@ static inline void nvmf_complete_timed_out_request(s=
truct request *rq)
=20
 static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *o=
pts)
 {
-	return min(opts->nr_io_queues, num_online_cpus()) +
+	return (min(opts->nr_io_queues, num_online_cpus()) +
 		min(opts->nr_write_queues, num_online_cpus()) +
-		min(opts->nr_poll_queues, num_online_cpus());
+		min(opts->nr_poll_queues, num_online_cpus())) *
+		opts->queues_per_hctx;
 }
=20
 static inline unsigned long nvmf_get_virt_boundary(struct nvme_ctrl *ctr=
l,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf7404..5f92dba7aeca9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -355,6 +355,8 @@ struct nvme_ctrl {
 	int numa_node;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
+	/* transport queues per hctx; set before nvme_alloc_io_tag_set() */
+	unsigned int queues_per_hctx;
 	struct list_head namespaces;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 921934028e0b2..6b36fe9445466 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -105,7 +105,10 @@ struct nvme_tcp_ctrl;
 struct nvme_tcp_queue {
 	struct socket		*sock;
 	struct work_struct	io_work;
+	struct workqueue_struct	*wq;
 	int			io_cpu;
+	/* queue_work_on() cpu; only a pod hint on the unbound workqueue */
+	int			wq_cpu;
=20
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
@@ -151,6 +154,13 @@ struct nvme_tcp_queue {
 #endif
 };
=20
+/* the transport queues backing one blk-mq hctx, and their rotor */
+struct nvme_tcp_hctx {
+	struct nvme_tcp_queue	*queues;
+	unsigned int		nr;
+	atomic_t		rotor;
+};
+
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
=20
@@ -167,6 +177,9 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
=20
+	/* connection being established; relies on connects being serialized */
+	struct nvme_tcp_queue	*connect_queue;
+
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -174,6 +187,12 @@ struct nvme_tcp_ctrl {
 };
=20
 static struct workqueue_struct *nvme_tcp_wq;
+/*
+ * Grouped queues must run concurrently, so they go on an unbound workqu=
eue and
+ * let the scheduler place them within the pod.  Retunable via sysfs
+ * affinity_scope.
+ */
+static struct workqueue_struct *nvme_tcp_unbound_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
@@ -256,13 +275,15 @@ static inline bool nvme_tcp_tls_configured(struct n=
vme_ctrl *ctrl)
 	return ctrl->opts->tls || ctrl->opts->concat;
 }
=20
+/* A group shares one tag set, so a command id is unique across its queu=
es. */
 static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue =
*queue)
 {
 	u32 queue_idx =3D nvme_tcp_queue_id(queue);
=20
 	if (queue_idx =3D=3D 0)
 		return queue->ctrl->admin_tag_set.tags[queue_idx];
-	return queue->ctrl->tag_set.tags[queue_idx - 1];
+	return queue->ctrl->tag_set.tags[(queue_idx - 1) /
+					 queue->ctrl->ctrl.queues_per_hctx];
 }
=20
 static inline u8 nvme_tcp_hdgst_len(struct nvme_tcp_queue *queue)
@@ -400,6 +421,17 @@ static inline bool nvme_tcp_queue_more(struct nvme_t=
cp_queue *queue)
 		nvme_tcp_queue_has_pending(queue);
 }
=20
+/*
+ * A grouped queue never sends inline: contending for send_mutex and the=
 socket
+ * lock against every sibling io_work costs more than the handoff it sav=
es.
+ */
+static inline bool nvme_tcp_send_from_submitter(struct nvme_tcp_queue *q=
ueue)
+{
+	if (nvme_tcp_queue_id(queue) && queue->ctrl->ctrl.queues_per_hctx > 1)
+		return false;
+	return queue->io_cpu =3D=3D raw_smp_processor_id();
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool last)
 {
@@ -411,14 +443,14 @@ static inline void nvme_tcp_queue_request(struct nv=
me_tcp_request *req,
=20
 	/*
 	 * if we're the first on the send_list and we can try to send
-	 * directly, otherwise queue io_work. Also, only do that if we
-	 * are on the same cpu, so we don't introduce contention.
+	 * directly, otherwise queue io_work. Also, only do that if this
+	 * context may send, so we don't introduce contention.
 	 *
 	 * TLS kTLS send takes ctx->tx_lock while blk_mq holds set->srcu.
 	 * lockdep reports circular locking via elevator_lock.  Defer TLS
 	 * sends to the io workqueue instead of inline from this path.
 	 */
-	if (queue->io_cpu =3D=3D raw_smp_processor_id() &&
+	if (nvme_tcp_send_from_submitter(queue) &&
 	    !nvme_tcp_queue_tls(queue) &&
 	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
@@ -426,7 +458,7 @@ static inline void nvme_tcp_queue_request(struct nvme=
_tcp_request *req,
 	}
=20
 	if (last && nvme_tcp_queue_has_pending(queue))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
 }
=20
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
@@ -555,7 +587,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_se=
t *set,
 	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(set->driver_data);
 	struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
 	struct nvme_tcp_cmd_pdu *pdu;
-	int queue_idx =3D (set =3D=3D &ctrl->tag_set) ? hctx_idx + 1 : 0;
+	int queue_idx =3D (set =3D=3D &ctrl->tag_set) ?
+		hctx_idx * ctrl->ctrl.queues_per_hctx + 1 : 0;
 	struct nvme_tcp_queue *queue =3D &ctrl->queues[queue_idx];
 	u8 hdgst =3D nvme_tcp_hdgst_len(queue);
=20
@@ -577,24 +610,87 @@ static int nvme_tcp_init_request(struct blk_mq_tag_=
set *set,
 	return 0;
 }
=20
+static int nvme_tcp_alloc_hctx(struct blk_mq_hw_ctx *hctx,
+		struct nvme_tcp_queue *queues, unsigned int nr)
+{
+	struct nvme_tcp_hctx *qg;
+
+	qg =3D kzalloc_obj(*qg);
+	if (!qg)
+		return -ENOMEM;
+
+	qg->queues =3D queues;
+	qg->nr =3D nr;
+	hctx->driver_data =3D qg;
+	return 0;
+}
+
+/* The queues of a group are contiguous, starting at hctx_idx * nr + 1. =
*/
 static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
 	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(data);
-	struct nvme_tcp_queue *queue =3D &ctrl->queues[hctx_idx + 1];
+	unsigned int nr =3D ctrl->ctrl.queues_per_hctx;
=20
-	hctx->driver_data =3D queue;
-	return 0;
+	return nvme_tcp_alloc_hctx(hctx, &ctrl->queues[hctx_idx * nr + 1], nr);
 }
=20
+/* Only the I/O tag set groups queues; the admin queue is always alone. =
*/
 static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *da=
ta,
 		unsigned int hctx_idx)
 {
 	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(data);
-	struct nvme_tcp_queue *queue =3D &ctrl->queues[0];
=20
-	hctx->driver_data =3D queue;
-	return 0;
+	return nvme_tcp_alloc_hctx(hctx, &ctrl->queues[0], 1);
+}
+
+static void nvme_tcp_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int =
hctx_idx)
+{
+	kfree(hctx->driver_data);
+	hctx->driver_data =3D NULL;
+}
+
+/* Pick the queue of this hctx that the next request goes to. */
+static struct nvme_tcp_queue *nvme_tcp_hctx_queue(struct blk_mq_hw_ctx *=
hctx)
+{
+	struct nvme_tcp_hctx *qg =3D hctx->driver_data;
+	struct nvme_tcp_queue *queue;
+	unsigned int slot;
+
+	if (qg->nr =3D=3D 1)
+		return qg->queues;
+
+	/* connect_q fabrics commands belong to the connection coming up */
+	if (unlikely(!hctx->queue->queuedata)) {
+		struct nvme_tcp_queue *connect =3D
+			READ_ONCE(qg->queues->ctrl->connect_queue);
+
+		if (connect)
+			return connect;
+	}
+
+	slot =3D (unsigned int)atomic_inc_return_relaxed(&qg->rotor) % qg->nr;
+	queue =3D &qg->queues[slot];
+	queue->wq_cpu =3D raw_smp_processor_id();
+
+	return queue;
+}
+
+/*
+ * Kick every queue of the group with work pending: a batch is spread ac=
ross all
+ * of them, so kicking only the last request's queue leaves the others s=
itting.
+ */
+static void nvme_tcp_kick_hctx_queues(struct blk_mq_hw_ctx *hctx)
+{
+	struct nvme_tcp_hctx *qg =3D hctx->driver_data;
+	struct nvme_tcp_queue *queue =3D qg->queues;
+	unsigned int i;
+
+	for (i =3D 0; i < qg->nr; i++, queue++) {
+		if (nvme_tcp_queue_has_pending(queue))
+			queue_work_on(queue->wq_cpu, queue->wq,
+				      &queue->io_work);
+	}
 }
=20
 static enum nvme_tcp_recv_state
@@ -835,7 +931,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue =
*queue,
 	nvme_tcp_setup_h2c_data_pdu(req);
=20
 	llist_add(&req->lentry, &queue->req_list);
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
=20
 	return 0;
 }
@@ -1122,7 +1218,7 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	queue =3D sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
 	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
=20
@@ -1137,7 +1233,7 @@ static void nvme_tcp_write_space(struct sock *sk)
 		/* Ensure pending TLS partial records are retried */
 		if (nvme_tcp_queue_tls(queue))
 			queue->write_space(sk);
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1460,7 +1556,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
=20
 	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
=20
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
 }
=20
 static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
@@ -1712,9 +1808,11 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_=
tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl =3D queue->ctrl;
 	struct blk_mq_tag_set *set =3D &ctrl->tag_set;
+	unsigned int qph =3D ctrl->ctrl.queues_per_hctx;
 	int qid =3D nvme_tcp_queue_id(queue) - 1;
 	unsigned int *mq_map =3D NULL;
 	int cpu, min_queues =3D INT_MAX, io_cpu;
+	int hctx_idx;
=20
 	if (wq_unbound)
 		goto out;
@@ -1729,20 +1827,34 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme=
_tcp_queue *queue)
 	if (WARN_ON(!mq_map))
 		goto out;
=20
-	/* Search for the least used cpu from the mq_map */
+	hctx_idx =3D qid / qph;
 	io_cpu =3D WORK_CPU_UNBOUND;
-	for_each_online_cpu(cpu) {
-		int num_queues =3D atomic_read(&nvme_tcp_cpu_queues[cpu]);
=20
-		if (mq_map[cpu] !=3D qid)
-			continue;
-		if (num_queues < min_queues) {
-			io_cpu =3D cpu;
-			min_queues =3D num_queues;
+	if (qph > 1) {
+		/* the group names the hctx's cpu, only a pod hint */
+		for_each_online_cpu(cpu) {
+			if (mq_map[cpu] =3D=3D hctx_idx) {
+				io_cpu =3D cpu;
+				break;
+			}
+		}
+	} else {
+		/* Search for the least used cpu from the mq_map */
+		for_each_online_cpu(cpu) {
+			int num_queues =3D atomic_read(&nvme_tcp_cpu_queues[cpu]);
+
+			if (mq_map[cpu] !=3D hctx_idx)
+				continue;
+			if (num_queues < min_queues) {
+				io_cpu =3D cpu;
+				min_queues =3D num_queues;
+			}
 		}
 	}
+
 	if (io_cpu !=3D WORK_CPU_UNBOUND) {
 		queue->io_cpu =3D io_cpu;
+		queue->wq_cpu =3D io_cpu;
 		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
 		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
 	}
@@ -1850,6 +1962,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *n=
ctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	queue->wq =3D (qid && nctrl->queues_per_hctx > 1) ? nvme_tcp_unbound_wq=
 :
+							  nvme_tcp_wq;
 	mutex_init(&queue->pf_cache_lock);
=20
 	if (qid > 0)
@@ -1907,6 +2021,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *n=
ctrl, int qid,
 	queue->sock->sk->sk_allocation =3D GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag =3D false;
 	queue->io_cpu =3D WORK_CPU_UNBOUND;
+	queue->wq_cpu =3D WORK_CPU_UNBOUND;
 	queue->request =3D NULL;
 	queue->data_remaining =3D 0;
 	queue->ddgst_remaining =3D 0;
@@ -2086,7 +2201,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *n=
ctrl, int idx)
=20
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
+		WRITE_ONCE(ctrl->connect_queue, queue);
 		ret =3D nvmf_connect_io_queue(nctrl, idx);
+		WRITE_ONCE(ctrl->connect_queue, NULL);
 	} else
 		ret =3D nvmf_connect_admin_queue(nctrl);
=20
@@ -2226,8 +2343,9 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_c=
trl *ctrl)
=20
 static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
-	unsigned int nr_io_queues;
-	int ret;
+	u32 hctxs[HCTX_MAX_TYPES] =3D { };
+	unsigned int nr_io_queues, qph;
+	int ret, i;
=20
 	nr_io_queues =3D nvmf_nr_io_queues(ctrl->opts);
 	ret =3D nvme_set_queue_count(ctrl, &nr_io_queues);
@@ -2240,12 +2358,21 @@ static int nvme_tcp_alloc_io_queues(struct nvme_c=
trl *ctrl)
 		return -ENOMEM;
 	}
=20
+	/* the controller may grant fewer, so keep whole groups only */
+	qph =3D ctrl->opts->queues_per_hctx;
+	if (nr_io_queues < qph)
+		qph =3D 1;
+	nr_io_queues -=3D nr_io_queues % qph;
+	ctrl->queues_per_hctx =3D qph;
+
 	ctrl->queue_count =3D nr_io_queues + 1;
-	dev_info(ctrl->device,
-		"creating %d I/O queues.\n", nr_io_queues);
+	dev_info(ctrl->device, "creating %d I/O queues, %u per hctx.\n",
+		nr_io_queues, qph);
+
+	nvmf_set_io_queues(ctrl->opts, nr_io_queues / qph, hctxs);
+	for (i =3D 0; i < HCTX_MAX_TYPES; i++)
+		to_tcp_ctrl(ctrl)->io_queues[i] =3D hctxs[i] * qph;
=20
-	nvmf_set_io_queues(ctrl->opts, nr_io_queues,
-			   to_tcp_ctrl(ctrl)->io_queues);
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
=20
@@ -2271,7 +2398,8 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
 	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
-	nr_queues =3D min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
+	nr_queues =3D min(ctrl->tagset->nr_hw_queues * ctrl->queues_per_hctx + =
1,
+			ctrl->queue_count);
 	ret =3D nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
 	if (ret)
 		goto out_cleanup_connect_q;
@@ -2290,7 +2418,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
 			goto out_wait_freeze_timed_out;
 		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
+			(ctrl->queue_count - 1) / ctrl->queues_per_hctx);
 		nvme_unfreeze(ctrl);
 	}
=20
@@ -2299,7 +2427,7 @@ static int nvme_tcp_configure_io_queues(struct nvme=
_ctrl *ctrl, bool new)
 	 * start all new queues now.
 	 */
 	ret =3D nvme_tcp_start_io_queues(ctrl, nr_queues,
-				       ctrl->tagset->nr_hw_queues + 1);
+			ctrl->tagset->nr_hw_queues * ctrl->queues_per_hctx + 1);
 	if (ret)
 		goto out_wait_freeze_timed_out;
=20
@@ -2840,17 +2968,14 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct=
 nvme_ns *ns,
=20
 static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 {
-	struct nvme_tcp_queue *queue =3D hctx->driver_data;
-
-	if (!llist_empty(&queue->req_list))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	nvme_tcp_kick_hctx_queues(hctx);
 }
=20
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
 	struct nvme_ns *ns =3D hctx->queue->queuedata;
-	struct nvme_tcp_queue *queue =3D hctx->driver_data;
+	struct nvme_tcp_queue *queue =3D nvme_tcp_hctx_queue(hctx);
 	struct request *rq =3D bd->rq;
 	struct nvme_tcp_request *req =3D blk_mq_rq_to_pdu(rq);
 	bool queue_ready =3D test_bit(NVME_TCP_Q_LIVE, &queue->flags);
@@ -2859,13 +2984,18 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_=
mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
=20
+	/* the queue is chosen per dispatch, everything below follows it */
+	req->queue =3D queue;
+
 	ret =3D nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
 		return ret;
=20
 	nvme_start_request(rq);
=20
-	nvme_tcp_queue_request(req, bd->last);
+	nvme_tcp_queue_request(req, false);
+	if (bd->last)
+		nvme_tcp_kick_hctx_queues(hctx);
=20
 	return BLK_STS_OK;
 }
@@ -2873,25 +3003,42 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_=
mq_hw_ctx *hctx,
 static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(set->driver_data);
+	unsigned int qph =3D ctrl->ctrl.queues_per_hctx;
+	u32 hctxs[HCTX_MAX_TYPES];
+	int i;
+
+	/* ctrl->io_queues counts transport queues, the maps count hctxs */
+	for (i =3D 0; i < HCTX_MAX_TYPES; i++)
+		hctxs[i] =3D ctrl->io_queues[i] / qph;
=20
-	nvmf_map_queues(set, &ctrl->ctrl, ctrl->io_queues);
+	nvmf_map_queues(set, &ctrl->ctrl, hctxs);
 }
=20
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batc=
h *iob)
 {
-	struct nvme_tcp_queue *queue =3D hctx->driver_data;
-	struct sock *sk =3D queue->sock->sk;
-	int ret;
+	struct nvme_tcp_hctx *qg =3D hctx->driver_data;
+	struct nvme_tcp_queue *queue =3D qg->queues;
+	unsigned int i;
+	int ret, nr_cqe =3D 0;
=20
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return 0;
+	for (i =3D 0; i < qg->nr; i++, queue++) {
+		struct sock *sk =3D queue->sock->sk;
=20
-	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_qu=
eue))
-		sk_busy_loop(sk, true);
-	ret =3D nvme_tcp_try_recv(queue);
-	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return ret < 0 ? ret : queue->nr_cqe;
+		if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+			continue;
+
+		set_bit(NVME_TCP_Q_POLLING, &queue->flags);
+		if (sk_can_busy_loop(sk) &&
+		    skb_queue_empty_lockless(&sk->sk_receive_queue))
+			sk_busy_loop(sk, true);
+		ret =3D nvme_tcp_try_recv(queue);
+		clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
+		if (ret < 0)
+			return ret;
+		nr_cqe +=3D queue->nr_cqe;
+	}
+
+	return nr_cqe;
 }
=20
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int s=
ize)
@@ -2927,6 +3074,7 @@ static const struct blk_mq_ops nvme_tcp_mq_ops =3D =
{
 	.init_request	=3D nvme_tcp_init_request,
 	.exit_request	=3D nvme_tcp_exit_request,
 	.init_hctx	=3D nvme_tcp_init_hctx,
+	.exit_hctx	=3D nvme_tcp_exit_hctx,
 	.timeout	=3D nvme_tcp_timeout,
 	.map_queues	=3D nvme_tcp_map_queues,
 	.poll		=3D nvme_tcp_poll,
@@ -2938,6 +3086,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_op=
s =3D {
 	.init_request	=3D nvme_tcp_init_request,
 	.exit_request	=3D nvme_tcp_exit_request,
 	.init_hctx	=3D nvme_tcp_init_admin_hctx,
+	.exit_hctx	=3D nvme_tcp_exit_hctx,
 	.timeout	=3D nvme_tcp_timeout,
 };
=20
@@ -2989,8 +3138,9 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(st=
ruct device *dev,
 	 */
 	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 	ctrl->ctrl.opts =3D opts;
-	ctrl->ctrl.queue_count =3D opts->nr_io_queues + opts->nr_write_queues +
-				opts->nr_poll_queues + 1;
+	ctrl->ctrl.queue_count =3D (opts->nr_io_queues + opts->nr_write_queues =
+
+				  opts->nr_poll_queues) *
+				 opts->queues_per_hctx + 1;
 	ctrl->ctrl.sqsize =3D opts->queue_size - 1;
 	ctrl->ctrl.kato =3D opts->kato;
=20
@@ -3111,7 +3261,8 @@ static struct nvmf_transport_ops nvme_tcp_transport=
 =3D {
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
-			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT |
+			  NVMF_OPT_QUEUES_PER_HCTX,
 	.create_ctrl	=3D nvme_tcp_create_ctrl,
 };
=20
@@ -3138,6 +3289,13 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
=20
+	nvme_tcp_unbound_wq =3D alloc_workqueue("nvme_tcp_unbound_wq",
+			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
+	if (!nvme_tcp_unbound_wq) {
+		destroy_workqueue(nvme_tcp_wq);
+		return -ENOMEM;
+	}
+
 	for_each_possible_cpu(cpu)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
=20
@@ -3157,6 +3315,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 	flush_workqueue(nvme_delete_wq);
=20
+	destroy_workqueue(nvme_tcp_unbound_wq);
 	destroy_workqueue(nvme_tcp_wq);
 }
=20
--=20
2.53.0-Meta


