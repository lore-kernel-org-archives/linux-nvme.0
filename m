Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C898CA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 15:24:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9B720679
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 15:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dEYaZyQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9B720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Vw7wbD6USwwpaLbwE9Y5JyRjDBZXBloosgYmWKZHmMY=; b=dEY
	aZyQqS3sykD3G0HPRoQMA5F5M9SixLia6dJgy8PAOpQZGWIx3BgYuILc9i6ku1RZGYxNmuNHrPjAJ
	I0Jib6o9oSEfO5F2FlbRJ2A0kHTnfakmKGPDete3YoD/SV6Jube8ql1a1RrTcPYtZG26/gmKNbRL+
	w0wPzPawnCl/mnhSLHuPPXlyFspsz84ciRqq1b//PslEF6VMzHx4uWes0FrIPbMuNx+PKBtvYIK/g
	9T3MY/h7aJaJQOb9+9GgLmGXMJ/fd55k+tTi95AcRVmpKndmQK3u6wm37jDRc1nvfmybYhVb/FuRW
	MGwe20XVb1K2F+LGkJhHJWzyIu7U9NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPppj-0003XU-0o; Wed, 30 Oct 2019 15:24:27 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPppf-0003WN-Pv
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 15:24:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B3A57AE87;
 Wed, 30 Oct 2019 15:24:20 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: [RFC] nvmet: Always remove processed AER elements from list
Date: Wed, 30 Oct 2019 16:24:18 +0100
Message-Id: <20191030152418.23753-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_082424_130562_22E49542 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Johannes Thumshirn <jthumshirn@suse.de>,
 linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All async events are enqueued via nvmet_add_async_event() which
updates the ctrl->async_event_cmds[] array and additionally an struct
nvmet_async_event is added to the ctrl->async_events list.

Under normal operations the nvmet_async_event_work() updates again the
ctrl->async_event_cmds and removes the corresponding struct
nvmet_async_event from the list again. Though nvmet_sq_destroy() could
be called which calles nvmet_async_events_free() which only updates
the ctrl->async_event_cmds[] array.

Add a new function nvmet_async_events_process() which processes the
async events and updates both array and the list. With this we avoid
having two places where the array and list are modified.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

I've got following oops:

PID: 79413  TASK: ffff92f03a814ec0  CPU: 19  COMMAND: "kworker/19:2"
#0 [ffffa5308b8c3c58] machine_kexec at ffffffff8e05dd02
#1 [ffffa5308b8c3ca8] __crash_kexec at ffffffff8e12102a
#2 [ffffa5308b8c3d68] crash_kexec at ffffffff8e122019
#3 [ffffa5308b8c3d80] oops_end at ffffffff8e02e091
#4 [ffffa5308b8c3da0] general_protection at ffffffff8e8015c5
    [exception RIP: nvmet_async_event_work+94]
    RIP: ffffffffc0d9a80e  RSP: ffffa5308b8c3e58  RFLAGS: 00010202
    RAX: dead000000000100  RBX: ffff92dcbc7464b0  RCX: 0000000000000002
    RDX: 0000000000040002  RSI: 38ffff92dc9814cf  RDI: ffff92f217722f20
    RBP: ffff92dcbc746418   R8: 0000000000000000   R9: 0000000000000000
    R10: 000000000000035b  R11: ffff92efb8dd2091  R12: ffff92dcbc7464a0
    R13: ffff92dbe03a5f29  R14: 0000000000000000  R15: 0ffff92f92f26864
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#5 [ffffa5308b8c3e78] process_one_work at ffffffff8e0a3b0c
#6 [ffffa5308b8c3eb8] worker_thread at ffffffff8e0a41e7
#7 [ffffa5308b8c3f10] kthread at ffffffff8e0a93af
#8 [ffffa5308b8c3f50] ret_from_fork at ffffffff8e800235

this maps to nvmet_async_event_results. So it looks like this function
access a stale aen pointer:

static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
{
        return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
}

The test which is executed removes during operation one of the nodes.

The only odd thing I could figure out so far is that the list is not
updated in sync with the array in all cases. I suppose this could be
the source of the crash. Not verified yet.

Johannes though it makes sense to post this as question.

Thanks,
Daniel

 drivers/nvme/target/core.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a67e244e568..9d9efd585847 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,27 +129,8 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
 }
 
-static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
+static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 {
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
-{
-	struct nvmet_ctrl *ctrl =
-		container_of(work, struct nvmet_ctrl, async_event_work);
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
@@ -163,16 +144,30 @@ static void nvmet_async_event_work(struct work_struct *work)
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
+	nvmet_async_events_process(ctrl, NVME_SC_INTERNAL | NVME_SC_DNR);
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
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
