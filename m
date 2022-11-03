Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF04BC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3nqhPjygjHSVEkN55SFSGc/D10IP5PD246eGLqs04JI=; b=aUoQeBMnsqGmvAszo9/M2OdTmz
	lQwiDRBhzHLjEANCVIYHliamu8WLsgzCWsVBNZVTDCD77ZxdHF4Iglya6wENjOgti41aEo5/MI5A3
	VAFK9cK6PC4Xfo/XYM97duZk06oXsxxJAiCOX1rCE7/IBkv0GrHowhe9CQ2kSAeJ5S0leY1JZK8dP
	tv3GDV4e9WiDmQTCALAJjoO+Q0P5sDVO1LFFHZEbW0q6QaXH2ojXklH2IOpucET2hD6CaTjzdTO0D
	weDtG1wbyATesQsLI4QHCpgpOnlwFCDXYsLs0TPCGDUUQH5+caTeap7OLonXWuZH8K3CRIrfsOsWt
	nQFi0VyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqZNn-00HJqX-Ur; Thu, 03 Nov 2022 12:31:44 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqZNc-00HJoJ-H4
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 12:31:37 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221103123122euoutp01e0625d2805b67569297a48dc3928d6d6~kEwbmRgU60854108541euoutp01m
	for <linux-nvme@lists.infradead.org>; Thu,  3 Nov 2022 12:31:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221103123122euoutp01e0625d2805b67569297a48dc3928d6d6~kEwbmRgU60854108541euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667478682;
	bh=3nqhPjygjHSVEkN55SFSGc/D10IP5PD246eGLqs04JI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=FNVvNgqtk+d2A6xvodf42JHW838g4BMdU6EUKlaPDhl8/2P6hhyD3AfbRa+cy/oSm
	 2q3n75woqCryaeQCTbync0mn2dzuECxThl6IVIRsJCUS3NM7ZGXYW3Vpb4g43K4+bD
	 nRyXB3UEcbK8LmS9Ofh+plbv0l6P4LYWbxfrH7c8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221103123121eucas1p275383bd4cdd7eee0ccb586afab3f1cd5~kEwbLu6WQ2287022870eucas1p2P;
	Thu,  3 Nov 2022 12:31:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.59.07817.994B3636; Thu,  3
	Nov 2022 12:31:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2~kEwam1LIY2393523935eucas1p1d;
	Thu,  3 Nov 2022 12:31:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221103123121eusmtrp28334041a5440572a5250d0139443aba6~kEwamJQIx2873828738eusmtrp2o;
	Thu,  3 Nov 2022 12:31:21 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-9c-6363b4996569
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 44.9D.10862.994B3636; Thu,  3
	Nov 2022 12:31:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221103123121eusmtip12f9d2ba22d5bb65766896ab6fdac9e06~kEwaYve7j2966729667eusmtip14;
	Thu,  3 Nov 2022 12:31:21 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 3 Nov 2022 12:31:20 +0000
From: Joel Granados <j.granados@samsung.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <kbusch@kernel.org>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH 1/1] nvme : Add ioctl to query nvme attributes
Date: Thu, 3 Nov 2022 13:27:46 +0100
Message-ID: <20221103122746.3599480-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103122746.3599480-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djP87oztyQnGyw9aGixcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDIWXj3O
	VLDaueLkhaeMDYz/zLoYOTkkBEwkrvSeZeli5OIQEljBKHHm00Io5wujxI1fZ9khnM+MEmdb
	Wli7GDnAWk40KEHElzNK7Dm2lRGuaF7nZlYIZxOjxMX2M2wgS9gEdCTOv7nDDNItImAp8fhT
	KkiYWSBN4n3vcXaQsLCAncSBiUUgYRYBFYnN5zezg9i8ArYS71bfYYM4VV6i7fp0RhCbE6h8
	1qxDLBA1ghInZz5hgRgpL9G8dTYzhC0hcfDFC2aIXkWJLXO+s0LYtRKnttxiAjlTQuACh8SL
	uV1QCReJLQfXQzUIS7w6voUdwpaR+L9zPhOEnS2xc8ouqJoCiVknp7JBAsVaou9MDkTYUeLt
	qrcsEGE+iRtvBSHO4ZOYtG06M0SYV6KjTWgCo8osJA/MQvLALCQPLGBkXsUonlpanJueWmyU
	l1quV5yYW1yal66XnJ+7iRGYQE7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4a0/G50sxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnJdthlaykEB6YklqdmpqQWoRTJaJg1OqgSn82/f/5cH9Ybb/jl36
	zMx64NrVr4uXvsreZ/ligcNZS8k3sh5vbwXvfHPYerJi7dTmijKTrBtbk0/uk16W0fbap0Wf
	aXH+vCrDKRdvP8w6uC1o4W/Nw++dCrybzi9wN1lxb6lCmvRZS4NL3pNbo6s51P1DD8uqP7/L
	Ou0GS4vlg4ybarn/nu/s4b1frph1bPvjpLt/rqrGq59b6BYWsev9cfk1SSf7eAzUg88/c6yr
	V5py5fFRQSFTmx8Fuj5/N4aGOnoX6/BNjVgVkTPt1V6z2NPLX5hPMA70OdHn3lc/fY714mXc
	DJqdP+9PNU82bI1+fpOx5OiqGS2uLz8xL8zYtfM7e0bp78xNFzVf7yhXYinOSDTUYi4qTgQA
	Aw4LYI8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7oztyQnG2x+zG2xcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIWXj3OVLDaueLkhaeMDYz/zLoYOTgk
	BEwkTjQodTFycQgJLGWU+NG3i7mLkRMoLiPx6cpHdghbWOLPtS42iKKPjBIn/5xlgnA2MUq8
	PNrDAlLFJqAjcf7NHWaQqSIClhKPP6WChJkF0iTe9x5nBwkLC9hJHJhYBBJmEVCR2Hx+M9h8
	XgFbiXer77BB7JKXaLs+nRHE5gQqnzXrENh0IaCaX5deMUPUC0qcnPmEBWK8vETz1tnMELaE
	xMEXL6DuV5TYMuc7K4RdK/H57zPGCYwis5C0z0LSPgtJ+wJG5lWMIqmlxbnpucVGesWJucWl
	eel6yfm5mxiBEbbt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG/92ehkId6UxMqq1KL8+KLSnNTi
	Q4ymQH9OZJYSTc4HxnheSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwen
	VANT7oTqfSJTim+w7mDeXLCp7eO3CVv8PnjW+PFcuJXWGFEqnHDG5+4fHaPvU7tqW5eKSLJ6
	rJELzUlp7k9jOm/TJyjIxx9XJ5pawFtWbpbyI3zGtm1XTN/5X1vZ4HFjsUGqh8KxZyqa7x43
	c507/aX+J5/8hXCDHx7HrhW9PLJFpl/6od/GLetVF/Q7CgYvPC0xb+9hDdfs5teJPdZNJVJn
	uvJXTXh2P+cQ4+Ol7nqdYjbtXrumRq5c47opsfTMhy5V0eZfXku+9JpuZ1//4uNHo2pxnZ/2
	rRrxPNYrxGf+WFWy7PAsyc+Jefaf+XxUy2XYez89kr31WOn306oYMRVW96TPVcJ7XknLRq+d
	66/EUpyRaKjFXFScCABLXtWzOQMAAA==
X-CMS-MailID: 20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2
X-Msg-Generator: CA
X-RootMTR: 20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2
References: <20221103122746.3599480-1-j.granados@samsung.com>
	<CGME20221103123121eucas1p1b1919ee3bc9a86d6af56e5e5694e07f2@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_053133_996160_F61D4B68 
X-CRM114-Status: GOOD (  23.43  )
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

An ioctl (NVME_IOCTL_GET_ATTR) is added to query nvme controller
attributes needed to effectively write to the char device without needing
to be a privileged user.  They are also provided on block devices for
convenience. The attributes here are meant to complement what you can
already get with the allowed identify commands.

New members are added to the nvme_ctrl struct: dmsl, vsl and wusl from
the I/O Command Set Specific Identify Controller Data Structure in the nvme
spec.

We add NVME_IOCTL_GET_ATTR_{V0SZ,CURZS} in order to make the ioctl
extensible. These serve as both size and version. The caller is expected to
pass the structure size as the first member of the struct. For example:

	{...
	struct nvme_get_attr nvme_get_attr = {0};
	nvme_get_attr.argsz = sizeof(struct nvme_get_attr);
	...}

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/core.c        |  5 ++-
 drivers/nvme/host/ioctl.c       | 57 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 +++++
 include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6..267f28592b9d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3062,9 +3062,12 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
-	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
+	ctrl->dmrsl = le32_to_cpu(id->dmrsl);
+	ctrl->dmsl = le64_to_cpu(id->dmsl);
+	ctrl->vsl = id->vsl;
+	ctrl->wusl = id->wusl;
 
 free_data:
 	kfree(id);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9273db147872..2197a2b7ab56 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -53,6 +53,57 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+static inline u32 nvme_sectors_to_mps(struct nvme_ctrl *ctrl, u32 unit)
+{
+	return ilog2(unit) + 9 - 12 - NVME_CAP_MPSMIN(ctrl->cap);
+}
+
+static int nvme_ctrl_export_attrs(struct nvme_ctrl *ctrl,
+				  struct nvme_get_attr __user *arg)
+{
+	struct nvme_get_attr nvme_get_attr = {0};
+	__u32 usize, retsize;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(struct nvme_get_attr) < NVME_IOCTL_GET_ATTR_V0SZ);
+	BUILD_BUG_ON(sizeof(struct nvme_get_attr) != NVME_IOCTL_GET_ATTR_CURSZ);
+
+	if (copy_from_user(&nvme_get_attr, arg, 2 * sizeof(__u32)))
+		return -EFAULT;
+
+	if (nvme_get_attr.flags != 0)
+		return -EINVAL;
+
+	if (nvme_get_attr.argsz < NVME_IOCTL_GET_ATTR_V0SZ)
+		return -EINVAL;
+	usize = nvme_get_attr.argsz;
+
+	// Enforce backwards compatibility
+	ret = copy_struct_from_user(&nvme_get_attr, NVME_IOCTL_GET_ATTR_CURSZ, arg, usize);
+	if (ret)
+		return ret;
+
+	nvme_get_attr.argsz = NVME_IOCTL_GET_ATTR_CURSZ;
+	nvme_get_attr.mpsmin = NVME_CAP_MPSMIN(ctrl->cap);
+	nvme_get_attr.vsl = ctrl->vsl;
+	nvme_get_attr.wusl = ctrl->wusl;
+	nvme_get_attr.dmrl = ctrl->max_discard_segments;
+	nvme_get_attr.dmsl = ctrl->dmsl;
+	nvme_get_attr.dmrsl = ctrl->dmrsl;
+	nvme_get_attr.oncs = ctrl->oncs;
+	if (ctrl->max_zeroes_sectors > 0)
+		nvme_get_attr.wzsl = nvme_sectors_to_mps(ctrl, ctrl->max_zeroes_sectors);
+	if (ctrl->max_hw_sectors > 0)
+		nvme_get_attr.mdts = nvme_sectors_to_mps(ctrl, ctrl->max_hw_sectors);
+
+	retsize = min(usize, NVME_IOCTL_GET_ATTR_CURSZ);
+	if (copy_to_user((struct nvme_get_attr __user *)arg, &nvme_get_attr,
+			 retsize))
+		return -EFAULT;
+
+	return 0;
+}
+
 static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		unsigned len, u32 seed)
 {
@@ -613,6 +664,8 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 		return nvme_user_cmd(ctrl, NULL, argp, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ctrl, argp);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -659,6 +712,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
 		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ns->ctrl, argp);
 	default:
 		return -ENOTTY;
 	}
@@ -950,6 +1005,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 			return -EACCES;
 		nvme_queue_scan(ctrl);
 		return 0;
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ctrl, argp);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee6..07c0d12747b7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -291,6 +291,9 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u32 dmrsl;
+	u64 dmsl;
+	u8 vsl;
+	u8 wusl;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
@@ -815,6 +818,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		int qid, int at_head,
 		blk_mq_req_flags_t flags);
+
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
@@ -1072,4 +1076,11 @@ static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
 }
 #endif /* CONFIG_NVME_VERBOSE_ERRORS */
 
+/*
+ * List of all nvme ioctl controller attribute calls. Use size of nvme_get_attr
+ * as the version which enables us to use copy_struct_from_user
+ */
+#define NVME_IOCTL_GET_ATTR_V0SZ		32u
+#define NVME_IOCTL_GET_ATTR_CURSZ		NVME_IOCTL_GET_ATTR_V0SZ
+
 #endif /* _NVME_H */
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 2f76cba67166..f15d2f7363fb 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -92,6 +92,79 @@ struct nvme_uring_cmd {
 	__u32   rsvd2;
 };
 
+
+/*
+ * This struct is populated from the following nvme commands:
+ * [1] Identify Controller Data Structure
+ * [2] I/O Command Set Specific Identify Controller Data Structure for the
+ *     NVME Command Set. Usually contained in struct nvme_id_ctrl_nvm
+ * [3] Controller capabilities on controller initialization
+ */
+struct nvme_get_attr {
+	__u32	argsz;
+	__u32	flags;
+
+	/*
+	 * Memory Page Size MINimum : The host should not configure a page size that
+	 * is larger than (2 ^ (12 + mpsmin)). Comes from [3]
+	 */
+	__u32	mpsmin;
+
+	/*
+	 * Verify Size Limit : Recommended or supported data size for a verify
+	 * command. From [2].
+	 */
+	__u8	vsl;
+
+	/*
+	 * Write Zeroes Size Limit : Recommended or supported data size for a
+	 * zeroes command. From [2].
+	 */
+	__u8	wzsl;
+
+	/*
+	 * Write Uncorrected Size Limit : Recommended or supported data size for
+	 * an uncorrected command. From [2].
+	 */
+	__u8	wusl;
+
+	/*
+	 * Dataset Management Ranges Limit : Recommended or supported maximum
+	 * number of logical block ranges for the Dataset Management Command.
+	 * From [2].
+	 */
+	__u8	dmrl;
+
+	/*
+	 * Dataset Management Size Limit : Recommended or supported maximum of
+	 * total number of logical blocks for a Dataset Management Command.
+	 * From [2].
+	 */
+	__u64	dmsl;
+
+	/*
+	 * Dataset Management Range Size Limit : Recommended or supported maximum
+	 * number of logical blocks in a range of a Dataset Management Command.
+	 * From [2].
+	 */
+	__u32	dmrsl;
+
+	/*
+	 * Optional NVM Command Support. Is needed to make sense of attributes
+	 * like vsl, wzsl, wusl... Comes from [1].
+	 */
+	__u16	oncs;
+
+	/*
+	 * Maximum data transfer size. Commands should not exceed this size.
+	 * Comes from [1].
+	 */
+	__u8	mdts;
+
+	__u8	rsvd0;
+
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_IOCTL_ID		_IO('N', 0x40)
@@ -104,6 +177,7 @@ struct nvme_uring_cmd {
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_GET_ATTR	_IOWR('N', 0x50, struct nvme_get_attr)
 
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
-- 
2.30.2


