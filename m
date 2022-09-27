Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE59DC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=yJeYi9ymi6Edpaw6u7X2sTQGS1uwbQQe4HnlsGnVWzQ=; b=XMW0dhMn1iU6wuUAu89sIXO5GO
	anXRONsxImirV1peWie6Kb9Zim7vgqPKxH7lN2811IVZeqGLYM4oD6yX10JSTZXPwhQs0lX+XI8P6
	OrfU/bQnLYJfgyDYGMDmoJVYDhPxxvIV80GgNN15HO1zKdMOYBcZEnCCl69142KjXxP00XNXS6bk/
	oMbeygZP3EGKcf1ug4ZeLRgMAfGao6dpDIg0c91TYPHWclytd7E8HP3RWimnabXMxAT3DNmASHllC
	CiRL5lP/CgShpvG4l+OPcb0joZsPvfI+k9Ghp3hEn+V2f/YbXVpIaBEDetbxtwz3zR9whtjkV0oqE
	9PfB3xXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odFbU-00CF0u-Gc; Tue, 27 Sep 2022 18:46:48 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odFbN-00CErV-5L
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 18:46:46 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220927184637epoutp03e8f9ce84e2bf15e9e92d46d6f8730c92~YzAgpryqf0241402414epoutp03O
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 18:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220927184637epoutp03e8f9ce84e2bf15e9e92d46d6f8730c92~YzAgpryqf0241402414epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664304397;
	bh=yJeYi9ymi6Edpaw6u7X2sTQGS1uwbQQe4HnlsGnVWzQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uuLxQRt3kP7lyZ0VfNRsl0V/s/VCKRtQS/i+DCwzp4wCgjBxZAwnhHWEVnA0sxn5x
	 uSe1ig5/m8Bf3fWuHpjsfrvHh+3H+iLwwphHxdA11g+kOBRJgWVv2jeyQ9UYBJU7aP
	 V/zGAVN6vtVF5TcnnblQ2Ok/d0VtHZnQHTbS/paY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220927184636epcas5p2d8c7188889ce600779943f8c73860f91~YzAf4SzNQ1218312183epcas5p24;
	Tue, 27 Sep 2022 18:46:36 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4McT9k39W9z4x9Pq; Tue, 27 Sep
	2022 18:46:34 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.32.39477.A0543336; Wed, 28 Sep 2022 03:46:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220927184633epcas5p2b4a49bdfb2748fb4218f1fb901f305a0~YzAcuoN-e1218412184epcas5p2r;
	Tue, 27 Sep 2022 18:46:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220927184633epsmtrp28508fb2d8bbb59928b9a3144935c422d~YzAct5mJm0191901919epsmtrp2c;
	Tue, 27 Sep 2022 18:46:33 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-10-6333450acccd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.D7.18644.90543336; Wed, 28 Sep 2022 03:46:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220927184632epsmtip201084349df616706afe8f365c78ad7c0~YzAbdzy8S0990709907epsmtip2y;
	Tue, 27 Sep 2022 18:46:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v2] nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
Date: Wed, 28 Sep 2022 00:06:20 +0530
Message-Id: <20220927183620.12583-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmli6Xq3GywY6PIhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
	c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoY
	GJkCFSZkZyx8+oul4GR4xbbmK8wNjIfduxg5OSQETCQaLu1g7mLk4hAS2M0o8fJkBwtIQkjg
	E6PE6rfiEInPjBJLn79ng+n4+HkvE0RiF6PEqXkT2eCqbtx+DTSLg4NNQFPiwuRSkAYRAReJ
	zz0XWEFsZoF4iZt/N4MNEhbwknhw/yFYnEVAVeLGgXdMIDavgIXE6wUzoJbJS8y89J0dIi4o
	cXLmExaIOfISzVtng50tIXCJXeJa8zUWiAYXibaZ81khbGGJV8e3sEPYUhKf3+2FGposcWnm
	OSYIu0Ti8Z6DULa9ROupfrD7mYHuX79LH2IXn0Tv7ydMIGEJAV6JjjYhiGpFiXuTnkJtEpd4
	OGMJlO0h8W1ePyMkEGMl1s3bxD6BUW4Wkg9mIflgFsKyBYzMqxglUwuKc9NTi00LjPJSy+FR
	mZyfu4kRnAa1vHYwPnzwQe8QIxMH4yFGCQ5mJRHe30cNk4V4UxIrq1KL8uOLSnNSiw8xmgKD
	dSKzlGhyPjAR55XEG5pYGpiYmZmZWBqbGSqJ8y6eoZUsJJCeWJKanZpakFoE08fEwSnVwLTg
	TAyHu88G1dsdR7q0e9TlMsRaclIq+GQttnTanz+WWGH0ztn+yhHRHyXLWzbkf6vVWbxUcOHd
	zkuf7WcdfLkmZta617vMtswz6nl9IWCzr8/aY7dDfFcuqj8dekSh+emyhJjZIudTL2yRLt9/
	8adcU/5m4S0cMQtep/ttW6z4NDkvoEzu5D6Lnd2tt36fmzlNnV+rIYAnJIs7btelf+W9X/en
	d93026TjoJbedK/6i4qUYitz/steJqdoY7Hjz798jGOye9m0gWXFo1LZVc9et/08w/XtRmmQ
	/Z3NYQu+qsTU51eHin0WrMo8brtB5SuLjkFukeJD7bSOq1Ea/221/hhuMp/Gm/nJ7GdtlRJL
	cUaioRZzUXEiAN+ede8MBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvC6nq3GyweTF4har7/azWdw8sJPJ
	YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs/iwO5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP
	vi2rGAPYorhsUlJzMstSi/TtErgyFj79xVJwMrxiW/MV5gbGw+5djJwcEgImEh8/72XqYuTi
	EBLYwShx+88qZoiEuETztR/sELawxMp/z9khij4ySpz5tZyli5GDg01AU+LC5FKQGhEBL4nb
	L5+D9TILJEq8P/qYFcQWBoo/uP8QzGYRUJW4ceAdE4jNK2Ah8XrBDDaI+fISMy99Z4eIC0qc
	nPmEBWKOvETz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cT
	IzhYtbR2MO5Z9UHvECMTB+MhRgkOZiUR3t9HDZOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817o
	OhkvJJCeWJKanZpakFoEk2Xi4JRqYEqelcCdfvC4vOz9IwsXe10sTZWZH8/zQv77hesTd4ve
	8CnoPBAoeuibc3LL/Ym56vtaRTME98umNUkuTeN9Yb//dHrShNAV00p//Z9t5qD5ujHATKzb
	+NiKRX6PC1JrQvjPJkvNYjK499tjvb4lX3PDt/AdqTJVnss2KMWU9Di/+OGS5WVyX+PMfDPB
	9Vcnmx0rEMq0sXj+POFfgJ7CjCRz+0jthHSvwjWVYryPd/K5eExqLTs/sSBlhc6yi4EX5Tcy
	+i/z3TnRa45i3qV7nBfb5m0JzeRh2bGv9rKtwQefPtb2KfsWMd3/Z+Nw3D8vTdFx9qtpX9hF
	igui7s/0qTg96baCfL54+bY2aYPnSizFGYmGWsxFxYkAScGfUsUCAAA=
X-CMS-MailID: 20220927184633epcas5p2b4a49bdfb2748fb4218f1fb901f305a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220927184633epcas5p2b4a49bdfb2748fb4218f1fb901f305a0
References: <CGME20220927184633epcas5p2b4a49bdfb2748fb4218f1fb901f305a0@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_114644_169963_F07CFEF9 
X-CRM114-Status: GOOD (  23.83  )
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
coarse-granular CAP_SYS_ADMIN check, without any regard to file open
mode.

$ ls -l /dev/ng*
crw-rw-rw- 1 root root 242, 0 Sep  9 19:20 /dev/ng0n1
crw------- 1 root root 242, 1 Sep  9 19:20 /dev/ng0n2

In the example above, ng0n1 appears as if it may allow unprivileged
read/write operation but it does not and behaves same as ng0n2.

This patch implements a shift from CAP_SYS_ADMIN to more fine-granular
control for io-commands.
If CAP_SYS_ADMIN is present, nothing else is checked as before.
Otherwise, following rules are enforced
- any admin-cmd is not allowed
- vendor-specific and fabric commmand are not allowed
- io-commands that can write are allowed if matching FMODE_WRITE
permission is present
- io-commands that read are allowed

Add a helper nvme_cmd_allowed that implements above policy.
Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
for any decision making.
Since file open mode is taken into consideration for any
approval/denial, change at various places to keep file-mode information
handy.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes since v1:
- Move nvme_cmd_allowed check at a place that allows using nvme_is_write
  helper (hch)
- Keep everything into single patch (chaitanya, hch)
- Comments cleanup (hch, chaitanya)
- Part of cover-letter moved to commit-description

 drivers/nvme/host/ioctl.c | 97 ++++++++++++++++++++++++++-------------
 include/linux/nvme.h      |  1 +
 2 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 548aca8b5b9f..ebe04e977baa 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -20,6 +20,29 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
+{
+	u8 opcode = c->common.opcode;
+
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	/* admin commands are not allowed */
+	if (ns == NULL)
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
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
@@ -240,7 +263,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
+			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -248,8 +271,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -259,6 +280,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
+
+	if (!nvme_cmd_allowed(ns, &c, mode))
+		return -EACCES;
+
 	c.common.flags = cmd.flags;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
@@ -287,15 +312,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -305,6 +329,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
+
+	if (!nvme_cmd_allowed(ns, &c, mode))
+		return -EACCES;
+
 	c.common.flags = cmd.flags;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
@@ -419,14 +447,14 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	blk_mq_req_flags_t blk_flags = 0;
 	void *meta = NULL;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
 		return -EINVAL;
 
+	if (!nvme_cmd_allowed(ns, &c, ioucmd->file->f_mode))
+		return -EACCES;
+
 	c.common.command_id = 0;
 	c.common.nsid = cpu_to_le32(cmd->nsid);
 	if (!nvme_validate_passthru_nsid(ctrl, ns, le32_to_cpu(c.common.nsid)))
@@ -498,13 +526,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
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
@@ -529,14 +557,14 @@ struct nvme_user_io32 {
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
@@ -548,19 +576,20 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
@@ -568,7 +597,7 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -576,7 +605,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
 
-	return __nvme_ioctl(ns, cmd, (void __user *)arg);
+	return __nvme_ioctl(ns, cmd, (void __user *)arg, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -644,7 +673,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
+		fmode_t mode)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -652,7 +682,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -677,9 +707,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -701,9 +732,10 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
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
@@ -777,7 +809,8 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
+		fmode_t mode)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -801,7 +834,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp);
+	ret = nvme_user_cmd(ctrl, ns, argp, mode);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -818,11 +851,11 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
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
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ae53d74f3696..8396eb7ecb68 100644
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


