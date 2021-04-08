Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB46C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:21:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DBC61130
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DBC61130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lwpMJHaRp/Jq+7/5Ndo127yB3uJt+Ns9cFpNOEjk1TA=; b=jJ1Qz4rcIT3Is11mszfP8bXnQ
	VOtQV0ktO0JzHfDSHafdBAUNinh6j3SttS3YFj1YU3F0z1SsKBXvUr9pGqZ8g2jcnC1qVTELKqybW
	a2LN1TFQoZ82gys4CfeDC/F+rZqFY64OVNom/aOrLVHrodTgzg89TyRXqUo4WHKi8XjORGSEqbw3I
	Xuvki9BhHv+HiGEnQ2E4rl+W9CbuEWoUUExgtgyelynjockn2AapUG753W7ZIMjW/rQ7Hh5asdWdg
	dmeYN9Cjik7XfHLqnN7DdjOsMVmygJmIYidkJnDgR8T0RIY+XUuaxQmmwb8SKCTDaH5wTiiId6MyT
	7Qcpze0uA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTer-007xdD-Kb; Thu, 08 Apr 2021 12:21:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdh-007xM2-KG
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:20:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hdc1sLr44sRk3TfOUKjONLiuBl9upvNYohaWJAfVV2c=; b=K1XPULrF56j7Q1uG4KASfWF419
 V+d2YT8gaWWNZATYLvE25VszgVuy4YPM2+FN9fQcGLZihSPJYCkA5K9MPQR75aITh4IXafXzYCsVU
 l/x8nGV+SUzw2NPwULRKYLGpEPzd8AqHn6VDBmxnNIGJmVmMTK0lkv3jB8RdykeaHMdxymTbzT6Yd
 eQyNMEenYu0m3Hl4BRAR/u2aOc/fgzslRyD5Bcm3qCESuyyf9Kd4cKKkmGnE5BOkrkOy/QBpy+dQo
 YzqR4FuwaH0w14sOvIrGyhiefPLmAUPK8I11yydANXGfuaH+MJ2cma7A3KLokTWz2JlN22NSQXkUL
 yLaTKF5w==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdd-00HATt-HQ; Thu, 08 Apr 2021 12:19:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 08/13] nvme: move the ioctl code to a separate file
Date: Thu,  8 Apr 2021 14:08:37 +0200
Message-Id: <20210408120842.1450092-9-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Split out the ioctl code from core.c into a new file.  Also update
copyrights while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   | 450 +-----------------------------------
 drivers/nvme/host/ioctl.c  | 455 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  10 +-
 4 files changed, 468 insertions(+), 449 deletions(-)
 create mode 100644 drivers/nvme/host/ioctl.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index d7f6a87687b8d9..cbc509784b2e73 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
 obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 
-nvme-core-y				:= core.o
+nvme-core-y				:= core.o ioctl.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75e230dcbfef06..98d87bff4ca37f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -112,7 +112,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	set_capacity_and_notify(ns->disk, 0);
 }
 
-static void nvme_queue_scan(struct nvme_ctrl *ctrl)
+void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * Only new queue scan work when admin and IO queues are both alive
@@ -179,7 +179,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
 
-static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
+int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
@@ -1016,40 +1016,6 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
-static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
-		unsigned len, u32 seed, bool write)
-{
-	struct bio_integrity_payload *bip;
-	int ret = -ENOMEM;
-	void *buf;
-
-	buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	ret = -EFAULT;
-	if (write && copy_from_user(buf, ubuf, len))
-		goto out_free_meta;
-
-	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
-	if (IS_ERR(bip)) {
-		ret = PTR_ERR(bip);
-		goto out_free_meta;
-	}
-
-	bip->bip_iter.bi_size = len;
-	bip->bip_iter.bi_sector = seed;
-	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
-			offset_in_page(buf));
-	if (ret == len)
-		return buf;
-	ret = -ENOMEM;
-out_free_meta:
-	kfree(buf);
-out:
-	return ERR_PTR(ret);
-}
-
 static u32 nvme_known_admin_effects(u8 opcode)
 {
 	switch (opcode) {
@@ -1138,66 +1104,6 @@ void nvme_execute_passthru_rq(struct request *rq)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
 
-static int nvme_submit_user_cmd(struct request_queue *q,
-		struct nvme_command *cmd, void __user *ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, u64 *result, unsigned timeout)
-{
-	bool write = nvme_is_write(cmd);
-	struct nvme_ns *ns = q->queuedata;
-	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
-	struct request *req;
-	struct bio *bio = NULL;
-	void *meta = NULL;
-	int ret;
-
-	req = nvme_alloc_request(q, cmd, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	if (timeout)
-		req->timeout = timeout;
-	nvme_req(req)->flags |= NVME_REQ_USERCMD;
-
-	if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
-				GFP_KERNEL);
-		if (ret)
-			goto out;
-		bio = req->bio;
-		if (bdev)
-			bio_set_dev(bio, bdev);
-		if (bdev && meta_buffer && meta_len) {
-			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
-					meta_seed, write);
-			if (IS_ERR(meta)) {
-				ret = PTR_ERR(meta);
-				goto out_unmap;
-			}
-			req->cmd_flags |= REQ_INTEGRITY;
-		}
-	}
-
-	nvme_execute_passthru_rq(req);
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-		ret = -EINTR;
-	else
-		ret = nvme_req(req)->status;
-	if (result)
-		*result = le64_to_cpu(nvme_req(req)->result.u64);
-	if (meta && !ret && !write) {
-		if (copy_to_user(meta_buffer, meta, meta_len))
-			ret = -EFAULT;
-	}
-	kfree(meta);
- out_unmap:
-	if (bio)
-		blk_rq_unmap_user(bio);
- out:
-	blk_mq_free_request(req);
-	return ret;
-}
-
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
@@ -1542,182 +1448,6 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 
-/*
- * Convert integer values from ioctl structures to user pointers, silently
- * ignoring the upper bits in the compat case to match behaviour of 32-bit
- * kernels.
- */
-static void __user *nvme_to_user_ptr(uintptr_t ptrval)
-{
-	if (in_compat_syscall())
-		ptrval = (compat_uptr_t)ptrval;
-	return (void __user *)ptrval;
-}
-
-static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
-{
-	struct nvme_user_io io;
-	struct nvme_command c;
-	unsigned length, meta_len;
-	void __user *metadata;
-
-	if (copy_from_user(&io, uio, sizeof(io)))
-		return -EFAULT;
-	if (io.flags)
-		return -EINVAL;
-
-	switch (io.opcode) {
-	case nvme_cmd_write:
-	case nvme_cmd_read:
-	case nvme_cmd_compare:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	length = (io.nblocks + 1) << ns->lba_shift;
-
-	if ((io.control & NVME_RW_PRINFO_PRACT) &&
-	    ns->ms == sizeof(struct t10_pi_tuple)) {
-		/*
-		 * Protection information is stripped/inserted by the
-		 * controller.
-		 */
-		if (nvme_to_user_ptr(io.metadata))
-			return -EINVAL;
-		meta_len = 0;
-		metadata = NULL;
-	} else {
-		meta_len = (io.nblocks + 1) * ns->ms;
-		metadata = nvme_to_user_ptr(io.metadata);
-	}
-
-	if (ns->features & NVME_NS_EXT_LBAS) {
-		length += meta_len;
-		meta_len = 0;
-	} else if (meta_len) {
-		if ((io.metadata & 3) || !io.metadata)
-			return -EINVAL;
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
-	c.rw.slba = cpu_to_le64(io.slba);
-	c.rw.length = cpu_to_le16(io.nblocks);
-	c.rw.control = cpu_to_le16(io.control);
-	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
-	c.rw.reftag = cpu_to_le32(io.reftag);
-	c.rw.apptag = cpu_to_le16(io.apptag);
-	c.rw.appmask = cpu_to_le16(io.appmask);
-
-	return nvme_submit_user_cmd(ns->queue, &c,
-			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
-}
-
-static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd __user *ucmd)
-{
-	struct nvme_passthru_cmd cmd;
-	struct nvme_command c;
-	unsigned timeout = 0;
-	u64 result;
-	int status;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
-		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
-	if (ns && cmd.nsid != ns->head->ns_id) {
-		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
-			current->comm, cmd.nsid, ns->head->ns_id);
-		return -EINVAL;
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
-	c.common.nsid = cpu_to_le32(cmd.nsid);
-	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
-	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
-	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
-	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
-	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
-	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
-	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
-
-	if (cmd.timeout_ms)
-		timeout = msecs_to_jiffies(cmd.timeout_ms);
-
-	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			nvme_to_user_ptr(cmd.addr), cmd.data_len,
-			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &result, timeout);
-
-	if (status >= 0) {
-		if (put_user(result, &ucmd->result))
-			return -EFAULT;
-	}
-
-	return status;
-}
-
-static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			struct nvme_passthru_cmd64 __user *ucmd)
-{
-	struct nvme_passthru_cmd64 cmd;
-	struct nvme_command c;
-	unsigned timeout = 0;
-	int status;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
-		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
-	if (ns && cmd.nsid != ns->head->ns_id) {
-		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
-			current->comm, cmd.nsid, ns->head->ns_id);
-		return -EINVAL;
-	}
-
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
-	c.common.nsid = cpu_to_le32(cmd.nsid);
-	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
-	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
-	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
-	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
-	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
-	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
-	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
-
-	if (cmd.timeout_ms)
-		timeout = msecs_to_jiffies(cmd.timeout_ms);
-
-	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			nvme_to_user_ptr(cmd.addr), cmd.data_len,
-			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
-			0, &cmd.result, timeout);
-
-	if (status >= 0) {
-		if (put_user(cmd.result, &ucmd->result))
-			return -EFAULT;
-	}
-
-	return status;
-}
-
 /*
  * Issue ioctl requests on the first available path.  Note that unlike normal
  * block layer requests we will not retry failed request on another controller.
@@ -1748,85 +1478,6 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
 		srcu_read_unlock(&head->srcu, idx);
 }
 
-static bool is_ctrl_ioctl(unsigned int cmd)
-{
-	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD)
-		return true;
-	if (is_sed_ioctl(cmd))
-		return true;
-	return false;
-}
-
-static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp)
-{
-	switch (cmd) {
-	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
-	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp);
-	default:
-		return sed_ioctl(ctrl->opal_dev, cmd, argp);
-	}
-}
-
-#ifdef COMPAT_FOR_U64_ALIGNMENT
-struct nvme_user_io32 {
-	__u8	opcode;
-	__u8	flags;
-	__u16	control;
-	__u16	nblocks;
-	__u16	rsvd;
-	__u64	metadata;
-	__u64	addr;
-	__u64	slba;
-	__u32	dsmgmt;
-	__u32	reftag;
-	__u16	apptag;
-	__u16	appmask;
-} __attribute__((__packed__));
-#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
-#endif /* COMPAT_FOR_U64_ALIGNMENT */
-
-static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp)
-{
-	switch (cmd) {
-	case NVME_IOCTL_ID:
-		force_successful_syscall_return();
-		return ns->head->ns_id;
-	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp);
-	/*
-	 * struct nvme_user_io can has different padding on some 32-bit ABIs.
-	 * Just accept the compat version as all fields that are used are the
-	 * same size and at the same offset.
-	 */
-#ifdef COMPAT_FOR_U64_ALIGNMENT
-	case NVME_IOCTL_SUBMIT_IO32:
-#endif
-	case NVME_IOCTL_SUBMIT_IO:
-		return nvme_submit_io(ns, argp);
-	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp);
-	default:
-		if (!ns->ndev)
-			return -ENOTTY;
-		return nvme_nvm_ioctl(ns, cmd, argp);
-	}
-}
-
-static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	struct nvme_ns *ns = bdev->bd_disk->private_data;
-	void __user *argp = (void __user *)arg;
-
-	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
-	return nvme_ns_ioctl(ns, cmd, argp);
-}
-
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
@@ -2336,7 +1987,7 @@ static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
 	nvme_put_ns_head(disk->private_data);
 }
 
-static struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
+struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	int ret;
@@ -2356,42 +2007,6 @@ static struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 	return ctrl;
 }
 
-static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
-		unsigned int cmd, void __user *argp)
-{
-	struct nvme_ctrl *ctrl = nvme_find_get_live_ctrl(head->subsys);
-	int ret;
-
-	if (IS_ERR(ctrl))
-		return PTR_ERR(ctrl);
-	ret = nvme_ctrl_ioctl(ctrl, cmd, argp);
-	nvme_put_ctrl(ctrl);
-	return ret;
-}
-
-static int nvme_ns_head_ns_ioctl(struct nvme_ns_head *head,
-		unsigned int cmd, void __user *argp)
-{
-	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
-	int ret = -EWOULDBLOCK;
-
-	if (ns)
-		ret = nvme_ns_ioctl(ns, cmd, argp);
-	srcu_read_unlock(&head->srcu, srcu_idx);
-	return ret;
-}
-
-static int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-
-	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
-	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
-}
-
 const struct block_device_operations nvme_ns_head_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= nvme_ns_head_submit_bio,
@@ -3354,65 +2969,6 @@ static int nvme_dev_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
-{
-	struct nvme_ns *ns;
-	int ret;
-
-	down_read(&ctrl->namespaces_rwsem);
-	if (list_empty(&ctrl->namespaces)) {
-		ret = -ENOTTY;
-		goto out_unlock;
-	}
-
-	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
-	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
-		dev_warn(ctrl->device,
-			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	dev_warn(ctrl->device,
-		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
-	kref_get(&ns->kref);
-	up_read(&ctrl->namespaces_rwsem);
-
-	ret = nvme_user_cmd(ctrl, ns, argp);
-	nvme_put_ns(ns);
-	return ret;
-
-out_unlock:
-	up_read(&ctrl->namespaces_rwsem);
-	return ret;
-}
-
-static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
-		unsigned long arg)
-{
-	struct nvme_ctrl *ctrl = file->private_data;
-	void __user *argp = (void __user *)arg;
-
-	switch (cmd) {
-	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp);
-	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp);
-	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp);
-	case NVME_IOCTL_RESET:
-		dev_warn(ctrl->device, "resetting controller\n");
-		return nvme_reset_ctrl_sync(ctrl);
-	case NVME_IOCTL_SUBSYS_RESET:
-		return nvme_reset_subsystem(ctrl);
-	case NVME_IOCTL_RESCAN:
-		nvme_queue_scan(ctrl);
-		return 0;
-	default:
-		return -ENOTTY;
-	}
-}
-
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
new file mode 100644
index 00000000000000..001faf31fb944f
--- /dev/null
+++ b/drivers/nvme/host/ioctl.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2014, Intel Corporation.
+ * Copyright (c) 2017-2021 Christoph Hellwig.
+ */
+#include <linux/ptrace.h>	/* for force_successful_syscall_return */
+#include <linux/nvme_ioctl.h>
+#include "nvme.h"
+
+/*
+ * Convert integer values from ioctl structures to user pointers, silently
+ * ignoring the upper bits in the compat case to match behaviour of 32-bit
+ * kernels.
+ */
+static void __user *nvme_to_user_ptr(uintptr_t ptrval)
+{
+	if (in_compat_syscall())
+		ptrval = (compat_uptr_t)ptrval;
+	return (void __user *)ptrval;
+}
+
+static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
+		unsigned len, u32 seed, bool write)
+{
+	struct bio_integrity_payload *bip;
+	int ret = -ENOMEM;
+	void *buf;
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	ret = -EFAULT;
+	if (write && copy_from_user(buf, ubuf, len))
+		goto out_free_meta;
+
+	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
+	if (IS_ERR(bip)) {
+		ret = PTR_ERR(bip);
+		goto out_free_meta;
+	}
+
+	bip->bip_iter.bi_size = len;
+	bip->bip_iter.bi_sector = seed;
+	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
+			offset_in_page(buf));
+	if (ret == len)
+		return buf;
+	ret = -ENOMEM;
+out_free_meta:
+	kfree(buf);
+out:
+	return ERR_PTR(ret);
+}
+
+static int nvme_submit_user_cmd(struct request_queue *q,
+		struct nvme_command *cmd, void __user *ubuffer,
+		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
+		u32 meta_seed, u64 *result, unsigned timeout)
+{
+	bool write = nvme_is_write(cmd);
+	struct nvme_ns *ns = q->queuedata;
+	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	struct request *req;
+	struct bio *bio = NULL;
+	void *meta = NULL;
+	int ret;
+
+	req = nvme_alloc_request(q, cmd, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	if (timeout)
+		req->timeout = timeout;
+	nvme_req(req)->flags |= NVME_REQ_USERCMD;
+
+	if (ubuffer && bufflen) {
+		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+				GFP_KERNEL);
+		if (ret)
+			goto out;
+		bio = req->bio;
+		if (bdev)
+			bio_set_dev(bio, bdev);
+		if (bdev && meta_buffer && meta_len) {
+			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
+					meta_seed, write);
+			if (IS_ERR(meta)) {
+				ret = PTR_ERR(meta);
+				goto out_unmap;
+			}
+			req->cmd_flags |= REQ_INTEGRITY;
+		}
+	}
+
+	nvme_execute_passthru_rq(req);
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+		ret = -EINTR;
+	else
+		ret = nvme_req(req)->status;
+	if (result)
+		*result = le64_to_cpu(nvme_req(req)->result.u64);
+	if (meta && !ret && !write) {
+		if (copy_to_user(meta_buffer, meta, meta_len))
+			ret = -EFAULT;
+	}
+	kfree(meta);
+ out_unmap:
+	if (bio)
+		blk_rq_unmap_user(bio);
+ out:
+	blk_mq_free_request(req);
+	return ret;
+}
+
+
+static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
+{
+	struct nvme_user_io io;
+	struct nvme_command c;
+	unsigned length, meta_len;
+	void __user *metadata;
+
+	if (copy_from_user(&io, uio, sizeof(io)))
+		return -EFAULT;
+	if (io.flags)
+		return -EINVAL;
+
+	switch (io.opcode) {
+	case nvme_cmd_write:
+	case nvme_cmd_read:
+	case nvme_cmd_compare:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	length = (io.nblocks + 1) << ns->lba_shift;
+
+	if ((io.control & NVME_RW_PRINFO_PRACT) &&
+	    ns->ms == sizeof(struct t10_pi_tuple)) {
+		/*
+		 * Protection information is stripped/inserted by the
+		 * controller.
+		 */
+		if (nvme_to_user_ptr(io.metadata))
+			return -EINVAL;
+		meta_len = 0;
+		metadata = NULL;
+	} else {
+		meta_len = (io.nblocks + 1) * ns->ms;
+		metadata = nvme_to_user_ptr(io.metadata);
+	}
+
+	if (ns->features & NVME_NS_EXT_LBAS) {
+		length += meta_len;
+		meta_len = 0;
+	} else if (meta_len) {
+		if ((io.metadata & 3) || !io.metadata)
+			return -EINVAL;
+	}
+
+	memset(&c, 0, sizeof(c));
+	c.rw.opcode = io.opcode;
+	c.rw.flags = io.flags;
+	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
+	c.rw.slba = cpu_to_le64(io.slba);
+	c.rw.length = cpu_to_le16(io.nblocks);
+	c.rw.control = cpu_to_le16(io.control);
+	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
+	c.rw.reftag = cpu_to_le32(io.reftag);
+	c.rw.apptag = cpu_to_le16(io.apptag);
+	c.rw.appmask = cpu_to_le16(io.appmask);
+
+	return nvme_submit_user_cmd(ns->queue, &c,
+			nvme_to_user_ptr(io.addr), length,
+			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
+}
+
+static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			struct nvme_passthru_cmd __user *ucmd)
+{
+	struct nvme_passthru_cmd cmd;
+	struct nvme_command c;
+	unsigned timeout = 0;
+	u64 result;
+	int status;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+		return -EFAULT;
+	if (cmd.flags)
+		return -EINVAL;
+	if (ns && cmd.nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
+			current->comm, cmd.nsid, ns->head->ns_id);
+		return -EINVAL;
+	}
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = cmd.opcode;
+	c.common.flags = cmd.flags;
+	c.common.nsid = cpu_to_le32(cmd.nsid);
+	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
+	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
+	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
+	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
+	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
+	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
+	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
+
+	if (cmd.timeout_ms)
+		timeout = msecs_to_jiffies(cmd.timeout_ms);
+
+	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
+			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
+			0, &result, timeout);
+
+	if (status >= 0) {
+		if (put_user(result, &ucmd->result))
+			return -EFAULT;
+	}
+
+	return status;
+}
+
+static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			struct nvme_passthru_cmd64 __user *ucmd)
+{
+	struct nvme_passthru_cmd64 cmd;
+	struct nvme_command c;
+	unsigned timeout = 0;
+	int status;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+		return -EFAULT;
+	if (cmd.flags)
+		return -EINVAL;
+	if (ns && cmd.nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
+			current->comm, cmd.nsid, ns->head->ns_id);
+		return -EINVAL;
+	}
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = cmd.opcode;
+	c.common.flags = cmd.flags;
+	c.common.nsid = cpu_to_le32(cmd.nsid);
+	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
+	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
+	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
+	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
+	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
+	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
+	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
+
+	if (cmd.timeout_ms)
+		timeout = msecs_to_jiffies(cmd.timeout_ms);
+
+	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
+			nvme_to_user_ptr(cmd.addr), cmd.data_len,
+			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
+			0, &cmd.result, timeout);
+
+	if (status >= 0) {
+		if (put_user(cmd.result, &ucmd->result))
+			return -EFAULT;
+	}
+
+	return status;
+}
+
+static bool is_ctrl_ioctl(unsigned int cmd)
+{
+	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD)
+		return true;
+	if (is_sed_ioctl(cmd))
+		return true;
+	return false;
+}
+
+static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
+		void __user *argp)
+{
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_cmd(ctrl, NULL, argp);
+	case NVME_IOCTL_ADMIN64_CMD:
+		return nvme_user_cmd64(ctrl, NULL, argp);
+	default:
+		return sed_ioctl(ctrl->opal_dev, cmd, argp);
+	}
+}
+
+#ifdef COMPAT_FOR_U64_ALIGNMENT
+struct nvme_user_io32 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	control;
+	__u16	nblocks;
+	__u16	rsvd;
+	__u64	metadata;
+	__u64	addr;
+	__u64	slba;
+	__u32	dsmgmt;
+	__u32	reftag;
+	__u16	apptag;
+	__u16	appmask;
+} __attribute__((__packed__));
+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
+#endif /* COMPAT_FOR_U64_ALIGNMENT */
+
+static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
+		void __user *argp)
+{
+	switch (cmd) {
+	case NVME_IOCTL_ID:
+		force_successful_syscall_return();
+		return ns->head->ns_id;
+	case NVME_IOCTL_IO_CMD:
+		return nvme_user_cmd(ns->ctrl, ns, argp);
+	/*
+	 * struct nvme_user_io can has different padding on some 32-bit ABIs.
+	 * Just accept the compat version as all fields that are used are the
+	 * same size and at the same offset.
+	 */
+#ifdef COMPAT_FOR_U64_ALIGNMENT
+	case NVME_IOCTL_SUBMIT_IO32:
+#endif
+	case NVME_IOCTL_SUBMIT_IO:
+		return nvme_submit_io(ns, argp);
+	case NVME_IOCTL_IO64_CMD:
+		return nvme_user_cmd64(ns->ctrl, ns, argp);
+	default:
+		if (!ns->ndev)
+			return -ENOTTY;
+		return nvme_nvm_ioctl(ns, cmd, argp);
+	}
+}
+
+int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *)arg;
+
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	return nvme_ns_ioctl(ns, cmd, argp);
+}
+
+#ifdef CONFIG_NVME_MULTIPATH
+static int nvme_ns_head_ctrl_ioctl(struct nvme_ns_head *head,
+		unsigned int cmd, void __user *argp)
+{
+	struct nvme_ctrl *ctrl = nvme_find_get_live_ctrl(head->subsys);
+	int ret;
+
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+	ret = nvme_ctrl_ioctl(ctrl, cmd, argp);
+	nvme_put_ctrl(ctrl);
+	return ret;
+}
+
+static int nvme_ns_head_ns_ioctl(struct nvme_ns_head *head,
+		unsigned int cmd, void __user *argp)
+{
+	int srcu_idx = srcu_read_lock(&head->srcu);
+	struct nvme_ns *ns = nvme_find_path(head);
+	int ret = -EWOULDBLOCK;
+
+	if (ns)
+		ret = nvme_ns_ioctl(ns, cmd, argp);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
+int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg)
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+
+	if (is_ctrl_ioctl(cmd))
+		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
+	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
+}
+#endif /* CONFIG_NVME_MULTIPATH */
+
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
+{
+	struct nvme_ns *ns;
+	int ret;
+
+	down_read(&ctrl->namespaces_rwsem);
+	if (list_empty(&ctrl->namespaces)) {
+		ret = -ENOTTY;
+		goto out_unlock;
+	}
+
+	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
+	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
+		dev_warn(ctrl->device,
+			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	dev_warn(ctrl->device,
+		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
+	kref_get(&ns->kref);
+	up_read(&ctrl->namespaces_rwsem);
+
+	ret = nvme_user_cmd(ctrl, ns, argp);
+	nvme_put_ns(ns);
+	return ret;
+
+out_unlock:
+	up_read(&ctrl->namespaces_rwsem);
+	return ret;
+}
+
+long nvme_dev_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg)
+{
+	struct nvme_ctrl *ctrl = file->private_data;
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case NVME_IOCTL_ADMIN_CMD:
+		return nvme_user_cmd(ctrl, NULL, argp);
+	case NVME_IOCTL_ADMIN64_CMD:
+		return nvme_user_cmd64(ctrl, NULL, argp);
+	case NVME_IOCTL_IO_CMD:
+		return nvme_dev_user_cmd(ctrl, argp);
+	case NVME_IOCTL_RESET:
+		dev_warn(ctrl->device, "resetting controller\n");
+		return nvme_reset_ctrl_sync(ctrl);
+	case NVME_IOCTL_SUBSYS_RESET:
+		return nvme_reset_subsystem(ctrl);
+	case NVME_IOCTL_RESCAN:
+		nvme_queue_scan(ctrl);
+		return 0;
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 70018ae2cb1876..d41c9ceeafa1b8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -647,14 +647,22 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
+int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
-
+void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
 struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx);
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
+struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys);
+int nvme_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg);
+int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg);
+long nvme_dev_ioctl(struct file *file, unsigned int cmd,
+		unsigned long arg);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
