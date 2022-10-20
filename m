Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A24EC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 07:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/3TkggT1icJaa9eiMzJYiJy7531iq1fN71bvq6ZpGs=; b=WqZKUt3MHAaObX+dO0M3Q5JPqI
	f3fvOE8OLlEJ3GNckbLogu1o+yLMAw0yYWySH2zXJf3vyhJtmCMPhhTQuJvkA6IlSLHA4nmTMsv3p
	M5gKmq1TUob0R8QBQecJFmctNalEfl7B5rgHO4aa1QqnLbdhC/7s9J3LCaBbycPmvnzm5RB7n09ar
	OGvxX3F+1YLbARzCTZQX+JgNgUgvwHV88NiCcHNCMOKf6fBL+xBTC6uzR8QoD+ygQ7++RfwuPnWkn
	ROFusjpVK0oGBKiSH1T1Gaw2enyJaFXr2npNSDcJ+WjXfmOT2R556p/94U9vZ6XsSu4cEIvwZuwmp
	2+A4c56Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olPlE-00BYXc-2v; Thu, 20 Oct 2022 07:14:36 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olPkm-00BY6W-C7
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 07:14:19 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221020071346epoutp0225f091efb783a63407535489c3576de2~ftZIjKzEN0972609726epoutp02f
	for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 07:13:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221020071346epoutp0225f091efb783a63407535489c3576de2~ftZIjKzEN0972609726epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666250026;
	bh=e/3TkggT1icJaa9eiMzJYiJy7531iq1fN71bvq6ZpGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AiH3ZUvg6chOleILOQvLOA9fjYyFipaqtao1Q1rFSWz5ffGrIGOptfoMAL+xqxofg
	 dmJjACw7nNAFVIPnMbXVeYI836rANyVrB0HnJIE8jcIxdQY9Ou1ypuo0OdoVaA+H7U
	 0CMy445aMFoXr59okRXTjlX3y0kI2Gq0/Vpmo0Go=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221020071346epcas5p41eaab6a0d72c2838f857ccf4b703e5ed~ftZIOxZPf0195301953epcas5p4n;
	Thu, 20 Oct 2022 07:13:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MtJjh0SgJz4x9Pv; Thu, 20 Oct
	2022 07:13:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.97.26992.725F0536; Thu, 20 Oct 2022 16:13:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20221020071343epcas5p3722073ab4822d39d6ca91606869f0379~ftZFlCEPY2943829438epcas5p33;
	Thu, 20 Oct 2022 07:13:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221020071343epsmtrp12b0599076dc0771536d6396861777f3e~ftZFkKbeh1842918429epsmtrp1I;
	Thu, 20 Oct 2022 07:13:43 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-c0-6350f52736e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.27.18644.725F0536; Thu, 20 Oct 2022 16:13:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221020071341epsmtip2ff77a9f138ee907879cd88d24ae32410~ftZDyl-Gn2954729547epsmtip2M;
	Thu, 20 Oct 2022 07:13:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 1/2] nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
Date: Thu, 20 Oct 2022 12:32:04 +0530
Message-Id: <20221020070205.57366-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020070205.57366-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTXVf9a0CywclrKhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
	c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoY
	GJkCFSZkZ9zc0shY8Di0Yv2HW+wNjDPduhg5OSQETCS6J1xlAbGFBHYzSuw5wNbFyAVkf2KU
	eHfwMzuE85lRYvWhiUAZDrCOSd+tIeK7GCUmLdzCBFe0/8UfRpAiNgFNiQuTS0Gmigi4SHzu
	ucAKYjMLxEvc/LuZDcQWFvCWuLh+HRNIOYuAqsTV00IgYV4BC4mu812MEMfJS8y89J0dxOYU
	sJRYeGweM0SNoMTJmU9YIEbKSzRvnc0MUf+RXaJjWgyE7SLx5+4qVghbWOLV8S3sELaUxMv+
	Nig7WeLSzHNMEHaJxOM9B6Fse4nWU/3MIKcxA32yfpc+xCo+id7fT5ggocAr0dEmBFGtKHFv
	0lOoTeISD2csgbI9JF4sfgcNnB5GiVW/GpgmMMrPQvLBLCQfzELYtoCReRWjZGpBcW56arFp
	gWFeajk8UpPzczcxglOjlucOxrsPPugdYmTiYDzEKMHBrCTCW/AuIFmINyWxsiq1KD++qDQn
	tfgQoykwhCcyS4km5wOTc15JvKGJpYGJmZmZiaWxmaGSOO/iGVrJQgLpiSWp2ampBalFMH1M
	HJxSDUxMdpP+80xr29QozHt0jZ2lwvdnXmGzKzdNDptydOe9mPtOC7bP12xQYT9+4d/tGYsY
	okPanma159q79bYdlXA7f/dwa7eUe3hPRfit05YHua+27JzFVDn5rPrF+q01p2s/te5paetf
	HFYg+ae3der5w933a5Z3f2f583FL/pSFLf5+GTMPNB0//XPRF4vf9zdUd/hyldqIfP37w9XF
	/uXv1WciglVvH/Q6uWRyv4KdSXXapNJENkOVC5pdnjm/Hi977Wwp9nr/89RujsZqjo7XJi/L
	tt1t29q/xzHa4+MKbz/zs3P/ayUcbbp3eRmPvUwAR/9UdQ9TDt4ehwp2Jbvfj+0ZD34wPFWv
	sPqz3mMlluKMREMt5qLiRAC/6VKgFgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvK7614Bkgz13WS1W3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRXHZpKTmZJalFunbJXBl3NzSyFjwOLRi/Ydb7A2MM926GDk4JARMJCZ9t+5i5OIQ
	EtjBKHH/7zrGLkZOoLi4RPO1H+wQtrDEyn/P2SGKPjJK/Dr2kQWkmU1AU+LC5FKQGhEBL4nb
	L58zg9jMAokS748+ZgWxhQW8JS6uX8cEUs4ioCpx9bQQSJhXwEKi63wX1Cp5iZmXvoOt4hSw
	lFh4bB7YGCGgmk+zvrBA1AtKnJz5hAVivLxE89bZzBMYBWYhSc1CklrAyLSKUTK1oDg3PbfY
	sMAoL7Vcrzgxt7g0L10vOT93EyM4sLW0djDuWfVB7xAjEwfjIUYJDmYlEd6CdwHJQrwpiZVV
	qUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTAdNzoaeMhp9f/Z5XMm
	zz3GUpvsNcXjSHNE6QZ1rUXyWv53ctb5qN2y3W+35XxMpvOBYqZ3whNfCa15a3sm97r44wmy
	3Pl3Z9zkfKE9qTY97uGK754XtfV/fhRenHvg9ZoF5dM/rml7oK9T2xLeoxVy6k1c4In6xs4g
	1rNTHp2w/cifw/75l+GVf+/Pv1wgkHDa9NTqZzVi+jldK8ykk6Ttm7q3Nlsc0BWdP/d2uFLA
	fZbWquUJ5W93+1b2mD23Vy76fTNO91xl5YnJoSKMZ29HSDTsv7b3Tmrp/ImTq9ev8lWJ2y6x
	z+bN/2tSO1akMKvaONw9FVSR9t66ZnryTxezSTbnVoRkPLmpZX9L5be2EktxRqKhFnNRcSIA
	FlmUZtsCAAA=
X-CMS-MailID: 20221020071343epcas5p3722073ab4822d39d6ca91606869f0379
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221020071343epcas5p3722073ab4822d39d6ca91606869f0379
References: <20221020070205.57366-1-joshi.k@samsung.com>
	<CGME20221020071343epcas5p3722073ab4822d39d6ca91606869f0379@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_001413_095775_4B77D3A3 
X-CRM114-Status: GOOD (  23.72  )
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

Currently both io and admin commands are kept under a
coarse-granular CAP_SYS_ADMIN check, disregarding file mode completely.

$ ls -l /dev/ng*
crw-rw-rw- 1 root root 242, 0 Sep  9 19:20 /dev/ng0n1
crw------- 1 root root 242, 1 Sep  9 19:20 /dev/ng0n2

In the example above, ng0n1 appears as if it may allow unprivileged
read/write operation but it does not and behaves same as ng0n2.

This patch implements a shift from CAP_SYS_ADMIN to more fine-granular
control for io-commands.
If CAP_SYS_ADMIN is present, nothing else is checked as before.
Otherwise, following rules are in place
- any admin-cmd is not allowed
- vendor-specific and fabric commmand are not allowed
- io-commands that can write are allowed if matching FMODE_WRITE
permission is present
- io-commands that read are allowed

Add a helper nvme_cmd_allowed that implements above policy.
Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
for any decision making.
Since file open mode is counted for any approval/denial, change at
various places to keep file-mode information handy.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 97 ++++++++++++++++++++++++++-------------
 include/linux/nvme.h      |  1 +
 2 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 81f5550b670d..9c581b1a8956 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -8,6 +8,29 @@
 #include <linux/io_uring.h>
 #include "nvme.h"
 
+bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
+{
+	u8 opcode = c->common.opcode;
+
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	/* admin commands are not allowed */
+	if (!ns)
+		return false;
+
+	/* exclude vendor-specific io and fabrics commands */
+	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
+		return false;
+
+	/* allow write cmds only if matching FMODE is present */
+	if (nvme_is_write(c))
+		return mode & FMODE_WRITE;
+
+	/* allow read cmds as the device permission allows access */
+	return true;
+}
+
 /*
  * Convert integer values from ioctl structures to user pointers, silently
  * ignoring the upper bits in the compat case to match behaviour of 32-bit
@@ -261,7 +284,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -269,8 +292,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -291,6 +312,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_cmd_allowed(ns, &c, mode))
+		return -EACCES;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -308,15 +332,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
 	if (cmd.flags)
@@ -337,6 +360,9 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
+	if (!nvme_cmd_allowed(ns, &c, mode))
+		return -EACCES;
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -483,9 +509,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	void *meta = NULL;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -507,6 +530,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
+	if (!nvme_cmd_allowed(ns, &c, ioucmd->file->f_mode))
+		return -EACCES;
+
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
@@ -570,13 +596,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
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
@@ -601,14 +627,14 @@ struct nvme_user_io32 {
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
@@ -620,19 +646,20 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
-       if (is_ctrl_ioctl(cmd))
-               return nvme_ctrl_ioctl(ns->ctrl, cmd, arg);
-       return nvme_ns_ioctl(ns, cmd, arg);
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, arg, mode);
+	return nvme_ns_ioctl(ns, cmd, arg, mode);
 }
 
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
@@ -640,7 +667,7 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -648,7 +675,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -716,7 +743,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
+		fmode_t mode)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -724,7 +752,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -749,9 +777,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -773,9 +802,10 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -849,7 +879,8 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+		fmode_t mode)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -873,7 +904,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	ret = nvme_user_cmd(ctrl, ns, argp, mode);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -890,11 +921,11 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
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
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 050d7d0cd81b..1d102b662e88 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -797,6 +797,7 @@ enum nvme_opcode {
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
+	nvme_cmd_vendor_start	= 0x80,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.25.1


