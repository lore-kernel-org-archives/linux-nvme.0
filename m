Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D0CC88E65
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Sep 2026 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1T1xM7WvsaSnz4vjGfPeE2GotheQaGRQND+mjnN9Juw=; b=xHj8eTZPYPNJ64aAfnIaZ69YRP
	FFsqLtVzYAr/klPaZBCbtBFCVMvMYjkp+sXyrtdlt1SPKl6XXsh1Ro0Z6m9gHXF5pSPDc9nnCSvd9
	RdFCckixOi2XuKcF0QHjY9EgSri6qub0P5p+xeFa1uf9g+WHgMR6auY1WSJ9gzPX0cuizDzS8AZtT
	JdDoY0FtxR/CUwANLWVpXYWcRBK4dzKXWMM/wc8OBJwaLymxSWeY3+BfFgLSm4wOn5ioivfN49cur
	ZYXqQBY6bm92Sx3glD7zdApO8KyNsEV1AUc/aiVf9jyBgdR/yiX2Z/z/3q1Pjd51et0Hlu1Fh/don
	hT5U8GMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5jWH-00000001fZz-0Dix;
	Sun, 13 Sep 2026 12:41:17 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5jW9-00000001fZV-3Lnz
	for linux-nvme@lists.infradead.org;
	Sun, 13 Sep 2026 12:41:11 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2D89D240028
	for <linux-nvme@lists.infradead.org>; Sun, 13 Sep 2026 14:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1789303262;
	bh=1T1xM7WvsaSnz4vjGfPeE2GotheQaGRQND+mjnN9Juw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=mgWMC8jWqV1KQJBg3F+NNXzy66cZ5aXATPlecKHCMLbZ051CkVZaP3CQ3icr7NnXd
	 f4snslPG9QIMMw41nhPoKrWQchHlp3l+rNeDS/zd4pvvx1zpA5AjB7h0vWVDdwivJo
	 1yotGpb/aEeV/maPNek+JPUXMYV+VaQa+bKpFd4iKoF5wjnrMS6zABbMcqxhc5Bb1g
	 /7MbH6U6sbNviAVpd+GoJ9PBHG/RYyE/FpZg4HFHuxKPJPsu/o2giIvsRokeOHprh5
	 L3GdYsk8OQA1cDuiLt5woxRs2pSbLryjy/j68beA2I4NOsu7sHj3qmLw8N/oA7fBCC
	 vrj1tCW/dbaRQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hjSZ44614z6tw8;
	Sun, 13 Sep 2026 14:41:00 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mateusz Nowicki <mateusz.nowicki@posteo.net>
Subject: [PATCH] nvme: bump genctr when cancelling a request
Date: Sun, 13 Sep 2026 12:41:01 +0000
Message-ID: <20260913124053.86565-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260913_054110_160928_AEBCCC83 
X-CRM114-Status: UNSURE (   8.75  )
X-CRM114-Notice: Please train this message.
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

nvme_find_rq() rejects a completion whose genctr does not match the
request, so a command completed once cannot be completed again by a
stale CQE. nvme_try_complete_req() bumps genctr for that reason.
nvme_cancel_request() completes the command too, but leaves genctr
alone. A CQE the controller posts for the cancelled command later still
matches and gets applied.

The cancel path is taken when the host stopped waiting for the
controller: CSTS.CFS set (dead path in nvme_dev_disable(), no CC.EN=0,
no wait), or CSTS.RDY not cleared within CAP.TO. Nothing stops the
controller from posting completions after that, and the second
nvme_dev_disable() from nvme_reset_work() reaps them in
nvme_reap_pending_cqes().

The cancelled request sits on the requeue list after the RETRY
disposition. The late CQE ends and frees it from there, and the next
dispatch hits req->mq_hctx == NULL:

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  RIP: nvme_prep_rq+0x1a6
  nvme_queue_rq
  blk_mq_dispatch_rq_list
  __blk_mq_sched_dispatch_requests
  blk_mq_run_work_fn

Bump genctr in nvme_cancel_request() like a real completion does.

Reproduced with vnvme (https://github.com/Mateusz-Nowicki-Embedded/vnvme),
a virtual NVMe endpoint that holds completions back under I/O, sets
CSTS.CFS, and releases them after the tagset was cancelled.

Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -532,6 +532,8 @@ bool nvme_cancel_request(struct request *req, void *data)
 	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
 		return true;
 
+	if (!(nvme_req(req)->ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+		nvme_req(req)->genctr++;
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 	blk_mq_complete_request(req);

