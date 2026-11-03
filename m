Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10540606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xLTR0ueE;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=OjuAlt1y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iHU0/54xdec8W74xwY6SvsKG+KurNlwiejIZ7W19vFs=; b=xLTR0ueESnjFD4cvXGRBLU8fbe
	bN87tVhF0l5nGSDM7QP/NNdwMsx2/jSc3t0/XfEr7cZu48/25CN+njjrB5GYlBHLCYNhlG9ETBsxB
	8WhmwXtBwxyJKtY04PKOD6Kkq0QNSEisZS1+FsFdCzmfY7k8xH2kFL+oRS4LL4fPR3u8dZzv7sH61
	E+wb2mL5Gc6+dxVe1h0CmqkbdrEOC/ILYukJLz+GGj0qQP56bSw2EIZay5ytKZ/UK9FbW3Yn9jT5z
	xYa+8er5TRNarrxQdzVNPPuUMA4c5rVkW8OJqPWGDZw4DpK/wy74sOxe9AywncD/eLpaUqot/+DRH
	1bYMw+vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3B3-00000000nJi-3vfH;
	Tue, 03 Nov 2026 01:19:05 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO3Au-00000000nIy-3Ays
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 01:19:00 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36a18fc7a38so6772334eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 17:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793668734; x=1794273534; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iHU0/54xdec8W74xwY6SvsKG+KurNlwiejIZ7W19vFs=;
        b=OjuAlt1yoBYvbgazGvpW5gBxgy/lo36LPOZfSt06r7sJcmf9atox+VbRWHUW05DL7J
         Tk3Y+H2gL9BQLiLDoU2hmKpupN1/tteZeN6n3AyaQy4lQluZypdetWkba8KEfzcBnZ8v
         JVAOFbbr9b+HaX5yRznuePcs0WOvdlJ+j+UTyalQxg0bsedCz2Y6BI0XY1toKIjPOS6Y
         VzgdBjP7j4+/XEtq8jNxct+DFxmyNMxPUgsrqNrzMJsPUabvxeLKqs6OiAUEMmGAUf+J
         IQvH2usafvDqDF2fM0Xvt5NUl3clMHlg9PtsfTtYXdnduSF8R0iMZK64s2Z9DaEiSF/N
         ZinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668734; x=1794273534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHU0/54xdec8W74xwY6SvsKG+KurNlwiejIZ7W19vFs=;
        b=ADjEvNQ2f3VnrFkfFvksvzEMFK7WJDnrtUktUbgZo7PzHDsVqN1G7aw6pqv0cjwb6+
         dEmMFMhvDclwkYGPdEw9wru5rWArY8wM4TGH4puDE58oC0gcGo7CO6qnPgTF3YjD2htv
         CuOCn1MFhWz2Pldpe0qxlNlUHOu0AiE42CZO3JziIxjyuc2/VsvWHzWmuogJENyLyBPH
         g6oMEpMYmoU2+nkKjauvRWfYleKYzffbHcM1wRYkIzt85wDa7Trn46+VODn1kJbhajaI
         XCNNvlDQtzUnnmDvgWwD56SPOnllR38Ynoq/2YwLYegfCR/YMMhdfINCpdjCS8o1m5JO
         12TQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/4d4g+uKf1RGpr6T/bCN+IOUUaI0jEVpMsrion1ENEK1osRxzNoWOc6qwMoJreU4b9pzhdJ1g8KSs@lists.infradead.org
X-Gm-Message-State: APuU4Z8h9EIMqggEJccJgohjo0DDkCwmWzxugzu7S5T6sh6PoZ+CVcAZ
	O3Rr2fvRxbw34FzfwLXRbrzQZIGuFJR63Yya8EjIOsyBD6tUTgwAGQc4ZGLDm0FmJ00=
X-Gm-Gg: AYBFou1z/IFsMxHodVDtREKYplTfiTGu1wmZLSkkUHcfGLF8NpH9Hiv2gBTFIcuRACt
	iAS3sloMIKkMRhbei3ei9pcmP3KLVWrBHA3UlzofLAtVk3eIwRfXlSWK6aWEoBUzNDZdnVt5h/E
	jlQGbJZDvnBPa9weWExy5SIbhk8gY8sYcecqknTvMQfuJ7746A9hh57x43UHUrG9MrhrEHWtb+1
	QSqsOfGnMrtkDAUhjMsjJxDkJU8mnw16j0d+plIhQfRp+biHWAs32cQwkovUpg91L7utiDivolT
	5XXznVfhEY3zNgczXVSUKw+NDHXjRU+gAu/y6LqNkT6BoaP8C2eNZZSbBeYTdDwQdKWNpfXXEI2
	fepfXIkhuDjIBkEn02ZsEf7pZJ/wwMTu2/GoRaXNwlIU+8qxx2agTkYhKsRcFMi4z6pd/q7Y2bS
	PN0n17Z3QF+e94OB6CnuuF0+fwt0eYdgT6X4Kgi2INb2XjldBmL+Te6UrhJ0+55uB8/T5oQganM
	aw3wFRyH2RnL+ACDjnb4rx52IVGUIxC3UdtWiF/x+fICHxb2hdmWAfN14FukR4euUXqWgQ8YFS9
	RyE9VZuU2IaVMxCiMaMgVHFsqzHUcfnmGNlRo1na2waUTL5Z
X-Received: by 2002:a05:693c:638e:20b0:369:f18f:34ab with SMTP id 5a478bee46e88-36a4235f6bamr18069443eec.11.1793668733484;
        Mon, 02 Nov 2026 17:18:53 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-36b13bd87b2sm1348645eec.28.2026.11.02.17.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:18:53 -0800 (PST)
Date: Mon, 2 Nov 2026 17:18:51 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in
 FENCING state
Message-ID: <20261103011851.GK122209-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
 <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
 <20261021212357.GZ2931-mkhalfella@purestorage.com>
 <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_171856_805146_96A566E6 
X-CRM114-Status: GOOD (  30.62  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri 2026-10-30 11:29:12 +0100, Daniel Wagner wrote:
> On Wed, Oct 21, 2026 at 02:23:57PM -0700, Mohamed Khalfella wrote:
> > Adding new FCPOP_STATE_HELD will result in a more invasive change and it
> > will result in nvme-fc no using nvme_cancel_tagset(). My intent with
> > this change is to bring nvme-fc closer to other transport and only
> > cancel inflight requests. synchronize_rcu() is a simpler in this case.
> 
> I am totally against introducing yet another synchronization method. Fix
> it properly.

Here is a diff that applies on top of the patches in order to remove
synchronize_rcu() and add FCPOP_STATE_HELD as you suggested. I will try
to run more testing on this change to see if it holds up. While I do
that please take a look and let me know what do you think.

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2bb6cdfbb718..6c260f6b47b2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -83,6 +83,7 @@ enum nvme_fcpop_state {
 	FCPOP_STATE_ACTIVE	= 2,
 	FCPOP_STATE_ABORTED	= 3,
 	FCPOP_STATE_COMPLETE	= 4,
+	FCPOP_STATE_HELD	= 5,
 };
 
 struct nvme_fc_fcp_op {
@@ -2086,9 +2087,6 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	 * association to be terminated.
 	 */
 
-	/* Pairs with synchronize_rcu() in __nvme_fc_teardown_association() */
-	rcu_read_lock();
-
 	opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
 
 	fc_dma_sync_single_for_cpu(ctrl->lport->dev, op->fcp_req.rspdma,
@@ -2201,12 +2199,18 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 
 	/*
 	 * If we are going to terminate associations and the controller is
-	 * LIVE or FENCING, then do not complete this request now. Let error
-	 * recovery cancel this request when it is safe to do so.
+	 * LIVE or FENCING, then do not complete this request now. Move the
+	 * op to HELD and let nvme_fc_cancel_held_requests() cancel it when
+	 * it is safe to do so. HELD is only reachable from COMPLETE through
+	 * this cmpxchg: if the cancellation has already walked the tagset it
+	 * moved the op out of COMPLETE, the cmpxchg fails and the request is
+	 * completed here instead. Either way exactly one path completes it.
 	 */
 	state = nvme_ctrl_state(&ctrl->ctrl);
 	if (terminate_assoc &&
-	    (state == NVME_CTRL_LIVE || state == NVME_CTRL_FENCING))
+	    (state == NVME_CTRL_LIVE || state == NVME_CTRL_FENCING) &&
+	    atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
+			   FCPOP_STATE_HELD) == FCPOP_STATE_COMPLETE)
 		goto check_op_term;
 
 	if (!nvme_try_complete_req(rq, status, result))
@@ -2218,8 +2222,6 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 check_error:
 	if (terminate_assoc)
 		nvme_fc_start_ioerr_recovery(ctrl, "io error");
-
-	rcu_read_unlock();
 }
 
 static int
@@ -3364,13 +3366,6 @@ __nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl)
 	clear_bit(FCCTRL_TERMIO, &ctrl->flags);
 	spin_unlock_irq(&ctrl->lock);
 
-	/*
-	 * Wait for a started nvme_fc_fcpio_done() to complete before we
-	 * proceed with cancelling inflight requests. This guarantees a
-	 * request is completed by one of the two codepaths, not both.
-	 */
-	synchronize_rcu();
-
 	nvme_fc_term_aen_ops(ctrl);
 
 	/*
@@ -3405,18 +3400,51 @@ __nvme_fc_teardown_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_ctlr_inactive_on_rport(ctrl);
 }
 
-/* Complete the requests held in __nvme_fc_teardown_association() */
+static bool
+nvme_fc_cancel_held_request(struct request *req, void *data)
+{
+	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
+	struct nvme_ctrl *ctrl = data;
+
+	/*
+	 * A single cmpxchg decides who completes this request. If the op is
+	 * HELD, nvme_fc_fcpio_done() is done with it and we cancel it. If it
+	 * is still COMPLETE, nvme_fc_fcpio_done() has not decided yet: move
+	 * it to IDLE so its own cmpxchg to HELD fails and it completes the
+	 * request itself (nvme_fc_complete_rq() sets IDLE anyway). Doing this
+	 * as read-then-cmpxchg would let the op become HELD in between and
+	 * leave it with no one to complete it.
+	 */
+	if (atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
+			   FCPOP_STATE_IDLE) == FCPOP_STATE_HELD)
+		nvme_cancel_request(req, ctrl);
+
+	return true;
+}
+
 static void
-nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl)
+nvme_fc_cancel_held_requests(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
 {
-	nvme_cancel_tagset(&ctrl->ctrl);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
+	if (set) {
+		blk_mq_tagset_busy_iter(set, nvme_fc_cancel_held_request, ctrl);
+		blk_mq_tagset_wait_completed_request(set);
+	}
+}
+
+/* Complete the requests nvme_fc_fcpio_done() held during the fence */
+static void
+nvme_fc_flush_held_requests(struct nvme_fc_ctrl *fc_ctrl)
+{
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+
+	nvme_fc_cancel_held_requests(ctrl, ctrl->tagset);
+	nvme_fc_cancel_held_requests(ctrl, ctrl->admin_tagset);
 
 	/* re-enable the admin_q so anything new can fast fail */
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(ctrl);
 
 	/* resume the io queues so that things will fast fail */
-	nvme_unquiesce_io_queues(&ctrl->ctrl);
+	nvme_unquiesce_io_queues(ctrl);
 }
 
 /*


