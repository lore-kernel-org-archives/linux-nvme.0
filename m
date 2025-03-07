Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE58C282DE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PedI3TlKGxv2yev2lhLhxk4RhMFSd/iR4d0gtYaLhmc=; b=A66pt4tfX2KxLCJBEuXi0YKRut
	Pp9ke0vdboiOD8rT5lsW6h6ndzxRmvNycf6eV2n0iiXy/NFclLUoiKQGW0RZwK66ztCaTJa5FrSS9
	/nEeyi2/UGs74d8wj5TVUjEzrCkNlEz8GKZ4EgxqJdZ4mVo9eaRefYxuG5dErouAG2yL8nuN8zfoQ
	T7K6cVBmbrSjf6vRNB6QIF4FBdI6z+A/9yU174ib0vxEz6/+jga1fb//0w28hScEKkAriBAGh/AXh
	40UqhXGX80owQI11s73PZs/5i2ubJSI8i9EN6NqpgmKGn+xAkIFCRv50AyXktJe+QNymSoc0QyHSC
	g1mO+liQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXlf-0000000EKeh-4Akl;
	Fri, 07 Mar 2025 13:29:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXkQ-0000000EKQN-0R5F
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 13:28:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B06F0A457BC;
	Fri,  7 Mar 2025 13:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9805C4AF09;
	Fri,  7 Mar 2025 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354096;
	bh=3GVjo+Bjnc0gJQkxttn936u+mT/BO/E9w2uXPBCZWK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5W1UwQF64RymODJacPqdcA4MqRYIpPIF4qvl65E/g0eDY7f5RW5MI2IhiNY/AFLU
	 aWmPDs+8BiXCiGSEWy2nvmAS9tHv8RgcfWlEMLEBjTFnMKt/JHY559+aHnIFED5IzW
	 ghV+yA4u9vFXdMSzFl4GquSTkyyp5YKeGhDGMBjX1f7qV9jAKhxaMkGoDsg/OE+2CI
	 DJvWC7jWXtdZO1AgknGfB+wWrYur/MjSjZa952Krt9Iy6Qk3WexVed4MZavp5PvJh3
	 ht/WcTBx4OXmuvl1jjIctJT4FvqJ/wAqYrCttuB4zHcVGWxe0WDfyuQ9YszZ8O/XkV
	 cfpDS67/PcUzQ==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Date: Fri,  7 Mar 2025 14:28:02 +0100
Message-Id: <20250307132802.111513-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307132802.111513-1-hare@kernel.org>
References: <20250307132802.111513-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_052818_229702_5F93D94B 
X-CRM114-Status: GOOD (  14.50  )
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

When the socket is busy processing nvme_tcp_try_recv() might
return -EAGAIN, but this doesn't automatically imply that
the sending side is blocked, too.
So check if there are pending requests once nvme_tcp_try_recv()
returns -EAGAIN and continue with the sending loop to avoid
I/O stalls.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 073c8c3538fd..d39d955bad99 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1357,9 +1357,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
 			pending = true;
-		else if (unlikely(result < 0))
+		else if (unlikely(result < 0) && result != -EAGAIN)
 			return;
 
+		if (nvme_tcp_queue_has_pending(queue))
+			pending = true;
+
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.35.3


