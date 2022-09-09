Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BA8ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPG+BKfu7WLh5ocyM5zUXmCD6G3l9MchyNLcTIfN8r8=; b=oRp3CgYCNpngN3easqKY8sO8U8
	GGVv/sZlm1HGTJxPVKsWB2Ed69MaNASjNjOx/CmzWf0qjup7lOmLmSb7pWwxuLhY0fm55vFliGDEx
	4rs67PoNdtRrEFst+zLzsP/mbJTtPC31BRIu/TmWIB0DEBf3cexMwgOr8gAW/xDSbNkpKSKdyZ5tl
	eLUoiaN2VzJ0WzphW/O9Gd3ZjBaPmSI6GnVUpT8vED+rmL5y9/Af+tBXF2Qs1Llx5wnUcroZMFyAC
	Zp/wbKTCjsOYJCCDGT7fyODltkUNb9LeVp8KmrFuTzBzQxOxW5iBcNIWR/F4RiMKu1L2u4zjWi6+p
	/87A43bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWh6P-000Qlv-Bw; Fri, 09 Sep 2022 16:43:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWh6G-000Qi4-Lu
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 16:43:31 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220909164325epoutp04185d2a1cb150499383ae1b0621850ab1~TPty3U6SR2819128191epoutp04q
	for <linux-nvme@lists.infradead.org>; Fri,  9 Sep 2022 16:43:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220909164325epoutp04185d2a1cb150499383ae1b0621850ab1~TPty3U6SR2819128191epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662741805;
	bh=SPG+BKfu7WLh5ocyM5zUXmCD6G3l9MchyNLcTIfN8r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IejDGP9wOBCN7KZYdFng4xYXX+LSZXRLVBRY27U0eitT8E6PN8LtCjYK589C1UjoO
	 OVVJ7TRP+aaybsKN1F/g5OEat06w1n418kWSjJfli02YkWaCzkRdB/7w+FuZpiMiTD
	 plMmmx2uXNGWyWMPWAAsfbHs5B35Eo1GgZl48UKQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220909164324epcas5p34119f6e752c9dd16331de97455ff4325~TPtyf5ysh1453314533epcas5p3-;
	Fri,  9 Sep 2022 16:43:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MPMHt6N5xz4x9Pt; Fri,  9 Sep
	2022 16:43:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.EE.54060.A2D6B136; Sat, 10 Sep 2022 01:43:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220909164322epcas5p392a312c882521eb8148ca8503999dcb6~TPtwfKn1j0326403264epcas5p3B;
	Fri,  9 Sep 2022 16:43:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220909164322epsmtrp1bd91cb2625c4f15f5161705c4eccd420~TPtweYlrx0184001840epsmtrp1X;
	Fri,  9 Sep 2022 16:43:22 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-36-631b6d2a5b4c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.EC.18644.A2D6B136; Sat, 10 Sep 2022 01:43:22 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220909164321epsmtip1ac4a704c29cf4ce5770d3895f3a4f366~TPtvJEies0354703547epsmtip1U;
	Fri,  9 Sep 2022 16:43:20 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, j.granados@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC 2/2] nvme: CAP_SYS_ADMIN to nvme-whitelisting
Date: Fri,  9 Sep 2022 22:03:07 +0530
Message-Id: <20220909163307.30150-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909163307.30150-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTQ1crVzrZ4Nl+fYvVd/vZLFauPspk
	sXT/Q0aLx3c+s1sc/f+WzWLSoWuMFvOXPWW3WPf6PYsDh8f5extZPC6fLfXYtKqTzWPzknqP
	3Tcb2Dz6tqxiDGCLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
	8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
	WmJlaGBgZApUmJCdced1WUGLY8Wb36fZGhgXm3YxcnJICJhI9DWsY+1i5OIQEtjNKLH54Sk2
	COcTo8TWMxeZIJzPjBK3v00FcjjAWn4dqoaI72KU2P2smxWu6FHzG1aQIjYBTYkLk0tBVogI
	uEi8O7KFDcRmFqiSmHVxOSOILSxgLdF35AsLiM0ioCqx/OBSZhCbV8BC4tSVmWwQ58lLzLz0
	nR3E5hSwlNix6xUbRI2gxMmZT1ggZspLNG+dzQxyg4TAV3aJhVemM0I0u0is6JrKDGELS7w6
	voUdwpaSeNnfBmUnS1yaeY4Jwi6ReLznIJRtL9F6qp8Z5BdmoF/W79KH2MUn0fv7CTQceCU6
	2oQgqhUl7k16ygphi0s8nLEEyvaQOLjzGNjJQgI9jBLfL2lMYJSfheSDWUg+mIWwbAEj8ypG
	ydSC4tz01GLTAuO81HJ4rCbn525iBKdJLe8djI8efNA7xMjEwXiIUYKDWUmEl8VQOlmINyWx
	siq1KD++qDQntfgQoykwiCcyS4km5wMTdV5JvKGJpYGJmZmZiaWxmaGSOO8UbcZkIYH0xJLU
	7NTUgtQimD4mDk6pBqZXDK2FdgsDdj5cscvs0AXx6ylsj35dE9cIPCqql8Dl+W7x9EOxbxuT
	n3JI9xv9dNuzpW9H6v9z/Zc0hP7PfWWhdGdbWtYLyf1G7B0s8555iW66fGyHyN9oX9dXmwq4
	8oyuz8npOxW5iGPHmVOZzg0Cy8+bqTRMOfhl9cQtQZ0TVv6ePkVKONTg5FLeuzJ7DkS8T+id
	9GLD5pQZJSsuL2BbWJFx7texS0eeZH3b0d0Su2nFrk2t/amrdbaoHc3+yzrPbNffnyVfpwkc
	nj917u09yxZER6s/K3418wvXi9/yi9f/Uzu9kbdj+7+cPfXbM1+uPcE6+3dD55E5czO3vb/T
	q/wh/27lz38zaw783H9yp9prJZbijERDLeai4kQAJStg2BwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSnK5WrnSywaeTkhar7/azWaxcfZTJ
	Yun+h4wWj+98Zrc4+v8tm8WkQ9cYLeYve8puse71exYHDo/z9zayeFw+W+qxaVUnm8fmJfUe
	u282sHn0bVnFGMAWxWWTkpqTWZZapG+XwJVx53VZQYtjxZvfp9kaGBebdjFycEgImEj8OlTd
	xcjFISSwg1Hi0o5Oxi5GTqC4uETztR/sELawxMp/z9khij4ySlxddY0JpJlNQFPiwuRSEFNE
	wEviXGM5SDmzQJ3Eksk7wVqFBawl+o58YQGxWQRUJZYfXMoMYvMKWEicujKTDWK8vMTMS9/B
	6jkFLCV27HoFFhcCqjl+9AkjRL2gxMmZT1gg5stLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz
	03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA1xLawfjnlUf9A4xMnEwHmKU4GBWEuFlMZROFuJN
	SaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFp+qkvbPl1j5MY
	3s4V5VXgFXgkuTi+4c0xS+XO97URV6Uie9Vu5BluuLHAcsM/bo3yLa88Cx8VnGvntmH1LzBZ
	lHXx74XC+KzwWe0GHFO5d/95eOzbx+v/+Y6pCWmp3AjJPrJ+wn6Wh4USMXkvnjklXfp9w+tY
	+3rluY1HCmVPbbY4uWuNVUdfgWMqe8HV9Y+z/Bwy3675tslhw93WKceXlZq/q1Fj91287Mv0
	yPPyCzWFqvln3L+aZZgrvPknd8ktOePnqTaRbWHP16a9MfA+o5zwK0j8xeQV2w44l2TNWlGu
	XjFn0TQJhY6FFx+lXch/fTohu+3fXd59n+cuYRd+ZSSdGnb7Q+XcDutdfp9klFiKMxINtZiL
	ihMBjtKbvt8CAAA=
X-CMS-MailID: 20220909164322epcas5p392a312c882521eb8148ca8503999dcb6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909164322epcas5p392a312c882521eb8148ca8503999dcb6
References: <20220909163307.30150-1-joshi.k@samsung.com>
	<CGME20220909164322epcas5p392a312c882521eb8148ca8503999dcb6@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_094329_193191_426CE490 
X-CRM114-Status: GOOD (  19.18  )
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

Change all the callers to go through nvme-whitelisting.
Make sure to take the file open mode into consideration for any approval
or denial.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 70 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 0d99135a1745..8a2e4ef5410d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -276,7 +276,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -284,10 +284,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -323,17 +323,18 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -455,14 +456,14 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -534,13 +535,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
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
@@ -565,14 +566,14 @@ struct nvme_user_io32 {
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
@@ -584,19 +585,20 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
+	       return nvme_ctrl_ioctl(ns->ctrl, cmd, arg, mode);
+       return nvme_ns_ioctl(ns, cmd, arg, mode);
 }
 
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
@@ -604,7 +606,7 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -612,7 +614,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -680,7 +682,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
+		fmode_t mode)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -688,7 +691,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -713,9 +716,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -737,9 +741,10 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -813,7 +818,8 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+		fmode_t mode)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -837,7 +843,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	ret = nvme_user_cmd(ctrl, ns, argp, mode);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -854,11 +860,11 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
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


