Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33B6C0219B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 00:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7OlWTlDzig/tKR7TwwALwoBDKgJliHpOgc4NwnFTW0=; b=hazaCEEB9eesHrp29fQzrplj/s
	WW38Sya51VpHQTSbiILhCaNqla+GIT7qooPTy57Z7rGU0OrJJZvpnjpkTtmn68MLs4x8yU9arvCUH
	v8c3RUMu91ls8/7ii4bQMQcGbwBdAEjPWaKa5uKms2g7kieG8Nuc9k8j+aZZpzy4jGdYZjSNKBlSw
	z3VQ9ocELwT2AHLTm2zdM5RomzmLq4NJbqBMbE5bLHYj5JoykorIln5uyG778fkeDRDJ5sfeVd7s9
	8r+o9BXD1UmBUNctFIrqXB0rmG9fdSmGzYPBZkOwAqp7uXttfePn3PMJbjJfX8pCJW0ttGtHUWtZx
	IKVKVenA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thHg1-0000000FqCj-1tPI;
	Mon, 10 Feb 2025 00:29:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thHfv-0000000FqBH-03Y3
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 00:29:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DE8A75C5CC8;
	Mon, 10 Feb 2025 00:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1970C4CEE7;
	Mon, 10 Feb 2025 00:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739147362;
	bh=a9a/QoVS9M50nZhATdPluX6ksc43+UYLpg1xOe8FguQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D5uthOBQjb38Ww0oWzYENh2shj4jB9D5F1XDdAjPv9Zn8S/qMRVLbGxb2WwpmBmOe
	 yVnPmbE/D9bxD2HjE2hMwEMu4kAsHFXtu03G8fmovDYyEwf4/TIJokZXLd1FXYz8OE
	 uukb51b/ipGtgFEQHe9GppypT+RP2o35HUlmULSVxi532+2T2V5XqX7EMuyGrbCS+C
	 5GziAQzEFNMUojKvzqdh8UTy1Ga79sh991V5lOVKSaKyDdcIoQf7+VAo0iOHlPuyTz
	 fP9wNBxfNaVSO4EuQ5dmYeU4kHq2YewUychhhTCRbN9PwVy26WRPRrmD1FzGuCgUKg
	 X6k9MQU2T1NTQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/3] nvme: tcp: Fix compilation warning with W=1
Date: Mon, 10 Feb 2025 09:28:15 +0900
Message-ID: <20250210002815.1744205-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210002815.1744205-1-dlemoal@kernel.org>
References: <20250210002815.1744205-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_162923_094484_4CA4EB81 
X-CRM114-Status: GOOD (  12.25  )
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

When compiling with W=1, a warning result for the function
nvme_tcp_set_queue_io_cpu():

host/tcp.c:1578: warning: Function parameter or struct member 'queue'
not described in 'nvme_tcp_set_queue_io_cpu'
host/tcp.c:1578: warning: expecting prototype for Track the number of
queues assigned to each cpu using a global per(). Prototype was for
nvme_tcp_set_queue_io_cpu() instead

Avoid this warning by using the regular comment format for the function
nvme_tcp_set_queue_io_cpu() instead of the kdoc comment format.

Fixes: 32193789878c ("nvme-tcp: Fix I/O queue cpu spreading for multiple controllers")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..4162893d4939 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1565,7 +1565,7 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
-/**
+/*
  * Track the number of queues assigned to each cpu using a global per-cpu
  * counter and select the least used cpu from the mq_map. Our goal is to spread
  * different controllers I/O threads across different cpu cores.
-- 
2.48.1


