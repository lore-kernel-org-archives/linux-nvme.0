Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A082C5CFCF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2026 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o1OJ/CkKReq4rbtHVjPHc5wLkujFnR3xVDAior4D7+0=; b=M5rwhOZSNp26LRrTTXRfNE21FU
	A1MTrjBe2eyIxb15B6cTvr9L8+c9AZAD6EieAERj+rhb3rxgD2GPcsITqK0Hd4bXhFt3oZNtWVYi4
	TYWstODndhM81SuedZlWnnMvHLP2uSLomQBj1EWEMKAu6SJ4NFiQUTjSr+TIwX0NXDCfQgeCE0xxH
	gt72x3/5BPcvYJlxcf4CLifmCfLGT0ddM/V7JBoy2+lLz//EjheeiEdRlA0K4+xPZS9NUQadfxzD8
	ih4qwe6tds6yXaXBV57g5E8/sVdR2bQlMJ5dQA/shETzmK8O2Vi2j2CdbZ4qGq2FujXjygy5te0r2
	9pU4S0Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wut3U-00000002o4D-2t6c;
	Fri, 14 Aug 2026 14:38:44 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wut3T-00000002o44-0AxL
	for linux-nvme@lists.infradead.org;
	Fri, 14 Aug 2026 14:38:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A4E360120;
	Fri, 14 Aug 2026 14:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEDD1F000E9;
	Fri, 14 Aug 2026 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718322;
	bh=o1OJ/CkKReq4rbtHVjPHc5wLkujFnR3xVDAior4D7+0=;
	h=From:To:Cc:Subject:Date;
	b=kT9Q3nvZCVd5sR/E6mayCabc8Z3lxG1MmRPnB/otJH8FRyiQKr9sjl1mfYoK2KA/u
	 hWrOFmDo3UqaMl+k89hRC21RD/7AMt9TwwCtKjwDvHszMdP67GMU3Pn9mSaCUmWJAO
	 tdLg1k8Ukk6bqS1kera5rLPwNlzufGJKDXy/vmTQ8XVrAmtFSL8cwBwRVzIe+p/9ED
	 slDgrbIUC4BoKEPWcZWZIDHohQYIIogPCa/g5cj6CgBvJxZyv/RyIGbMabuej2tiiF
	 puLku6ZZh0kVeucX9BMXhc/SEq86gz5SaeNDJ/Zn+f/kGn2cp9wUp4fJTw3KP0fYLP
	 GH72xXldAgjCQ==
From: Niklas Cassel <cassel@kernel.org>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Fri, 14 Aug 2026 16:38:34 +0200
Message-ID: <20260814143833.1953415-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6059; i=cassel@kernel.org; h=from:subject; bh=3C3wfzjhBHsyvklz5qL5DnhR900kXN8729uVFerCtMw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLqNTIP/FrNvpXpsllf4OQvi8MPWJ2ZEKFf99BTYWu21 Izkpn0HO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRA6cYGT4f4J/sm+kxS7BB UiZgWorid8Ud8ydY26vtK14dJPKmR4/hf9Gmx705z3N5Xy+22LTsgrfL8b9HD375IvmN70rO9fO v97EAAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
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

nvmf_create_ctrl() owns the fabrics options and frees them whenever
->create_ctrl() returns an error, so a transport must not free them on
its own error paths.  nvme-fc tracks this by testing ctrl->ctrl.opts in
nvme_fc_ctrl_free(), which requires nvme_fc_init_ctrl() to clear that
pointer on every error exit.

The coupling is implicit, and commit 1a9e218195a5 ("nvme: split device
add from initialization") broke it by adding a second error exit.  When
nvme_add_ctrl() fails, nvme_fc_init_ctrl() jumps to out_put_ctrl:, past
the "ctrl->ctrl.opts = NULL" that only sits on the fail_ctrl: path, so
nvme_fc_ctrl_free() frees the options and nvmf_create_ctrl() frees them
a second time:

  BUG: KASAN: slab-use-after-free in nvmf_free_options+0x30/0x190
   nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
   nvmf_create_ctrl drivers/nvme/host/fabrics.c:1374 [inline]
  Freed by task 5534:
   nvme_fc_ctrl_free drivers/nvme/host/fc.c:2374 [inline]
   nvme_fc_init_ctrl+0xe17/0x1450 drivers/nvme/host/fc.c:3605

nvme_add_ctrl() fails when dev_set_name() cannot allocate, so this is
reachable under memory pressure or fault injection.  Without KASAN the
options are freed twice.

Rather than clear the pointer on the second exit as well, derive
ownership the way nvme-tcp, nvme-rdma and nvme-loop do, from list
membership: their free_ctrl leaves the options alone unless the
controller made it onto the transport list.

The list cannot simply be populated on the success path as it is there.
nvme-fc runs the initial connect synchronously via flush_delayed_work(),
and the controller has to be reachable on rport->ctrl_list for the whole
of it: nvme_fc_unregister_remoteport() needs to find it to signal
connectivity loss, nvme_fc_match_disconn_ls() matches an incoming
Disconnect Association LS against ctrl->association_id, which is only
assigned during that window, nvme_fc_resume_controller() needs it on
remoteport re-registration, and nvme_fc_existing_controller() uses it to
reject a duplicate connect racing the one in flight.

Keep the insertion where it is and add a fail_unlist: label, falling
into fail_ctrl:, for the error paths that run after it.  The earlier
error paths never reach the insertion and keep using fail_ctrl:
directly, so the list is only touched where the controller is actually
on it.

nvme_fc_ctrl_free() cannot use the plain "goto free_ctrl" the other
transports use, because it still has to put_device(), release the rport
reference and free the ida entry for resources taken before the
insertion.  Sample list_empty() under rport->lock instead.

ctrl->ctrl.opts also stays valid for the whole teardown now.  That is
not the bug being fixed, but it removes some fragility around the old
idiom: nvme_free_ctrl() calls nvme_auth_free() before ->free_ctrl(), and
ctrl_max_dhchaps() dereferences ctrl->opts without a NULL check when
ctrl->dhchap_ctxs is set, which nvme-fc permits since NVMF_ALLOWED_OPTS
allows the dhchap options.  The nvme sysfs attributes that dereference
ctrl->opts, such as hostnqn and address, evaluate their is_visible()
test once at device_add() time and stay readable until
cdev_device_del().

Fixes: 1a9e218195a5 ("nvme: split device add from initialization")
Cc: stable@vger.kernel.org
Reported-by: syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f58e57380a6083c4041d
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/host/fc.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 04363b9c4489..7e1794f054d6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2358,9 +2358,15 @@ nvme_fc_ctrl_free(struct kref *ref)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(ref, struct nvme_fc_ctrl, ref);
 	unsigned long flags;
+	bool owns_opts;
 
-	/* remove from rport list */
+	/*
+	 * Presence on the rport list means nvme_fc_init_ctrl() completed,
+	 * and with it ownership of the fabrics options passed to it. If it
+	 * failed instead, the options still belong to nvmf_create_ctrl().
+	 */
 	spin_lock_irqsave(&ctrl->rport->lock, flags);
+	owns_opts = !list_empty(&ctrl->ctrl_list);
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
@@ -2370,7 +2376,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	nvme_fc_rport_put(ctrl->rport);
 
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	if (ctrl->ctrl.opts)
+	if (owns_opts)
 		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
 }
@@ -3569,14 +3575,14 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
-		goto fail_ctrl;
+		goto fail_unlist;
 	}
 
 	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to schedule initial connect\n",
 			ctrl->cnum);
-		goto fail_ctrl;
+		goto fail_unlist;
 	}
 
 	flush_delayed_work(&ctrl->connect_work);
@@ -3587,14 +3593,22 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	return &ctrl->ctrl;
 
+fail_unlist:
+	/*
+	 * Leaving the list hands the options back to nvmf_create_ctrl();
+	 * see nvme_fc_ctrl_free().  Re-init so that list_empty() there
+	 * reports the controller as unlisted.
+	 */
+	spin_lock_irqsave(&rport->lock, flags);
+	list_del_init(&ctrl->ctrl_list);
+	spin_unlock_irqrestore(&rport->lock, flags);
+
 fail_ctrl:
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-	ctrl->ctrl.opts = NULL;
-
 	if (ctrl->ctrl.admin_tagset)
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	/* initiate nvme ctrl ref counting teardown */
-- 
2.55.0


