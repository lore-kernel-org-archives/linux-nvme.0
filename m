Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C0DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQEtPkjsOoNetUtKozc5+X0iKou8cfsr3xAOxY+aAug=; b=JCx70ny3dvx5pmNOlT8D4Oaox6
	KjN1f6MBHOCy1nCsGYvHvNohbx9MK+59tn/vZu+CV64SiVMWCxBgsmyxvh7i5NLp2ayXfFNYDfFri
	NrzPQ2d6j/tFUAPRJ/FrKjR/Uh4tT9oyAKZfXCPyJRZPhs2dFWkBOvVhLVbbP1tskPCAry5o9f0sr
	K7rvP0lG1hErSGtZH/Ad5qXeY88SchNdFeOhvMh5nYJhxXaPap+JlbtfLRaEspK5wy9lSJLXUbSNn
	RjZ70OALzJa7KqfRF63p8xUUvO5gDdg6iWy8D0Tk2lngNIN7inEFNCaouDnIMcMflafNzqExM9jhc
	FV2ovDbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwIsx-00ENqK-2n; Wed, 01 Jun 2022 07:35:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwIsu-00ENne-16
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 07:35:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2B2AE68AFE; Wed,  1 Jun 2022 09:35:06 +0200 (CEST)
Date: Wed, 1 Jun 2022 09:35:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	caroline.subramoney@microsoft.com, riwurd@microsoft.com,
	nathan.obr@microsoft.com
Subject: Re: [PATCH 2/2] nvme-pci: handle persistent internal error AER
 from NVMe controller
Message-ID: <20220601073505.GA24875@lst.de>
References: <1654056747-40143-1-git-send-email-mikelley@microsoft.com> <1654056747-40143-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654056747-40143-2-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_003516_399528_6D2A28AB 
X-CRM114-Status: GOOD (  18.71  )
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

This really belongs into common code.  See the untested patch below
of how I'd do it.  The nvme_should_reset would be a separate prep
patch again.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72f7c955c7078..b8b8e9ee04120 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -171,6 +171,24 @@ static inline void nvme_stop_failfast_work(struct nvme_ctrl *ctrl)
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 }
 
+bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts)
+{
+	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
+	switch (ctrl->state) {
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	default:
+		break;
+	}
+
+	/*
+	 * We shouldn't reset unless the controller is on fatal error state or
+	 * if we lost the communication with it.
+	 */
+	return (csts & NVME_CSTS_CFS) ||
+		(ctrl->subsystem && (csts & NVME_CSTS_NSSRO));
+}
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -4537,24 +4555,41 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aen_persistent_error(struct nvme_ctrl *ctrl)
+{
+	u32 csts;
+
+	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) < 0 ||
+	    nvme_should_reset(ctrl, csts)) {
+		dev_warn(ctrl->device, "resetting due to AEN\n");
+		nvme_reset_ctrl(ctrl);
+	}
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	u32 aer_type = result & 0x07;
+	u32 aen_type = result & 0x07;
+	u32 aen_subtype = (result & 0xff00) >> 8;
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
-	switch (aer_type) {
+	switch (aen_type) {
 	case NVME_AER_NOTICE:
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		if (aen_subtype == NVME_AER_ERROR_PERSIST_INT_ERR) {
+			nvme_handle_aen_persistent_error(ctrl);
+			break;
+		}
+		fallthrough;
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
+		trace_nvme_async_event(ctrl, aen_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c9..0d7e9ac52d25a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -762,6 +762,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
+bool nvme_should_reset(struct nvme_ctrl *ctrl, u32 csts);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_try_sched_reset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7de09642..c57023d98f8f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1293,31 +1293,6 @@ static void abort_endio(struct request *req, blk_status_t error)
 	blk_mq_free_request(req);
 }
 
-static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
-{
-	/* If true, indicates loss of adapter communication, possibly by a
-	 * NVMe Subsystem reset.
-	 */
-	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
-
-	/* If there is a reset/reinit ongoing, we shouldn't reset again. */
-	switch (dev->ctrl.state) {
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	default:
-		break;
-	}
-
-	/* We shouldn't reset unless the controller is on fatal error state
-	 * _or_ if we lost the communication with it.
-	 */
-	if (!(csts & NVME_CSTS_CFS) && !nssro)
-		return false;
-
-	return true;
-}
-
 static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 {
 	/* Read a config register to help see what died. */
@@ -1355,7 +1330,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Reset immediately if the controller is failed
 	 */
-	if (nvme_should_reset(dev, csts)) {
+	if (nvme_should_reset(&dev->ctrl, csts)) {
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3481ff6..8ced2439f1f34 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -711,6 +711,10 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
+enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,

