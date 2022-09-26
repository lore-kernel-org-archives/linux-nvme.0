Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8605FC6FA83
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hvv22++27ZeBZJa4PcpzXQ0WOoqtGTImGNfYJ8jQRu8=; b=fMGuB7YrmkwtvFt0Qkr1xrBQjp
	Mg3koGyHBbSUa8gf+vbsEZLEDDjJkpfEKOAv59Xs3pF9KOcTqX8QDM/uvWH0sv/34sIYUOjxOvCBw
	WDe/QGhofgiIK0AFy1QcIpgNOOOF2bu1P2MVyESI4LhGy8ectNRn9q9iwmwQ97mdc9QaozOPVC54n
	8BbyAl1dZAW3c5MX9v7OeE4nRLp99sBZZDsZyVnwLPwRU7/6TdzNJumJpKKi+kHrBlqGSHRWxOvHu
	5Z4GFe8b9ALBG3y0JW3sKtxiEF68jLtr1HkM6hCaWaSGR7hR6TWOu5X9QHsgZqSxzqFdPlN5zGPbH
	eeidJZGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpfO-005YvZ-Of; Mon, 26 Sep 2022 15:05:06 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpfB-005YrV-82
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 15:04:59 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220926150445epoutp0332add0665cc830288c80b5ceb07a9715~YcVgC8AbL1824818248epoutp03K
	for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 15:04:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220926150445epoutp0332add0665cc830288c80b5ceb07a9715~YcVgC8AbL1824818248epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664204685;
	bh=Hvv22++27ZeBZJa4PcpzXQ0WOoqtGTImGNfYJ8jQRu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z68/7H9sMIoSWEtJ6yLOtDtkXNf39Zmrbp+vsb0k/0dmShDp6wjAhemTZnyMcFe35
	 7jScQ5bewWjv6uHAefflhO63Mpy5++yip0k/wd+ZvhPJ/yoU3a3EkrgCgSyZdSjk7+
	 8qlAOdQG4BKZwJNFxoV0zF62LSRvqUB47UpgTucI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220926150443epcas5p235e73726373bb925b8109026cf06a754~YcVe9if9n0056500565epcas5p2i;
	Mon, 26 Sep 2022 15:04:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MbmJB2pwhz4x9Pp; Mon, 26 Sep
	2022 15:04:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.D5.39477.A8FB1336; Tue, 27 Sep 2022 00:04:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c~YcVdMV7VR0590705907epcas5p2B;
	Mon, 26 Sep 2022 15:04:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220926150442epsmtrp1d07f46ec8c8bed047a9e96138b918bae~YcVdK8b6S0808308083epsmtrp1q;
	Mon, 26 Sep 2022 15:04:42 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-28-6331bf8a92ab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.4C.18644.98FB1336; Tue, 27 Sep 2022 00:04:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220926150440epsmtip2684b01139e9973c3abc46e58264820a3~YcVb4JFgU1214312143epsmtip2R;
	Mon, 26 Sep 2022 15:04:40 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH for-next 2/2] nvme: Make CAP_SYS_ADMIN fine-granular
Date: Mon, 26 Sep 2022 20:24:30 +0530
Message-Id: <20220926145430.81658-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926145430.81658-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTS7drv2GywY1JIhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
	c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoY
	GJkCFSZkZ1ydOJO54KVjxbWOnywNjF9Muxg5OSQETCQWv5/N2MXIxSEksJtR4tLcbcwQzidG
	ib/bNrFCOJ8ZJZ5u28wM07Js33moll2MEjvnfmCBq5p+fQdQFQcHm4CmxIXJpSANIgIuEp97
	LrCC2MwC8RI3/25mA7GFgeIvf14BG8oioCqx5MMjdhCbV8BCYveuDUwQy+QlZl76DhbnFLCU
	WLLiECtEjaDEyZlPWCBmyks0b50NdraEwEd2icefbrFDNLtI/Hp+hgXCFpZ4dXwLVFxK4mV/
	G5SdLHFp5jmoZSUSj/cchLLtJVpP9YP9wgz0y/pd+hC7+CR6fz9hAglLCPBKdLQJQVQrStyb
	9JQVwhaXeDhjCZTtIfHx3jpoiPYwSmzY85htAqP8LCQvzELywiyEbQsYmVcxSqYWFOempxab
	FhjlpZbDIzY5P3cTIzhFanntYHz44IPeIUYmDsZDjBIczEoivCkXdZOFeFMSK6tSi/Lji0pz
	UosPMZoCw3gis5Rocj4wSeeVxBuaWBqYmJmZmVgamxkqifMunqGVLCSQnliSmp2aWpBaBNPH
	xMEp1cA02e5QpWXT6eVPFTo+McX8SZl98u3adI1nN0QesnOaHtfjPfaX+wi7ROJmfS7LYJVl
	kzj/v3o89aeztJjwUQ65ptffmBiXNkx4dsi4IOCz3U+7ffLujPOMvO1yDqYuXK/w+0cSQ6e1
	e3lXWNzs6xOTt2wosuYqCb3z2tw+lHdJrb/xgav/XJZG6yUssT/zUXEd+2UV0bYjpSITe7d7
	f3Puv/nNqc4poXLmN85bdy9kmem4pzrzOQhM+aGc5mnFnZLA3WXcPZ3F+HlP8Uw9jfrPHefs
	E7TfXmxUCTg+u0wmQHbZ8lMLMv2+H7rXcEBHq+Bc8np/nsQSk6kRrak37TS1e+yqqlQq6+Kr
	fmrLKrEUZyQaajEXFScCAC1mccAaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvG7nfsNkgx1vzSxW3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRXHZpKTmZJalFunbJXBlXJ04k7ngpWPFtY6fLA2MX0y7GDk5JARMJJbtO8/YxcjF
	ISSwg1Gi/8ArFoiEuETztR/sELawxMp/z9khij4yShx4dxOog4ODTUBT4sLkUpAaEQEvidsv
	nzOD2MwCiRLvjz5mBbGFBVwkXv68AhZnEVCVWPLhEdhMXgELid27NjBBzJeXmHnpO1icU8BS
	YsmKQ2C9QkA1Ly/cZIWoF5Q4OfMJC8R8eYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFh
	gVFearlecWJucWleul5yfu4mRnBwa2ntYNyz6oPeIUYmDsZDjBIczEoivCkXdZOFeFMSK6tS
	i/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYLK+U57DoiAp62nAf669
	VH7L7g0F7sW/k62UXu1y8HRgEC77KDz/p8WW8ld7JBInzFA3nnyZ3cVDss3GrFnj8BQx2St5
	c5cZRjF9MWt7vvBa2vXmw1KXzl+KmDmXwfGWzZnGPL7FbSXzrq4/VNf1wvD5HxXF/jB5z+aD
	cSVPLk3LaWG3WxlR/D+/5Zv1W0Pj+xWsR2/un5t4er7ll+LgbV8mS+/xDfBqSTiR4WvfYWiR
	f/LQ1RzV9ZP33Dzm1n42cObeJY9tWKZuLG/bvOt2W5LARuPeHZXFAl9Nvu6P82lYzGze6H9a
	xYRj3YNTuoIBplzdKZ8mPFN9WvFgxfdn9qv5f+iXfp1ztfXg/513XyixFGckGmoxFxUnAgCu
	l5Jh3QIAAA==
X-CMS-MailID: 20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c
References: <20220926145430.81658-1-joshi.k@samsung.com>
	<CGME20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_080453_779962_F398B7B9 
X-CRM114-Status: GOOD (  19.04  )
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

Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
for any decision making.
Since file open mode is taken into consideration for any
approval/denial, change at various places to keep file-mode information
handy.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 70 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6ca6477dd899..4e53a01e702d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -259,7 +259,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -267,10 +267,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
+	if (!nvme_cmd_allowed(ns, cmd.opcode, mode))
+		return -EACCES;
 	if (cmd.flags)
 		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
@@ -306,17 +306,18 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd, bool vec)
+			struct nvme_passthru_cmd64 __user *ucmd, bool vec,
+			fmode_t mode)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
+	if (!nvme_cmd_allowed(ns, cmd.opcode, mode))
+		return -EACCES;
 	if (cmd.flags)
 		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
@@ -438,14 +439,14 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	blk_mq_req_flags_t blk_flags = 0;
 	void *meta = NULL;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
 		return -EINVAL;
 
+	if (!nvme_cmd_allowed(ns, c.common.opcode, ioucmd->file->f_mode))
+		return -EACCES;
+
 	c.common.command_id = 0;
 	c.common.nsid = cpu_to_le32(cmd->nsid);
 	if (!nvme_validate_passthru_nsid(ctrl, ns, le32_to_cpu(c.common.nsid)))
@@ -517,13 +518,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 }
 
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp)
+		void __user *argp, fmode_t mode)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+		return nvme_user_cmd(ctrl, NULL, argp, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, false);
+		return nvme_user_cmd64(ctrl, NULL, argp, false, mode);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -548,14 +549,14 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
 
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp)
+		void __user *argp, fmode_t mode)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp);
+		return nvme_user_cmd(ns->ctrl, ns, argp, mode);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -567,19 +568,20 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	case NVME_IOCTL_SUBMIT_IO:
 		return nvme_submit_io(ns, argp);
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, false);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, false, mode);
 	case NVME_IOCTL_IO64_CMD_VEC:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, true);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, true, mode);
 	default:
 		return -ENOTTY;
 	}
 }
 
-static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *arg)
+static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __user *arg,
+			fmode_t mode)
 {
        if (is_ctrl_ioctl(cmd))
-               return nvme_ctrl_ioctl(ns->ctrl, cmd, arg);
-       return nvme_ns_ioctl(ns, cmd, arg);
+               return nvme_ctrl_ioctl(ns->ctrl, cmd, arg, mode);
+       return nvme_ns_ioctl(ns, cmd, arg, mode);
 }
 
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
@@ -587,7 +589,7 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -595,7 +597,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -663,7 +665,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
+		fmode_t mode)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -671,7 +674,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -696,9 +699,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+					mode);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp);
+	ret = nvme_ns_ioctl(ns, cmd, argp, mode);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -720,9 +724,10 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		goto out_unlock;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
+				file->f_mode);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp);
+	ret = nvme_ns_ioctl(ns, cmd, argp, file->f_mode);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -796,7 +801,8 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+		fmode_t mode)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -820,7 +826,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	ret = nvme_user_cmd(ctrl, ns, argp, mode);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -837,11 +843,11 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
+		return nvme_user_cmd(ctrl, NULL, argp, file->f_mode);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, false);
+		return nvme_user_cmd64(ctrl, NULL, argp, false, file->f_mode);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp);
+		return nvme_dev_user_cmd(ctrl, argp, file->f_mode);
 	case NVME_IOCTL_RESET:
 		dev_warn(ctrl->device, "resetting controller\n");
 		return nvme_reset_ctrl_sync(ctrl);
-- 
2.25.1


