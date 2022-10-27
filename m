Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CF3FA3741
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HQ70eErw0l92qB2eJcqFlsIPEFb23C2fWksMYUlr+I=; b=4u6KZbMyXB1Qfa2eiuFeHcfFx5
	/oyu31IPHPffzzOO/vejj7+ocTtjnpV9gqozKKAHeeAwEgUN6St0ad22aTSiKb/PeO4GRUhjP/Lwq
	hi2yWs4ChVVInJZHcU3HCmwzKGo9pvIIAwPEVbzE3fbsNR4swbnFCo4csZGFZVOXtuiZOZCDFXjgb
	A+c2WV/OGgsoVke7q2zOuudFxL73EhLbn31TxWNyCLL+7lakJLyTcToh+xmnPg6AtlKw15LKhnutz
	AZD4idP7t7498+S+FoSVEMp8tE3DYLBsE+KZljNS5B9LpGaJ20IPBKOxW7AUpQ18yvbkmxQZvAhzo
	HzPiosVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5Jw-00E9m3-3w; Thu, 27 Oct 2022 16:01:28 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5Jg-00E9d5-Vo
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:01:16 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221027160109euoutp010d301cab0266d65b5f4283248c9a1584~h_GmDmdQq1395413954euoutp01x
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 16:01:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221027160109euoutp010d301cab0266d65b5f4283248c9a1584~h_GmDmdQq1395413954euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666886469;
	bh=8HQ70eErw0l92qB2eJcqFlsIPEFb23C2fWksMYUlr+I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZXFL8T0nljjZjl1jwkOHSXr/kfjcO9+Wbl6YOxlZOTIiawRRHSjZQS3HD8GVmmbfd
	 eWNTTl4JHrQjfjeQB1RgZ+bL1EBTSyZ6RrH+oC7cK/+Iaz5CouG1Ert91v62mTelTf
	 jXhiksL+eDEofqlDoZvhpv0BLo4naQ8DCM11jYnA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221027160108eucas1p2e950768ef92557bca7a16e854350a5cf~h_Glnf_Pw2435324353eucas1p24;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.89.29727.44BAA536; Thu, 27
	Oct 2022 17:01:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab~h_GlSvr2W2362923629eucas1p25;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221027160108eusmtrp17d8feec177c21b606218fc215a05831e~h_GlQ365D2493424934eusmtrp1Z;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-22-635aab44355d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.B7.07473.44BAA536; Thu, 27
	Oct 2022 17:01:08 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221027160108eusmtip2033308ec4ca7987eff0d59a0b41f4023~h_GlHh-nj1597815978eusmtip2W;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 27 Oct 2022 17:01:04 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<joshi.k@samsung.com>, <javier.gonz@samsung.com>, <p.raghav@samsung.com>,
	Joel Granados <j.granados@samsung.com>
Subject: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Date: Thu, 27 Oct 2022 17:57:24 +0200
Message-ID: <20221027155724.1161670-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221027155724.1161670-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87ouq6OSDX4/ULNYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBlnNm5g
	LbhgX7HqRBtbA2OjSRcjJ4eEgInEvp/3GbsYuTiEBFYwSpy7sp4FJCEk8IVR4sl5b4jEZyC7
	6RcjTMf7n2vYIBLLGSUuP2xnhKua1/SVHcLZzChx4Nk2dpAWNgEdifNv7jCD2CIClhIT3vxn
	ASliFtjEKHFr4zImkISwgI3Ep/YPQA0cHCwCqhKvpoqAhHkFbCWOPj7FArFaXqLt+nRGkBJO
	ATuJjvPmECWCEidnPgErYQYqad46mxnClpA4+OIFM0SrosSWOd9ZIexaib3NB8DulBC4wiGx
	vHMeE0TCReJ15zqoXcISr45vYYewZSROT+6BimdL7JyyC2pogcSsk1PZQO6RELCW6DuTAxF2
	lDi35RAjRJhP4sZbQYhz+CQmbZvODBHmlehoE5rAqDILyQOzkDwwC8kDCxiZVzGKp5YW56an
	FhvmpZbrFSfmFpfmpesl5+duYgSmkNP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeM/eCE8W4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzss2QytZSCA9sSQ1OzW1ILUIJsvEwSnVwDRnx/bz9jNPrz5h
	bb7wzTwD6wtBn5mzDmfYXcp1sVwqVbTNNoyzr+td8ObHLw/KC0QVMounrTtz+sgCjeip0x7V
	Nopr7mv3dFim0DP3xObDulenHnz93+dokny4+rvClR2afTrf5us7flM2W1qwe5H0jY2XZ/av
	n3quVPzM1k3Jhg8dTlfdW/zyUu25FKvE1QdqKvL5rkq/lp05/cOddMWWyU3X5WdfiG9ziBSX
	eMYZ3G2j5j49T0V+0XG5v4s+MFXs2dL/0OPbbc0ZNw9wdK//lXHY2SDSJjy2K3QiS6DIrrhJ
	gbf3tc5V0JufvGSm0OfJ3MscH02yeS9xgFWyMWT6idNBre997U/3Pnx1jH2WEktxRqKhFnNR
	cSIAC0EtyJADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7ouq6OSDebeFLBYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlnNm5gLbhgX7HqRBtbA2OjSRcjJ4eE
	gInE+59r2LoYuTiEBJYySmzedo8RIiEj8enKR3YIW1jiz7UuNhBbSOAjo8S1xaEQDZsZJT7s
	ug7WwCagI3H+zR1mEFtEwFJiwpv/LCBFzAKbGCVubVzGBJIQFrCR+NT+AWgqBweLgKrEq6ki
	IGFeAVuJo49PsUAsk5douz6dEaSEU8BOouO8OcReW4kfkzYwQ5QLSpyc+QSsnBmovHnrbGYI
	W0Li4IsXzBBjFCW2zPnOCmHXSnS+Os02gVFkFpL2WUjaZyFpX8DIvIpRJLW0ODc9t9hQrzgx
	t7g0L10vOT93EyMwxrYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4T17IzxZiDclsbIqtSg/vqg0
	J7X4EKMp0JcTmaVEk/OBUZ5XEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPH
	xMEp1cC08Oy1isatAUxTw55tFNh/+m+B3PHOs25vXhjNEry78YyY1tcfUl7iSRvKWh5lfu17
	sel486ULIYW9txe7O+bIqX47csvk6+9Dk3ybvaSWCuapdsncDGHsd+aOiArY7PB+ktDmTRVy
	2Z53RGT+lpw1NYs2q82sTKj7MdFpoccdu1YG9cgJ03TOvVkd9pqrKLSLZ3H01oNbFrDvu1KZ
	tSTz0f0iS/fzJzOU35g3zK13PW62L2aNlfklTZuX25W6VI8eN/i+vVD5eKgad53A7K/aDGXO
	305rF8txXJ0ouf3eildSN1ZXSHXu/Zi30X1S3cNt777Ey2x6ar5nXtfRwHq708vmbt3llTzl
	w8szShGuSizFGYmGWsxFxYkAZkUTBToDAAA=
X-CMS-MailID: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_090113_632652_CEBC0E13 
X-CRM114-Status: GOOD (  22.42  )
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
to be a priviledged user.  We also provide them for block devices for
convenience. The attributes here are meant to complement what you can
already get with the allowed identify commands.

We add NVME_IOCTL_GET_ATTR_{V0SZ,CURZS} in order to make the ioctl
extensible. These serve as both size and version. The caller is expected to
pass the structure size as the first memeber of the struct. For example:

	{...
	struct nvme_get_attr nvme_get_attr = {0};
	nvme_get_attr.argsz = sizeof(struct nvme_get_attr);
	...}

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/core.c        |  2 +-
 drivers/nvme/host/ioctl.c       | 58 ++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        | 10 +++++
 include/uapi/linux/nvme_ioctl.h | 74 +++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d76be125dc49..1cc14bd94aa5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1276,7 +1276,7 @@ static bool nvme_ctrl_limited_cns(struct nvme_ctrl *ctrl)
 	return ctrl->vs < NVME_VS(1, 1, 0);
 }
 
-static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
+int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
 	int error;
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9273db147872..21291981584b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -53,6 +53,58 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+static int nvme_ctrl_export_attrs(struct nvme_ctrl *ctrl,
+				  struct nvme_get_attr __user *arg)
+{
+	int ret;
+	struct nvme_id_ctrl *id_ctrl;
+	struct nvme_get_attr nvme_get_attr = {0};
+	struct nvme_id_ctrl_nvm *id_ctrl_nvm;
+	__u32 usize;
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
+	switch (nvme_get_attr.argsz) {
+	case NVME_IOCTL_GET_ATTR_V0SZ:
+		break;
+	default:
+		return -EINVAL;
+	}
+	usize = nvme_get_attr.argsz;
+
+	ret = nvme_identify_ctrl(ctrl, &id_ctrl);
+	if (ret)
+		return ret;
+
+	ret = nvme_identify_cs_ctrl(ctrl, &id_ctrl_nvm);
+	if (ret)
+		return ret;
+
+	nvme_get_attr.argsz = NVME_IOCTL_GET_ATTR_CURSZ;
+	nvme_get_attr.mpsmin = NVME_CAP_MPSMIN(ctrl->cap);
+	nvme_get_attr.vsl = id_ctrl_nvm->vsl;
+	nvme_get_attr.wzsl = id_ctrl_nvm->wzsl;
+	nvme_get_attr.wusl = id_ctrl_nvm->wusl;
+	nvme_get_attr.dmrl = id_ctrl_nvm->dmrl;
+	nvme_get_attr.dmsl = id_ctrl_nvm->dmsl;
+	nvme_get_attr.dmrsl = id_ctrl_nvm->dmrsl;
+	nvme_get_attr.oncs = id_ctrl->oncs;
+	nvme_get_attr.mdts = id_ctrl->mdts;
+
+	if (copy_to_user((struct nvme_get_attr __user *)arg, &nvme_get_attr,
+			  usize))
+		return -EFAULT;
+
+	return ret;
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
index a29877217ee6..77693f51975b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -815,6 +815,9 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		int qid, int at_head,
 		blk_mq_req_flags_t flags);
+
+int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id);
+int nvme_identify_cs_ctrl(struct nvme_ctrl *ctrl, struct nvme_id_ctrl_nvm **id);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
@@ -1072,4 +1075,11 @@ static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
 }
 #endif /* CONFIG_NVME_VERBOSE_ERRORS */
 
+/*
+ * List of all nvme ioctl controller attribute calls. Use size of nvme_get_attr
+ * as the version which enables us to use copy_struct_from_user
+ */
+#define NVME_IOCTL_GET_ATTR_V0SZ		32
+#define NVME_IOCTL_GET_ATTR_CURSZ		NVME_IOCTL_GET_ATTR_V0SZ
+
 #endif /* _NVME_H */
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 2f76cba67166..b44a53d81aa9 100644
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
+	__le64	dmsl;
+
+	/*
+	 * Dataset Management Range Size Limit : Recommended or supported maximum
+	 * number of logical blocks in a range of a Dataset Management Command.
+	 * From [2].
+	 */
+	__le32	dmrsl;
+
+	/*
+	 * Optional NVM Command Support. Is needed to make sense of attributes
+	 * like vsl, wzsl, wusl... Comes from [1].
+	 */
+	__le16	oncs;
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


