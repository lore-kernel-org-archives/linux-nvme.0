Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C2C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DCD208A7
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MY67OKk0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="efOhbxNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DCD208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LF2yXkX0ZcH6zeUMB6ibCKLRS2wOJPCF3nh9lg1LSns=; b=MY67OKk0eew2Fk
	pYubrxXy4l24bMEezxNJVXZQigsk/jnok1xsI52kc3f6hv/ScoDdv0IKBRKyRJ50ikVhnp6ovsFG6
	3g1o1qgOgqxyw1cHJtU4UvOGIE/bRjGzN066Fde2HDkYe0zqlKPTF9dZENe5Pf5pqnCH6PRnE5eGq
	Bk8Jxw93o57IM9vBakJx0AZ+WDD+RsunkJmMXUDEbyJT+GKmb/c6bCo8QmX7XAjdh46d/0ysjZLrZ
	f++2mgennPAW0F3jQ5S0joG7M1jqtfyGANFevpHd2+wopKjbptUSVpVifYAqq8QHw36/qgGSZn8gv
	KmIsdrTugIpV6W+MlZ/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiR5A-0001H6-ID; Mon, 08 Jun 2020 23:21:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiQvJ-0004ic-D9
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 23:11:27 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEAD920890;
 Mon,  8 Jun 2020 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657880;
 bh=rkbbiQCs8BHaHAQU5zfRpAxLE0KUC9UftSsS8I2Mpe0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=efOhbxNz2KTF7Q2wV3/g9wSdumlDXPJOtY81+KL+jko7+nhjymMvUNzkFKM0tUIFU
 op1y1bgDJkIwEwZ2331oChz3VhGYSS50IUYVZTkPy1JG04DfPQ1G/lqBQ5b6PTlSob
 Mv+3CYnKLMWtvSBvigQjwSZOjIUbMibXmx8IBdPE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 237/274] nvmet: fix memory leak when removing
 namespaces and controllers concurrently
Date: Mon,  8 Jun 2020 19:05:30 -0400
Message-Id: <20200608230607.3361041-237-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_161121_574255_AE9DD2E8 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Sasha Levin <sashal@kernel.org>, David Milburn <dmilburn@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 64f5e9cdd711b030b05062c17b2ecfbce890cf4c ]

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
Tested-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b685f99d56a1..aa5ca222c6f5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -157,14 +157,12 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 
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
@@ -764,10 +762,8 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
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
@@ -1357,6 +1353,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
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
