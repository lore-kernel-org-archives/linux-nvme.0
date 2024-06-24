Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99445C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FdipEvRDLp554TK6MfbC0RKU5cwPnSeRgiYA7tDAPWA=; b=RM6p5U6e9lqsJofsje7yCfx8E/
	5ogM7uWWMSeB2ETpncpkXebJxE6fPoWjZG6gOqVZQ7oyIwQG0jEE6Zc/C9sQTuw71sFcVZRcVuD5t
	QlDmxn6l81n0qATj3NffXMKFnBifhNpVGu4Zi51hLpahNHa08vWS/5clun6vtaHppzjteQ6FAE24m
	ePjqXOU9dbl6SM7hH1QU+iA1+HMZBgpmypzSNT+55X0YQdOMQMAjwvXbIudoqTkGsh/qrjRASIySY
	1CxYuVtjXxWl23pFa3xl5+xTJK/zAeogbPXYRabtxteP7sJOhsRSqbzEmdcJxljMfQGA491pISHZp
	KakuYBqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLnTC-000000005Ov-31H1;
	Mon, 24 Jun 2024 17:27:10 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLnTA-000000005MT-1W6p
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 17:27:09 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OGobXw006791
	for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 10:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=Fdi
	pEvRDLp554TK6MfbC0RKU5cwPnSeRgiYA7tDAPWA=; b=ng/DBBSqFkWQjlg9Snn
	xYJuFe20HY3g3kUbgTxuYLNzJ2bp9ESEThxsOY0CO8BllKN4Oqv0fPm+9rn6RAF6
	m0EiDWq4RboYGzElqbFFzR0J5MYnd7GWiOqt+4za7Ltefb6iEp59NZjpRckFB3Cr
	4/JZxZ/0ZbTNNocdkkFDOx8/z04rzcwqpUYeuCcIAsIoAQuMt25m/TpLfmeqPlJK
	Rij+WP4AIYJLdGrPg2ekcy8oD2OaQVyzukdk/4OzA96+ODfeGqgjLnOIxwgZ5qys
	NZnhrzo0LOwCGE7CbVY2rTykKbbB2/+/e0CBOzv4G0OzUIqnckIzFVHe+Jwsx7Lp
	zKw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yy218kj92-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 10:27:07 -0700 (PDT)
Received: from twshared19013.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 24 Jun 2024 17:26:53 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id F3631FD0E687; Mon, 24 Jun 2024 10:26:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2] nvme-pci: do not directly handle subsys reset fallout
Date: Mon, 24 Jun 2024 10:26:49 -0700
Message-ID: <20240624172649.2268634-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WDeR2oj_Zp3ATuH2QdQC3H8uTqScdHaI
X-Proofpoint-GUID: WDeR2oj_Zp3ATuH2QdQC3H8uTqScdHaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_14,2024-06-24_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_102708_445828_F6E844AA 
X-CRM114-Status: GOOD (  22.15  )
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

Scheduling reset_work after a nvme subsystem reset is expected to fail
on pcie, but this also prevents potential handling from the platform's
pcie services may provide that may successfully recovering the link
without re-enumeration. Such examples include AER, DPC, and power's EEH.

Provide a pci specific operation that safely initiates a subsystem
reset, and instead of scheduling reset work, read back the status
register to trigger a pcie read error.

Since this only affects pci, the other fabrics drivers subscribe to a
generic nvmf subsystem reset that is exactly the same as before. The
loop fabric doesn't use it because nvmet doesn't support setting that
property anyway.

And since we're using the magic NSSR value in two places now, provide a
symbolic define for it.

Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Changes from v1, applied comments from Christoph:

  Split out and require new ctrl subsystem reset op

  Comments updated for correctness and clarity

  Use a symbolic name for the special reset value

 drivers/nvme/host/fabrics.c | 15 +++++++++++++++
 drivers/nvme/host/fabrics.h |  1 +
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/nvme.h    | 14 +++-----------
 drivers/nvme/host/pci.c     | 35 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 include/linux/nvme.h        |  3 +++
 8 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ceb9c0ed3120b..bb52049cb7c54 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -280,6 +280,21 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off=
, u32 val)
 }
 EXPORT_SYMBOL_GPL(nvmf_reg_write32);
=20
+int nvmf_subsystem_reset(struct nvme_ctrl *ctrl)
+{
+	int ret;
+
+	if (!nvme_wait_reset(ctrl))
+		return -EBUSY;
+
+	ret =3D ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, NVME_SUBSYS_RESET);
+	if (ret)
+		return ret;
+
+	return nvme_try_sched_reset(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_subsystem_reset);
+
 /**
  * nvmf_log_connect_error() - Error-parsing-diagnostic print out functio=
n for
  * 				connect() errors.
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 602135910ae9c..21d75dc4a3a09 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -217,6 +217,7 @@ static inline unsigned int nvmf_nr_io_queues(struct n=
vmf_ctrl_options *opts)
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
+int nvmf_subsystem_reset(struct nvme_ctrl *ctrl);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f0b0813327491..67802078c78c1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3382,6 +3382,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops =
=3D {
 	.reg_read32		=3D nvmf_reg_read32,
 	.reg_read64		=3D nvmf_reg_read64,
 	.reg_write32		=3D nvmf_reg_write32,
+	.subsystem_reset	=3D nvmf_subsystem_reset,
 	.free_ctrl		=3D nvme_fc_free_ctrl,
 	.submit_async_event	=3D nvme_fc_submit_async_event,
 	.delete_ctrl		=3D nvme_fc_delete_ctrl,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 68b400f9c42d5..9909ca8a1f476 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -551,6 +551,7 @@ struct nvme_ctrl_ops {
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
+	int (*subsystem_reset)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
@@ -649,18 +650,9 @@ int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
=20
 static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
-	int ret;
-
-	if (!ctrl->subsystem)
+	if (!ctrl->subsystem || !ctrl->ops->subsystem_reset)
 		return -ENOTTY;
-	if (!nvme_wait_reset(ctrl))
-		return -EBUSY;
-
-	ret =3D ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
-	if (ret)
-		return ret;
-
-	return nvme_try_sched_reset(ctrl);
+	return ctrl->ops->subsystem_reset(ctrl);
 }
=20
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65ff..6cb7acef05576 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1143,6 +1143,40 @@ static void nvme_pci_submit_async_event(struct nvm=
e_ctrl *ctrl)
 	spin_unlock(&nvmeq->sq_lock);
 }
=20
+static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev =3D to_nvme_dev(ctrl);
+	int ret =3D 0;
+
+	/*
+	 * Taking the shutdown_lock ensures the BAR mapping is not being
+	 * altered by reset_work. Holding this lock before the RESETTING state
+	 * change, if successful, also ensures nvme_remove won't be able to
+	 * proceed to iounmap until we're done.
+	 */
+	mutex_lock(&dev->shutdown_lock);
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
+		ret =3D -EBUSY;
+		goto unlock;
+	}
+
+	if (!dev->bar_mapped_size) {
+		ret =3D -ENODEV;
+		goto unlock;
+	}
+
+	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
+
+	/*
+	 * Read controller status to flush the previous write and trigger a
+	 * pcie read error.
+	 */
+	readl(dev->bar + NVME_REG_CSTS);
+unlock:
+	mutex_unlock(&dev->shutdown_lock);
+	return ret;
+}
+
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	struct nvme_command c =3D { };
@@ -2859,6 +2893,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
 	.reg_read64		=3D nvme_pci_reg_read64,
 	.free_ctrl		=3D nvme_pci_free_ctrl,
 	.submit_async_event	=3D nvme_pci_submit_async_event,
+	.subsystem_reset	=3D nvme_pci_subsystem_reset,
 	.get_address		=3D nvme_pci_get_address,
 	.print_device_info	=3D nvme_pci_print_device_info,
 	.supports_pci_p2pdma	=3D nvme_pci_supports_pci_p2pdma,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 51a62b0c645a7..f514ffa671879 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2201,6 +2201,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_op=
s =3D {
 	.reg_read32		=3D nvmf_reg_read32,
 	.reg_read64		=3D nvmf_reg_read64,
 	.reg_write32		=3D nvmf_reg_write32,
+	.subsystem_reset	=3D nvmf_subsystem_reset,
 	.free_ctrl		=3D nvme_rdma_free_ctrl,
 	.submit_async_event	=3D nvme_rdma_submit_async_event,
 	.delete_ctrl		=3D nvme_rdma_delete_ctrl,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83b..46c1c4c5128c0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2662,6 +2662,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops=
 =3D {
 	.reg_read32		=3D nvmf_reg_read32,
 	.reg_read64		=3D nvmf_reg_read64,
 	.reg_write32		=3D nvmf_reg_write32,
+	.subsystem_reset	=3D nvmf_subsystem_reset,
 	.free_ctrl		=3D nvme_tcp_free_ctrl,
 	.submit_async_event	=3D nvme_tcp_submit_async_event,
 	.delete_ctrl		=3D nvme_tcp_delete_ctrl,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c693ac344ec05..b7d06d46aa08c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -25,6 +25,9 @@
=20
 #define NVME_NSID_ALL		0xffffffff
=20
+/* Special NSSR value, 'NVMe' */
+#define NVME_SUBSYS_RESET	0x4E564D65
+
 enum nvme_subsys_type {
 	/* Referral to another discovery type target subsystem */
 	NVME_NQN_DISC	=3D 1,
--=20
2.43.0


