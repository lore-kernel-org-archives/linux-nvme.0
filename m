Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1D606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b08Li9p3;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iT3jOwJu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8BGMaVX2ojEnc2pfao27skA7lke7MCwTW0eBU+Cg4VE=; b=b08Li9p3WOme4PdGdKkJezpZ5J
	E0KRoftPn3NndeOxOwaye4atV6t1uAfe8jAjzGzpew+mhnhZCMB0tBFjncEtabzQlaqcCR/S10Uyr
	Qb+t/35hpIVbIJLVhI3gOFNB+d4exr3mFKShIQ+G5+arFxRFnNJAeeKSmZVaFGzOdDzI2PuPa8nkz
	feRgM0gHuUPKcqmUYjy9raR+DhcCNGZdX6aBy8BXLSWOxzcQjcjAa2N2Rau3vZ0AZELg6b3hIna5X
	zpFwKQVtgam+vCGzXzsKpppaE2ltlQb8OmEYD5/YruSBlhYDsSBQ4JFzkdLYXW5RxUPnGdEkhI+bR
	FuZ2jcRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVcu6-000000057Ns-2xl5;
	Mon, 23 Nov 2026 22:52:54 +0000
Received: from mail-ot1-x346.google.com ([2607:f8b0:4864:20::346])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVcu3-000000057MO-2oRh
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 22:52:52 +0000
Received: by mail-ot1-x346.google.com with SMTP id 46e09a7af769-860e65f42a5so4105868a34.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795474369; x=1796079169; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BGMaVX2ojEnc2pfao27skA7lke7MCwTW0eBU+Cg4VE=;
        b=iT3jOwJu32VQdFySvUiEEr4xZPJNQJI9XGd1T5u8WTGgNjudBijwofSHBne16b2fHN
         eCSUaNFtlecpQ61dJVlzOXjQadtl80IwYpRXJbq4iK6ZBx6wqarOSP6RohfBPtacaQ1a
         yND2OfpTBE+xZ3sv+A9fOMFPP3B5ep4Lct67YtgURJXohC7UrmB78RojRg4DD71+CmrU
         F+hV8kD76gIdpd6EvnMufME9RoEZIrW2SFUsFMYb3M7Pap9HhOjimKrMDbswzxM0IKww
         zKu8LPxJ2AuWr5WqxHlL8qFTHUKf95pvZmj7g7DFoFGOLZRwT6aQvL8PlaWYJ7Y6lk/n
         G68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474369; x=1796079169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BGMaVX2ojEnc2pfao27skA7lke7MCwTW0eBU+Cg4VE=;
        b=hggyfxq4dRzYozENkX1/RQJuzwPz4UvTWqVdC2lsTktJc3aA/Q74NmBGsMMXy7cWLm
         pOGPd019AXqkokp+/sMF+LqVqYkwMgz2T9u+1ue7zYg8MlhtrXmbkzOfFgxYUqCPcyaL
         tkl4FieicqRiO+GqNFxetbYuCFUyuQjpPWRWbj4rd2e50U3o5olL5w6WF/w/MSS4EpXP
         KXkfyF4x4EltfW9ByPJ1SH4rg3XCoW7Bq54Y/aSlyvAMfjcoKfryoaKPjLgKuKX8i0Cy
         nN5yQbQhSKFoq5dNQFO6QtE23hkDdM5A8+w60CBSTX0AW0lCX4QDDXhIpnftMhTjEAM+
         DK1g==
X-Forwarded-Encrypted: i=1; AL+hErFIo0KXkJ5byQqTeiYX2dhIJwVdXKg7I9oX/1JzJg253Dt///VgxbyJl6VFmLDx6DUNXC/YDXTvyf2c@lists.infradead.org
X-Gm-Message-State: APuU4Z/cCM6l8VnaBxFzwTZcY/cPE/xcBu/J92Htb04PM7B0qUaiZ6xg
	L9TOfXo/0u1RZUZ2EdX3ra5Xdfj81SkMCCr89XwhRb2aT/2qaFbSVGs4sfnd8BONMTlPe/EduRE
	+BRdbiYBppuomRvZT6k/2+uEVJ/Igtw==
X-Received: from ilbeh11-n1.prod.google.com ([2002:a05:6e02:4c0b:10b0:50c:2841:18fc])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3501:b0:567:d689:9b62 with SMTP id 5614622812f47-57a037b96e8mr14473846b6e.0.1795474368504;
 Mon, 23 Nov 2026 14:52:48 -0800 (PST)
Date: Mon, 23 Nov 2026 22:52:46 +0000
In-Reply-To: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123225246.1653658-1-zhenwenliang@google.com>
Subject: [PATCH] nvme-tcp: set up R2T data transfer in the send path
From: Zhenwen Liang <zhenwenliang@google.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: Shao Mingyin <shao.mingyin@zte.com.cn>, linux-nvme@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_145251_733557_C586F8EE 
X-CRM114-Status: GOOD (  37.95  )
X-Spam-Score: -9.5 (---------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_tcp_handle_r2t() runs in the receive path and sets up the H2CData
transfer directly in the request: it checks the R2T against
req->data_sent and calls nvme_tcp_setup_h2c_data_pdu(), which resets
req->pdu_sent and req->state.

The send path updates req->data_sent and req->pdu_sent only after
sock_sendmsg() has returned (nvme_tcp_advance_req(), for every send
except the last one of the request). When a controller splits a write
into several R2Ts, it can send the next R2T as soon as it has received
the last bytes of the previous one. The receive path can then handle
that R2T while the sender is still between sock_sendmsg() and
nvme_tcp_advance_req() for those bytes. For example, on a poll queue
nvme_tcp_poll() receives while io_work sends; the sender can also be
the submitting task sending directly from queue_rq() (the tag set is
BLK_MQ_F_BLOCKING) while io_work receives:

  send path                          receive path (nvme_tcp_poll)
  ---------                          ----------------------------
  sock_sendmsg(last bytes of R2T)
                                     R2T, offset = end of previous R2T
                                     data_sent is still the old value
                                     setup_h2c_data_pdu(): pdu_sent = 0
  nvme_tcp_advance_req()
    data_sent += ret; pdu_sent += ret
  nvme_tcp_done_send_req()

Commit e371af033c56 ("nvme-tcp: fix incorrect h2cdata pdu offset
accounting") already noted that an R2T can arrive before data_sent is
updated, and took the H2CData offset from the R2T. But pdu_sent is still
reset by the receive path and then advanced by the send path, so the
next H2CData PDU carries fewer data bytes than its header says. The
controller waits for the rest until the command times out, and the host
starts error recovery and reconnects.

Since commit 347d50d92e25 ("nvme-tcp: require the R2T offset to match
the data sent") the receive path requires r2t_offset == data_sent, so
with the old data_sent the host now rejects the valid R2T with
"unexpected r2t offset" and starts error recovery instead.

Let the receive path only record the R2T, and let the send path, which
owns the send state under send_mutex, check it and set up the H2CData
PDU when it next takes the request off the list. The R2T is recorded
before llist_add(), and nvme_tcp_process_req_list() takes the list with
llist_del_all(), so the sender sees it; the send path reads the recorded
fields once. The exact checks (offset equal to data_sent, length within
the request) move to the send path, where data_sent is final. The
receive path keeps the "<" offset check and the length check, which
cannot reject a valid R2T because data_sent only grows. A bad R2T still
starts error recovery, which then cancels the request.

Reproduced in QEMU with the nvmet-tcp target over loopback, a poll
queue and RWF_HIPRI writes, using a debug-only patch, not part of this
change, that makes nvmet send one R2T per 16 KiB (stock nvmet sends one
R2T per command, so it does not hit this) and delays the host between
sock_sendmsg() and nvme_tcp_advance_req() for the last bytes of an R2T.
On v7.4-rc4, "unexpected r2t offset" and error recovery were seen in 6
of 15 runs; on v6.18.65, a 30 second I/O timeout and a reconnect were
seen in 10 of 15 runs. With this patch (on v7.4-rc4, and backported to
v6.18.65) there was no error in 15 of 15 runs on each, although a
debug marker showed R2Ts handled during the delay, i.e. inside the
window, in 10 and 7 of those runs. With the delay switched off (with
the nvmet one-R2T-per-16KiB test helper still applied), the reject
still happened in 1 of 10 runs on v7.4-rc4 (QEMU TCG, whose timing does
not represent real hardware).

The problem was found with a Lean-based formal model of the code and
AI-assisted analysis. The patch and this description were written with
AI assistance; a human checked them against the source.

Fixes: e371af033c56 ("nvme-tcp: fix incorrect h2cdata pdu offset accounting")
Fixes: 347d50d92e25 ("nvme-tcp: require the R2T offset to match the data sent")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenwen Liang <zhenwenliang@google.com>
---
nvme_tcp_handle_r2t() can run while the send path is still between
sock_sendmsg() and nvme_tcp_advance_req() for the last bytes of the
previous R2T (drivers/nvme/host/tcp.c:1261-1275 in v7.4-rc4): it then
sees a stale data_sent and resets pdu_sent, which the sender advances
afterwards. e371af033c56 noted that an R2T can arrive early, but fixed
only the offset.

Effect by version:
- stable 5.10.y to 7.3.y ("<" check): from the code, the next
  H2CData PDU is short; observed as a 30 s I/O timeout and a
  reconnect on v6.18.65 (target data not checked).
- v7.4-rc4 and next (347d50d92e25, "!="): the valid R2T is rejected
  with "unexpected r2t offset" and the host reconnects.
So 347d50d92e25 changed how the race fails; it did not create it. A
plain revert would bring the stall back. The patch keeps the exact
check, in the send path; trees without 347d50d92e25 keep their "<"
line when backporting. 347d50d92e25 is Cc: stable but not yet in a
stable branch. On a bad R2T, receiving now stops only when error
recovery stops the queue.

Stock nvmet sends one R2T per command; targets that send several (one
outstanding, as maxr2t=0 allows) can hit this.

Reproduction: QEMU x86_64 TCG, 4 vCPUs, nvme-tcp host and nvmet-tcp
over loopback, one poll queue, 5 x 64 KiB pwritev2(RWF_HIPRI) per run.
Debug-only test helpers, not part of the fix: nvmet sends one R2T per
16 KiB; the host busy-waits 2 s (mdelay) in the window and logs R2Ts
handled while it owns the request.

  v7.4-rc4:              reject + error recovery in 6 of 15 runs
  v7.4-rc4 + patch (*):  no error in 15 of 15; R2T handled inside
                         the window in 10 of them
  v6.18.65:              30 s timeout + reconnect in 10 of 15
  v6.18.65 + backport:   no error in 15 of 15; inside the window in 7
  no delay (nvmet R2T helper and marker still on):
                         v7.4-rc4 reject in 1 of 10; other kernels
                         3 of 3 clean each
(*) plus our unrelated smc/autofs/serial/ufs fixes.
An identical early-boot KASAN report, before the test, occurs on
unpatched (1 of 55 boots) and patched (4 of 67) v6.18.65 images, never
on v7.4-rc4 (0 of 132): unrelated to the patch.

The no-delay hit was under QEMU TCG, not representative of real
hardware timing. Untested: other targets, non-poll queues, digests,
TLS. The send-path error branch was never triggered. Helpers, test
program and logs on request.

Found by a formal code verification tool under development (Lean-based),
with AI-assisted analysis; verified by the reproduction above and human
review. The patch and this text were written with AI assistance and
reviewed by a human. Point of contact: Zhenwen Liang
<zhenwenliang@google.com>.

Public list archives, git history and syzbot show no earlier report,
including in the 347d50d92e25 thread.

 drivers/nvme/host/tcp.c | 93 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b8ab9b..28a5d6da8f18 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -103,6 +103,11 @@ struct nvme_tcp_request {
 	u32			h2cdata_left;
 	u32			h2cdata_offset;
 	u16			ttag;
+	/* R2T received but not yet set up by the send path */
+	bool			r2t_pending;
+	u16			r2t_ttag;
+	u32			r2t_offset;
+	u32			r2t_length;
 	__le16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
@@ -823,6 +828,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct request *rq;
 	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
+	size_t data_sent;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -847,17 +853,25 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+	/*
+	 * The send path may not have accounted the last bytes of the
+	 * previous R2T yet, so data_sent can still be too small here (it is
+	 * written by the send path, hence READ_ONCE()).  data_sent only
+	 * grows, so these checks never reject a valid R2T;
+	 * nvme_tcp_setup_r2t() checks the R2T exactly.
+	 */
+	data_sent = READ_ONCE(req->data_sent);
+	if (unlikely(data_sent + r2t_length > req->data_len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, r2t_length, req->data_len, req->data_sent);
+			rq->tag, r2t_length, req->data_len, data_sent);
 		return -EPROTO;
 	}
 
-	if (unlikely(r2t_offset != req->data_sent)) {
+	if (unlikely(r2t_offset < data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, r2t_offset, req->data_sent);
+			rq->tag, r2t_offset, data_sent);
 		return -EPROTO;
 	}
 
@@ -869,12 +883,18 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	req->pdu_len = 0;
-	req->h2cdata_left = r2t_length;
-	req->h2cdata_offset = r2t_offset;
-	req->ttag = pdu->ttag;
-
-	nvme_tcp_setup_h2c_data_pdu(req);
+	/*
+	 * The controller can send this R2T as soon as it has the last bytes
+	 * of the previous one, while nvme_tcp_try_send_data() has not yet
+	 * updated data_sent and pdu_sent for them.  Do not touch the send
+	 * state here; record the R2T and let nvme_tcp_try_send() set it up
+	 * when it takes the request off the list.  llist_add() orders these
+	 * stores before the request is visible on req_list.
+	 */
+	WRITE_ONCE(req->r2t_ttag, pdu->ttag);
+	WRITE_ONCE(req->r2t_offset, r2t_offset);
+	WRITE_ONCE(req->r2t_length, r2t_length);
+	req->r2t_pending = true;
 
 	llist_add(&req->lentry, &queue->req_list);
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
@@ -1401,20 +1421,72 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	return -EAGAIN;
 }
 
+static int nvme_tcp_setup_r2t(struct nvme_tcp_request *req)
+{
+	struct nvme_tcp_queue *queue = req->queue;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	/*
+	 * Read the recorded R2T once: a controller that violates the protocol
+	 * could send another R2T and rewrite these fields meanwhile.
+	 */
+	u32 r2t_length = READ_ONCE(req->r2t_length);
+	u32 r2t_offset = READ_ONCE(req->r2t_offset);
+	u16 r2t_ttag = READ_ONCE(req->r2t_ttag);
+
+	req->r2t_pending = false;
+
+	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
+			rq->tag, r2t_length, req->data_len, req->data_sent);
+		return -EPROTO;
+	}
+
+	if (unlikely(r2t_offset != req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t offset %u (expected %zu)\n",
+			rq->tag, r2t_offset, req->data_sent);
+		return -EPROTO;
+	}
+
+	req->pdu_len = 0;
+	req->h2cdata_left = r2t_length;
+	req->h2cdata_offset = r2t_offset;
+	req->ttag = r2t_ttag;
+
+	nvme_tcp_setup_h2c_data_pdu(req);
+	return 0;
+}
+
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
 	unsigned int noreclaim_flag;
+	bool fetched = false;
 	int ret = 1;
 
 	if (!queue->request) {
 		queue->request = nvme_tcp_fetch_request(queue);
 		if (!queue->request)
 			return 0;
+		fetched = true;
 	}
 	req = queue->request;
 
 	noreclaim_flag = memalloc_noreclaim_save();
+	if (fetched && req->r2t_pending) {
+		ret = nvme_tcp_setup_r2t(req);
+		if (unlikely(ret)) {
+			/*
+			 * Handle a bad R2T as the receive path does: leave
+			 * the request to the error recovery.
+			 */
+			nvme_tcp_done_send_req(queue);
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+			goto out;
+		}
+	}
+
 	if (req->state == NVME_TCP_SEND_CMD_PDU) {
 		ret = nvme_tcp_try_send_cmd_pdu(req);
 		if (ret <= 0)
@@ -3120,6 +3192,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
+	req->r2t_pending = false;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
-- 
2.56.1.809.ga0b61035b5-goog


