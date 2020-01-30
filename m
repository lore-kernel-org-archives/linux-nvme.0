Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE18C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:30:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF23720658
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MVIB7P2g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LC7udPjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF23720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HlvMcMTbkDaHlT4A6wzBgIS3J+MAHYU6Q86eob1K1bg=; b=MVIB7P2g6Rq1eW
	xc5OuotfaDBJ12kqf5zD94Xalvjs1lxz8V4e72XCJxREjmkUYFFxMWx4zMg9PMfChNqhyCtSzTCLD
	F0mDTcFt/Q5Y7n+zsxoN04cj2Mi6Tvl5WsWuYuiNyrktEWW/5Revsn4ti203YyMrmm7bUDWQhYLsB
	JTM5QAiPzjwJ9iy8lMlZPksPPwJR+8qyjQ+Hxa5Mb5gtLU7i5U72hcLvxd7ZjFZB0WIZb1zA+njDU
	ojgTiSOFjAqn20aDv6vSpObbX0UUMdojBG0pdXghRqkFZBhxrIyOx1qSsFMtO0G6X/TqrNzj30wbY
	s54C9akFX+7181MX7nkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixEaT-0006t6-Ps; Thu, 30 Jan 2020 18:30:45 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixEZk-0005CT-JE
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 18:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580409000; x=1611945000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BVmEj/RAjs+I0YbX/4cerznHO1u41G4fOJG8GGbSE+c=;
 b=LC7udPjCOwSorsEibDr9sGTZT2Zvv9H+caymvs3K822Uw0UiTunN3eWN
 SUH+ga/wV5gm6fhFmB4YZWZAqmHlQVNVD/SusP5n3+OFwobWQjGhPqNQb
 ckUchVeYALcpo+A5AXl2rlLRBI5rZdHqvQdT4p57Bqvwy+ZedD22S/oix
 smXYHnDnj4oOZwW746hqvyjsrFii4kypbormNDz7kM+ZOnAk9yCH8w58x
 f35dqZpDRKyyLqUgsRDdfYf72aiq0QXkjFo0wj4feJabcPK3Q1TlSTkMR
 ot0wz41MXz2BzY2aE/hX9OH9UH193Byx4pa/8Wwipx16ZZ7UwGwI32Nzy Q==;
IronPort-SDR: 7ipCv6fJUoF6zhk6yJ5+B5hx6xPOUR9ap7gYwwZJkGSPI4lVozfzQSDJgOzzr1vUi/v8VFNH7w
 kBcwrK2hhECKBpV0dyX4YfUDpn6RF/poE8PQCWZcFZCEwrPOLEyzqAiA4VywraTnYSlxvE9gIG
 YM9LsPWMF8bQI8WjpuLX6f8Au5eXI6SsMZf4xS7MTy5go+6pysLp1buevNPAjFluX2YKOliBh7
 MvaMM9gRe8RNNFD65nRO6o5/wWuNusDamBfbRWv8rTuzU2BIqRt9UOu15auj0t7eioqRKs0xdD
 D2k=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; d="scan'208";a="128763548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 02:29:59 +0800
IronPort-SDR: eBQ387iwKF+4wW2rEbSXiO1A+9a3DRAlz7ZVeAid4X1PCzMPD0BokJUc14SZOFyetTRvsABphH
 YUofJlSd6c4HPvlx3kywGOwVLw2imz37XH+rhG0wownCC2VvGcBe9IpX8qxjFiHMI+WGe3ZWGf
 eUAJufnYy9PsKAmwl7OSRbBva+abCIcOnzNWO/Eeafa9jvSLNMdse4tqeoEQqnYAAxM3uEKvD5
 ZJZdjQExUBBomOBeoKXPB/erlbVmK1N8x7LmxkIMOMacsTDDAnTT7c7dNyIwoL/l+W8WU1w1sL
 26zUOrb7qPE8Cu4008+UobdI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2020 10:23:10 -0800
IronPort-SDR: hkxlip9eMcAlEjkgYhPhCGYIW5lNCvYp2HOX7veEnk/8SVSB+V7or8+YFCq7QHKPVDnz9m/snF
 JY2Ddb1/2794nZlpWlT3KXF9GCLCc8tv1kvK7Ybz5+kshIhcHmcW8zBiEuQTB+yd3wRnMhYsTc
 KeiY9z6pNQkZ+zIfbfSvZxxapUowbuXsbrr9j3/Tr4oaUVm1AklD3s9PhtfkQITaTjp2acIGLQ
 o9pw7doUY7P1NTmNM3d7UtDYDoyYRGgIVWg7aUFIeobW+qyIoj9c3gcUwaVIFhw3zSgZW5lgRQ
 u6w=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2020 10:29:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 4/4] nvmet: update AEN list and array at one place
Date: Thu, 30 Jan 2020 10:29:34 -0800
Message-Id: <20200130182934.6109-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
References: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_103000_703222_68698BBC 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
Changes from V3:-

1. Remove the sq->ctrl in the nvmet_sq_destroy() and use local ctrl
   variable.
2. Initialize sq->ctrl == NULL instead of local variable.

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
index 72938c8e9fcb..002658850aa5 100644
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
@@ -752,19 +756,24 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
 
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
 
-	if (sq->ctrl) {
-		nvmet_ctrl_put(sq->ctrl);
+	if (ctrl) {
+		nvmet_ctrl_put(ctrl);
 		sq->ctrl = NULL; /* allows reusing the queue later */
 	}
 }
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
