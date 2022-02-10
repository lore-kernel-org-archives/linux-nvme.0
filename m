Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EE9C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 05:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Kp4CDDf3j0Ko0iPECGYEpWcMahGlQ5qamrxa2DPRjTc=; b=0JV+fzHluH+EsAZ5jvEjhkkcPi
	sl/XL33qya/YHI9wlssrkm7RjA9ZzwhBLMF71xhCb0t2OuXQmfjkJcM7FJ0X1nMHPfn+bN26Mx/i4
	fJuGpP2JQfB1Y6wNFR9bak3FA3jb+OumJOa4QZ2LTPlJrMYjlMf2bsoIxz2sJ+Q8DmML9VihEX0D+
	jxEFX/k9/Z0gb+IMjaxuR1cYxIhvev8MxJ2eNUOk+zoByGBjly3YrzAPf3IDVCWVzfTQrLN7XxUN6
	Rgx49nbZOwlCIvC+HwvwR7D2U+H9qNsc14eMSIac7ZHXPG1GbmluIVqCC+2tVaDBYU5qOG8Xpd2cf
	fbPfip2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nI2Ho-002eOq-Nj; Thu, 10 Feb 2022 05:46:32 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI2Hj-002eNU-Dy
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 05:46:32 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20220210054622epoutp017684711b474531a6f50be1f923ca664a~SVo4Zx5OH3044530445epoutp01I
 for <linux-nvme@lists.infradead.org>; Thu, 10 Feb 2022 05:46:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20220210054622epoutp017684711b474531a6f50be1f923ca664a~SVo4Zx5OH3044530445epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1644471982;
 bh=Kp4CDDf3j0Ko0iPECGYEpWcMahGlQ5qamrxa2DPRjTc=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gaQzbSJgQILGMwu4Ui9qcuwC1tcO0GHD/II6f2F7oD8VfUZSN5gFDRTp+dL8QN7a3
 MnqCACDjJ9DA86gRrrCkvbrT9TMYtPeJjmS+iN0RcVOn9xW/Q0BzVa/Pmbq3RlIvpU
 jw2qKEsP/YxrLCvnv5oLB9Lo2ei1JhDnuqjFoUFc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20220210054621epcas5p376bcec44032756d88a0a85c198cb94f5~SVo32Jfd81445614456epcas5p3z;
 Thu, 10 Feb 2022 05:46:21 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4JvQj20zbyz4x9Pt; Thu, 10 Feb
 2022 05:46:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 5D.C2.05590.5E5A4026; Thu, 10 Feb 2022 14:43:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23~SVmAhvcsy2875128751epcas5p1Y;
 Thu, 10 Feb 2022 05:43:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220210054304epsmtrp22dcc0507b0c712098d9851252c7ca572~SVmAg7mfT1863018630epsmtrp24;
 Thu, 10 Feb 2022 05:43:04 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-a8-6204a5e569b7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 62.D6.29871.8E5A4026; Thu, 10 Feb 2022 14:43:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220210054303epsmtip13c9278ff9fe92264c93352c30b141f95~SVl-W26hR1712517125epsmtip1h;
 Thu, 10 Feb 2022 05:43:03 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, sagi@grimberg.me,
 joshiiitr@gmail.com
Subject: [PATCH v4] nvme: add vectored-io support for user-passthru
Date: Thu, 10 Feb 2022 11:07:55 +0530
Message-Id: <20220210053755.451855-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTXffpUpYkg1mrNCxW3+1ns1i5+iiT
 xfm3h5ksJh26xmjx9OosJov5y56yW6x7/Z7Fgd1j56y77B7n721k8bh8ttRj06pONo/NS+o9
 dt9sYPPobX7HFsAelW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
 4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
 tcTK0MDAyBSoMCE74/PGI+wFq3Qrnu16zNrAOF21i5GDQ0LARGLdeYcuRk4OIYHdjBIrGrm7
 GLmA7E+MEj+erWKFcL4xSnQ0vmGFaTi+XxcivpdRYvX6g4wQzmdGiRtfL7GBFLEJaEpcmFwK
 YooIGEncfhsDYjILREtMepIPsktYwFmi+fMsdhCbRUBV4t7H/WwgNq+ApcTnw1dYQWwJAXmJ
 mZe+s0PEBSVOznzCAmIzA8Wbt85mBtkqIXCLXeLqlXnMEA0uEs+fTmSCsIUlXh3fwg5hS0l8
 freXDcIulvh15yhUcwejxPWGmSwQCXuJi3v+MkEcqimxfpc+RFhWYuqpdUwQi/kken8/gZrP
 K7FjHoytKHFv0lOoo8UlHs5YAmV7SDz438oICdxYiUWNV9gmMMrPQvLPLCT/zELYvICReRWj
 ZGpBcW56arFpgXFeajk8UpPzczcxgpOklvcOxkcPPugdYmTiYDzEKMHBrCTCe6qeOUmINyWx
 siq1KD++qDQntfgQoykwkCcyS4km5wPTdF5JvKGJpYGJmZmZiaWxmaGSOO+p9A2JQgLpiSWp
 2ampBalFMH1MHJxSDUyNfVs2+YZ+POA3zX3yveC7HGdenyg79qLzFkd5X7k329l04w7xv3fq
 PDLfK6fp3jLU2Tr546HG51OMJnNMEfEQMDn9dtl1huM7bqq2Hpmc6L6xOO/92t1Oi05s6mvf
 +76adWr9zIrpV95c2GdfuKNUbb/o9qbs5V0Pm7YkTOX6t5yvI23LHDWmi+lRy3l9W2ZOPm8Q
 5XjV5C5P/FY9a8WHkx2KuC1+zJVl2Ox7f9pl0afXg8WCPq71ZL0xc9fb57eEeCYfevGh5Kt2
 /R6Zmf61ZwP7LlTtn7bM4uKnohvTOuWeH/3u8ed1gXV2xKYVfA3Czpcy154Vr0jSVs+05Mqd
 euTdyhU5xzMfneapFXOVUmIpzkg01GIuKk4EAKDufVQbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO6LpSxJBhubxS1W3+1ns1i5+iiT
 xfm3h5ksJh26xmjx9OosJov5y56yW6x7/Z7Fgd1j56y77B7n721k8bh8ttRj06pONo/NS+o9
 dt9sYPPobX7HFsAexWWTkpqTWZZapG+XwJXxeeMR9oJVuhXPdj1mbWCcrtrFyMEhIWAicXy/
 bhcjF4eQwG5GiZnT7jF2MXICxcUlmq/9YIewhSVW/nvODlH0kVFixf4/TCDNbAKaEhcml4LU
 iAiYSSxYMI8FxGYWiJfYNuMGG4gtLOAs0fx5FtgcFgFViXsf94PFeQUsJT4fvsIKMV9eYual
 7+wQcUGJkzOfQM2Rl2jeOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnFhsWGOallusVJ+YWl+al
 6yXn525iBAetluYOxu2rPugdYmTiYDzEKMHBrCTCe6qeOUmINyWxsiq1KD++qDQntfgQozQH
 i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJo3MOXcZf3qFLBDm8OXuLF/4brf+4yurLoeH
 +lcq/GuqUeO4wnC0OG1CZ+bLIucdeVF+LzyzgtZnS53edyWs9c/mh5drJkopTuY8v/3Ctehv
 odN//j35OtRc8F1Whk1cKL/s0tbbi3dp2vWEHfLfadCSXyX658V9zZ298hsuizW2nvayEV2o
 kfwnhfXmkR6pJ3Z8B1IZXvDtsJ9db+jg8Nan3/L7Lssnvxo2bqh9af5Lc/HkRTPWiXuXzKnP
 6/7sWTu51Ph4W6+qw+Ml0u/m91pfPztX8qiVrWryxOCMP58vT1/2s9hpXo619/HNLwx+aSV4
 3dig3bCg7ojLKtNJ/yT3hbN1vWTfcft0AdefTiWW4oxEQy3mouJEAEdotPTJAgAA
X-CMS-MailID: 20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23
References: <CGME20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_214627_933221_F96B4C1A 
X-CRM114-Status: GOOD (  23.71  )
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

wire up support for passthru that takes an array of buffers (using
iovec).
Exposed via a new ioctl NVME_IOCTL_IO64_CMD_VEC for which -

1. cmd.addr is base address of user iovec array
2. cmd.vec_cnt is count of iovec array elements

This patch does not include vectored-variant for admin-commands as most
of them are light on buffers and likely to have low invocation frequency.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---

Changes since v3:
- remove newline (sagi)
- add tags

Changes since v2:
- remove wrappers (hch)
- update commit message (hch)

Changes since v1:
- added new ioctl rather than reusing NVME_IOCTL_IO64_CMD (hch)
- dropped block-layer helper and open-coded in nvme instead (hch)

 drivers/nvme/host/ioctl.c       | 35 ++++++++++++++++++++++++---------
 include/uapi/linux/nvme_ioctl.h |  6 +++++-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 22314962842d..aaf3dfad2657 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -56,7 +56,7 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout)
+		u32 meta_seed, u64 *result, unsigned timeout, bool vec)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -75,8 +75,22 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+		if (!vec)
+			ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
 				GFP_KERNEL);
+		else {
+			struct iovec fast_iov[UIO_FASTIOV];
+			struct iovec *iov = fast_iov;
+			struct iov_iter iter;
+
+			ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
+					UIO_FASTIOV, &iov, &iter);
+			if (ret < 0)
+				goto out;
+			ret = blk_rq_map_user_iov(q, req, NULL, &iter,
+					GFP_KERNEL);
+			kfree(iov);
+		}
 		if (ret)
 			goto out;
 		bio = req->bio;
@@ -170,7 +184,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	return nvme_submit_user_cmd(ns->queue, &c,
 			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
+			metadata, meta_len, lower_32_bits(io.slba), NULL, 0,
+			false);
 }
 
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -224,7 +239,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout);
+			0, &result, timeout, false);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -235,7 +250,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd)
+			struct nvme_passthru_cmd64 __user *ucmd, bool vec)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
@@ -270,7 +285,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &cmd.result, timeout);
+			0, &cmd.result, timeout, vec);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -296,7 +311,7 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp);
+		return nvme_user_cmd64(ctrl, NULL, argp, false);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -340,7 +355,9 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, argp);
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, false);
+	case NVME_IOCTL_IO64_CMD_VEC:
+		return nvme_user_cmd64(ns->ctrl, ns, argp, true);
 	default:
 		return -ENOTTY;
 	}
@@ -480,7 +497,7 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp);
+		return nvme_user_cmd64(ctrl, NULL, argp, false);
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..b2e43185e3b5 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -55,7 +55,10 @@ struct nvme_passthru_cmd64 {
 	__u64	metadata;
 	__u64	addr;
 	__u32	metadata_len;
-	__u32	data_len;
+	union {
+		__u32	data_len; /* for non-vectored io */
+		__u32	vec_cnt; /* for vectored io */
+	};
 	__u32	cdw10;
 	__u32	cdw11;
 	__u32	cdw12;
@@ -78,5 +81,6 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_RESCAN	_IO('N', 0x46)
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
+#define NVME_IOCTL_IO64_CMD_VEC	_IOWR('N', 0x49, struct nvme_passthru_cmd64)
 
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.25.1


