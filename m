Return-Path: <SRS0=KBoe=7W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF55C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:55:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE28A206F7
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2020 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jvhw2mCW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lCjA3uR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE28A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Nzx8OVwh8IuCLJtmwxXKqQiBJHbVV57E+ac5pPJhfbU=; b=jvhw2mCWOnF+6v
	6mPCUEomnHg9UIVhih6oNOCVjo6HYQEurTLwShkehOULJ1g3WKBeaOkVguJU6aHa2NxNOtxufNUyf
	RVvGquCcJA7r7IGn1DTZsNwAbONfwClU5ubMLOsbmGG96DFo1qJrHNuRnei5r+vv4TCOhNni8DvYS
	dJbbmNFSO4Vs12S8IPxmffpXYKQO5HfH3knOW/cMZbwf3zzGmIgScHwQOw66wTEdsE2IH1y+JHK6+
	oPBRqPFXWR+EHDWbC8E5OUe8SWeSdHoMwmk3KaE8BTgeZ+5p6w/4j8Xa6Nsb6BFzrTKceSSZiJFr9
	1Lpq1/ZSRK/asE+aXWRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jio5R-0007pE-T6; Tue, 09 Jun 2020 23:55:21 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jio5P-0007on-4l
 for linux-nvme@lists.infradead.org; Tue, 09 Jun 2020 23:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591746919; x=1623282919;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hEe5Vfv7sIQ4JInhCeeszBf497E5HIDxDQIn1zY+PBA=;
 b=lCjA3uR/9OItQRcxgHXz6/UU6KJ5tkK/w2HO+FB7bkpgOHt7BgaHCF4N
 sGYf9e8mLKRalTzWp9uvIX+ESRgB7ciDYq2yUysNume7yjPKjgewC1AsW
 aAOqIMtZdjeTWm37upx0oGdiKJoA4+9OVQerMFGqi7KFmZ+2OshVvywa3
 MFeB3VW3HuslmBmgj9rc/nG/h2sukPvkC35AFb3fzZARQ1lfBmA3HEHxZ
 NoZJI5foruBQYNRrEpucF07irwBBg3IVewDoGfKmlXjdvcZ3k/uKHCqbB
 tXQQVPm+PO381r8GjAUTOlZ1Xeh+Ra9JjS6d16EITb+lVXkNhoiKB2Euf Q==;
IronPort-SDR: CvVpNmzsVzHrXanJ4nVxMXwofMg66iB8A7/lgS7+jKYsTWfIKNtesYoxnDfcog2kEvt24TMI/9
 C4jcMdQvhkuyiEjl++UlahKzbI6ofFQjlItmJXM4UUndA62mlcy6CAwvPRjmOJfhUh/xg1O8TP
 HJ1Cd9l/4VipUysJkpH+/xqdeFvkKpRnDHtJtImh0NLOqtDf3ZDcvCo2bEZ9haTXGy0Dby/hb1
 vh+D1IX+s34g++orjxls6aeyie0StpO2/6iQdger3JkHxqr3Ht5uXGJXuqBZ5yqqrtfGPPAaAj
 A+o=
X-IronPort-AV: E=Sophos;i="5.73,493,1583164800"; d="scan'208";a="141000632"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 07:55:17 +0800
IronPort-SDR: xGzkGorDKmtJ9/i1PRmEaOQwnd8Z/UDhZzv4J9oGrxXliBsaQUMOdyNYoit+ZyDThWIxDqdO6t
 HOaP6IRG4VceC6yXGsP2U8XDIJN2NHbyA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2020 16:44:45 -0700
IronPort-SDR: Xh64vbrEeextm2ZB5D5CrgWMTCHx0QeoYk51ULvsiGuT/pSf3C8bjHcQ0PgSeg0G3FaElH8Z3L
 +le8qfRcd+4g==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jun 2020 16:55:17 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3] nvmet: fail outstanding host posted AEN req
Date: Tue,  9 Jun 2020 16:55:14 -0700
Message-Id: <20200609235514.57266-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200609_165519_253564_5BE6D137 
X-CRM114-Status: GOOD (  16.57  )
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

In function nvmet_async_event_process() we only process AENs iff
there is an open slot on the ctrl->async_event_cmds[] && aen
event list posted by the target is not empty. This keeps host
posted AEN outstanding if target generated AEN list is empty.
We do cleanup the target generated entries from the aen list in
nvmet_ctrl_free()-> nvmet_async_events_free() but we don't
process AEN posted by the host. This leads to following problem :-

When processing admin sq at the time of nvmet_sq_destroy() holds
an extra percpu reference(atomic value = 1), so in the following code
path after switching to atomic rcu, release function (nvmet_sq_free())
is not getting called which blocks the sq->free_done in
nvmet_sq_destroy() :-

nvmet_sq_destroy()
 percpu_ref_kill_and_confirm()
 - __percpu_ref_switch_mode()
 --  __percpu_ref_switch_to_atomic()
 ---   call_rcu() -> percpu_ref_switch_to_atomic_rcu()
 ----     /* calls switch callback */
 - percpu_ref_put()
 -- percpu_ref_put_many(ref, 1)
 --- else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
 ----   ref->release(ref); <---- Not called.

This results in indefinite hang:-

  void nvmet_sq_destroy(struct nvmet_sq *sq)
...
          if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
                  nvmet_async_events_process(ctrl, status);
                  percpu_ref_put(&sq->ref);
          }
          percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
          wait_for_completion(&sq->confirm_done);
          wait_for_completion(&sq->free_done); <-- Hang here

Which breaks the further disconnect sequence. This problem seems to be
introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when
removing namespaces and controllers concurrently").

This patch processes ctrl->async_event_cmds[] in the admin sq destroy()
context irrespetive of aen_list. Also we get rid of the controller's
aen_list processing in the nvmet_sq_destroy() context and just ignore
ctrl->aen_list.

This results in nvmet_async_events_process() being called from workqueue
context so we adjust the code accordingly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
* Changes from V2:-

1. Remove the call for nvmet_async_event_process in the
   nvmet_sq_destroy() for admin queue.
2. Now that we only call nvmet_async_event_process() from the workqueue
   context where status is valid adjust the code accordingly.

* Chnages from V1:

1. Isolate host posted target controller AEN cmds cleanup into separate
   routine.
---
 drivers/nvme/target/core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6392bcd30bd7..6e2f623e472e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,7 +129,22 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
 }
 
-static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
+static void nvmet_async_events_failall(struct nvmet_ctrl *ctrl)
+{
+	u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
+	struct nvmet_req *req;
+
+	mutex_lock(&ctrl->lock);
+	while (ctrl->nr_async_event_cmds) {
+		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
+		mutex_unlock(&ctrl->lock);
+		nvmet_req_complete(req, status);
+		mutex_lock(&ctrl->lock);
+	}
+	mutex_unlock(&ctrl->lock);
+}
+
+static void nvmet_async_events_process(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
@@ -139,15 +154,14 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 		aen = list_first_entry(&ctrl->async_events,
 				       struct nvmet_async_event, entry);
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		if (status == 0)
-			nvmet_set_result(req, nvmet_async_event_result(aen));
+		nvmet_set_result(req, nvmet_async_event_result(aen));
 
 		list_del(&aen->entry);
 		kfree(aen);
 
 		mutex_unlock(&ctrl->lock);
 		trace_nvmet_async_event(ctrl, req->cqe->result.u32);
-		nvmet_req_complete(req, status);
+		nvmet_req_complete(req, 0);
 		mutex_lock(&ctrl->lock);
 	}
 	mutex_unlock(&ctrl->lock);
@@ -170,7 +184,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	struct nvmet_ctrl *ctrl =
 		container_of(work, struct nvmet_ctrl, async_event_work);
 
-	nvmet_async_events_process(ctrl, 0);
+	nvmet_async_events_process(ctrl);
 }
 
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
@@ -779,7 +793,6 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
 
 void nvmet_sq_destroy(struct nvmet_sq *sq)
 {
-	u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
 	struct nvmet_ctrl *ctrl = sq->ctrl;
 
 	/*
@@ -787,7 +800,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 * queue doesn't have outstanding requests on it.
 	 */
 	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
-		nvmet_async_events_process(ctrl, status);
+		nvmet_async_events_failall(ctrl);
 	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
