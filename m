Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5D0C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tFheIn/VkVYaZ/Hmf92QiS3etV23lsXUp06DU3LwTOk=; b=G/adzMDRl0rJ0W3Z97gwpsN+7g
	UG0J97B2w42psAsxDR3OeJtPt5Iuvvkr/PtDPyST68tnyR08MNbU1KA3MxMA2R44MEpmyaP/3Hhx5
	MwwTN/WXlLWsjl73SmAiNOYP7/3dtM+ykxMiE32BqXIUi4/cYFJRfvDbnHpw5qRU97/BEvhAJq3AJ
	lxHt+yWJ72pO7BaEdgjO/CdB7iGHbu9/FulRFhQHxR8DbXfDrcaxhY8GiWLoQNQC05md1ydaVxd59
	A6gUSLR2W9gIjpbnVzeA8uXY0gY3APOMugGYo588cp8Y7sh75xn+NDZjL9PlBHdRb86sFnVIkH7Wr
	SwmzblMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovfhu-00Ekmv-9O; Thu, 17 Nov 2022 14:17:34 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovfhl-00Ekhj-Ui
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 14:17:29 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221117141719euoutp016a035e262ff4c45ae4251b8b64de3b63~oZO7oEOus0582905829euoutp018
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 14:17:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221117141719euoutp016a035e262ff4c45ae4251b8b64de3b63~oZO7oEOus0582905829euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668694639;
	bh=tFheIn/VkVYaZ/Hmf92QiS3etV23lsXUp06DU3LwTOk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ngWCXEjFJQ3oAqnHdbTZmd0ShEJkCv11swALC1DV+F9O3nAYnIOFRRyE8mpqytmzP
	 TGAgcHCdgQOeYJ90HADrfNXJ7y+sB2qOk3Kr07ncuebet/AYNXZid3a5uIHEf0x9LU
	 ZkhTF23seUSlE5XbIdJUjIMlSI2Qcyg+1hJc4PV0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221117141719eucas1p1b59333ec9cb7af190a8f8dab58571331~oZO7cykuF0102801028eucas1p1R;
	Thu, 17 Nov 2022 14:17:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.52.09549.E6246736; Thu, 17
	Nov 2022 14:17:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8~oZO7LHEcc0097300973eucas1p1V;
	Thu, 17 Nov 2022 14:17:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221117141718eusmtrp173177de6e4fc4027582a2428bc28461d~oZO7Kg7MN0620206202eusmtrp1W;
	Thu, 17 Nov 2022 14:17:18 +0000 (GMT)
X-AuditID: cbfec7f5-f47ff7000000254d-71-6376426e7c37
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.E5.09026.E6246736; Thu, 17
	Nov 2022 14:17:18 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221117141718eusmtip1e92314379b28d3982d5fae37c4fc183b~oZO7CVWpI2274122741eusmtip1b;
	Thu, 17 Nov 2022 14:17:18 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 17 Nov 2022 14:17:17 +0000
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
	<kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v3 1/1] nvme : Add ioctl to query nvme attributes
Date: Thu, 17 Nov 2022 15:13:37 +0100
Message-ID: <20221117141337.3719372-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117141337.3719372-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd08p7Jkg95nVhbvDz5mtVi5+iiT
	xaRD1xgt5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwevc3v2AJYo7hsUlJzMstS
	i/TtErgyPszYyl6wx7Zi84FbTA2M7426GDk5JARMJDb8+M/WxcjFISSwglHi1fU+JpCEkMAX
	RomDcxQgEp8ZJZ69u8sC07Fk9QGoouWMEt+ayyBsoKKOpcoQDZsZJX7ff8sMkmAT0JE4/+YO
	mC0iECJxqnUH0DoODmaBNIlrXzhBTGEBR4lp+5lATBYBVYmnSwpBinkFbCUeznjIDLFVXqLt
	+nRGEJtTwE7iYvN5ZogaQYmTM5+AXcYMVNO8dTYzhC0hcfDFC6heRYktc76zQti1EmuPnWEH
	uVJC4AaHxJfTPUwQCReJE2tfs0PYwhKvjm+BsmUkTk/ugXo9W2LnlF1QQwskZp2cCvaJhIC1
	RN+ZHIiwo8TbORugwnwSN94KQpzDJzFp23RmiDCvREeb0ARGlVlIHpiF5IFZSB5YwMi8ilE8
	tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzCdnP53/OsOxhWvPuodYmTiYDzEKMHBrCTCm3ux
	NFmINyWxsiq1KD++qDQntfgQozQHi5I4L9sMrWQhgfTEktTs1NSC1CKYLBMHp1QDk3OIdVrH
	xq1GrEXfL5mvKw86HxhrKPT0rfScrdNZTSZstpjFdL7mn1NnTt51NYfUOewfo+POf27nWOwa
	Zuy4uOX7PDW+O7G5eceD7Xc0BrM+Dm7pO6yddMLtydGtL6uflYeXvzdlnMHQutmwV7nh2HPO
	LXsqew9u9lGc/22T2r2KCxuMY1N4/xQ+Pph6Zi9nyvEtMhsk+1+f0njqyCb7TsNRIDxLoUrX
	SLxx9RKzOeqL9bNc9j+Mu3Bc2Jjl6oTDsxliVbnj3CyM2VJOuNTMnrsphe+uxhfpOe9mtzz0
	M6ywZs1vjPJZsrNlZ+757Z/ufH8f8Me8vdHPJmPnTbFTR1a3cF94ErY5RWCTT6SrEktxRqKh
	FnNRcSIAvTrSzZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7p5TmXJBrM6NS3eH3zMarFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRunZFOWXlqQq
	ZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlfJixlb1gj23F5gO3
	mBoY3xt1MXJySAiYSCxZfYCpi5GLQ0hgKaPE6alvmSESMhKfrnxkh7CFJf5c62KDKPrIKPFz
	1zUWCGczo8SUK3/BOtgEdCTOv7kDZosIhEicat0B1MHBwSyQJnHtCyeIKSzgKDFtPxOIySKg
	KvF0SSFIMa+ArcTDGQ+h1spLtF2fzghicwrYSVxsPg8WFwKqWXKwnRGiXlDi5MwnLCA2M1B9
	89bZzBC2hMTBFy+g5ihKbJnznRXCrpV4dX834wRGkVlI2mchaZ+FpH0BI/MqRpHU0uLc9Nxi
	I73ixNzi0rx0veT83E2MwKjbduznlh2MK1991DvEyMTBeIhRgoNZSYQ392JpshBvSmJlVWpR
	fnxRaU5q8SFGU6A3JzJLiSbnA+M+ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
	tQimj4mDU6qBKSZ7+s+rCcztR0LvFe9Yqagw9cr2kMoTef99/lzRXrw0sFPvcnxo+b+orh+l
	0V/q2cv2TbRPUv+x+sPmN7u7urpmOL2oKD9V+14ikrlJhL/Y9tnuFZtmRJ448Png1pN8564F
	B38J/CPxKDPiS0KIlNLPu0fnvL5ftOnHucg9US0lWTeORpoZsATNV1mez5Z1IFJ2xYPOdNbA
	/+4yWdVHtiesWxe2tK2jqkVS7zKfxwL7liWTuNrTHfXzbSZX2vycZns204afR/dHtbC205rF
	De6s8qzBe8vvXzFe0Jc8//qTl2eeH3FQiA3YoM+8uo9t+eGfcVtP9r7TU5tVfHJiu1jwXhVe
	U4lnoWWFybmblFiKMxINtZiLihMB9/TxDkMDAAA=
X-CMS-MailID: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
X-Msg-Generator: CA
X-RootMTR: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8
References: <20221117141337.3719372-1-j.granados@samsung.com>
	<CGME20221117141718eucas1p11d0b9f10ff4c0ca6ba865251af775fc8@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_061726_612902_2FFF6742 
X-CRM114-Status: GOOD (  24.47  )
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
 drivers/nvme/host/core.c        |  8 ++++-
 drivers/nvme/host/ioctl.c       | 61 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 ++++++
 include/uapi/linux/nvme_ioctl.h | 23 +++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f94b05c585cb..51c99302786b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3061,9 +3061,12 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
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
@@ -5246,6 +5249,9 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_get_attr) < NVME_IOCTL_GET_ATTR_V0SZ);
+	BUILD_BUG_ON(sizeof(struct nvme_get_attr) != NVME_IOCTL_GET_ATTR_CURSZ);
+
 }
 
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9273db147872..daafea38d39b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -53,6 +53,61 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+/*
+ * Reverse conversion from sectors to original NVMe values expressed in units
+ * of MPSMIN. Use ilog2 to change to power of 2 values and then reverse what
+ * was done in nvme_mps_to_sectors. 9 is the kernel sectors size and 12 is part
+ * of how mpsmin is defined in the NVMe spec (2^(12 + mpsmin))
+ */
+static inline u32 nvme_sectors_to_mps(struct nvme_ctrl *ctrl, u32 unit)
+{
+	return ilog2(unit) + 9 - 12 - NVME_CAP_MPSMIN(ctrl->cap);
+}
+
+static int nvme_ctrl_export_attrs(struct nvme_ctrl *ctrl,
+				  struct nvme_get_attr __user *arg)
+{
+	struct nvme_get_attr nvme_get_attr = { };
+	__u32 usize, retsize;
+	int ret;
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
+	/* Enforce backwards compatibility */
+	ret = copy_struct_from_user(&nvme_get_attr, NVME_IOCTL_GET_ATTR_CURSZ,
+				    arg, usize);
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
+	ret = copy_to_user((struct nvme_get_attr __user *)arg, &nvme_get_attr, retsize);
+	if (ret)
+		return -EFAULT;
+
+	return 0;
+}
+
 static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		unsigned len, u32 seed)
 {
@@ -613,6 +668,8 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 		return nvme_user_cmd(ctrl, NULL, argp, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ctrl, argp);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -659,6 +716,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
 		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ns->ctrl, argp);
 	default:
 		return -ENOTTY;
 	}
@@ -950,6 +1009,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 			return -EACCES;
 		nvme_queue_scan(ctrl);
 		return 0;
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ctrl, argp);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f9df10653f3c..0f36259a7992 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -292,6 +292,9 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u32 dmrsl;
+	u64 dmsl;
+	u8 vsl;
+	u8 wusl;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
@@ -814,6 +817,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		int qid, int at_head,
 		blk_mq_req_flags_t flags);
+
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
@@ -1071,4 +1075,11 @@ static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
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
index 2f76cba67166..57b05d26f682 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -92,6 +92,28 @@ struct nvme_uring_cmd {
 	__u32   rsvd2;
 };
 
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
+	__u32	mpsmin;
+	__u8	vsl;
+	__u8	wzsl;
+	__u8	wusl;
+	__u8	dmrl;
+	__u64	dmsl;
+	__u32	dmrsl;
+	__u16	oncs;
+	__u8	mdts;
+};
+
 #define nvme_admin_cmd nvme_passthru_cmd
 
 #define NVME_IOCTL_ID		_IO('N', 0x40)
@@ -104,6 +126,7 @@ struct nvme_uring_cmd {
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_GET_ATTR	_IOWR('N', 0x50, struct nvme_get_attr)
 
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
-- 
2.30.2


