Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89458606B6DA
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xP8/4MSs;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=dk1llskK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BYo0W6AgTAD4HePkGTCtZZdNoeTJeu4/QhvV0yiNWAE=; b=xP8/4MSsPMLfQM
	/F1LfwM2djG6eRP4yyJ+N4Okc4KZ5sVb1uPQuD7LeWrD1LSbss5q/VOxG/RiXAti2glgJrEtlaUhf
	xutPcqxxJiQar2oaaEVTCQJ12cnSSo8L/nrr0nUJwdlbix3DyA8IDZrlG2aiRn9YV+YB7Ls/WFMvh
	fKFgqiqcg6qQeCwItxXgry+3faWfHU0hr022oD6t1rrKVlDsgxkYYCr3dvD2q6IsBOr3jg/rJdgQE
	p0MVTZ1xVZUUyJdGFME7zMpt/kaG3eyOUuhJ0zXjMnjAJvtIdRdhN6t/LvGCw382/BFI8ydoZppIK
	I9+12X9MoojVXmigoqUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45z-0000000FAbr-445r;
	Sat, 14 Nov 2026 03:06:27 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45e-0000000FA3E-0Dkt
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:16 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1861457c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625565; x=1795230365; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYo0W6AgTAD4HePkGTCtZZdNoeTJeu4/QhvV0yiNWAE=;
        b=dk1llskKr0H7ijkqV0fcOnLt+Q8rMum7F5F3DkbnnJfCkz0jlH3nWvN6yjJQzzg7J7
         m2tb+OVrwywzVUne7xOzYe7swiGYn6lWRbwePpwUzfr3tyDeLCpdaIoPmpKugCfpgRn5
         UVXZb2vVWORQX+rWVIluj8pQuQB1AUAQfVXnbUuJmcqSVpScwxSU+hKkPzvBPcCxMhkX
         +cawnmE22TWpZmcqXPFbkdE+CK2vwxpWiSdc5yVaK6KySLIkUsK+RVn65p1pJgSrOKC6
         tvPXkrZcoJG6FbGcNwX4lxDzM1yOSv65womKVlB+ZQuQb/XudkCyJ5L/1oetmsYDlk6r
         lVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625565; x=1795230365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYo0W6AgTAD4HePkGTCtZZdNoeTJeu4/QhvV0yiNWAE=;
        b=HL/VFVe6CIgZprvkhQFZxsD5XCH7LyGcwrhi9bqwylr0Rb03MT9ZS087hcuP3V6Y/m
         WXQ1Dqp5N7M+1UFWlhGCdQl68itNIX+/bLyPoSmC2igAu+9ntM1+DYpP8sNnKSlGGqYq
         mPWJ1S9f5B+MJPQOn7wfwpDPAQO1cI4ERnjoMGCKiAy8JrTEk5dI/SLJiEn/JYQdJbeX
         JzR85qZ3VRc5L626tKYwoBj59/6zDMHWGJBf5aONVmU4FKL3aUO942cKoxbxDeGZQAdx
         6pZ+11QqU++0JeVSKlPflxJ8NcMsWp+aHYMENic9x6lVg17aZFKl4uStiOhQB8A6a3zy
         VIKw==
X-Forwarded-Encrypted: i=1; AL+hErFArBTIu38FGZ7VCEI1ZoSfxGAqtbLg+vISGOaG/ezrlNKe/IazaQtJOm1r++gloQRslHAbcLu5mstN@lists.infradead.org
X-Gm-Message-State: APuU4Z/hhIqHZmg3+1tVDPu4LxU3fU/D6UpRssRWWoC9MDVjdoxFCV2F
	BrTlMaEPi6VhzrLjWLe+XkcoDpvwdfdjXPhuKNwh4K5Pv5onVufiNspNdXK/Tfm/bgk=
X-Gm-Gg: AYBFou1St/oWz1ilAZhiscF1PWsZf0BLgYrsFqU3pUDoCNFng3Zv3z76i/FeuoSR1RL
	JEF64ZiKTrSHgeh+6Ea+xB/Zt5+uoJcBrp0ke2E8tSk+uXDNrJIoGxXgfUF2Pk+cqD//gdCCSDF
	CGsfEszueY8WmOYccuKOvm+KtWF7Mou/pmNf2MuTIjKkAYOi1oMD8rkecR6U1muAG6g8PLT5daD
	vqnICDydbqCb4dfSvjVPooioBivUstNy4Ab5AglXyRARDcKCojCSEJNwhVk7CAUWoNu1Luddc+n
	EkJEycvTJLW+cZ2HNYxLGyXrQHLYboVjCK31ud3YbIFsOTwwyDMVs0LOndYxrDAm3S8MvgwDZIS
	MNRg6DXbGIfgU+O9l4j5IKixKx1xVo/DXHy5ynMoZy3keqUqRo+F7ZWl3LzOHkIi43eOUkhQZsP
	d68Q2fhFJNZNkJhldHUNh3hVNd+T4Y21BPJ8hkicR0j18bF/FjxNs2vQMmInE5lQtlO+gxh5y8g
	E/h9uPUJEslE4+dw28W8rjkXWznC4X/Sr+u5i80i+89bCagJwSyx7vgO4TjS26wVuXlgh0K8qdv
	8x+5tpyqg4VDNo5vd0vFA7GZI90WjEBNt80PLfX75htwm9x1shkL3nIFMUggg35BAiYqSebN4A=
	=
X-Received: by 2002:a05:701b:2810:b0:1a3:65d7:efae with SMTP id a92af1059eb24-1b5030f2c84mr3776124c88.21.1794625564996;
        Fri, 13 Nov 2026 19:06:04 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:06:04 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 14/17] nvme-fc: Use CCR to recover controller that hits an error
Date: Fri, 13 Nov 2026 19:04:28 -0800
Message-ID: <20261114030454.2836543-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190607_771670_A6BBAEF0 
X-CRM114-Status: GOOD (  21.67  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A LIVE controller that hits an error now moves to FENCING instead of
RESETTING. ctrl->fencing_work attempts CCR to terminate inflight IOs.
Regardless of the success or failure of the CCR operation, the
controller then moves to RESETTING to continue error recovery.

nvme_fc_fencing_work() tears down the association before fencing so
the LLDD can finish unregistering the remoteport/localport. With this
patch alone that still completes the inflight requests at the start of
the fence, which matches the behavior before this series. The next
patch holds them until fencing has finished.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 69 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0ba621649afe..095adc9011cc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
+	struct work_struct	fencing_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1877,6 +1878,33 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static void nvme_fc_fencing_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl =
+			container_of(work, struct nvme_fc_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+	unsigned long rem;
+
+	/*
+	 * Tear down the association before fencing starts. Fencing can take
+	 * a long time and the LLDD can't finish unregistering the
+	 * remoteport/localport until all associations on it are gone.
+	 * Inflight requests are held and only completed once fencing has
+	 * finished.
+	 */
+	nvme_stop_keep_alive(ctrl);
+	cancel_work_sync(&ctrl->async_event_work);
+	nvme_fc_delete_association(fc_ctrl);
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1921,11 +1949,20 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
 /*
- * Start recovery only if this caller can claim it with a state change.
+ * Start recovery only if this caller can claim it with a state change:
+ * FENCING from LIVE, or RESETTING otherwise.
  */
 static void
 nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: starting controller fencing %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
 		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
 			 ctrl->cnum, errmsg);
@@ -2439,6 +2476,12 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
 	return kref_get_unless_zero(&ctrl->ref);
 }
 
+static void
+nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
+{
+	flush_work(&to_fc_ctrl(nctrl)->fencing_work);
+}
+
 /*
  * All accesses from nvme core layer done - can now free the
  * controller. Called after last nvme_put_ctrl() call
@@ -2554,6 +2597,7 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 	u16 qnum = op->queue->qnum;
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
+	enum nvme_ctrl_state state;
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
@@ -2562,15 +2606,16 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 		nvme_fabrics_opcode_str(qnum, sqe),
 		sqe->common.cdw10, sqe->common.cdw11);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
-		 * The association is being set up, being torn down or is
-		 * already gone, so recovery cannot be started from here.
-		 * Abort the command so the connect or teardown it would
-		 * block can make progress. It completes through
-		 * nvme_fc_fcpio_done() once the LLDD has finished the
-		 * abort, and the abort is counted so a teardown that
-		 * follows waits for it.
+		 * The fence is over or the association is being set up,
+		 * being torn down or is already gone, so recovery cannot
+		 * be started from here. Abort the command so the connect
+		 * or teardown it would block can make progress. It
+		 * completes through nvme_fc_fcpio_done() once the LLDD has
+		 * finished the abort, and the abort is counted so a
+		 * teardown that follows waits for it.
 		 */
 		__nvme_fc_abort_op(ctrl, op);
 		return BLK_EH_DONE;
@@ -2578,7 +2623,9 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 
 	/*
 	 * A LIVE controller starts error recovery, which tears the
-	 * association down and completes this request.
+	 * association down and completes this request. While FENCING the
+	 * request must not be completed before the fence is over, so only
+	 * rearm the timer; the fence completes it.
 	 */
 	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
 	return BLK_EH_RESET_TIMER;
@@ -3397,6 +3444,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
+	.stop_ctrl		= nvme_fc_stop_ctrl,
 	.get_virt_boundary	= nvmf_get_virt_boundary,
 };
 
@@ -3516,6 +3564,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.56.0


