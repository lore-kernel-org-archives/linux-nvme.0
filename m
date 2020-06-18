Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55095C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:32:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C35207E8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M49ttNS6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gkV+R6Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C35207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9BNVcKffeWQUasVzlPOM7JtU+FI1/fWSvx5FffanFwU=; b=M49ttNS6Sb8IPs
	DMbGUfRYjCbbcMUVZ29XscGSYkrpBrNpLqx9XlP3zzvp0p7ia5k1QjXRuo2FPHCp617+N/juJXixu
	tQiaMzkLnFkn3KQFi7dE0USCk47ZuP6Dg70fkkgXRrrhmdiai49jns2E/HaPq0BemSWLrWDv6FdGW
	xVREROTpxNoeLrQQHknet/yYTJaHN8li6IYkO8Lx6EqYt5SlGowYArvSn+OiW5/PiZCNoEdrV3sku
	oum0w2NvrowJJ5H3NdlgRSkPWQP/2bSS/j+eQORtnAykJneBeMTpJGXF3JX9An/j+Rob9yz7MipHI
	tqy0khnab5OcO5/qKmnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvb2-0004Sf-St; Thu, 18 Jun 2020 14:32:52 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvaz-0004Rb-GK
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592490780; x=1624026780;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tKQtZA7H8abTwZOrHKywDFOuog+pGmQVcPZ/CYAS/qk=;
 b=gkV+R6UrbdIg2aLsxSZxEzCU1Sf/bZ2AIikTIr0ft1dXWCK7NE6TY34q
 ehApE6kl2LAahzYj82aqlIBFpwqYlD5R7hcWqDGlt+JBwxknUqJbD5jbv
 /xo8mGejMKw+LgutjXisKeusycynCi5C/Wk44mNfM4hX8X+8k8NEGV3ra
 wjW8lEmSToeHQzuJjp3DupXCgoYSA2Qj1M0b7rfTvot9LtIihIwKNX5Lp
 hWpTKKHtk8NKkA4x4RbXpTTz4a6r09U85Eb8J08LD4v4pVvF6u+eZtJOu
 hZWqeDldRSaQ9g+YlXrPTII8jji7yt89WAXZ2Y1ceUHqZ0i7qMdPvEBhS w==;
IronPort-SDR: lR7SRc/Nfi5+TH9Zt+4GfDU0nZRPC2UVpzw8Up3gEbE+XOt7tEQZXD/i5/oTkHDsKItrZA+Eyn
 yYzLkJf2dPqxGvdMvxacqqis0zDCfPH2XfcURE0cdou3sqJERJ4vIOteJMiM7QedkQJNFLRlkh
 c4djr1P8N0wXyIvkvF/qDb4VoQQLRvgLsUJa7dxs9yvyL1VVOazwzGY4fNcS90KqN4szUuxbP8
 OBps79gSltrIV6XzWbFc6HrQuOcNY04dzSrflyhlV7Kz5W/EtTZEQ8v5X6CA8CH9vpkjtUVI+F
 Okg=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; d="scan'208";a="243285411"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 22:32:57 +0800
IronPort-SDR: z9KaVDZXTYAEMJFWQl3O2AkuYPI1RIrRvohA1CpOpnHDwnyX9nMB/htvE9bKAxVUypI4OpSnRs
 KWYIR6dGtd1IqujwtICFDm7XGal1sv18Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 07:22:00 -0700
IronPort-SDR: Uw7NVs1KDMNCtOuozNNRBU++DtokeoDkiKZuhv3DdUKYNyqLBJbvPaPzhGsHwZapR1qdz2DvOZ
 07zC/HR4atSg==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO localhost.hgst.com) ([10.86.58.135])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 07:32:45 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/2] nvme: remove workarounds for gcc bug wrt unnamed fields
 in initializers
Date: Thu, 18 Jun 2020 16:32:40 +0200
Message-Id: <20200618143241.1056800-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_073249_612937_64A70679 
X-CRM114-Status: GOOD (  16.46  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Workarounds for gcc issues with initializers and anon unions was first
introduced in commit e44ac588cd61 ("drivers/block/nvme-core.c: fix build
with gcc-4.4.4").

The gcc bug in question has been fixed since gcc 4.6.0:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10676

The minimum gcc version for building the kernel has been 4.6.0 since
commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6"),
and has since been updated to gcc 4.8.0 in
commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for
kernel builds to 4.8").

For that reason, it should now be safe to remove these workarounds
and make the code look like it did before
commit e44ac588cd61 ("drivers/block/nvme-core.c: fix build with gcc-4.4.4")
was introduced.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
If, for some reason, we want to allow builds with gcc < 4.6.0
even though the minimum gcc version is now 4.8.0,
there is another less intrusive workaround where you add an extra pair of
curly braces, see e.g. commit 6cc65be4f6f2 ("locking/qspinlock: Fix build
for anonymous union in older GCC compilers").

 drivers/nvme/host/core.c     | 59 ++++++++++++++++++------------------
 drivers/nvme/host/lightnvm.c | 32 +++++++++----------
 drivers/nvme/host/rdma.c     | 28 ++++++++---------
 3 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9491dbcfe81a..99059340d723 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1038,13 +1038,12 @@ static bool nvme_ctrl_limited_cns(struct nvme_ctrl *ctrl)
 
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.cns = NVME_ID_CNS_CTRL,
+	};
 	int error;
 
-	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = NVME_ID_CNS_CTRL;
-
 	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
 	if (!*id)
 		return -ENOMEM;
@@ -1096,16 +1095,16 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.nsid = cpu_to_le32(nsid),
+		.identify.cns = NVME_ID_CNS_NS_DESC_LIST,
+	};
 	int status;
 	void *data;
 	int pos;
 	int len;
 
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(nsid);
-	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
-
 	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -1143,11 +1142,12 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 
 static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST,
+		.identify.nsid = cpu_to_le32(nsid),
+	};
 
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
-	c.identify.nsid = cpu_to_le32(nsid);
 	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list,
 				    NVME_IDENTIFY_DATA_SIZE);
 }
@@ -1155,14 +1155,13 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 		unsigned nsid, struct nvme_id_ns **id)
 {
-	struct nvme_command c = { };
+	struct nvme_command c = {
+		.identify.opcode = nvme_admin_identify,
+		.identify.nsid = cpu_to_le32(nsid),
+		.identify.cns = NVME_ID_CNS_NS,
+	};
 	int error;
 
-	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(nsid);
-	c.identify.cns = NVME_ID_CNS_NS;
-
 	*id = kmalloc(sizeof(**id), GFP_KERNEL);
 	if (!*id)
 		return -ENOMEM;
@@ -2815,17 +2814,17 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 		void *log, size_t size, u64 offset)
 {
-	struct nvme_command c = { };
 	u32 dwlen = nvme_bytes_to_numd(size);
-
-	c.get_log_page.opcode = nvme_admin_get_log_page;
-	c.get_log_page.nsid = cpu_to_le32(nsid);
-	c.get_log_page.lid = log_page;
-	c.get_log_page.lsp = lsp;
-	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
-	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
-	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
-	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
+	struct nvme_command c = {
+		.get_log_page.opcode = nvme_admin_get_log_page,
+		.get_log_page.nsid = cpu_to_le32(nsid),
+		.get_log_page.lid = log_page,
+		.get_log_page.lsp = lsp,
+		.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1)),
+		.get_log_page.numdu = cpu_to_le16(dwlen >> 16),
+		.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset)),
+		.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset)),
+	};
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 69608755d415..7c44eca78f0d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -432,12 +432,12 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
 	struct nvme_nvm_id12 *id;
-	struct nvme_nvm_command c = {};
+	struct nvme_nvm_command c = {
+		.identity.opcode = nvme_nvm_admin_identity,
+		.identity.nsid = cpu_to_le32(ns->head->ns_id),
+	};
 	int ret;
 
-	c.identity.opcode = nvme_nvm_admin_identity;
-	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
-
 	id = kmalloc(sizeof(struct nvme_nvm_id12), GFP_KERNEL);
 	if (!id)
 		return -ENOMEM;
@@ -479,16 +479,16 @@ static int nvme_nvm_get_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr ppa,
 	struct nvm_geo *geo = &nvmdev->geo;
 	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_nvm_command c = {};
+	struct nvme_nvm_command c = {
+		.get_bb.opcode = nvme_nvm_admin_get_bb_tbl,
+		.get_bb.nsid = cpu_to_le32(ns->head->ns_id),
+		.get_bb.spba = cpu_to_le64(ppa.ppa),
+	};
 	struct nvme_nvm_bb_tbl *bb_tbl;
 	int nr_blks = geo->num_chk * geo->num_pln;
 	int tblsz = sizeof(struct nvme_nvm_bb_tbl) + nr_blks;
 	int ret = 0;
 
-	c.get_bb.opcode = nvme_nvm_admin_get_bb_tbl;
-	c.get_bb.nsid = cpu_to_le32(ns->head->ns_id);
-	c.get_bb.spba = cpu_to_le64(ppa.ppa);
-
 	bb_tbl = kzalloc(tblsz, GFP_KERNEL);
 	if (!bb_tbl)
 		return -ENOMEM;
@@ -532,15 +532,15 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 							int nr_ppas, int type)
 {
 	struct nvme_ns *ns = nvmdev->q->queuedata;
-	struct nvme_nvm_command c = {};
+	struct nvme_nvm_command c = {
+		.set_bb.opcode = nvme_nvm_admin_set_bb_tbl,
+		.set_bb.nsid = cpu_to_le32(ns->head->ns_id),
+		.set_bb.spba = cpu_to_le64(ppas->ppa),
+		.set_bb.nlb = cpu_to_le16(nr_ppas - 1),
+		.set_bb.value = type,
+	};
 	int ret = 0;
 
-	c.set_bb.opcode = nvme_nvm_admin_set_bb_tbl;
-	c.set_bb.nsid = cpu_to_le32(ns->head->ns_id);
-	c.set_bb.spba = cpu_to_le64(ppas->ppa);
-	c.set_bb.nlb = cpu_to_le16(nr_ppas - 1);
-	c.set_bb.value = type;
-
 	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct nvme_command *)&c,
 								NULL, 0);
 	if (ret)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f8f856dc0c67..08c8728b3b29 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1804,22 +1804,22 @@ static int nvme_rdma_addr_resolved(struct nvme_rdma_queue *queue)
 static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-	struct rdma_conn_param param = { };
-	struct nvme_rdma_cm_req priv = { };
+	struct rdma_conn_param param = {
+		.qp_num = queue->qp->qp_num,
+		.flow_control = 1,
+		.responder_resources = queue->device->dev->attrs.max_qp_rd_atom,
+		/* maximum retry count */
+		.retry_count = 7,
+		.rnr_retry_count = 7,
+		.private_data = &priv,
+		.private_data_len = sizeof(priv),
+	};
+	struct nvme_rdma_cm_req priv = {
+		.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0),
+		.qid = cpu_to_le16(nvme_rdma_queue_idx(queue)),
+	};
 	int ret;
 
-	param.qp_num = queue->qp->qp_num;
-	param.flow_control = 1;
-
-	param.responder_resources = queue->device->dev->attrs.max_qp_rd_atom;
-	/* maximum retry count */
-	param.retry_count = 7;
-	param.rnr_retry_count = 7;
-	param.private_data = &priv;
-	param.private_data_len = sizeof(priv);
-
-	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
-	priv.qid = cpu_to_le16(nvme_rdma_queue_idx(queue));
 	/*
 	 * set the admin queue depth to the minimum size
 	 * specified by the Fabrics standard.
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
