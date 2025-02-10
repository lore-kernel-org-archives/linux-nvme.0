Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB17C02198
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U7OlWTlDzig/tKR7TwwALwoBDKgJliHpOgc4NwnFTW0=; b=uaGb+PT/EzzjRng/eNh5BBoGGJ
	r/R/ONjXOeSKljeaijoOv4B1Pu9iRu9tJ7gXljCATcwOYuV2uuFJ82al+tj+0L2NDxLSP/LZZdjYa
	RmeQRkxYqggF6qbaoSJ2YEZeKvzhYFjdbAcYQ2FPXnv7J0Dy2fLqNIExysEL5EXcjDgDUZaBPrrnl
	mPUmnY4nhpPiRszaSZdU1qogLudQGSNDb3WAh6OvazHnuQkrPgrxQpNUQIFAedRLsoEaWfBnN72Q2
	N64qzvfHQj8PjYW75ytJqmvPKHQc8RDTB/P6zggGLXe1MTfNupv4AUVP2j9mST4hFbCN9q2GilCsB
	kMoZkKkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwm-00000001ann-3quo;
	Mon, 10 Feb 2025 22:08:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwl-00000001anN-1Vks
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 22:08:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EBE545C5EFD;
	Mon, 10 Feb 2025 22:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C258C4AF09;
	Mon, 10 Feb 2025 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739225286;
	bh=a9a/QoVS9M50nZhATdPluX6ksc43+UYLpg1xOe8FguQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tX9ZXSlbJoWnM8qAj2UjXsdoFDpgAlPFOM2b7fkIx60S9OwaU06mxmx/8Gdb1D4nn
	 BG3RslyScmBTSiBmyhFE/1vP/wMeMOJitXk8z76PHFsSnsDN75BLInbw8zYJGxnexa
	 Ah+G/o0/9KiLrjw1495yWUwQTbiY/z4vAkZq+od/W5fQOu4acM3/gMUf49arMyKJMy
	 cOB8aFddPHRe4YNnHoRBKrA8XdkJuMEm1WcuvvmrsQxPcVJTS62qLuZR2p96rqbjfz
	 ZNpKOzKYcrtgwUpzPJL6iD+3+cXuVtRiyoV5vyt41cCkL5Ks9jnHqbcb+yibAG0rGH
	 927/XuI3j/YBg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 4/4] nvme: tcp: Fix compilation warning with W=1
Date: Tue, 11 Feb 2025 07:06:57 +0900
Message-ID: <20250210220657.1762684-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210220657.1762684-1-dlemoal@kernel.org>
References: <20250210220657.1762684-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_140807_433037_221C501B 
X-CRM114-Status: GOOD (  12.53  )
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


