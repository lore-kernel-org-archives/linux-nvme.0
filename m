Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A4C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC0221531
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bzStTKml";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dlKmlQog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC0221531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uAYJJ4q9dNyZI9pHQUetb9MacobVZps2nTBkMr/zuZA=; b=bzStTKml2aOKrfB9F4w/iu61h
	yZ0FY/hD/NqutZ/MzgcHgHbV9t5N4UenYAkMXC4XPY+XFSqbGfJ3+/LHjTQoS38E2IVagK9dUcHXf
	hUNgyq2coaCQcB+WQZWom3Uy9d/vguXuJchZZM+ImqVRlRMKlNg40/nxxjNII0ZTSGxJ8HyVVdeyb
	pKDtLyheIjTRytq2UQ63+vHYj+uR+vGkuDyRFgBwOCcBxK6xXuTM8qiInuyno5ue6lQ5Wdof/2fKQ
	qCWgg4CGR9Y1vtaL1xwwB4rT0KZDCBudLV3leic0Fu5ShHP//wlhRJyulwZ1NqMAhmo2Fm2t5Ezh/
	2HIHDTd8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNp-0002fF-9C; Mon, 28 Sep 2020 12:35:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNL-0002Qe-1Y
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=+BB8ZoZAR5fcHBbpJKXaGadSvqk4DOdfJ0hJcqRpSrQ=; b=dlKmlQogkxIDVjSI2NA0ba6hKs
 kmr3YqwPXTM2/kgYgPtPuYLDFWFxTfjaQAFM1+M0RiYbOjt/j9UcAzadzxjO2yh0NxEvJxtWLzWLo
 Rx6DcNyQEpf2+v8Fv2uFRX0Er7TAFeiPovNbBblme0KV8HD8ydt6t98jwKiiR5gU5H+cdc/Y9Pn0n
 zNEGRitC+O08KdIfnJoS/NLkpIj0F8q6fvDAYus5vATtqNZuZBPc/UV1PywzV0ue5+hCWVkXBBmwj
 XCSnLDvxA/FgjW9wgHkQYK86UILfLoevhMDY5VMrSjd0TX2x1C2RThE9U/hF/fgY5Dm2aIpZazOnc
 91+DolxQ==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNJ-0004m5-UM; Mon, 28 Sep 2020 12:35:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 15/20] nvme: remove nvme_update_formats
Date: Mon, 28 Sep 2020 14:34:57 +0200
Message-Id: <20200928123502.435373-16-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now that the queue is frozen before updating ->lba_shift we can't hit the
invalid references mentioned in the comment any more.  More importantly
this code would not have helped us if the format was changed by another
controller or through implementation defined back channels.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4737591c1143ae..f19f6c7c5b1242 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -89,7 +89,6 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
-static int nvme_validate_ns(struct nvme_ns *ns);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
@@ -1009,7 +1008,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	 * For simplicity, IO to all namespaces is quiesced even if the command
 	 * effects say only one namespace is affected.
 	 */
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		mutex_lock(&ctrl->scan_lock);
 		mutex_lock(&ctrl->subsys->lock);
 		nvme_mpath_start_freeze(ctrl->subsys);
@@ -1020,36 +1019,9 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
-{
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (nvme_validate_ns(ns))
-			nvme_set_queue_dying(ns);
-		else if (blk_queue_is_zoned(ns->disk->queue)) {
-			/*
-			 * IO commands are required to fully revalidate a zoned
-			 * device. Force the command effects to trigger rescan
-			 * work so report zones can run in a context with
-			 * unfrozen IO queues.
-			 */
-			*effects |= NVME_CMD_EFFECTS_NCC;
-		}
-	up_read(&ctrl->namespaces_rwsem);
-}
-
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 {
-	/*
-	 * Revalidate LBA changes prior to unfreezing. This is necessary to
-	 * prevent memory corruption if a logical block size was changed by
-	 * this command.
-	 */
-	if (effects & NVME_CMD_EFFECTS_LBCC)
-		nvme_update_formats(ctrl, &effects);
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		nvme_unfreeze(ctrl);
 		nvme_mpath_unfreeze(ctrl->subsys);
 		mutex_unlock(&ctrl->subsys->lock);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
