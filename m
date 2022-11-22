Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869C5C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dWkdLccAFgwEs4tz72UdzMTYczUIeztfzuP+CwAkd30=; b=zhFvrOXCZzwBX99S+JGN2wopW4
	aWI82QK5vq1Y/meY75vuVK3hmFrNvT8ob+QzWjTqyf+PBOGaUilhk1sQ3aGv1iipj9nE85ExKkCX/
	ADASEWYx7T9R9qIYNs9xnB3C/HAQoMIn8WgjknyzJD/HVj5ULlMcFHbWTyibymcrt3rTmXum3DUvS
	L7lQNammqYhIi/LglJUccRLMsrTLTlZAf8ygDNgUu4gxlXfOKO1NZ0nOngI6Dkrj/6t1oRe2XdDCo
	yGxLNMaotI7OV/FAXWBU+nDzCcG1jfSgquMk/jSp2OUUArqR08ZS8Isg7zXXGpSuhC3HzKD4W9nBO
	5Xi7nVMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPa1-0070LC-9K; Tue, 22 Nov 2022 09:28:37 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxPY7-006yy6-J4
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 09:26:44 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221122092633euoutp02c571f516c2fa2dfe59f1a2b228cde04d~p3ffWnKxs1993319933euoutp02K
	for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 09:26:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221122092633euoutp02c571f516c2fa2dfe59f1a2b228cde04d~p3ffWnKxs1993319933euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669109193;
	bh=dWkdLccAFgwEs4tz72UdzMTYczUIeztfzuP+CwAkd30=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=mbm1hAPnQ15hgj3H0bRF0GVGrQKc0KP1TJmHrHrne8zByLxEdIjUqYYFKJiXicv1A
	 y6r8lwG8V3MEPmQRZsghIl9eQmDLYHS+ZJv2Y2uXkNYt1wG8gA/MxQbKmnvn3jFN8b
	 NOmTPNZaCQQT873N9JosJoMSLLGYsWsgpcRf6Rks=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221122092633eucas1p1a453cae301e491979e0e4cdef4b8ef69~p3ffK118e2585725857eucas1p1R;
	Tue, 22 Nov 2022 09:26:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.CC.09561.9C59C736; Tue, 22
	Nov 2022 09:26:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221122092632eucas1p2648479360860fa80e35c964d99b54f0b~p3fezun7w3120131201eucas1p2H;
	Tue, 22 Nov 2022 09:26:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221122092632eusmtrp27b9393dc92fd76e399d897256dd0a511~p3fezLKwx0180001800eusmtrp2A;
	Tue, 22 Nov 2022 09:26:32 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-55-637c95c95319
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.9F.09026.8C59C736; Tue, 22
	Nov 2022 09:26:32 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221122092632eusmtip2e8e0045f9ac47c0bc6ffa3510ebbd0cc~p3femZfd21859018590eusmtip29;
	Tue, 22 Nov 2022 09:26:32 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 22 Nov 2022 09:26:32 +0000
From: Joel Granados <j.granados@samsung.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <kbusch@kernel.org>,
	<chaitanyak@nvidia.com>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v4 1/1] nvme : Add ioctl to query nvme attributes
Date: Tue, 22 Nov 2022 10:22:44 +0100
Message-ID: <20221122092244.899894-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221122092244.899894-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOd2TU2uSDS7/Z7N4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVsfBnD0vBEtuKUxNlGxhvGnUxcnJICJhIrD56n72LkYtDSGAFo8StPdugnC+MEtO/
	dDNBOJ8ZJa492ccO0/Lp/C5miMRyRomP/3cygSTAqrrn+0EkNjNKdM3YywaSYBPQkTj/5g4z
	iC0iECLxcctvVhCbWSBN4n3vcbCpwgKOEjPP72UEsVkEVCV6519g6WLk4OAVsJHo384PsVhe
	ou36dLASTgFbiXtHusFsXgFBiZMzn7BAjJSXaN46mxnClpA4+OIFM0SvosSWOd9ZIexaib3N
	B8DelBC4wyHx+vAqdpBdEgIuEhO/R0HUCEu8Or4F6mEZif875zNB2NkSO6fsgppZIDHr5FQ2
	iFZrib4zORBhR4lLM7YxQoT5JG68FYS4hk9i0rbpzBBhXomONqEJjCqzkNw/C8n9s5Dcv4CR
	eRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgSjn97/inHYxzX33UO8TIxMF4iFGCg1lJ
	hLfesyZZiDclsbIqtSg/vqg0J7X4EKM0B4uSOC/bDK1kIYH0xJLU7NTUgtQimCwTB6dUA5Mz
	R1RH3smdp6fJTxK5ErcicO6iu+6CHPotEl8i/FpV6zTW1J44bnGDyTksRr+iala9W/LOHzWP
	Fks47Nh0dfbK78d2KD9amiq5kKuf4WXNrgm73iQd5a86mTKj40aS3O/ME5y8fYdvTuwIfHXh
	1VqPi1JCXxsDKlhLM6dcWqiUuEUhNOCdu9UNAcdtBdMadV/XOl9mOFXfWbX/AOf6mbeetMxi
	CHD7eedcdOIdmZ256r3XT+03uHN5/eYv3bavi5bX+TToca/ffHr24/V3LO/7/ZW6fIYvffat
	Np86/dkTliq7aIgf77dymeYnNuNhwzu+ra+tp1sVzjrJkuZh3ldQbFKk6flMQ669vEz5naoS
	S3FGoqEWc1FxIgCIzWQUmAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7onptYkG6yYq2vx/uBjVouVq48y
	WUw6dI3RYv6yp+wW616/Z3Fg9Th/byOLx6ZVnWwem5fUe+y+2cDm0dv8ji2ANUrPpii/tCRV
	ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY+HPHpaCJbYVpybK
	NjDeNOpi5OSQEDCR+HR+F3MXIxeHkMBSRolHXVMZIRIyEp+ufGSHsIUl/lzrYoMo+sgo8WLh
	ZiYIZzOjxKffzawgVWwCOhLn39xhBrFFBEIkPm75DRZnFkiTeN97HGySsICjxMzze8E2sAio
	SvTOv8DSxcjBwStgI9G/nR9imbxE2/XpYCWcArYS9450g9lCQCV7mpvZQGxeAUGJkzOfsECM
	l5do3jqbGcKWkDj44gUzxBxFiS1zvrNC2LUSna9Os01gFJmFpH0WkvZZSNoXMDKvYhRJLS3O
	Tc8tNtIrTswtLs1L10vOz93ECIy7bcd+btnBuPLVR71DjEwcjIcYJTiYlUR46z1rkoV4UxIr
	q1KL8uOLSnNSiw8xmgK9OZFZSjQ5Hxj5eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZ
	qakFqUUwfUwcnFINTDqrN39uu358Tbbwf7YrCTdXVBzK+biYlb9KTmF9Qp6i+MyzNrkzvJrX
	lUUcTrW6Oe8oZ9aPrM3KM57+/FfOvndywOGjV9xrffgrb0bdOiV/cQV/1MLbZwKqd23hbL8s
	/6ag/XLrSmX1aQlTuG4kPHOzcmWfLbvK6iXj5zkT9tqzH3aYWNmy579hkFKrVtgEp5vcSWer
	jIrqutQt3s+1mX3AqOmr7uv5EpIxmwqCTS0vvZuVesMzd+nuFL/LYflXvzvMtPJNv5p6NcFD
	rrJJZbHPyh8TGvbotS7a7/Sgov3/TM9Jz//PXW3rJ57vk1u5vKm0amJI2xL5h9tCvu/Qu6ov
	WcZ1L0fK5U+I1HUeRSWW4oxEQy3mouJEAGRhPTBEAwAA
X-CMS-MailID: 20221122092632eucas1p2648479360860fa80e35c964d99b54f0b
X-Msg-Generator: CA
X-RootMTR: 20221122092632eucas1p2648479360860fa80e35c964d99b54f0b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221122092632eucas1p2648479360860fa80e35c964d99b54f0b
References: <20221122092244.899894-1-j.granados@samsung.com>
	<CGME20221122092632eucas1p2648479360860fa80e35c964d99b54f0b@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_012640_030094_68156559 
X-CRM114-Status: GOOD (  24.66  )
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
index 2f76cba67166..5ad2fe1951e4 100644
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
+#define NVME_IOCTL_GET_ATTR	_IO('N', 0x50)
 
 /* io_uring async commands: */
 #define NVME_URING_CMD_IO	_IOWR('N', 0x80, struct nvme_uring_cmd)
-- 
2.30.2


