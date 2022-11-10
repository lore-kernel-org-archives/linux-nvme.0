Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D835C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kiDfF0EjRk3KCVW64QsqIZQbi4hbjsCa3KwRdxlyV5o=; b=NpXch2Ej05ybL0U3aAbGUnlYDH
	c3P2oLVXJ34E2u+2uOr0tJ7omGi06w+xfDcYiCsLP5aZI0WvpHMBvFF3AIjhd5169tNwb4++p2cbr
	9xjmdgKsvSEu+RAVqcm7giOo1qz7/zMOkOnrdBkrOn/nbWGU6hwEQpdzZLea+I2uMmF0uG1a+w3xK
	Pq/Z7d480+ikevvOFP9H0drmnD09JFosEreALeM22bK7Shw/Ft2S5LLQ51ewh1zn6/Zb6/Yv7daWf
	ms8hqRFcljngwPtxwVvKD4n4M4rL1HfIeWk+B+0q5C43b2SshOv3ALmqDkGsvPnQ5d0UT6tJLh2tY
	fhYvB0cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot5lc-005NAA-BO; Thu, 10 Nov 2022 11:30:44 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot5Qj-005EN2-TG
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 11:09:13 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221110110859euoutp02927c89b48eca4997c490f0ee390a26ca~mNJgP8HAr0532205322euoutp02T
	for <linux-nvme@lists.infradead.org>; Thu, 10 Nov 2022 11:08:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221110110859euoutp02927c89b48eca4997c490f0ee390a26ca~mNJgP8HAr0532205322euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668078539;
	bh=kiDfF0EjRk3KCVW64QsqIZQbi4hbjsCa3KwRdxlyV5o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=o4Wtr2ALc6K2vEA18JaRJJGRhdDuvZuYOlO7IM6atfOlyn+vIkY+AHAFe28oR8OlM
	 dqsfe3pRbQqjkBg8CMF7bJbf6xueajf75Kwd7Duju3nHbwxcZ3bLD6ZzTHmEGlWH2b
	 EaBf7Lc0Khy1nqdhHPmG5UJCHdrhKL86ltMzC9Z0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221110110859eucas1p2271d10967234f61e7e0d826c43b453dc~mNJgAPzhn1163711637eucas1p2x;
	Thu, 10 Nov 2022 11:08:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.9B.09561.BCBDC636; Thu, 10
	Nov 2022 11:08:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c~mNJfuNE171240312403eucas1p2C;
	Thu, 10 Nov 2022 11:08:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221110110859eusmtrp2efce0c014338d54a5f9b4c54566e7bc0~mNJftmLX62561325613eusmtrp2R;
	Thu, 10 Nov 2022 11:08:59 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-bd-636cdbcb5648
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.02.09026.ACBDC636; Thu, 10
	Nov 2022 11:08:58 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221110110858eusmtip1508552b0a0e79171ae168b364533d801~mNJfepbq12051420514eusmtip1A;
	Thu, 10 Nov 2022 11:08:58 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 10 Nov 2022 11:08:58 +0000
From: Joel Granados <j.granados@samsung.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <kbusch@kernel.org>,
	<chaitanyak@nvidia.com>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v2 1/1] nvme : Add ioctl to query nvme attributes
Date: Thu, 10 Nov 2022 12:05:22 +0100
Message-ID: <20221110110522.1626637-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110110522.1626637-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd3Tt3OSDXZuFbN4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVcXrKOsaCg84V16Z+Zmpg7DLvYuTkkBAwkZjytI2li5GLQ0hgBaPEqiWnWSGcL4wS
	5zofQDmfGSUmbpvPDNPy6+99qJbljBIX5nWwwVU9X7yOEaRKSGAzo0RDuxiIzSagI3H+zR2w
	bhGBEImPW36zgtjMAmkS73uPs4PYwgKOEs0rprGA2CwCqhK9M16BzeEVsJV43raCBWKzvETb
	9elgcU4BO4mpd3ezQdQISpyc+YQFYqa8RPPW2cwQtoTEwRcvoK5WlNgy5zsrhF0rsbf5ADvI
	0RICdzgk5r3pg0q4SLzsPsYIYQtLvDq+hR3ClpH4v3M+E4SdLbFzyi6ooQUSs05OBTqCA8i2
	lug7kwMRdpT4/OA0I0SYT+LGW0GIc/gkJm2bzgwR5pXoaBOawKgyC8kDs5A8MAvJAwsYmVcx
	iqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJpbT/45/2sE499VHvUOMTByMhxglOJiVRHi5
	NbKThXhTEiurUovy44tKc1KLDzFKc7AoifOyzdBKFhJITyxJzU5NLUgtgskycXBKNTA1Rusu
	Z9hUlXQv5If5YuV3Ev892Zif2F/WnMD7dYpxV9z8OcEq1xvf/r4etcbcrCjBY2JIOMtrcZX4
	7JRrhlE/j73cGXOs76jbilv1nv+1NaY1mGdZKDRmHflZdPquxqqKgjyWXQEsB2Y82WLNKey7
	ICDEeELnpT1sFVevHqxd2psfumyx+K1Zm+13NZkwH+x1WyXF1Fu4rCPlTET0ntXTddnWKM5Z
	EXvuiKW+7cH/DsvSl//Onnus5kZnRpe9yPnT9ZeFmU+cn/Fp8u28BxvXfM95br4gMPkr1xpT
	8+vHW9hL5OKEa1q+qTKuXcbnvjZfdp+qyadNojxMOY//uPNPj17+on339Y8SzLvWvexXYinO
	SDTUYi4qTgQAgaCiE5sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7qnbuckG7SftLZ4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcXrKOsaCg84V16Z+
	Zmpg7DLvYuTkkBAwkfj19z5LFyMXh5DAUkaJ54d2skIkZCQ+XfnIDmELS/y51sUGUfSRUWLK
	lt9gRUICmxklPjeWgthsAjoS59/cYQaxRQRCJD5C1TALpEm87z0ONkhYwFGiecU0FhCbRUBV
	onfGK0YQm1fAVuJ52woWiGXyEm3Xp4PFOQXsJKbe3Q20mANol63EhY3qEOWCEidnPmGBGC8v
	0bx1NjOELSFx8MULZogxihJb5nyH+qVWovPVabYJjCKzkLTPQtI+C0n7AkbmVYwiqaXFuem5
	xUZ6xYm5xaV56XrJ+bmbGIFxt+3Yzy07GFe++qh3iJGJg/EQowQHs5IIL7dGdrIQb0piZVVq
	UX58UWlOavEhRlOgNycyS4km5wMjP68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1
	ILUIpo+Jg1OqgYnX6Zyb6e3DjHa8BhWzLGTFGgrE1227qOY4tTVgpVfAoR52VRfp85JRJjoV
	O1W45ledVTmgfG6tj57KO6Gpb+ftvp/9V0rNYnGfoPzmyXzNzFLnRZ5G8PzYry5qO7c6dMr+
	+osdHau2Ze4W897Zv7W4V15XoZefzW1ebzqjUKPKZu0rwXFn0lwZ/L6WTHq8Z7X1Sb6cOH2x
	M+8TF3x7ylT5ehbLVGdTY4eWOcc9GCev3POgP/j8wULvla9fVvPUsor/uXR1r5Dv36Sd9hnn
	T22dvsmf8e/M7xz2ljz/fvc8UD7UGPtTee/jV2tPrmxLFJxTW/fx355D3yc/fvOw4M1SjuOK
	G5xuLdX+cvm8P58SS3FGoqEWc1FxIgDKsu+2RAMAAA==
X-CMS-MailID: 20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c
X-Msg-Generator: CA
X-RootMTR: 20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c
References: <20221110110522.1626637-1-j.granados@samsung.com>
	<CGME20221110110859eucas1p25881553dd9cbe21118561b1f2692ed6c@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_030910_276514_F5A1F732 
X-CRM114-Status: GOOD (  23.40  )
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
 drivers/nvme/host/ioctl.c       | 58 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 11 +++++
 include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)

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
index 9273db147872..ce69659f05b6 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -53,6 +53,58 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
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
@@ -613,6 +665,8 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 		return nvme_user_cmd(ctrl, NULL, argp, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ctrl, argp);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -659,6 +713,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
 		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
+	case NVME_IOCTL_GET_ATTR:
+		return nvme_ctrl_export_attrs(ns->ctrl, argp);
 	default:
 		return -ENOTTY;
 	}
@@ -950,6 +1006,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
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


