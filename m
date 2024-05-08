Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A931DC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qs/PxW7amlUd3+q6+if7VkPCOc+vpApqkI9URAsCLtI=; b=NfkX4/wVgWVQ5KShNp0zLYLR8u
	LD1fAnMbPM5sanH/s9SlF0bPWMOBd8jiwzWfM1oRSnwARrJ3DTy7OPndvptYw0rvRkMR1LDF6pqPw
	NbmX445rw1PKPU02cWm7EDHawei5uV2gWolYfR9WEM+FZnup/Ep3hfxy4zgO+PuFBsUXCQxtS6BBW
	+5SdWgQSDfx0I7VYDa/2lJeevw2e3c9aT5NxA2I1swyyEEd29W8y3B1x8QWQ47nCggR33ux3BV6Tu
	rSVQSp89sm4hlJXUp/D2MjrVOISfaDfqEzF3+iF6HChUBouzlP8fRm35JVs23TjsaZQuDqPjeAWXg
	POlMWvxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fVx-0000000FEMk-1rbw;
	Wed, 08 May 2024 11:31:13 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSl-0000000EyDB-1y8I
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8F048CE1844;
	Wed,  8 May 2024 10:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849DEC113CC;
	Wed,  8 May 2024 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163828;
	bh=3OzmMsYdPwqFLiMFnPLb9oukcUNoIFe/SO7Q4e9SulE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p04shOixWqQi/J3u+PaSYJBVlIb9X7MXZwRAdqYgeeOfgsywvb7BDWcMkUu7zzlOZ
	 k5f82yb8XYwOTwdmJjYzRY7lk/2/Z/hG99sJYL8V26S3e2vi/WjIzc8Ntel29XjqVM
	 EUneWffXx37i0SBRlYJkorwpkA7onR4kW6dPGyB+lFHSMHA8NgnHGyxsyyclojis+b
	 3FHlMq2TLMCosgukEh0Tc9W7VxHrWvSHILhivbRk2ENKrqmhgvMiLi1JBTF/cL1PRQ
	 yUyyW8lzzffZPItTQLWZRPpeG/UtW2WMguw1q7nszRTdkua61ZYQ2FKrwDPXRH2HUa
	 sqjJogN01bcwg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 15/19] nvme-tcp: do not start queues when TLS is not enabled for secure concatenation
Date: Wed,  8 May 2024 12:23:01 +0200
Message-Id: <20240508102305.108949-16-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032352_165301_5DF370EF 
X-CRM114-Status: GOOD (  12.50  )
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

For secure concatenation the TLS PSK is negotiated with DH-HMAC-CHAP,
and then the queue is reset to enable TLS. During that state we should
not start the I/O queues as the connection will be reset after
DH-HMAC-CHAP is run.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a9fd3169ae45..232ea8572cdd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2065,6 +2065,17 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
+
+	/*
+	 * If secure concatenation is enabled don't start queues
+	 * when TLS is not enabled; the connection will be reset
+	 * after DH-HMAC-CHAP is run to enable TLS.
+	 */
+	if (new && ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		nr_queues = 1;
+		dev_dbg(ctrl->device, "restrict I/O queues for secure concatenation\n");
+	}
+
 	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
 	if (ret)
 		goto out_cleanup_connect_q;
-- 
2.35.3


