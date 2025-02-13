Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA8C021AB
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fSMD8ETIH2M04iMnA1JCA5nK0t90PcVDz2rxvKsMCBQ=; b=cVl0tOAhXfvIaSlUeCq72bgRFM
	QsyjRi2M5nMQV6oLxutrQfwqCmAe8yQRkNlv4qIdA2ZSQmcaWuko6I2/k8jBv4u6eN/5yzxrM+Y0s
	L1NFXvdoT7ebGLZgjwWVFa+yd+Ufm49lcrK+3OKpw96mPfTNiWlAlFD2Hw1c5N/3pjqQI0C8MUVSu
	h9fzMX82eRKYQTEUwG+JfF6Mup37KHMBo/StXHIQHdBW3BoOieGCx1HFWSlDqjmMQ31YIHjRxfii/
	ijqxFzhGbIG75h0klwD4SqXt6PgiptCv1cis1ybL2SLkux5EakiO4CadN0uuYeSQutF9j/qRb3GBf
	AtHFI6Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5U-0000000A0JT-1vSS;
	Thu, 13 Feb 2025 06:52:40 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5Q-0000000A0GX-3ca5
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:52:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C3345A41E70;
	Thu, 13 Feb 2025 06:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565C1C4CED1;
	Thu, 13 Feb 2025 06:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429555;
	bh=rvWya628sBYS9Iu/RZQNvGz6AHpAv98lfbn+zavNkdk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fEnBW4Jl7xcFhGFbYx9BSAqB/e/llFLGPLCcLeNBWT+G7NLRrzoLXtN8tnb68onhW
	 vmVUOw/HMQnW1sx9hRU0ejE/A2+s6+v3LYqNI0zawanIzqUGy4xmKdySfE/2LYBvQj
	 M5oVywAhkNj+9r34Tl/WM1gDcJkt1qwPFCo9jVig0x6vuA+zr2urS+HAyrlRYfhlMe
	 lryui2kIhtqhoy+qDV4rOMuEWh02fxqcZAPuV99/qtZ3EJ6OwSSDq91ln8z5vVCBhk
	 sdkN0wzi0K+3YQrsZod+yVmmygAOKhlXlvpiTPfXXGMFXH++dY/9rPuOqEiY98qAq+
	 4IZcpRJ9e+CKQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 4/4] nvme: tcp: Fix compilation warning with W=1
Date: Thu, 13 Feb 2025 15:52:31 +0900
Message-ID: <20250213065231.598527-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213065231.598527-1-dlemoal@kernel.org>
References: <20250213065231.598527-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225236_974336_365C3F39 
X-CRM114-Status: GOOD (  12.71  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


