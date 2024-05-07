Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CB6C25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1sv/bXg1ouqgC+DNAP3svGNCkJrurFoxOrDxvpdJEY4=; b=jej+KwH2OykHwtr5z9oiZvDW8m
	pMbM+7DSEjMJRhsZBCe/oecMNTyVL+kUbA923M7htREfIOHdubETtz1Fgl2IjYk1n8lojtBWY+3Ay
	bv4CRlnBbA1FNIrDOwwe3+Yxa/Z7jTHFlBrxaotB3qZ1V7RCrCTKGhSsZ8Y/GxaHXoMGBsJ7CQN7H
	jbPm7bRDcgP3s6qBGIry4dPmRJkGTgb/ZC/1ge9ICpNOkeXiATurEYh4xxZ1C8Foxgv1BG7EBDA+k
	xSpByFArJQTkD+GhClVR8VJRyNDezQpo2fP9b/DnU30gUswc1cq23J+8ro7eNHlYgCgj3rbZsBw0B
	1fuu6LSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Two-0000000DAKf-3Qtg;
	Tue, 07 May 2024 23:10:10 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twi-0000000DAEd-27q2
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:10:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 55D8BCE1757;
	Tue,  7 May 2024 23:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A46C4AF17;
	Tue,  7 May 2024 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123401;
	bh=eo1c5Avq+ijbEULoGJKldihoAOoaAEFxOcxVHPr11w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBdHeOPpT+Zf6ZyyvqF/BOykw7hJomq4KZ00JQVGUazh2/i0SpWFCqLP5OWZfZeuj
	 UiYtkOp3/GP1+ywWtkWc+lzJU5qcvT89fLr2tNC+SNdeDjLqjZpNrPn49m9N+h6Sb9
	 O+VlEIu3k0dzT1QUDucED/dW4gTyfG3cFVZtssfN4/3M5/3RpljRlRKDphVi5tZfEL
	 GlVjzYSFTdzx5NMjkwnAWlR+zkHcEt0wUkhngH0n2wrLJTtAb8uc/LX97lIWN9fFvz
	 KU+6NCsyeNi6Y8bIuj7KJ4QemGqbK04DiZ93S0oT6lJ3tfnoI1FxYiF2qAG5sLI7Up
	 59F4N+8DsrNJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 51/52] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
Date: Tue,  7 May 2024 19:07:17 -0400
Message-ID: <20240507230800.392128-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161005_121692_0091F83B 
X-CRM114-Status: GOOD (  14.25  )
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 50abcc179e0c9ca667feb223b26ea406d5c4c556 ]

TLS requires a strict pdu pacing via MSG_EOR to signal the end
of a record and subsequent encryption. If we do not set MSG_EOR
at the end of a sequence the record won't be closed, encryption
doesn't start, and we end up with a send stall as the message
will never be passed on to the TCP layer.
So do not check for the queue status when TLS is enabled but
rather make the MSG_MORE setting dependent on the current
request only.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e056021..6eeb96578d1b4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -352,12 +352,18 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
 		!llist_empty(&queue->req_list);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+		nvme_tcp_queue_has_pending(queue);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -378,7 +384,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		mutex_unlock(&queue->send_mutex);
 	}
 
-	if (last && nvme_tcp_queue_more(queue))
+	if (last && nvme_tcp_queue_has_pending(queue))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
-- 
2.43.0


