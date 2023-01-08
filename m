Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291E9C54EBD
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nTLvfv8ImydgtigVmEcARK3nTt+QB3FHx6nFJl0FkKs=; b=UzBTyhFkhpyexugPKKodWP9v8c
	J+wuKyBgr2yayEmQ/jRqQIZM4rL1I8r6EHcDTZJRPr2z0Cqme0LCXhsy69MjE+tuXXagv7sixncg8
	eizyCKti9XkLX6V8fnoScNuPVCZYGmDtePOVDZkPS5Y27yLmfasBLVGc8NfW2NrDC8pRjtjF+yhai
	RQfFmLNbgqqQsGdcLJ2t+PxzTvy3dASbLTXw6fo+8YVvwQMTkYH81Kk6iWwIBAFRmyPKc9IzugSvm
	KzRA9jFR7xWvwUh2OI8Kd6/7f4DNp5/wRPdRuTPUuoGV1ITJQilZFCIPzM3WXqscXWxG8EsMBt+wC
	nNM6sJzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYsl-00EQCo-7m; Sun, 08 Jan 2023 16:50:51 +0000
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEYse-00EQ9P-0l; Sun, 08 Jan 2023 16:50:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: don't allow unprivileged passthrough on partitions
Date: Sun,  8 Jan 2023 17:50:33 +0100
Message-Id: <20230108165033.380842-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230108165033.380842-1-hch@lst.de>
References: <20230108165033.380842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Passthrough commands can always access the entire device, and thus
submitting them on partitions is an privelege escalation.

In hindsight we should have never allowed any passthrough commands on
partitions, but it's probably too late to change that decision now.

Fixes: e4fbcf32c860 ("nvme: identify-namespace without CAP_SYS_ADMIN")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 47 ++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 999ebc1b700056..06f52db34be9bd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -10,16 +10,24 @@
 
 enum {
 	NVME_IOCTL_VEC		= (1 << 0),
+	NVME_IOCTL_PARTITION	= (1 << 1),
 };
 
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
-		fmode_t mode)
+		unsigned int flags, fmode_t mode)
 {
 	u32 effects;
 
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 
+	/*
+	 * Do not allow unprivileged passthrough on partitions, as that allows an
+	 * escape from the containment of the partition.
+	 */
+	if (flags & NVME_IOCTL_PARTITION)
+		return false;
+
 	/*
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
 	 * commands as we can't be sure about their effects.
@@ -327,7 +335,8 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
+		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
+		fmode_t mode)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -355,7 +364,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, mode))
+	if (!nvme_cmd_allowed(ns, &c, 0, mode))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -402,7 +411,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, mode))
+	if (!nvme_cmd_allowed(ns, &c, flags, mode))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -571,7 +580,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
-	if (!nvme_cmd_allowed(ns, &c, ioucmd->file->f_mode))
+	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode))
 		return -EACCES;
 
 	d.metadata = READ_ONCE(cmd->metadata);
@@ -641,7 +650,7 @@ static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, mode);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, mode);
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, 0, mode);
 	default:
@@ -668,16 +677,14 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
 
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, fmode_t mode)
+		void __user *argp, unsigned int flags, fmode_t mode)
 {
-	unsigned int flags = 0;
-
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp, mode);
+		return nvme_user_cmd(ns->ctrl, ns, argp, flags, mode);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -703,10 +710,14 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
 	void __user *argp = (void __user *)arg;
+	unsigned int flags = 0;
+
+	if (bdev_is_partition(bdev))
+		flags |= NVME_IOCTL_PARTITION;
 
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
-	return nvme_ns_ioctl(ns, cmd, argp, mode);
+	return nvme_ns_ioctl(ns, cmd, argp, flags, mode);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -717,7 +728,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, file->f_mode);
-	return nvme_ns_ioctl(ns, cmd, argp, file->f_mode);
+	return nvme_ns_ioctl(ns, cmd, argp, 0, file->f_mode);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -807,6 +818,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
+	unsigned int flags = 0;
+
+	if (bdev_is_partition(bdev))
+		flags |= NVME_IOCTL_PARTITION;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
@@ -822,7 +837,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
 					mode);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp, mode);
+	ret = nvme_ns_ioctl(ns, cmd, argp, flags, mode);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -847,7 +862,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
 				file->f_mode);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp, file->f_mode);
+	ret = nvme_ns_ioctl(ns, cmd, argp, 0, file->f_mode);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -946,7 +961,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp, mode);
+	ret = nvme_user_cmd(ctrl, ns, argp, 0, mode);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -963,7 +978,7 @@ long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, file->f_mode);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, file->f_mode);
 	case NVME_IOCTL_ADMIN64_CMD:
 		return nvme_user_cmd64(ctrl, NULL, argp, 0, file->f_mode);
 	case NVME_IOCTL_IO_CMD:
-- 
2.35.1


