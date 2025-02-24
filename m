Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96138C021BE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrhAOYXxRO43yerJ1HPQ2gGJDFmrO2xP+TyGBj1kRkQ=; b=qcrmKuwCimv7dIgbHeB/muCp3D
	lk/PQYLzBEtBRWI/6lfKcDVoK9YmjbukkKPV1P6yo2P7ieU/zb3p+mCxqhDik0jtYxBLDXmWfy3lL
	QgQRFy7BcXnJAzJ7JXz9GVA1+Or/lJb2KNKhEfiIEMY8FqlxokLpvm7nbELp5Dz3cQMU8CHALdrTw
	yx9W1ulrNzFyVgg1ip18bO6vr0Z8Mjah1CoMAhQkqyCnQ9s+KxM9ZvvR8MOO+pB7Z5pxvIiEjwEVn
	ij2KHM1SmVIRA5/0eA55zJovkzs+h+7bqcbUNiMELE9Q7G6Me5G4ZoeH1oxYpnlP0q+SWuweHODzm
	Bwgomx7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdFo-0000000EomR-071h;
	Mon, 24 Feb 2025 18:32:32 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5O-0000000Emfu-2VDm
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:48 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFDGTM000601
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=RrhAOYXxRO43yerJ1HPQ2gGJDFmrO2xP+TyGBj1kRkQ=; b=bT8W3tCi6mK0
	s1vnqijltD2s0+6uBbwohzcZiGddqBXPrV9wNk92p2eItuskEz3AaO14hilEFtEc
	33eviZftFb7nFqKd0bylvD9MBJ4fykZmgUJgsqdkShby2HSt+AIfKmLVUd7nS/pO
	qkOXfCSiwxCyZxorYg69+kO8x+41B25N+j97I02/fdwq/IspzXIk2EMhN3qdwbPA
	VcPbGkJsa3EFR9NB8SUzgq5WyOyiHrNd2cEep+6VGnqWnBM6Jcf05ruQuj9qmcGJ
	ca/qeQk3wralhEiY7in8l8yf99hqWbbnl7EPudYdCJWJpCGhrFBO4XDHNk13ENKB
	A4tN3RO8wQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450tt7hunv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:46 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6FB9218678FB3; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/6] nvme-ioctl: fold open_for_write into flags
Date: Mon, 24 Feb 2025 10:21:23 -0800
Message-ID: <20250224182128.2042061-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _sWDYh4P_y5aLmzA-6ZnsW6oy3BjFwBX
X-Proofpoint-ORIG-GUID: _sWDYh4P_y5aLmzA-6ZnsW6oy3BjFwBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102146_648562_9CE49416 
X-CRM114-Status: GOOD (  15.90  )
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

From: Keith Busch <kbusch@kernel.org>

Helps to reduce the number of parameters passed around.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 84 ++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847af..a3082414c7714 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -12,10 +12,11 @@
 enum {
 	NVME_IOCTL_VEC		=3D (1 << 0),
 	NVME_IOCTL_PARTITION	=3D (1 << 1),
+	NVME_IOCTL_WRITABLE	=3D (1 << 2),
 };
=20
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
-		unsigned int flags, bool open_for_write)
+		unsigned int flags)
 {
 	u32 effects;
=20
@@ -78,7 +79,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct=
 nvme_command *c,
 	 * writing.
 	 */
 	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
-	    !open_for_write)
+	    !(flags & NVME_IOCTL_WRITABLE))
 		goto admin;
=20
 	return true;
@@ -293,8 +294,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_c=
trl *ctrl,
 }
=20
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
-		bool open_for_write)
+		struct nvme_passthru_cmd __user *ucmd, unsigned int flags)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -322,7 +322,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
 	c.common.cdw14 =3D cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 =3D cpu_to_le32(cmd.cdw15);
=20
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
+	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
 	if (cmd.timeout_ms)
@@ -341,8 +341,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
 }
=20
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
-		bool open_for_write)
+		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
@@ -369,7 +368,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
 	c.common.cdw14 =3D cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 =3D cpu_to_le32(cmd.cdw15);
=20
-	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
 	if (cmd.timeout_ms)
@@ -467,6 +466,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	struct request *req;
 	blk_opf_t rq_flags =3D REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags =3D 0;
+	unsigned int flags =3D 0;
 	int ret;
=20
 	c.common.opcode =3D READ_ONCE(cmd->opcode);
@@ -490,7 +490,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	c.common.cdw14 =3D cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 =3D cpu_to_le32(READ_ONCE(cmd->cdw15));
=20
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
+	if (ioucmd->file->f_mode & FMODE_WRITE)
+		flags |=3D NVME_IOCTL_WRITABLE;
+	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
 	d.metadata =3D READ_ONCE(cmd->metadata);
@@ -538,13 +540,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 }
=20
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp, bool open_for_write)
+		void __user *argp, unsigned int flags)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp, flags);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd64(ctrl, NULL, argp, flags);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -569,14 +571,14 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
=20
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, unsigned int flags, bool open_for_write)
+		void __user *argp, unsigned int flags)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write);
+		return nvme_user_cmd(ns->ctrl, ns, argp, flags);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -591,8 +593,7 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned=
 int cmd,
 		flags |=3D NVME_IOCTL_VEC;
 		fallthrough;
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, flags,
-				       open_for_write);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, flags);
 	default:
 		return -ENOTTY;
 	}
@@ -602,28 +603,32 @@ int nvme_ioctl(struct block_device *bdev, blk_mode_=
t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns =3D bdev->bd_disk->private_data;
-	bool open_for_write =3D mode & BLK_OPEN_WRITE;
 	void __user *argp =3D (void __user *)arg;
 	unsigned int flags =3D 0;
=20
+	if (mode & BLK_OPEN_WRITE)
+		flags |=3D NVME_IOCTL_WRITABLE;
 	if (bdev_is_partition(bdev))
 		flags |=3D NVME_IOCTL_PARTITION;
=20
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
-	return nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, flags);
+	return nvme_ns_ioctl(ns, cmd, argp, flags);
 }
=20
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned lon=
g arg)
 {
 	struct nvme_ns *ns =3D
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
-	bool open_for_write =3D file->f_mode & FMODE_WRITE;
 	void __user *argp =3D (void __user *)arg;
+	unsigned int flags =3D 0;
+
+	if (file->f_mode & FMODE_WRITE)
+		flags |=3D NVME_IOCTL_WRITABLE;
=20
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
-	return nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, flags);
+	return nvme_ns_ioctl(ns, cmd, argp, flags);
 }
=20
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -682,7 +687,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd =
*ioucmd,
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
-		bool open_for_write)
+		unsigned int flags)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl =3D ns->ctrl;
@@ -690,7 +695,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns=
, unsigned int cmd,
=20
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret =3D nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	ret =3D nvme_ctrl_ioctl(ns->ctrl, cmd, argp, flags);
=20
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -700,12 +705,13 @@ int nvme_ns_head_ioctl(struct block_device *bdev, b=
lk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head =3D bdev->bd_disk->private_data;
-	bool open_for_write =3D mode & BLK_OPEN_WRITE;
 	void __user *argp =3D (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret =3D -EWOULDBLOCK;
 	unsigned int flags =3D 0;
=20
+	if (mode & BLK_OPEN_WRITE)
+		flags |=3D NVME_IOCTL_WRITABLE;
 	if (bdev_is_partition(bdev))
 		flags |=3D NVME_IOCTL_PARTITION;
=20
@@ -721,9 +727,9 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk=
_mode_t mode,
 	 */
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-					       open_for_write);
+					       flags);
=20
-	ret =3D nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
+	ret =3D nvme_ns_ioctl(ns, cmd, argp, flags);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -732,13 +738,16 @@ int nvme_ns_head_ioctl(struct block_device *bdev, b=
lk_mode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
-	bool open_for_write =3D file->f_mode & FMODE_WRITE;
 	struct cdev *cdev =3D file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =3D
 		container_of(cdev, struct nvme_ns_head, cdev);
 	void __user *argp =3D (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret =3D -EWOULDBLOCK;
+	unsigned int flags =3D 0;
+
+	if (file->f_mode & FMODE_WRITE)
+		flags |=3D NVME_IOCTL_WRITABLE;
=20
 	srcu_idx =3D srcu_read_lock(&head->srcu);
 	ns =3D nvme_find_path(head);
@@ -747,9 +756,9 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsign=
ed int cmd,
=20
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-				open_for_write);
+					       flags);
=20
-	ret =3D nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
+	ret =3D nvme_ns_ioctl(ns, cmd, argp, flags);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -799,7 +808,7 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, u=
nsigned int issue_flags)
 }
=20
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
-		bool open_for_write)
+		unsigned int flags)
 {
 	struct nvme_ns *ns;
 	int ret, srcu_idx;
@@ -826,7 +835,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, =
void __user *argp,
 	}
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
=20
-	ret =3D nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
+	ret =3D nvme_user_cmd(ctrl, ns, argp, flags);
 	nvme_put_ns(ns);
 	return ret;
=20
@@ -838,17 +847,20 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl=
, void __user *argp,
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
-	bool open_for_write =3D file->f_mode & FMODE_WRITE;
 	struct nvme_ctrl *ctrl =3D file->private_data;
 	void __user *argp =3D (void __user *)arg;
+	unsigned int flags =3D 0;
+
+	if (file->f_mode & FMODE_WRITE)
+		flags |=3D NVME_IOCTL_WRITABLE;
=20
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp, flags);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd64(ctrl, NULL, argp, flags);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
+		return nvme_dev_user_cmd(ctrl, argp, flags);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
--=20
2.43.5


