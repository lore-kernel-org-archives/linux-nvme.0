Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5974C4450A
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jul 2026 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EitaNS2wEB3zSKXz/lyoBiX2bkpMb8TjKS3Q/UyhpfM=; b=JBtQ9dU/VCgV3uFHoG2sS8+uaS
	ciJkDQ4xnzdCfSSogcRyXWNZzlGvKmsDhimVCBg++bE3ForgHsXmrkkJVZRCBBtAZmj+DbBoG4g6D
	x8KaB3mZ79j4kSCRBJ6SX84V2r4ua/9RD3V/IPf/aB/8VhJw/hds/W9melCU6LQjzS2QO6g3v/HN0
	kEm6w9DkDZj9kXtKvHR1nIemRVnfbWthUpd5Ve31oNon2MV6S6727AR9DTwJjgeMe4nGWyVVJ2ejU
	sAFvxmTLxA3jkwjDDesAKK/5Z0ginslSAk+6WJdJbUPCA+DgGbEzJhpffl839ST9Ry22CNug+D+dm
	gdCOWT0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNIJ-0000000HWcs-1yf2;
	Thu, 16 Jul 2026 14:42:35 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNIG-0000000HWbq-2MYK
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jul 2026 14:42:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1778476D95;
	Thu, 16 Jul 2026 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784212949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EitaNS2wEB3zSKXz/lyoBiX2bkpMb8TjKS3Q/UyhpfM=;
	b=Mr5ROjRZ0puS9Rv/dFdpWqdwzrSE9O0bDLr5gnY+F9nGAQso0VgFBKcsnZ8bJMcI0FY72X
	B1/n/DVtINI1REF9O0x1b462f4lurKU3kVwd3DXPFVXuyDZyB1WxwqDokeSDqbHI1tMXC/
	cziOi3umkEQDjpJgb3Ia9kdMsYq/W2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784212949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EitaNS2wEB3zSKXz/lyoBiX2bkpMb8TjKS3Q/UyhpfM=;
	b=02GwUyju9gwI0trC7xt5GRr0mooTECvpxb7ceecIHApvodXgHSq4yTaf3eGk32glHFm3pD
	CdpRU/0S7Zn/0oDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784212949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EitaNS2wEB3zSKXz/lyoBiX2bkpMb8TjKS3Q/UyhpfM=;
	b=Mr5ROjRZ0puS9Rv/dFdpWqdwzrSE9O0bDLr5gnY+F9nGAQso0VgFBKcsnZ8bJMcI0FY72X
	B1/n/DVtINI1REF9O0x1b462f4lurKU3kVwd3DXPFVXuyDZyB1WxwqDokeSDqbHI1tMXC/
	cziOi3umkEQDjpJgb3Ia9kdMsYq/W2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784212949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EitaNS2wEB3zSKXz/lyoBiX2bkpMb8TjKS3Q/UyhpfM=;
	b=02GwUyju9gwI0trC7xt5GRr0mooTECvpxb7ceecIHApvodXgHSq4yTaf3eGk32glHFm3pD
	CdpRU/0S7Zn/0oDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 050A4779AD;
	Thu, 16 Jul 2026 14:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G0FNO9TtWGqvTwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 16 Jul 2026 14:42:28 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Thu, 16 Jul 2026 16:42:19 +0200
Subject: [PATCH] nvme-tcp: fix usage of page_frag_cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-nvme-tcp-page_fraq_cache-v1-1-ea660828cf93@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQB4nYq5QicZzoFJqmiUpBv
 HvTunyL/3fIklQyXKsdkmya9RUK6ksFPLswCepYDGTImra2GLan4MIRo5uk98m9e3Y8C46m8Zb
 I+o5aKHlM4vXzX9/up/M6PISX3w+O4wvp/7G+fAAAAA==
X-Change-ID: 20260716-nvme-tcp-page_fraq_cache-d04f6226f927
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Dmitry Bogdanov <d.bogdanov@yadro.com>, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.15.0
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_MATCH_TO(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,yadro.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_074232_770833_BAD1B512 
X-CRM114-Status: GOOD (  14.60  )
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

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

nvme uses page_frag_cache to preallocate PDU for each preallocated request
of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
	tcp_sendmsg_locked+0x782/0xce0
	tcp_sendmsg+0x27/0x40
	sock_sendmsg+0x8b/0xa0
	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by serializing the usage of page_frag_cache.

Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
If the target exposes many namespaces (>1000) and the host has many CPUs (>80),
it is trivial to trigger the allocation race condition in nvme_tcp_init_request
which results in the logs below:

WARNING: CPU: XX PID: XXXX at net/core/skbuff.c:XXXX skb_splice_from_iter+0xfa/0x310
nvme nvme22: failed to send request -5
nvme nvme23: failed to send request -5
nvme nvme24: failed to send request -5
[... repeating for all controllers, thousands of times ...]

RDX: 00000000000005e8 RSI: 0000000000000010 RDI: 0000000000000000
RBP: 000000000000004c R08: ff57ae906085bd78 R09: 000000000000004c
R10: 000000000000004c R11: 00000000000003ef R12: 0000000000000000
R13: ff4f98b626e30c00 R14: ff57ae906085bbf0 R15: ff4f98b626e30c00
FS:  0000000000000000(0000) GS:ff4f98e2abc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0f167ff000 CR3: 0000000382a18003 CR4: 0000000000f71ee0
Call Trace:
 <TASK>
 ? __warn+0x86/0x150
 ? skb_splice_from_iter+0xfa/0x310
 ? report_bug+0xfb/0x1e0
 ? handle_bug+0x44/0x80
 ? exc_invalid_op+0x13/0x60
 ? asm_exc_invalid_op+0x16/0x20
 ? skb_splice_from_iter+0xfa/0x310
 ? __alloc_skb+0xd5/0x190
 tcp_sendmsg_locked+0x782/0xcd0
 tcp_sendmsg+0x27/0x40
 sock_sendmsg+0x98/0xc0
 nvme_tcp_try_send_cmd_pdu+0x149/0x2a0 [nvme_tcp]
 nvme_tcp_try_send+0xbb/0x2c0 [nvme_tcp]
 nvme_tcp_io_work+0x37/0xb0 [nvme_tcp]
 process_one_work+0x223/0x460
 ? __pfx_worker_thread+0x10/0x10
 worker_thread+0x2a/0x3b0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xdf/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x29/0x50
 </TASK>

The above excerpt is from our customers log. I was able to reproduce this on the
latest nvme-7.3 branch. Dmitry's patch [1] looks correct to me. All the
allocation happens in the slow path and the context can sleep, thus a mutex
seems to be a good choice.

[1] https://lore.kernel.org/linux-nvme/20250929111951.6961-1-d.bogdanov@yadro.com/
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..dd40798bc248 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -108,6 +108,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -550,9 +551,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1417,9 +1420,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1461,6 +1466,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1788,6 +1794,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1928,6 +1935,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 

---
base-commit: 29261f8bb41662f2a660c479e5cf592942b53f78
change-id: 20260716-nvme-tcp-page_fraq_cache-d04f6226f927

Best regards,
--  
Daniel Wagner <wagi@kernel.org>


