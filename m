Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4A606A31E
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Nov 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vecAVcfc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEQgfy3h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:References:
	In-Reply-To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oNGH8CkQEAHyP4UwSbh8lNhTyJIeqpdcyD+h2VeLbFw=; b=vecAVcfcjwU6tY
	UU6puZi/3ylfYqLZdljMcQinUmiU9qy/a7Ygh5F9pcIF9bEt6Jq8QF0ZMPRK51H/GvYu1XP73Q7Rc
	lLQ+u0ivTeNsyjJZFh/ydzSaVrDBTB7E5W3EG/aK1JkTXt+huD19nlp10J3YlQAvkEWq0CwXp7t/D
	oJoT/kzqQa6P5w7IuUBM+5tKDT3HmRluqLIL57QcvkYNkvhAf05mAn5gX1QYKW6def+PvzFO0HSZJ
	doFs1IBCz3G8LUpi0cI8m49uK34lCeCFtWwYFZeRI2O3R0hHkQPpGNYtXeYXnB415/dVmI31uPfu2
	KehNPPUH2SIgUW22Xlmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xX7iZ-00000000HYg-0egQ;
	Sat, 28 Nov 2026 01:59:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xX7iY-00000000HYa-0fS4
	for linux-nvme@lists.infradead.org;
	Sat, 28 Nov 2026 01:59:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E07460232;
	Sat, 28 Nov 2026 01:59:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795831149;
	b=n7Fw8DyZcY4pzMJnLNZ86f3ECXEmpcDswS6X0sjkH3Qar6oSjo9vy/niIONZ+OWF6Wqh
	 2zSzP/DjP1rpZlGQS+lFppa4s7uovqgTmgpoTudEAmcM241oBpeuNyG2WNyzuOZ4d6l1j
	 Wsh2nanQEIHoHkR9aksi/mcq5FXhfASfgaHp2XfXKR4wtWAoe63bXvjCnPVyS/X3O16Z0
	 h+Gs+UCZYWoiGiqFMYxQEFFXzTkJiyilmzdjS/i6/o0glF+2KnKOIN0o/smJtHE2cMGLc
	 j+dy7V0T8ypHxfLjiOiApTFcTUBGteZ3+fw4fR3w1MVE0CdnrraebTjNfzwzwWZ46uA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795831149;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=oNGH8CkQEAHyP4UwSbh8lNhTyJIeqpdcyD+h2VeLbFw=;
	b=vyY9AhbG5nTiY9MSHhWPpjWncXq3sQxH5Wtdt3u8kIxo/9+Taqqij2ywqmTprfIiw948
	 LOHA8eYDKcwZpwds4D/iExSgwy6dPwtiFTTZvUP81n3yH9YpxKElDH0Ga+QxRyOFBFdOy
	 YEiyGp5OY+cqfzPkle+EjMEq7099NL4xTsM9nC93b99ul0IYG2ARtS1TU8pcXUAStl2My
	 sfW0C4YQUj8LYugZ78pg+hF6Ae8LzXwGbdQMQxU+6h0w/27uI7UNDoMZNqRB5wbQNTw1z
	 uTzI7/sn9Iy4YA2bN9GfhX1u6zXrKVNi7CVysWYIjb9NpD3kRDi1WIoyy6MeLymhnLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 83A3E1F000C1;
	Sat, 28 Nov 2026 01:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795831148;
	bh=oNGH8CkQEAHyP4UwSbh8lNhTyJIeqpdcyD+h2VeLbFw=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To;
	b=PEQgfy3h8YwYZHK2wZoC2EriVkPWw0D543jWy8LO+fWd9yfpOQ+v3EtL6KS4jYCMy
	 ejTISI+/82iXFGZ+aOjSgbsDDzSTYQTL81Ak/i4P1dzTIgJEg+1B/EjayfrJyihVAd
	 31PI3KpCTUT/HjN9bVjjduhGAyc6ie8Zl1DiLiluI1A7guv5CpdSnj9zy01zpeQ03y
	 biD3jsxnjx0ogaBlk7L/xmA5pO+lCgXWUEojEgLsD1FK507MF30uEjZ1s8aVaOsQah
	 hqLGshWwHz2jcKxzbw+xR6u3zjr85PmaUL3liIEhBxun3WNMwBdLMSzDVdAeqDZpUx
	 Ig/J6L2cmgEPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 167FB4DF09;
	Sat, 28 Nov 2026 01:59:08 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Sat, 28 Nov 2026 01:53:37 +0000
Subject: [PATCH 6.6.y] nvme-tcp: fix usage of page_frag_cache
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261128-nvme-pfc-66b-v1-1-1e9e62f279aa@certik.com>
X-B4-Tracking: v=1; b=H4sIACA0CmsC/02NwQ7CIBBEf6XZs1uFRFL9FdMDLFuLUWjY2mia/
 rugF4/zMvNmBeEcWODcrJB5CRJSLEHtGqDRxitj8CWDPmijlO4wLg/GaSA0xqH2dOzsoE9sCMp
 kyjyE11d3AdOa9g39D8vT3ZjmqqpFZ4XRZRtprEg4+jmlO1a+/7+AbfsAOJ3hdKQAAAA=
X-Change-ID: 20261128-nvme-pfc-66b-2dc58af29e6c
In-Reply-To: <2026093029-shadily-cattle-6976@gregkh>
References: <2026093029-shadily-cattle-6976@gregkh>
To: stable@vger.kernel.org
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>, Daniel Wagner <wagi@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795830816; l=4082;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=CdE6yazXdSUljdqOaRYpG4gOpo7h4tspV/2rkKEFY6s=;
 b=NYsneGD3NMbEmIgR07SkJTCdj2M5Up0H0/CiIhVf7ecGOMBmFFI7NtYc4YfgCoO6TLEUh1cd6
 9hAVeGA+PpAAWdzRT/N+FI1ObvPNbspk+OkxJI3XDiEWz4hlYLDXsN/
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: dickson.wu@certik.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.

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
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ adapted to 6.6.y: no lockdep key cleanup in the queue teardown ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This failed to apply to 6.6.y. The fix is the same: a per-queue mutex
around the two page_frag_alloc() callers, initialized in
nvme_tcp_alloc_queue() and destroyed on the free and error paths. Only
the context differs, since the 6.6 queue teardown has no lockdep keys.

Tested on 6.6.163: W=1 build of drivers/nvme/host/tcp.o, base vs
patched, no new warnings. Both kernels booted under QEMU, connected to
a loopback NVMe/TCP target, read a block and disconnected. I didn't
reproduce the page_frag_cache race itself.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 83347e01929f..673253762c83 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -121,6 +121,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -498,9 +499,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1438,9 +1441,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1469,6 +1474,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1644,6 +1650,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1771,6 +1778,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 

---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261128-nvme-pfc-66b-2dc58af29e6c

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>



