Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3E1C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rb/i4ywpXCUSCDXyZPQpmxyo3+vnXX4jvRs8tdQ+7Tk=; b=5DHdmB2wKPKJJ4IJ3hUY8gWAIN
	hN8hw1lNtJAVBindfruVSLYl4QPSj/PJVw1blJhuNIogbOx6VtphDsliR5uj1BTR1XXqBCJFIm7wu
	UTwfmR36fDm0VuiM2f1aPfsKs4JNrT2rvA9ie0VEscUorgJw0JlPXw1oSXQ8I/a7uhH8b4yLePuAF
	lp9pOP4xbzRviZk6tXVUoEuryLkCQvibAIAKffYMEjhz428XRg/tRPMBtToGehQG2QsKJrHTqVze/
	eZp+mxwITbOfSIYMDF6SFC7G61vdaslpnTgR5G2ekx3WkQFyDIve+dWecgm4mLvT2pec/1xpoBZ+F
	UexNoe9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0y7u-0000000Gz3q-1qol;
	Sun, 28 Apr 2024 06:35:06 +0000
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0y7r-0000000Gz1h-2R4d
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 06:35:05 +0000
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3c70a55988dso2026094b6e.0
        for <linux-nvme@lists.infradead.org>; Sat, 27 Apr 2024 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1714286091; x=1714890891; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb/i4ywpXCUSCDXyZPQpmxyo3+vnXX4jvRs8tdQ+7Tk=;
        b=MNpg+VermgvWEHSAAVsyxZ4G/vWBMa3IjAOvJhVinIF3j7E8HeTERapaMsmbyPT1ow
         w3A2eYNknL5402/82348Mvyf9G4dDfCYIKgJA5XM9dDJx+Y7zAJzXexnb2HcMw+YNTNT
         8g6ujTGMeZpUXU2FiWwkNM97BFLoDDtdRJe97cYcjjo0kxDjDgmd9T19J0CA4MB7OmTv
         3YcEiKQxOQgUc9qxkek0PAb615UwEO+MVausblASTAO1Er/6YhTg2zEk6nLr9ey4MbsM
         WT5vwCY8PKUxUrT64lkI0NotyVDmpreflJGG0OIJF4v4WlFaIdEIuDF0i0159vJiQizj
         V+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714286091; x=1714890891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rb/i4ywpXCUSCDXyZPQpmxyo3+vnXX4jvRs8tdQ+7Tk=;
        b=d1yRpV5/xmLHpdAQq3rLgZzteIoGxFOlTqp85p5fjJGkKQEy0VFLFkycCeSY0A0qam
         kqkUoDvpbkmUzUAsIyBC3ek5H2NHGk/UZEABH6Y65do7nyWxiZ3YeVokdkgOsyZ64LeB
         h1IqfRzLM9xCgIMU305yq7wV1IX77RfPPjpcmPcBPUj6853q+nI8UZU8aZ5YPKu1BNkS
         XpAUmlsoXpjLzLvk8bZU/A0AZplLHssuBWYNiv7LvJ4WLOmxznt7tjocmKzUKcAhSwLq
         JC35FOIEOyjgB6+TrMbqbIjsoMoumTTRU9Rjm9guMV4My6BbP5BDE38Xs+qEqPsH6GEc
         v/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVXXFxqAUzxzDCT13tedIkigqb0HWX+S5+SoAFkeUAykoAAaUGs3bdREQprSoLJIo29AN3VKvhj0h2gAC8j71zO/0j43eW9k/sX19ZpMhA=
X-Gm-Message-State: AOJu0YwEvljfBnw3mUPqy6kJcjXh7skUNhMUAawuvn+dTmXS3l0hHUph
	N+KD/o5juEeeBWqszgQVN8fAkOaMVcOBaGy9m7B1OBKSYBLSFjcZ9IFpm6W/7Qw=
X-Google-Smtp-Source: AGHT+IELCTRAfn4Q3j5bkoEKsJmTJ0sElaOKbp2cdJoLDBMzu4CJ1I4mXsTIKkTvkDQkCbEZVskYhQ==
X-Received: by 2002:a05:6808:2a0d:b0:3c8:6957:fbae with SMTP id ez13-20020a0568082a0d00b003c86957fbaemr31832oib.17.1714286091039;
        Sat, 27 Apr 2024 23:34:51 -0700 (PDT)
Received: from C02FRH0UMD6M.cn.corp.seagroup.com ([143.92.118.30])
        by smtp.gmail.com with ESMTPSA id t3-20020a635343000000b005f077dce0f6sm17075109pgl.31.2024.04.27.23.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 23:34:50 -0700 (PDT)
From: kwb <wangbing.kuang@shopee.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: chunguang.xu@shopee.com,
	kwb <wangbing.kuang@shopee.com>
Subject: [Bug Report] nvme connect deadlock in allocating tag
Date: Sun, 28 Apr 2024 14:31:48 +0800
Message-Id: <20240428063147.88058-1-wangbing.kuang@shopee.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_233503_714340_974E3F01 
X-CRM114-Status: GOOD (  21.02  )
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

Hi,
We found nvme connect will dealock when it cannot alloc tag in admin queue. So we reproduce it and find a way to work around. The solution is to utilize reserve tag for connecting.
Here is the deadlock environment:
1. the process [kworker/u129:1+nvme-wq] want to connect wait for geting tag, but tag is used up:
[<0>] blk_mq_get_tag+0x11d/0x2d0
[<0>] __blk_mq_alloc_request+0x92/0x180
[<0>] blk_mq_alloc_request+0x7c/0xc0
[<0>] nvme_alloc_request+0x28/0x100 [nvme_core]
[<0>] __nvme_submit_sync_cmd+0x1ea/0x230 [nvme_core]
[<0>] nvmf_reg_read64+0x62/0xa0 [nvme_fabrics]
[<0>] nvme_enable_ctrl+0x25/0xb0 [nvme_core]
[<0>] nvme_tcp_setup_ctrl+0x257/0x340 [nvme_tcp]
[<0>] nvme_tcp_reconnect_ctrl_work+0x24/0x40 [nvme_tcp]
[<0>] process_one_work+0x228/0x3d0
[<0>] worker_thread+0x4d/0x3f0
[<0>] kthread+0x127/0x150
[<0>] ret_from_fork+0x1f/0x30
2. many processes (here is nvme list) is waiting for connecting:
[<0>] blk_execute_rq+0x8d/0x110
[<0>] nvme_execute_passthru_rq+0x60/0x1f0 [nvme_core]
[<0>] nvme_submit_user_cmd+0x23e/0x400 [nvme_core]
[<0>] nvme_user_cmd+0x163/0x1d0 [nvme_core]
[<0>] nvme_ctrl_ioctl+0x2e/0x40 [nvme_core]
[<0>] __nvme_ioctl+0x78/0xc0 [nvme_core]
[<0>] nvme_ioctl+0x1e/0x20 [nvme_core]
[<0>] blkdev_ioctl+0x126/0x260
[<0>] block_ioctl+0x4a/0x60
[<0>] __x64_sys_ioctl+0x91/0xc0
[<0>] do_syscall_64+0x59/0xc0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Reproduce method is very eazy:
1. call many nvme list
2. make nvme io timeout to recover connection
3. trick is to make reconnect-delay much time, eg:30s

The solution is the appending patch. it is tested and also consider keepalive and reset/showdown tag reserve.

---
 drivers/nvme/host/core.c    | 16 ++++++++--------
 drivers/nvme/host/fabrics.c | 12 ++++++------
 drivers/nvme/host/fabrics.h | 16 +++++++---------
 drivers/nvme/host/fc.c      |  4 ++--
 drivers/nvme/host/nvme.h    |  8 ++++----
 drivers/nvme/host/pci.c     |  6 +++---
 drivers/nvme/host/rdma.c    |  4 ++--
 drivers/nvme/host/tcp.c     |  4 ++--
 drivers/nvme/target/loop.c  |  4 ++--
 9 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6aaecf2ecf97..761bc44527a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2138,7 +2138,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
 	int ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, BLK_MQ_REQ_RESERVED)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
 		if ((csts & NVME_CSTS_RDY) == bit)
@@ -2171,7 +2171,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 
@@ -2187,7 +2187,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	unsigned dev_page_min;
 	int ret;
 
-	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap, BLK_MQ_REQ_RESERVED);
 	if (ret) {
 		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
 		return ret;
@@ -2210,7 +2210,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 	return nvme_wait_ready(ctrl, ctrl->cap, true);
@@ -2226,11 +2226,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config, BLK_MQ_REQ_RESERVED);
 	if (ret)
 		return ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, BLK_MQ_REQ_RESERVED)) == 0) {
 		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
 			break;
 
@@ -3070,7 +3070,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 {
 	int ret;
 
-	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
+	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs, 0);
 	if (ret) {
 		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
 		return ret;
@@ -4331,7 +4331,7 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 
 	u32 csts;
 
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts, 0))
 		return false;
 
 	if (csts == ~0)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567..5d18822edd0a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd;
 	union nvme_result res;
@@ -154,7 +154,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -188,7 +188,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd = { };
 	union nvme_result res;
@@ -200,7 +200,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags)
 {
 	struct nvme_command cmd = { };
 	int ret;
@@ -245,7 +245,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, flags);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 561c2abd3892..3f9ed5392e36 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,12 +18,10 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
+/* Reserved for connect */
+#define NVMF_IO_RESERVED_TAGS		1
+/* Reserved for connect and keep alive and reset/delete */
+#define NVMF_ADMIN_RESERVED_TAGS	3
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
@@ -179,9 +177,9 @@ nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 	return true;
 }
 
-int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
-int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
-int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
+int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags);
+int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t falgs);
+int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..36834408caf0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_fc_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->tag_set.reserved_tags = NVMF_IO_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size =
@@ -3510,7 +3510,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->admin_tag_set.reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d94774cc52bc..b7577156ed80 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,9 +493,9 @@ struct nvme_ctrl_ops {
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_PCI_P2PDMA		(1 << 2)
-	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
-	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
-	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
+	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags);
+	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags);
+	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
@@ -566,7 +566,7 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->subsystem)
 		return -ENOTTY;
-	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65, BLK_MQ_REQ_RESERVED);
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d820131d39b2..b614273029fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2850,19 +2850,19 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
+static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val, blk_mq_req_flags_t flags)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
+static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val, blk_mq_req_flags_t flags)
 {
 	writel(val, to_nvme_dev(ctrl)->bar + off);
 	return 0;
 }
 
-static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
+static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val, blk_mq_req_flags_t flags)
 {
 	*val = lo_hi_readq(to_nvme_dev(ctrl)->bar + off);
 	return 0;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a49061f2afce..20fedf17166b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -801,7 +801,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE;
@@ -814,7 +814,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2d81db71aaa1..df7acb44b20c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1667,7 +1667,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
@@ -1679,7 +1679,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 2553f487c9f2..9a591ab4c810 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -353,7 +353,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->admin_tag_set.reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
@@ -527,7 +527,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_loop_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = NVMF_RESERVED_TAGS;
+	ctrl->tag_set.reserved_tags = NVMF_IO_RESERVED_TAGS;
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
-- 
2.36.0


