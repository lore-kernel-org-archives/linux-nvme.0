Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5B8C7618E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bXdgUo/8OQQoWcrm88Amzbl68YnBbt+MJkmr74d6h8Y=; b=PSygbIiniwSjRo/LI5Ro+D2Dmq
	+6UpW6S9gNg0xPca5TOcPPJw68sDdwxWUnsX/JocT1rig375wMKuyd9DLaQP+/6Hq/scAXRHhsQq4
	1NP/zhxFWE8FEhTVxiKlkbFgjVGVKAyDRSu1unWM2VyRjsMLfasjwufO9QlqDGg50exajwSIrkdsV
	XjdNuuBiP4ls8Y4z4jcr9IbbDw84m/FekwiJiGWPjQ+mOQgn1suIeMDut3e1w/qYCebH5446Q7GJU
	O7bG0VpA8hv0pB/BkbVe33fbtLr97kT/nb49xBK6D7Ty+eGgjxld3heBVCrdTDin0bQ/79kuhiMF4
	wWFZG1kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prghb-004HYF-1t;
	Wed, 26 Apr 2023 15:05:03 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prghX-004HWG-2y
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 15:05:02 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33QDOAcp007231
	for <linux-nvme@lists.infradead.org>; Wed, 26 Apr 2023 08:04:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=bXdgUo/8OQQoWcrm88Amzbl68YnBbt+MJkmr74d6h8Y=;
 b=e154/ovQcrRZ48+9yfI0TbDKegP/u5jCclJL5OYf16gAvfx5+8SA12e5JRLYxHGGnnc3
 FnmFa5zqMC3QOvkEP6dhrx67YiFrZmgPnjZ7W86K52ntZFOxvjR24XbOXUsAUqQWSOzb
 WycObz9YZcg0bMzkuO1CtqdBYSKBfKOLRT632mU1mAcn8nth/O/blDpE9tp2lE47eF6y
 puCZhokfNGG4fpF02JTq0RMFTQBZ17lWYKZ9eoxJTzzuq/IiyMI70BcXG3OoKutSWGHZ
 DwReF8R77e+Ao2Ijb7Jr5+qCkAmDiKxM9hRP5lqVQPOu+ym9I8NsZ7eW6JFPD/34j5qj 1Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3q6s3gvhut-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Apr 2023 08:04:55 -0700
Received: from twshared31955.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 08:04:52 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id EAB021709D04C; Wed, 26 Apr 2023 08:04:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCHv2] nvme-fabrics: add queue setup helpers
Date: Wed, 26 Apr 2023 08:04:41 -0700
Message-ID: <20230426150441.595318-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Blz4zcGBEW6Pt6S6pzzoq_cE2t2g6P5c
X-Proofpoint-ORIG-GUID: Blz4zcGBEW6Pt6S6pzzoq_cE2t2g6P5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_07,2023-04-26_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_080500_141543_319E49B9 
X-CRM114-Status: GOOD (  21.40  )
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

tcp and rdma transports have lots of duplicate code setting up the
different queue mappings. Add common helpers.

Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Merged up to latest that doesn't have the RDMA specifics

  Simplified io queue count function (Christoph)

  Use 'nvmf_' prefix for function names.

 drivers/nvme/host/fabrics.c | 76 ++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h | 11 +++++
 drivers/nvme/host/rdma.c    | 79 ++-----------------------------
 drivers/nvme/host/tcp.c     | 92 ++-----------------------------------
 4 files changed, 96 insertions(+), 162 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502b..3ff5030562088 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -957,6 +957,82 @@ static int nvmf_parse_options(struct nvmf_ctrl_optio=
ns *opts,
 	return ret;
 }
=20
+void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues=
,
+			u32 io_queues[HCTX_MAX_TYPES])
+{
+	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
+		/*
+		 * separate read/write queues
+		 * hand out dedicated default queues only after we have
+		 * sufficient read queues.
+		 */
+		io_queues[HCTX_TYPE_READ] =3D opts->nr_io_queues;
+		nr_io_queues -=3D io_queues[HCTX_TYPE_READ];
+		io_queues[HCTX_TYPE_DEFAULT] =3D
+			min(opts->nr_write_queues, nr_io_queues);
+		nr_io_queues -=3D io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		/*
+		 * shared read/write queues
+		 * either no write queues were requested, or we don't have
+		 * sufficient queue count to have dedicated default queues.
+		 */
+		io_queues[HCTX_TYPE_DEFAULT] =3D
+			min(opts->nr_io_queues, nr_io_queues);
+		nr_io_queues -=3D io_queues[HCTX_TYPE_DEFAULT];
+	}
+
+	if (opts->nr_poll_queues && nr_io_queues) {
+		/* map dedicated poll queues only if we have queues left */
+		io_queues[HCTX_TYPE_POLL] =3D
+			min(opts->nr_poll_queues, nr_io_queues);
+	}
+}
+EXPORT_SYMBOL_GPL(nvmf_set_io_queues);
+
+void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
+		     u32 io_queues[HCTX_MAX_TYPES])
+{
+	struct nvmf_ctrl_options *opts =3D ctrl->opts;
+
+	if (opts->nr_write_queues && io_queues[HCTX_TYPE_READ]) {
+		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
+		set->map[HCTX_TYPE_READ].nr_queues =3D
+			io_queues[HCTX_TYPE_READ];
+		set->map[HCTX_TYPE_READ].queue_offset =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		/* shared read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
+		set->map[HCTX_TYPE_READ].nr_queues =3D
+			io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_READ].queue_offset =3D 0;
+	}
+
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+	if (opts->nr_poll_queues && io_queues[HCTX_TYPE_POLL]) {
+		/* map dedicated poll queues only if we have queues left */
+		set->map[HCTX_TYPE_POLL].nr_queues =3D io_queues[HCTX_TYPE_POLL];
+		set->map[HCTX_TYPE_POLL].queue_offset =3D
+			io_queues[HCTX_TYPE_DEFAULT] +
+			io_queues[HCTX_TYPE_READ];
+		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+	}
+
+	dev_info(ctrl->device,
+		"mapped %d/%d/%d default/read/poll queues.\n",
+		io_queues[HCTX_TYPE_DEFAULT],
+		io_queues[HCTX_TYPE_READ],
+		io_queues[HCTX_TYPE_POLL]);
+}
+EXPORT_SYMBOL_GPL(nvmf_map_queues);
+
 static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
 		unsigned int required_opts)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f76..e438d67a319b5 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -203,6 +203,13 @@ static inline void nvmf_complete_timed_out_request(s=
truct request *rq)
 	}
 }
=20
+static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *o=
pts)
+{
+	return min(opts->nr_io_queues, num_online_cpus()) +
+		min(opts->nr_write_queues, num_online_cpus()) +
+		min(opts->nr_poll_queues, num_online_cpus());
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
@@ -215,5 +222,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *bu=
f, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues=
,
+			u32 io_queues[HCTX_MAX_TYPES]);
+void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
+		     u32 io_queues[HCTX_MAX_TYPES]);
=20
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb736..168fdf5e11113 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -713,18 +713,10 @@ static int nvme_rdma_start_io_queues(struct nvme_rd=
ma_ctrl *ctrl,
 static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts =3D ctrl->ctrl.opts;
-	struct ib_device *ibdev =3D ctrl->device->dev;
-	unsigned int nr_io_queues, nr_default_queues;
-	unsigned int nr_read_queues, nr_poll_queues;
+	unsigned int nr_io_queues;
 	int i, ret;
=20
-	nr_read_queues =3D min_t(unsigned int, ibdev->num_comp_vectors,
-				min(opts->nr_io_queues, num_online_cpus()));
-	nr_default_queues =3D  min_t(unsigned int, ibdev->num_comp_vectors,
-				min(opts->nr_write_queues, num_online_cpus()));
-	nr_poll_queues =3D min(opts->nr_poll_queues, num_online_cpus());
-	nr_io_queues =3D nr_read_queues + nr_default_queues + nr_poll_queues;
-
+	nr_io_queues =3D nvmf_nr_io_queues(opts);
 	ret =3D nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -739,34 +731,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdm=
a_ctrl *ctrl)
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
=20
-	if (opts->nr_write_queues && nr_read_queues < nr_io_queues) {
-		/*
-		 * separate read/write queues
-		 * hand out dedicated default queues only after we have
-		 * sufficient read queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_READ] =3D nr_read_queues;
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_READ];
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(nr_default_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/*
-		 * shared read/write queues
-		 * either no write queues were requested, or we don't have
-		 * sufficient queue count to have dedicated default queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(nr_read_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	}
-
-	if (opts->nr_poll_queues && nr_io_queues) {
-		/* map dedicated poll queues only if we have queues left */
-		ctrl->io_queues[HCTX_TYPE_POLL] =3D
-			min(nr_poll_queues, nr_io_queues);
-	}
-
+	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
 	for (i =3D 1; i < ctrl->ctrl.queue_count; i++) {
 		ret =3D nvme_rdma_alloc_queue(ctrl, i,
 				ctrl->ctrl.sqsize + 1);
@@ -2138,44 +2103,8 @@ static void nvme_rdma_complete_rq(struct request *=
rq)
 static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl =3D to_rdma_ctrl(set->driver_data);
-	struct nvmf_ctrl_options *opts =3D ctrl->ctrl.opts;
=20
-	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
-		/* separate read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_READ];
-		set->map[HCTX_TYPE_READ].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/* shared read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_READ].queue_offset =3D 0;
-	}
-	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
-	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
-
-	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
-		/* map dedicated poll queues only if we have queues left */
-		set->map[HCTX_TYPE_POLL].nr_queues =3D
-				ctrl->io_queues[HCTX_TYPE_POLL];
-		set->map[HCTX_TYPE_POLL].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
-			ctrl->io_queues[HCTX_TYPE_READ];
-		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
-	}
-
-	dev_info(ctrl->ctrl.device,
-		"mapped %d/%d/%d default/read/poll queues.\n",
-		ctrl->io_queues[HCTX_TYPE_DEFAULT],
-		ctrl->io_queues[HCTX_TYPE_READ],
-		ctrl->io_queues[HCTX_TYPE_POLL]);
+	nvmf_map_queues(set, &ctrl->ctrl, ctrl->io_queues);
 }
=20
 static const struct blk_mq_ops nvme_rdma_mq_ops =3D {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf0230442d570..260b3554d821d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1802,58 +1802,12 @@ static int __nvme_tcp_alloc_io_queues(struct nvme=
_ctrl *ctrl)
 	return ret;
 }
=20
-static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
-{
-	unsigned int nr_io_queues;
-
-	nr_io_queues =3D min(ctrl->opts->nr_io_queues, num_online_cpus());
-	nr_io_queues +=3D min(ctrl->opts->nr_write_queues, num_online_cpus());
-	nr_io_queues +=3D min(ctrl->opts->nr_poll_queues, num_online_cpus());
-
-	return nr_io_queues;
-}
-
-static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
-		unsigned int nr_io_queues)
-{
-	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(nctrl);
-	struct nvmf_ctrl_options *opts =3D nctrl->opts;
-
-	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
-		/*
-		 * separate read/write queues
-		 * hand out dedicated default queues only after we have
-		 * sufficient read queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_READ] =3D opts->nr_io_queues;
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_READ];
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(opts->nr_write_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/*
-		 * shared read/write queues
-		 * either no write queues were requested, or we don't have
-		 * sufficient queue count to have dedicated default queues.
-		 */
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =3D
-			min(opts->nr_io_queues, nr_io_queues);
-		nr_io_queues -=3D ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	}
-
-	if (opts->nr_poll_queues && nr_io_queues) {
-		/* map dedicated poll queues only if we have queues left */
-		ctrl->io_queues[HCTX_TYPE_POLL] =3D
-			min(opts->nr_poll_queues, nr_io_queues);
-	}
-}
-
 static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
 	int ret;
=20
-	nr_io_queues =3D nvme_tcp_nr_io_queues(ctrl);
+	nr_io_queues =3D nvmf_nr_io_queues(ctrl->opts);
 	ret =3D nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -1868,8 +1822,8 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctr=
l *ctrl)
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
=20
-	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
-
+	nvmf_set_io_queues(ctrl->opts, nr_io_queues,
+			   to_tcp_ctrl(ctrl)->io_queues);
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
=20
@@ -2449,44 +2403,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_m=
q_hw_ctx *hctx,
 static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_tcp_ctrl *ctrl =3D to_tcp_ctrl(set->driver_data);
-	struct nvmf_ctrl_options *opts =3D ctrl->ctrl.opts;
-
-	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
-		/* separate read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_READ];
-		set->map[HCTX_TYPE_READ].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		/* shared read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset =3D 0;
-		set->map[HCTX_TYPE_READ].nr_queues =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_READ].queue_offset =3D 0;
-	}
-	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
-	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
-
-	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
-		/* map dedicated poll queues only if we have queues left */
-		set->map[HCTX_TYPE_POLL].nr_queues =3D
-				ctrl->io_queues[HCTX_TYPE_POLL];
-		set->map[HCTX_TYPE_POLL].queue_offset =3D
-			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
-			ctrl->io_queues[HCTX_TYPE_READ];
-		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
-	}
-
-	dev_info(ctrl->ctrl.device,
-		"mapped %d/%d/%d default/read/poll queues.\n",
-		ctrl->io_queues[HCTX_TYPE_DEFAULT],
-		ctrl->io_queues[HCTX_TYPE_READ],
-		ctrl->io_queues[HCTX_TYPE_POLL]);
+
+	nvmf_map_queues(set, &ctrl->ctrl, ctrl->io_queues);
 }
=20
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batc=
h *iob)
--=20
2.34.1


