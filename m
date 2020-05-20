Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C971C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4986207D8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uHCqeZr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4986207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VZQhPlHGW/rSgiFa7NaQAs9te2xpOEzz9QVI6Li5X7c=; b=uHCqeZr0d240YN
	z2N3f+25okCWqAZxPgwHCxEePmvYASnhxXbl6XBxQG21ZmdlEtWGb/sOJ+b8vmpStjDNuYfkbbZN3
	L9JhT1ny4hJJs+wgQLxas3uj7Pq8A5UB2F+2luwF8K9Qmn8RNKctMRHi+3oaD5jJf+5ryy0vSWtOS
	EYf8OUj5hniCRsUq5cR401Kx8NaUTtt6DO6j7otdlGy/CIp80pbmUBj1k5JtEsHUTyv8rTjHpvJzk
	BSybn5HXIDaMdgckT+MrKPo+FlCBXYaiWn5SjndewsyoldcTj6AtWSC/tHhAkGsg809p1dCmT74Z3
	olpurImfPyen7hAZvD6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbUhP-0002zq-Op; Wed, 20 May 2020 19:48:19 +0000
Received: from [2601:647:4802:9070:91e2:91f6:e321:5d4d]
 (helo=localhost.localdomain)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUhO-0002zF-1I; Wed, 20 May 2020 19:48:18 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvmet: fix memory leak when removing namespaces and
 controllers concurrently
Date: Wed, 20 May 2020 12:48:12 -0700
Message-Id: <20200520194812.73876-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When removing a namespace, we add an NS_CHANGE async event, however if
the controller admin queue is removed after the event was added but not
yet processed, we won't free the aens, resulting in the below memory
leak [1].

Fix that by moving nvmet_async_event_free to the final controller
release after it is detached from subsys->ctrls ensuring no async
events are added, and modify it to simply remove all pending aens.

--
$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888c1af2c000 (size 32):
  comm "nvmetcli", pid 5164, jiffies 4295220864 (age 6829.924s)
  hex dump (first 32 bytes):
    28 01 82 3b 8b 88 ff ff 28 01 82 3b 8b 88 ff ff  (..;....(..;....
    02 00 04 65 76 65 6e 74 5f 66 69 6c 65 00 00 00  ...event_file...
  backtrace:
    [<00000000217ae580>] nvmet_add_async_event+0x57/0x290 [nvmet]
    [<0000000012aa2ea9>] nvmet_ns_changed+0x206/0x300 [nvmet]
    [<00000000bb3fd52e>] nvmet_ns_disable+0x367/0x4f0 [nvmet]
    [<00000000e91ca9ec>] nvmet_ns_free+0x15/0x180 [nvmet]
    [<00000000a15deb52>] config_item_release+0xf1/0x1c0
    [<000000007e148432>] configfs_rmdir+0x555/0x7c0
    [<00000000f4506ea6>] vfs_rmdir+0x142/0x3c0
    [<0000000000acaaf0>] do_rmdir+0x2b2/0x340
    [<0000000034d1aa52>] do_syscall_64+0xa5/0x4d0
    [<00000000211f13bc>] entry_SYSCALL_64_after_hwframe+0x6a/0xdf

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Reported-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
David, it would be great to get your Tested-by tag.

 drivers/nvme/target/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index edf54d9957b7..48f5123d875b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -158,14 +158,12 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 
 static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
 {
-	struct nvmet_req *req;
+	struct nvmet_async_event *aen, *tmp;
 
 	mutex_lock(&ctrl->lock);
-	while (ctrl->nr_async_event_cmds) {
-		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
-		mutex_lock(&ctrl->lock);
+	list_for_each_entry_safe(aen, tmp, &ctrl->async_events, entry) {
+		list_del(&aen->entry);
+		kfree(aen);
 	}
 	mutex_unlock(&ctrl->lock);
 }
@@ -791,10 +789,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	 * If this is the admin queue, complete all AERs so that our
 	 * queue doesn't have outstanding requests on it.
 	 */
-	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq) {
+	if (ctrl && ctrl->sqs && ctrl->sqs[0] == sq)
 		nvmet_async_events_process(ctrl, status);
-		nvmet_async_events_free(ctrl);
-	}
 	percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
@@ -1427,6 +1423,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
 
+	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
 	kfree(ctrl->cqs);
 	kfree(ctrl->changed_ns_list);
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
