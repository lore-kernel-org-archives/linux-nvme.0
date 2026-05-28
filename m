Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A58CD5BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9C4v7pMf1bBU4idbf7sJYY/EwVtQD4vdwhtoY8tZaPc=; b=tInUuPGyJtMM7l9Ag9/NBXTRoO
	Klg1xFYS+2nOKCGbcv5z3bsfWKN7iCpg/0qsR7rjoU3x9kNfV+rD2d2ZDxnN0e1hz4giJX3+zVsLD
	FsrsygkVkie3mP52TD1y9V0wIFWl+gJjNTtB961ERT55R4YEIflEmhpCpO6TAR+2X7H3Ot+ke6LRA
	2au8e3Nk+eYmkiE932PS/tCWnmezeMxXdTlRCBfeZkfssA/heBJfqZXj9xy4r+K9Pg+6BJmOnvxTA
	x0Osk9i+U34DYKuRTTffHzo/RK3QQ669iAOIcEt3f6AY92Vrp9U3MEB0nveiQacz5+4XOnKjWo22o
	xgVgzRdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX1v-00000005VEe-2QhD;
	Thu, 28 May 2026 09:27:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSX1r-00000005VDX-4919
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 09:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779960470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9C4v7pMf1bBU4idbf7sJYY/EwVtQD4vdwhtoY8tZaPc=;
	b=JM9h88jCy8H57QXJBDy07Jza8RU0PAXIzxBt8fPMFZCxcVQS5sGXTKG4ZejFIBAN7J6mLr
	pkpt29mkBeFRQ9mhNLFFjnbu8HTvEQhjgnA2p5RTPNc8MYTRNWmexTCo1mglPc9HY7dy6k
	HdiZ9Ypd3CuOc8MfBqtxI0udpneVNSM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-PtVEYc5LNXuaCRSDhcWDKA-1; Thu,
 28 May 2026 05:27:46 -0400
X-MC-Unique: PtVEYc5LNXuaCRSDhcWDKA-1
X-Mimecast-MFC-AGG-ID: PtVEYc5LNXuaCRSDhcWDKA_1779960464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C64218005BA;
	Thu, 28 May 2026 09:27:44 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.41])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A5D61955F19;
	Thu, 28 May 2026 09:27:40 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	emilne@redhat.com
Subject: [PATCH 1/1] nvme-fc: Do not cancel requests in io target before it is initialized
Date: Thu, 28 May 2026 11:27:34 +0200
Message-ID: <20260528092734.258899-2-mlombard@redhat.com>
In-Reply-To: <20260528092734.258899-1-mlombard@redhat.com>
References: <20260528092734.258899-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -5DfLcAjVmqEB5k3PJJUfU9AHqbXEXCwxdqhyjGGrGE_1779960464
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_022752_114676_DFDA2083 
X-CRM114-Status: GOOD (  12.52  )
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

From: Mohamed Khalfella <mkhalfella@purestorage.com>

A new nvme-fc controller in CONNECTING state sees admin request timeout
schedules ctrl->ioerr_work to abort inflight requests. This ends up
calling __nvme_fc_abort_outstanding_ios() which aborts requests in both
admin and io tagsets. In case fc_ctrl->tag_set was not initialized we
see the warning below. This is because ctrl.queue_count is initialized
early in nvme_fc_alloc_ctrl().

nvme nvme0: NVME-FC{0}: starting error recovery Connectivity Loss
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
lpfc 0000:ab:00.0: queue 0 connect admin queue failed (-6).
you didn't initialize this object before use?
turning off the locking correctness validator.
Workqueue: nvme-reset-wq nvme_fc_ctrl_ioerr_work [nvme_fc]
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x80
 register_lock_class+0x567/0x580
 __lock_acquire+0x330/0xb90
 lock_acquire.part.0+0xad/0x210
 blk_mq_tagset_busy_iter+0xf9/0xc00
 __nvme_fc_abort_outstanding_ios+0x23f/0x320 [nvme_fc]
 nvme_fc_ctrl_ioerr_work+0x172/0x210 [nvme_fc]
 process_one_work+0x82c/0x1450
 worker_thread+0x5ee/0xfd0
 kthread+0x3a0/0x750
 ret_from_fork+0x439/0x670
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Update the check in __nvme_fc_abort_outstanding_ios() confirm that io
tagset was created before iterating over busy requests. Also make sure
to cancel ctrl->ioerr_work before removing io tagset.

Reviewed-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Signed-off-by: James Smart <jsmart833426@gmail.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e4f4528fe2a2..5c6a81333174 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2461,7 +2461,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * io requests back to the block layer as part of normal completions
 	 * (but with error status).
 	 */
-	if (ctrl->ctrl.queue_count > 1) {
+	if (ctrl->ctrl.queue_count > 1 && ctrl->ctrl.tagset) {
 		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -2900,6 +2900,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 out_delete_hw_queues:
 	nvme_fc_delete_hw_io_queues(ctrl);
 out_cleanup_tagset:
+	/*
+	 * In CONNECTING state ctrl->ioerr_work will abort both admin
+	 * and io tagsets. Cancel it first before removing io tagset.
+	 */
+	cancel_work_sync(&ctrl->ioerr_work);
 	nvme_remove_io_tag_set(&ctrl->ctrl);
 	nvme_fc_free_io_queues(ctrl);
 
-- 
2.54.0


