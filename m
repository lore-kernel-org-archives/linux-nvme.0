Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048B7C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=7LigFguPDDjen/RjjTVPhHOufHj+KmAsGaYW/wg5jbc=; b=xglrFiPf81v85FN2bRu6B3H3hb
	aW8DXsmdZc1dN42NYe5G5oZE9X77TuqDDdiXIMG8ALGe1n8fzukgZ6Pd/52mXl9YGheaG1S7+glKV
	kYz0xf5cxFQMHJFgXT8uxcUegT7sNdfADlbh3WTThdJ3f1kJhomimv98iHpsG6LfAC+qldfvryprD
	F7mfny0DKJb+50QKAQjUcJAoWLBwV02Q+CSUYhfNy9NWUVwlk93bsHtqTIFVG/BRWpYKIoUbP5P1R
	41DOFedc0cijd649FxtMUYUAjvYb7TASJf18mUxymTVV9F4w5ZQIkn52DLCeIFvIYMyEZgJUgTSUC
	hWZKixJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOapm-00000006MjE-2GJE;
	Tue, 02 Jul 2024 10:34:02 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOapi-00000006MhH-0XSz
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 10:34:01 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240702103351epoutp023a5c3f5abc10a104d79ecf0ae17d3549~eXuHJHyZ20330803308epoutp020
	for <linux-nvme@lists.infradead.org>; Tue,  2 Jul 2024 10:33:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240702103351epoutp023a5c3f5abc10a104d79ecf0ae17d3549~eXuHJHyZ20330803308epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719916431;
	bh=7LigFguPDDjen/RjjTVPhHOufHj+KmAsGaYW/wg5jbc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rFPyLfrqVWpqfPJ+zgb6W2bYMFZC457ZdZTHAlTxKqV1en9o9gspYFdZTcogJUd1L
	 RwIbAJuR/KBFJ1g58SXslwfJu0HTr5gqEsMyS62pi3w0/2xtisZLNO0iSSRknzQ9zZ
	 aXYDSU5UVw+fCGUQlZ4lN+bI+FgltfxOUzS60YWU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240702103351epcas5p24c08c42bc3e9f53a61826dff264a58a3~eXuGy7OUo2711427114epcas5p2v;
	Tue,  2 Jul 2024 10:33:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WCzlx3dyrz4x9Q1; Tue,  2 Jul
	2024 10:33:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.63.09989.D87D3866; Tue,  2 Jul 2024 19:33:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240702103348epcas5p1015eafbddf4795558843cd74b0453b12~eXuEqqIV12361323613epcas5p1o;
	Tue,  2 Jul 2024 10:33:48 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240702103348epsmtrp22c6849563f780dd014e71fe640018522~eXuEp0TUh2200622006epsmtrp24;
	Tue,  2 Jul 2024 10:33:48 +0000 (GMT)
X-AuditID: b6c32a4a-bffff70000002705-51-6683d78d96d6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.45.18846.C87D3866; Tue,  2 Jul 2024 19:33:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240702103346epsmtip123e540c05cf70a4b35b15be47540a691~eXuCofuEl2148421484epsmtip1m;
	Tue,  2 Jul 2024 10:33:46 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, bvanassche@acm.org,
	javier.gonz@samsung.com, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCH v3] nvme: enable FDP support
Date: Tue,  2 Jul 2024 15:56:19 +0530
Message-Id: <20240702102619.164170-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmum7v9eY0g7//RS1W3+1ns5j24Sez
	xc0DO5ksVq4+ymSxc9ladovHdz6zWxz9/5bNYtKha4wW85c9ZbdYfvwfk8W23/OZLda9fs/i
	wONx+Yq3x/l7G1k8Lp8t9di0qpPNY/OSeo/dNxvYPD4+vcXi0bdlFWMAR1S2TUZqYkpqkUJq
	XnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QsUoKZYk5pUChgMTiYiV9
	O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IxNp08wFjSYVJw8
	3MnawNiq1cXIySEhYCLxY+k/5i5GLg4hgd2MEhev3mCEcD4xSlz6MRXB2fNnCxtMy+WvF6AS
	Oxklfq/tYIVwPjNKNGzdyt7FyMHBJqApcWFyKUiDiECSxMe+82ANzALXGCWeTNgINklYQEfi
	6KFtrCA2i4CqROuKI2wgvbwClhK3+lgglslLzLz0nR3E5hUQlDg58wlYnBko3rx1NtjdEgKt
	HBLPv3wA2ysh4CIx7XwiRK+wxKvjW9ghbCmJz+/2Qj2QLfHg0QOo+TUSOzb3sULY9hINf26w
	goxhBjp//S59iFV8Er2/nzBBTOeV6GgTgqhWlLg36SlUp7jEwxlLoGwPiSN7fzCClAsJxEos
	+lU0gVFuFpL7ZyG5fxbCrgWMzKsYJVMLinPTU4tNC4zyUsvhMZmcn7uJEZxItbx2MD588EHv
	ECMTB+MhRgkOZiUR3sBf9WlCvCmJlVWpRfnxRaU5qcWHGE2BYTqRWUo0OR+YyvNK4g1NLA1M
	zMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamCaP937nlOo2jY7OxsXJv2DB44t
	2ylxZf7EntkM3yWr6z78l6o4NEsku/Tq83aRTdNjZGYLGO7eOePIfa7fb599eVC3kyfkzOqa
	ez97Go7V71H6zZHito1nlWTtth1SS5cxW+9rezO1g1dia57lK7ebTwL/cp5L3tvTbPLji9aX
	45Wh938ymdaViCkVxKxZF51XdOh+Ru4a1dq52z3PerfUsR106NuScmSLrla+W/2Vi5ITH/AI
	hv0Q7xGpvOnbdOOsitiVSP2MpesWzg56XLvFZXOsYcyrQJnIDqUvTDZeN90amBZtexjzcsOy
	76wrey5P5j2pcDjxpIu2ivuO6mcL/wq8FHtyYrHr7Ve9AptnKbEUZyQaajEXFScCABdpAL0t
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnG7P9eY0g8s79SxW3+1ns5j24Sez
	xc0DO5ksVq4+ymSxc9ladovHdz6zWxz9/5bNYtKha4wW85c9ZbdYfvwfk8W23/OZLda9fs/i
	wONx+Yq3x/l7G1k8Lp8t9di0qpPNY/OSeo/dNxvYPD4+vcXi0bdlFWMARxSXTUpqTmZZapG+
	XQJXxqbTJxgLGkwqTh7uZG1gbNXqYuTkkBAwkbj89QJjFyMXh5DAdkaJa723mSES4hLN136w
	Q9jCEiv/PWeHKPrIKHHy4jmmLkYODjYBTYkLk0tBakQEMiQ6fs8A62UWuMMo0dorD2ILC+hI
	HD20jRXEZhFQlWhdcYQNpJVXwFLiVh8LxHh5iZmXvoOt4hUQlDg58wkLxBh5ieats5knMPLN
	QpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwmGsF7WBctv6v3iFGJg7GQ4wS
	HMxKIryBv+rThHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODil
	Gpjksi98ehR//FqRWOvdPTsu/JNOdXyu25Cx/ln7pqWbzdY52alu9OVo6n18Kbhsjfbrf7tr
	K4PTzM5/+Taz+CCb0xoHA5trP84/89oytXnB1QWsF/kd7rybeNsju1GgItxcdgNHXH2CxPK3
	NW4fzHctNr+54PXKyekHr5T/t9qcvG+FUf3PrvITSecOWB20O3ZEkMeN5fLrWd0u75hL+sWY
	nkzf1uDrwLV55SZWm5d6XvFrxeb6HVtzumV11tfZzDOSXafr7Z7e17bDWmV9rpeVxp9J2S9/
	z30598MW//v+uWc+r92ft4x9nde8qdb8HBrX989buJBpzW/zKQYZV/w2cLiyit6pvi+ncUhK
	KqZ5phJLcUaioRZzUXEiAKEP4NXiAgAA
X-CMS-MailID: 20240702103348epcas5p1015eafbddf4795558843cd74b0453b12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240702103348epcas5p1015eafbddf4795558843cd74b0453b12
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_033358_848334_C6D7553E 
X-CRM114-Status: GOOD (  24.18  )
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

Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
to control the placement of logical blocks so as to reduce the SSD WAF.

Userspace can send the data lifetime information using the write hints.
The SCSI driver (sd) can already pass this information to the SCSI
devices. This patch does the same for NVMe.

Fetch the placement-identifiers if the device supports FDP.
The incoming write-hint is mapped to a placement-identifier, which in
turn is set in the DSPEC field of the write command.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Hui Qi <hui81.qi@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
Changes since v2:
- Base it on nvme-6.11 and resolve a merge conflict

Changes since v1:
- Reduce the fetched plids from 128 to 6 (Keith)
- Use struct_size for a calculation (Keith)
- Handle robot/sparse warning

 drivers/nvme/host/core.c | 67 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +++
 include/linux/nvme.h     | 19 ++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 20e7505852ce..c7455e917e3b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -42,6 +42,20 @@ struct nvme_ns_info {
 	bool is_removed;
 };
 
+struct nvme_fdp_ruh_status_desc {
+	u16 pid;
+	u16 ruhid;
+	u32 earutr;
+	u64 ruamw;
+	u8  rsvd16[16];
+};
+
+struct nvme_fdp_ruh_status {
+	u8  rsvd0[14];
+	__le16 nruhsd;
+	struct nvme_fdp_ruh_status_desc ruhsd[];
+};
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -957,6 +971,16 @@ static bool nvme_valid_atomic_write(struct request *req)
 	return true;
 }
 
+static inline void nvme_assign_placement_id(struct nvme_ns *ns,
+					struct request *req,
+					struct nvme_command *cmd)
+{
+	enum rw_hint h = umin(ns->head->nr_plids - 1, req->write_hint);
+
+	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
+	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
+}
+
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
@@ -1075,6 +1099,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		break;
 	case REQ_OP_WRITE:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		if (!ret && ns->head->nr_plids)
+			nvme_assign_placement_id(ns, req, cmd);
 		break;
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
@@ -2105,6 +2131,40 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	return ret;
 }
 
+static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
+{
+	struct nvme_command c = {};
+	struct nvme_fdp_ruh_status *ruhs;
+	struct nvme_fdp_ruh_status_desc *ruhsd;
+	int size, ret, i;
+
+	size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
+	ruhs = kzalloc(size, GFP_KERNEL);
+	if (!ruhs)
+		return -ENOMEM;
+
+	c.imr.opcode = nvme_cmd_io_mgmt_recv;
+	c.imr.nsid = cpu_to_le32(nsid);
+	c.imr.mo = 0x1;
+	c.imr.numd =  cpu_to_le32((size >> 2) - 1);
+
+	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
+	if (ret)
+		goto out;
+
+	ns->head->nr_plids = le16_to_cpu(ruhs->nruhsd);
+	ns->head->nr_plids =
+		min_t(u16, ns->head->nr_plids, NVME_MAX_PLIDS);
+
+	for (i = 0; i < ns->head->nr_plids; i++) {
+		ruhsd = &ruhs->ruhsd[i];
+		ns->head->plids[i] = le16_to_cpu(ruhsd->pid);
+	}
+out:
+	kfree(ruhs);
+	return ret;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2196,6 +2256,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		if (ret && !nvme_first_scan(ns->disk))
 			goto out;
 	}
+	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ret = nvme_fetch_fdp_plids(ns, info->nsid);
+		if (ret)
+			dev_warn(ns->ctrl->device,
+				"FDP failure status:0x%x\n", ret);
+	}
+
 
 	ret = 0;
 out:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b512012b7044..7b88b8ae502e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -450,6 +450,8 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+#define NVME_MAX_PLIDS   (WRITE_LIFE_EXTREME + 1)
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -466,6 +468,8 @@ struct nvme_ns_head {
 	struct kref		ref;
 	bool			shared;
 	bool			passthru_err_log_enabled;
+	u16			nr_plids;
+	u16			plids[NVME_MAX_PLIDS];
 	int			instance;
 	struct nvme_effects_log *effects;
 	u64			nuse;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 57e27e48c913..9effc5902901 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -273,6 +273,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_FDPS		= (1 << 19),
 };
 
 struct nvme_id_ctrl {
@@ -832,6 +833,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_register	= 0x0d,
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
+	nvme_cmd_io_mgmt_recv	= 0x12,
 	nvme_cmd_resv_release	= 0x15,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
@@ -853,6 +855,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
@@ -1004,6 +1007,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
+	NVME_RW_DTYPE_DPLCMT		= 2 << 4,
 	NVME_WZ_DEAC			= 1 << 9,
 };
 
@@ -1091,6 +1095,20 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
 
+struct nvme_io_mgmt_recv_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			mo;
+	__u8			rsvd11;
+	__u16			mos;
+	__le32			numd;
+	__le32			cdw12[4];
+};
+
 enum {
 	NVME_ZRA_ZONE_REPORT		= 0,
 	NVME_ZRASF_ZONE_REPORT_ALL	= 0,
@@ -1811,6 +1829,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_io_mgmt_recv_cmd imr;
 	};
 };
 
-- 
2.25.1


