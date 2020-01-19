Return-Path: <SRS0=Eo3O=3I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02414C33CAF
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 21:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C2E20678
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 21:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MxF3rIpI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FSm6yNXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C2E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTtl/Mx7fsiV23AcEzmv0im73kBuoITqYdu/dOUAcBE=; b=MxF3rIpIT9bRhP
	VGxG+WzLUlB7bK6duJ+MuoD/SQYzJTmpIjAPJtMcnYI5IMwYkPFNQMafJ4K0Jqb86BHWkt2ijXX5Q
	qyIydwjpanZvzvTAadOqdIPAOxZnwK6qWIHo/fpN+lZFutCtwr/j5WNfUm5Mqol28Ll5lnd1e3eop
	WHC1Kb66HV+IqqE4E/XWmEygtKB7AXrcS+hqVu525q67Tk6nW1qHkHnk18PZlhQmttEYQvpW7EBbP
	+sz5e8Cpy2xvPk2INpU9lPBsnPBj5MUDDNQw5uNjNF23RSlAg3moL0/3QaXJ+HMIIbB0LhboeFjoD
	m+vM00VppWAjPACAFmZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itI3A-0005AT-VG; Sun, 19 Jan 2020 21:24:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itI2e-0004hn-So
 for linux-nvme@lists.infradead.org; Sun, 19 Jan 2020 21:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579469012; x=1611005012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ax33sAIdCUfV9r8DC9tcvwUPh9ZFGKtC1p35EKdqTfk=;
 b=FSm6yNXv0gS9hkbs5Nv4VBKtTn2wpobqMxf3PSoW+27rf2rLOYMNkSWm
 Uuorjmg2S4KPvkBhhcOQbY3cDklwZ6eC/nT/BKPLTMpMMv5T1NRq1c6vQ
 uYXB77WlnA0g59cBYFLvnZEoMz1rPIl5pM/CPbtNSy+D2oj+627ghRsuE
 3wKkRqYd0z9iPhLnLsP0WgcU430YfujIOV2/nBiJWfp6GLXFAHczK1X9R
 S5OeFpMqY0amtKbccGWCBz3o6N2OqDIHMPvmZIh9rE14qn5kq/5HWLgdd
 QXV+PifxZCfMgGdYQwOZQzIdGRVgr8Vvb07UWOyBB9kLnRJChT611UU6C g==;
IronPort-SDR: 1KXTRF/bgNf2g3ros/83fwGmh3taUF6d8ss7p8XgEmFRsqJmOt0xcy2c7SI6+qTFyJ+FgAHfDw
 u2CP8kr0mwJkMlXFVl05ChpZ1KvJs1YfjOa0RV68t/j4Lh/f5disEd8ffaPRgx8P25v+QFgFFC
 7lFuaoAlrL1qYH42hJOmQdO9x9nqUlVeAp9QRmCCyrxWDy9Sla2YuzvyXfdlHpGc0kxmVrz7eF
 YML/0uvaOFAxeUw2A88JEA2JjrVk24nLfKzISRy47uGGiULgycvI54d6oKcvanRL+82Ysvlp1p
 e8E=
X-IronPort-AV: E=Sophos;i="5.70,339,1574092800"; d="scan'208";a="235845826"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2020 05:23:31 +0800
IronPort-SDR: KML91xTs8pLxqNwnTizoRqU657JjoSQ1MWpLrmf7zuxSSY0PJ7JmNTF+zShCfLsr7QsETcWLqS
 sIKf86JEz66V4+I3CclcbkwWCSgdOQvx0Ul4KLq+SXqol4tjfNWXC1+Av4/Vbjx2svtX1Zt8Qc
 /DfZnUlsZGExUrlQvLdrGzcuNr10XzQLGTDnT9Rn1BA60jqq5EgvzW/vIXdrfQAq2BFmsuIHSF
 w+iDCnx1b6qPr2nd//WtCWkShkWAhCeqt6PkvrHCo2PkZZ15M89+N0Oq58FXdu6N564+Oc6eJG
 6WNyCg6CBlk/+K+1CE+QpzfI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2020 13:17:00 -0800
IronPort-SDR: O7fsFw/6nPqP+rRudaCe2+xoLUHrcOHXdcyj60EJaymPQKUgEDmFsK/jPM3FLi5o6Kq7G3S/6W
 RdJs4hdfZ9Q07PkPAsJ8Ve01ciKts6v+5y8RZf9oRGc5uR70CCD57Co8/6gslxrpTerunpepMN
 TOW6Y2yK4F5H3XI3TgF7g1MLq3gVIiRtWIFjCh3+kUdfXv889saE2SNrPGc5EUSLKzBNDLZd2S
 Txr3a3BXglPG4Oomrou5X0pM1NqId/ba54BTjEGv6dOFYXV533dN20ZngPSeOIIEJnzlcJGbYt
 qVM=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 Jan 2020 13:23:32 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 4/4] nvmet: update AEN list and array at one place
Date: Sun, 19 Jan 2020 13:23:26 -0800
Message-Id: <20200119212326.19701-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200119212326.19701-1-chaitanya.kulkarni@wdc.com>
References: <20200119212326.19701-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200119_132332_948982_704C4159 
X-CRM114-Status: GOOD (  16.68  )
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
Cc: Daniel Wagner <dwagner@suse.de>, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Daniel Wagner <dwagner@suse.de>

From: Daniel Wagner <dwagner@suse.de>

All async events are enqueued via nvmet_add_async_event() which
updates the ctrl->async_event_cmds[] array and additionally an struct
nvmet_async_event is added to the ctrl->async_events list.

Under normal operations the nvmet_async_event_work() updates again the 
ctrl->async_event_cmds and removes the corresponding struct
nvmet_async_event from the list again. Though nvmet_sq_destroy() could
be called which calls nvmet_async_events_free() which only updates 
the ctrl->async_event_cmds[] array.

Add new functions nvmet_async_events_process() and 
nvmet_async_events_free() to process async events, update an
array and the list.

When we destroy submission queue after clearing the aen present on the 
ctrl->async list we also loop over ctrl->async_event_cmds[] for any 
requests posted by the host for which we don't have the AEN in the 
ctrl->async_events list by calling nvmet_async_event_process() and 
nvmet_async_events_free().

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[chaitanya.kulkarni@wdc.com
 * Added the code to loop over and clear out outstanding requests
   present in the ctrl->async_event_cmds[] for which aen is not
   generated.
 * Update patch description and title to fit kernel log style.
]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V2:-

1. Add helper to clean up the array ctrl->nr_async_event_cmds[]
   nvmet_async_events_free().
2. Use local variable into nvmet_sq_destroy().
3. Call newly added helper nvmet_async_events_free() from
   nvmet_sq_destroy().
4. Update commit log.

Changes from V1:-

1. Generate patch on nvme-5.6 branch.
---
 drivers/nvme/target/core.c | 63 ++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 72938c8e9fcb..b775fce820a2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,27 +129,8 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
 }
 
-static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
-{
-	struct nvmet_req *req;
-
-	while (1) {
-		mutex_lock(&ctrl->lock);
-		if (!ctrl->nr_async_event_cmds) {
-			mutex_unlock(&ctrl->lock);
-			return;
-		}
-
-		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
-	}
-}
-
-static void nvmet_async_event_work(struct work_struct *work)
+static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 {
-	struct nvmet_ctrl *ctrl =
-		container_of(work, struct nvmet_ctrl, async_event_work);
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
@@ -159,20 +140,43 @@ static void nvmet_async_event_work(struct work_struct *work)
 				struct nvmet_async_event, entry);
 		if (!aen || !ctrl->nr_async_event_cmds) {
 			mutex_unlock(&ctrl->lock);
-			return;
+			break;
 		}
 
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		nvmet_set_result(req, nvmet_async_event_result(aen));
+		if (status == 0)
+			nvmet_set_result(req, nvmet_async_event_result(aen));
 
 		list_del(&aen->entry);
 		kfree(aen);
 
 		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, 0);
+		nvmet_req_complete(req, status);
 	}
 }
 
+static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_req *req;
+
+	mutex_lock(&ctrl->lock);
+	while (ctrl->nr_async_event_cmds) {
+		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+		mutex_unlock(&ctrl->lock);
+		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+		mutex_lock(&ctrl->lock);
+	}
+	mutex_unlock(&ctrl->lock);
+}
+
+static void nvmet_async_event_work(struct work_struct *work)
+{
+	struct nvmet_ctrl *ctrl =
+		container_of(work, struct nvmet_ctrl, async_event_work);
+
+	nvmet_async_events_process(ctrl, 0);
+}
+
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
@@ -752,20 +756,25 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
 
 void nvmet_sq_destroy(struct nvmet_sq *sq)
 {
+	u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
+	struct nvmet_ctrl *ctrl = sq->ctrl;
+
 	/*
 	 * If this is the admin queue, complete all AERs so that our
 	 * queue doesn't have outstanding requests on it.
 	 */
-	if (sq->ctrl && sq->ctrl->sqs && sq->ctrl->sqs[0] == sq)
-		nvmet_async_events_free(sq->ctrl);
+	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
+		nvmet_async_events_process(ctrl, status);
+		nvmet_async_events_free(ctrl);
+	}
 	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 
 	if (sq->ctrl) {
-		nvmet_ctrl_put(sq->ctrl);
-		sq->ctrl = NULL; /* allows reusing the queue later */
+		nvmet_ctrl_put(ctrl);
+		ctrl = NULL; /* allows reusing the queue later */
 	}
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_destroy);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
