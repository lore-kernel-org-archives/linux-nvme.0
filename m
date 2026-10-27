Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1680B606A331
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ILRU7t8U;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YY3f/f+A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0RU8xfLIY3EPFCoIx77yj59Kk3q7QfLCJaqDRdNp4aw=; b=ILRU7t8Us1N967
	Z913QfHiNT6PrNBO7BgsX0m5ef2VyPqVb6UCXdBmSKGi4wC5kmJrhc+h48D2LI+AbwpdaFrpKeQpN
	vw+sh9svS5MGen0yH9AtBDJWcWq3OU9zAxHEvztafn+gF7uy6nPGBfVBn3/Z6EBPynUPwmS4ci2Na
	wkFdGvQnJyqToSdCqCPtlF4KZdq1Y/qey68Ue8gUEIXVTnMQ4i3V25EZdWwcgxfGFYAd0yBLHfU+R
	Gm9hHrLBXemv6kbYe6aO/L2AOzR95RNJE9KoyEA+MTFePCcDLVxh2DJOrOgQXOvnBcyNf7fLJpv4+
	RE38IuwRRPcNmtOhirTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLea9-00000004JXQ-42O1;
	Tue, 27 Oct 2026 10:39:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLea8-00000004JUd-45xK
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 10:39:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D3D2406E7;
	Tue, 27 Oct 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793097540;
	b=uRueTTpPexHfHdhP7n40t2EVW6hsqh02e/p+O9L1wUyobDtFC8EB4b1NiepsDLWWfW8G
	 EVm0c3lCIAPtRTEpM9AObcuB0JF2awRLoA2tXzt/jwITc9zjLQsRswxmO4j6G6S0z5xav
	 PzXq3DpBz/kwYDp7q9Frtz/wEhWVrzMIhbc1Dbir8gVV1kKN9n+ByijkAd9dKkhxQhokK
	 Vr3ECYPCWx6PRDmq43phKvjPQY9CqvhMobWDEzzju3s5InsTW8m5RKBNBMPt20WwElZWp
	 F4wPDjxMj7jiTeWOdW+9OOBotvYA84g3WuPwIQ7oHabaCSlVQ8Wqy+roPKOFavH+hTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793097540;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=0RU8xfLIY3EPFCoIx77yj59Kk3q7QfLCJaqDRdNp4aw=;
	b=uvlSgbXJ4Rs5SDeRetaOs22ciknCiuVVkvMYadW5s6BkwicPWgvRlVL08HdGMO+EPJFT
	 R58Eku3md+6kMQ8gKYb4MQ+KbvLytbyvM7Er4DRfhv+VA7miO35pc8TMF/edAt8cBOPvN
	 +X3q/OVzBsjF8urgkBiE3p0Lo4HGYkSDnSLjxRLepbyJnZ8cHXfBXIF7BOoHVtHVHRVPt
	 +YSAKqP0roYvh6JfsysvnqEocTc5UHFxlZO9cPmzJLgfD+bzr/EojZgE3CJt0tHnoQkxK
	 sYIJF5km5UVT27cExMDpfeKvL7fYi+SEaCNpmlzEhTYGlS+FH8SrSqb8LnyHOnJd6Qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C8C361F01828;
	Tue, 27 Oct 2026 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097540;
	bh=0RU8xfLIY3EPFCoIx77yj59Kk3q7QfLCJaqDRdNp4aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YY3f/f+AXwnZD8ehWsHGN3UZ1OXa65TySmm8q372qpgNuCTtns+WvbgjN2N7TLaP8
	 Na5Z193H4hr5c/pVF02qJkhUhuL5MLnaEQ00o9JGtpdk3FeWrfLicVSTE5tX6nyirY
	 3M9sF7QJi1m4DG4DDfrUT54n5l6LMcRmo2heI1z6jQuaDPc9AI9pjZMHV29tPkC57q
	 ZKZuiGZiipnsItZqlLUYKwb47n8qS4jrng9mnOflK9vxe4LBZdklOhfWXxQBcgzspk
	 hquJW6JrPREVHP+WsFtogGuFHQ4YJFNI7ihJNQ5pOMy52tyfhao+uh+scPcYDVV056
	 YB9/p0XQ20LNA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 34DB84508F;
	Tue, 27 Oct 2026 10:38:59 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 06:38:52 -0400
Subject: [PATCH v2 1/2] nvme-tcp: start error recovery when read_sock fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-nvme-tcp-ctrlrec-fixes-v2-1-9656395ebcf2@gmail.com>
References: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
In-Reply-To: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097538; l=1682;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=hDUpWm1V3KSmqXGaIokvqiOU1vnqpmBdJKR+jEs0Z8E=;
 b=GLMuaIbGa9+1cdJ/X2rg+kI5ktjvxKfw6FY6iPGzg8gRjGdKFzt1S6+mHkaX++usMNA/PLKps
 d03mkoVUBEdBvqlBicld6/RqO4ZLNQA2a2QpiAV/RQEjwpSsTpaqEuB
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

nvme_tcp_recv_skb() disables the queue and starts error recovery for
errors it detects itself. An error returned by the transport reaches
nvme_tcp_try_recv() without either action.

nvme_tcp_io_work() returns on a negative result and does not requeue
itself, so the queue stops receiving and remains stalled until a command
times out.

Report the error and start error recovery when the queue is still
enabled, which indicates that the error was not handled by the actor.
Do this under the socket lock, as nvme_tcp_recv_skb() does.

Assisted-by: LLM
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7190eb10c248..0231b95fe4e4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1430,6 +1430,19 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	lock_sock(sk);
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	/*
+	 * nvme_tcp_recv_skb() handles its own errors, so a queue that is
+	 * still enabled failed inside read_sock(). Handle it before
+	 * release_sock() processes the backlog.
+	 */
+	if (unlikely(consumed < 0 && consumed != -EAGAIN &&
+		     queue->rd_enabled)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: receive failed: %d\n",
+			nvme_tcp_queue_id(queue), consumed);
+		queue->rd_enabled = false;
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+	}
 	release_sock(sk);
 	return consumed == -EAGAIN ? 0 : consumed;
 }

-- 
2.53.0



