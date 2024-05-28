Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B6C25B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=jwl5Y3j3G8GGiiQGYnfGIQ+Boqh6W8pSL9eZbmy56Y4=; b=XdHsdoxjsfm4iBMOsu6heT1rZ2
	causrfYIILRmv21RAxUcd6uhixe5dcR6mKakgLAvDaDAlyOcX4WqEYZ5J+pfxIeVUBifIrIOkxiMF
	5M9HS3rHrP5k6Mr+dmvwcPPHZ3Ty+/G8zS+Y63K576O/nDGP8a7IoVvKUQj1OeoOKIiWKq786p8M1
	mNrc26TniwZ2tFgAEl96YZpxJBz0I68fFcGV5TlJBJRzlNn1mJiF3LSFqvWZBoutCsaDu1N+Br+7i
	KDnse+lJA2+ftLLw++uWfHNgTkshbrS1Wphei3lrTv6le70GZFOWzdjS9r1mAkuB972VND+zezGQS
	U3pbadCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sByTB-000000019ly-2gw9;
	Tue, 28 May 2024 15:10:33 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sByT1-000000019Zc-1rbx
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 15:10:27 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240528151010epoutp02e3c93d6fdcaa7c53cdeee1b61e884144~Tr6X5kgBt1526315263epoutp02T
	for <linux-nvme@lists.infradead.org>; Tue, 28 May 2024 15:10:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240528151010epoutp02e3c93d6fdcaa7c53cdeee1b61e884144~Tr6X5kgBt1526315263epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716909010;
	bh=jwl5Y3j3G8GGiiQGYnfGIQ+Boqh6W8pSL9eZbmy56Y4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hD+SLmbwXuSXaK06eUCH41gSiaxSFoOYzwNmptKp6Uw5NEyQDzN/pEjhanqS7RlrZ
	 zu6JqVdS36tTL/xPyEACxKJIDVezwWZ6OH88bksiWFVBW4UV24RWKICamKJJiBjDtJ
	 xjYR9ry16mBR9w0gKqd0UpuPhXreTC29gHwMXjGg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240528151009epcas5p3d2d298f3c406261a893cb807c2e4df75~Tr6XBZobd0143601436epcas5p3_;
	Tue, 28 May 2024 15:10:09 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VpbXv5B2Hz4x9Pp; Tue, 28 May
	2024 15:10:07 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.C5.08853.FC3F5566; Wed, 29 May 2024 00:10:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed~Tr6U9UGSc0144101441epcas5p36;
	Tue, 28 May 2024 15:10:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240528151007epsmtrp22852a4cf2f405c31d72caedf7b56aef7~Tr6U8gvsU2164921649epsmtrp2I;
	Tue, 28 May 2024 15:10:07 +0000 (GMT)
X-AuditID: b6c32a44-fc3fa70000002295-6a-6655f3cf46be
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.F6.08622.FC3F5566; Wed, 29 May 2024 00:10:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240528151005epsmtip1a8cc55425794c71a7e0ccd7dd9dd98bf~Tr6TT3zBE3136131361epsmtip1l;
	Tue, 28 May 2024 15:10:05 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, javier.gonz@samsung.com,
	bvanassche@acm.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCH v2] nvme: enable FDP support
Date: Tue, 28 May 2024 20:32:33 +0530
Message-Id: <20240528150233.55562-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTXff859A0g2dLNCxW3+1ns5j24Sez
	xc0DO5ksVq4+ymSxc9ladovHdz6zWxz9/5bNYtKha4wW85c9ZbfY9ns+s8W61+9ZHLg9Ll/x
	9jh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm0ffllWMAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B
	8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
	S2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzpnStYS5oMq44caqFtYFxmWYXIyeH
	hICJxOQ3/UxdjFwcQgK7GSWafn9kAkkICXxilHjxIhDC/sYoceV+LUxD//R9LBANexklvsya
	ywhR9JlRov1gWRcjBwebgKbEhcmlIGERAReJC78PsIPUMwtcY5SYsvoiWL2wgI5E66tORpB6
	FgFViTMz/EHCvAIWEoc3L2aE2CUvMfPSd3aIuKDEyZlPWEBsZqB489bZzCAzJQT+sktMnPue
	GaLBRaLrXQMThC0s8er4FnYIW0ri87u9bBB2ssSlmeegakokHu85CGXbS7Se6mcGuYcZ6P71
	u/QhdvFJ9P5+wgQSlhDglehoE4KoVpS4N+kpK4QtLvFwxhIo20Pi5+450CCMlVg9aRXTBEa5
	WUg+mIXkg1kIyxYwMq9ilEwtKM5NT002LTDMSy2HR2Ryfu4mRnDK1HLZwXhj/j+9Q4xMHIyH
	GCU4mJVEeM9MCk0T4k1JrKxKLcqPLyrNSS0+xGgKDNWJzFKiyfnApJ1XEm9oYmlgYmZmZmJp
	bGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAPTykvujqHRG9feWr1xsmi5y2GVcyd830V/
	lLB41fNQKVX3/Z8X0qIX1ubMvKrNJjMzZFV5lseJdhWlv++Fmw3Yk57sjLZ+XBLOvlKqwNO4
	3fByyazej6EpG0otT0w86xXkpspZU8/JbiKuVlCtfttP4Nj2kNzI+aFy7I+PMbCrn5kXlRSW
	dv1b56PF5b3hnvciu7NTFPnO56bFdjHars92KXlmKDUpynwyq9vRCzd+v1JnfP6ij32pX07q
	qm5n/QeBclPPT2axCyo+yBbe13KP6+Y5m7VTz53bvfj/3h3sj0x6o+enxWeEBi4+KSnnynRV
	7bjQyULFlJCV+/LVVlhaqEzaGiZz0XUb6zyD+UosxRmJhlrMRcWJAPCGvuYiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnO75z6FpBit/slmsvtvPZjHtw09m
	i5sHdjJZrFx9lMli57K17BaP73xmtzj6/y2bxaRD1xgt5i97ym6x7fd8Zot1r9+zOHB7XL7i
	7XH+3kYWj8tnSz02repk89i8pN5j980GNo++LasYA9ijuGxSUnMyy1KL9O0SuDKmdK1hLmgy
	rjhxqoW1gXGZZhcjJ4eEgIlE//R9LF2MXBxCArsZJT7fvcAEkRCXaL72gx3CFpZY+e85O0TR
	R0aJLc8OA3VwcLAJaEpcmFwKYooIeElsW2oIUsIscIdRYnJLDzNIr7CAjkTrq05GkBoWAVWJ
	MzP8QcK8AhYShzcvZoQYLy8x89J3doi4oMTJmU9YQGxmoHjz1tnMExj5ZiFJzUKSWsDItIpR
	MrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzi0tbR2MO5Z9UHvECMTB+MhRgkOZiUR3jOT
	QtOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRqYOqI0lnM
	YbB73vPJZTXvBLleGlW++VmvPX2TlZZ0k7OUb5L+d44rD1eoLi4ruXve3dI64RjbWSX29qRT
	7uc41bNCD59it9x0g2lR2Peta5WmJ8U/9DpzR7rIwNg8L2Gv0JzbW+5O22ndqLd3aQJvg+se
	hTvmTT7yxYZ/o6c9uLJA356pPCdjiextlq65jqoZMV6lnyPun+xbs/28xYzV9w+z39x+mLn+
	9JJD+Z039iUuVOPf0Ji2/4Sn0615eucCn9+8e7DtiL7YZ0sR3clztN3z5PX/GH65vOKqWJFA
	xZpPtxfUqBb63HyirftYYN2W7k+my5gdnXs9l6mf+r0jYG0Vz62kx4nrA081NJ3xW6HEUpyR
	aKjFXFScCADWTSdF3AIAAA==
X-CMS-MailID: 20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_081024_239644_30D155EA 
X-CRM114-Status: GOOD (  23.15  )
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

Fetches the placement-identifiers (plids) if the device supports FDP.
And map the incoming write-hints to plids.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Hui Qi <hui81.qi@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
Changes since v1:
- Reduce the fetched plids from 128 to 6 (Keith)
- Use struct_size for a calculation (Keith)
- Handle robot/sparse warning

 drivers/nvme/host/core.c | 67 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 +++
 include/linux/nvme.h     | 19 ++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 954f850f113a..9b67c3afe003 100644
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
@@ -922,6 +936,16 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	return BLK_STS_OK;
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
@@ -1037,6 +1061,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		break;
 	case REQ_OP_WRITE:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		if (!ret && ns->head->nr_plids)
+			nvme_assign_placement_id(ns, req, cmd);
 		break;
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
@@ -2049,6 +2075,40 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
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
@@ -2136,6 +2196,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
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
index cacc56f4bbf4..bec3024d6af9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,6 +445,8 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+#define NVME_MAX_PLIDS   (WRITE_LIFE_EXTREME + 1)
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -462,6 +464,8 @@ struct nvme_ns_head {
 	bool			shared;
 	bool			passthru_err_log_enabled;
 	int			instance;
+	u16			nr_plids;
+	u16			plids[NVME_MAX_PLIDS];
 	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 425573202295..fc07ba1b5ec5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -270,6 +270,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_FDPS		= (1 << 19),
 };
 
 struct nvme_id_ctrl {
@@ -829,6 +830,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_register	= 0x0d,
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
+	nvme_cmd_io_mgmt_recv	= 0x12,
 	nvme_cmd_resv_release	= 0x15,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
@@ -850,6 +852,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
@@ -1001,6 +1004,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
+	NVME_RW_DTYPE_DPLCMT		= 2 << 4,
 	NVME_WZ_DEAC			= 1 << 9,
 };
 
@@ -1088,6 +1092,20 @@ struct nvme_zone_mgmt_recv_cmd {
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
@@ -1808,6 +1826,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_io_mgmt_recv_cmd imr;
 	};
 };
 
-- 
2.25.1


