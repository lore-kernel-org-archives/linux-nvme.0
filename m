Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C5FC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80B864E10
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80B864E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LuAA9b8mzY+qjVZEBgk6D1ES2uMOLWr69bypOAiVkbA=; b=T+BEGEIOmMrIeMoC6ylPFS1XF
	3U5aXXeXkQ02qUUAFt4EpOvh5LygO7/wCnPpqLMR/Q9a8tKmnbez86NF+zwd2drl+1blYuYXZEkO4
	RdrOPHTF/wlk9+Qzsw6Duod5RW/jft3t1gKYmR0GrI13L3XAbb/AvvzCzZ8UogG6TVCabcqhOiux7
	wWXtX7gpKjCIdu8YU+fl9kZVW4++mdW77FMD6RgnkZ/JXHqeFar99paDjU6H5vKO6mW4X1Tj8BuZ6
	53MESr3I+UbKWO6p98u+kb0iWFwsDjApT93zZ1z0g6/30NGHVLuZ9tDyunyWlkObb7RYz/BAXY/q3
	BMG8Qsrkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxH-0004Q4-OO; Mon, 01 Mar 2021 02:06:39 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxF-0004PD-43
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564396; x=1646100396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UdvmtRO2EafxBcaJQFd2/K20AMM/0FSsNLWlfS/XsaU=;
 b=CKk74QFJoDiu634RRPyUvm5pB5B5LFJ1YDGV0lbU0LJRo0nwYDyuMXX1
 qva4gJ+HFmKuh3Bk1kAbA+0rMLMO7700ap7gf7yBtZRdQG4BGxIhhZL5I
 F4lmMnNyaDR0sHDOqP9pFQ57Zm1Iw+pe6/iw2W0VUYgkQAUwB12ESwZWp
 VNkqn+dsgq+SAPNi33FFwAAlkSjUBPZPlFGZrcYM+IbzBodC6b95qXLs+
 vuG5n6Sabb+QurbtMYKVAFQWoxrVrQpnRXDskXLlYqftIt/h+NBg2C7y0
 nF3HooYI5xpsVuTr13g/Eevq3eyBEs/K7zz9jf2huLykR7okn2xLRozqX g==;
IronPort-SDR: g3xMeAg2cwMqyYng1kq05P1pqVwbGHpOpRgYSmTveZMikX1pwyzRn0wts0DG39TavtbTBraGAL
 hHSzGeVWy2jRmIFUMcAZqVPcvYrQZgcSF6x6Gc7Mj1iFzodtjC6TzMTV0w0CmZjXdppTtYwxNm
 lleoyij6WLaFzFAcYhxsGyuDVHlc1msd6JFzn6Abtktg9RjVh2Ef90toG11uLlG0x3AuS69umH
 8wdynm5qyraO2JzhHT0tSuoharhwfxL/BOvsRFy9jlUJ43eiYZWNRoAomjp1Agq5LHQjg8K1iK
 ZLg=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="271615083"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:06:23 +0800
IronPort-SDR: MukBsASS53hzj5ImhXrEJlRCssFzUcRbEndXvGnpXXxNA7lm1kNK6g5tDtsJQ0c2NGXc7jAE5y
 VWAe1dy0rEHWOLVHNyxFfYYKVEhbB/wgV2apnPdHHWT4C7fMIHr5no7pIn6WHNWhKLvU46oJQL
 +ylIei57LiUggDSer93p0aFQanlqbrN7IDMZyPPqt93N9Xh3SeonG4ZX2Hm/+yZ3VgEOuAuABV
 6WWaVpvEXhPTZtVqEcIJ3urnNLnFk9ExtX8LUZn6CBzasPffV0teb9HXgxITA+x85pfTynhxrW
 VbEGdsZCOE5WlvISiKmi8P8y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:47:40 -0800
IronPort-SDR: PL0T+dOeuu+g3qUW3zKJCF7ClwG8sFJi1htgOGmKztEm3w8iEbrefy1k4d36ZqAsv5ODHcx6F4
 LM63nLnF7gpXwfQAnl/n9FUgkhKMUaLEKYgXkPMhW4o0E4PIVXXthYYlBRSjbnvTM9wSiOnOh3
 DSofyEHrfcK6xmYCjy/8EvwjZ46V2ZaDJE/3UzG8VWcDUckvYB4q/0RYEU9LerE9EJuIM93yO4
 dTQAPOz9DVl3N/Yczl8fXRNQSk449g1omVOZ0h+ky8zXhMp5ABdYR6gDoLnDBCEB/Jdp0ISdqH
 Dno=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:06:23 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/8] nvme-core: rename nvme_init_identify()
Date: Sun, 28 Feb 2021 18:06:04 -0800
Message-Id: <20210301020611.18669-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210637_397554_E5AD36B1 
X-CRM114-Status: GOOD (  15.38  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a prep patch so that we can move the identify data structure
related code initialization from nvme_init_identify() into a helper.

Rename the function nvmet_init_identify() to nvmet_init_ctrl_finish().

Next patch will move the nvme_id_ctrl related initialization from newly
renamed function nvme_init_ctrl_finish() into the nvme_init_identify()
helper.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c   | 8 ++++----
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e68a8c4ac5a6..b72d0ec706be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1119,7 +1119,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC)
-		nvme_init_identify(ctrl);
+		nvme_init_ctrl_finish(ctrl);
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
@@ -1978,7 +1978,7 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 	 * In order to be more cautious use controller's max_hw_sectors value
 	 * to configure the maximum sectors for the write-zeroes which is
 	 * configured based on the controller's MDTS field in the
-	 * nvme_init_identify() if available.
+	 * nvme_init_ctrl_finish() if available.
 	 */
 	if (ns->ctrl->max_hw_sectors == UINT_MAX)
 		max_blocks = (u64)USHRT_MAX + 1;
@@ -3064,7 +3064,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
  * register in our nvme_ctrl structure.  This should be called as soon as
  * the admin queue is fully up and running.
  */
-int nvme_init_identify(struct nvme_ctrl *ctrl)
+int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
 	int ret, page_shift;
@@ -3251,7 +3251,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	kfree(id);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_init_identify);
+EXPORT_SYMBOL_GPL(nvme_init_ctrl_finish);
 
 static int nvme_dev_open(struct inode *inode, struct file *file)
 {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 20dadd86e981..962987a330d6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3085,7 +3085,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-	ret = nvme_init_identify(&ctrl->ctrl);
+	ret = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
 		goto out_disconnect_admin_queue;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..624fc4334a2c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -599,7 +599,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
-int nvme_init_identify(struct nvme_ctrl *ctrl);
+int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 207137a0ed8e..b8f0bfaa8f2a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2652,7 +2652,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev->ctrl.max_integrity_segments = 1;
 
-	result = nvme_init_identify(&dev->ctrl);
+	result = nvme_init_ctrl_finish(&dev->ctrl);
 	if (result)
 		goto out;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 53ac4d7442ba..9c710839b03a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -917,7 +917,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-	error = nvme_init_identify(&ctrl->ctrl);
+	error = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (error)
 		goto out_quiesce_queue;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69f59d2c5799..735e768f9f43 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1875,7 +1875,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 
 	blk_mq_unquiesce_queue(ctrl->admin_q);
 
-	error = nvme_init_identify(ctrl);
+	error = nvme_init_ctrl_finish(ctrl);
 	if (error)
 		goto out_quiesce_queue;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index cb6f86572b24..a7f97c8b2f77 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -396,7 +396,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-	error = nvme_init_identify(&ctrl->ctrl);
+	error = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
