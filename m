Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33AC4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 17:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7EE207FF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 17:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jl4T/ehH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7EE207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=EX46X2cJI8G1/AHZO0+xmz6/Zki4kbzudkIKMZzkxes=; b=Jl4
	T/ehHWxyTCDoGU5qGW4uPAkKubztlQrvzV5fjtkRubM1hotkhpHkTV4lW9CLuhv+Yt9TjOkSCkptU
	TcPlSpD4pl5OY4OHU6LGfyYlt6TSPrsCT+wXm3PfeNoShlyklt11rr7/k9fAJcEr1Ku/sjBhXvmDV
	YA/qUdEQeNCIHo4A9brfB92hQ+x1jNTdEVck2oP3Wfo1879Xist30k9pEnWC0gPAYGK0lw17Ihdoe
	T3VLCLTipju9U7XvrBkmS1a+jrd+wZwsXwf4x3EgH3qPFIc+lFYK62Ytzm0GW/0UJvuYURMSMm45H
	XFfTE6CCthT2p8JCHdsc9YtSOsU1JnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDtzw-00041C-Eu; Fri, 27 Sep 2019 17:25:40 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDtzv-00040q-BZ; Fri, 27 Sep 2019 17:25:39 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-rdma: fix possible use-after-free in connect timeout
Date: Fri, 27 Sep 2019 10:25:37 -0700
Message-Id: <20190927172537.9555-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the connect times out, we may have already destroyed the
queue in the timeout handler, so test if the queue is still
allocated in the connect error handler.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9d16dfc29368..4d280160dd3f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -620,7 +620,8 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	if (!ret) {
 		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
 	} else {
-		__nvme_rdma_stop_queue(queue);
+		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+			__nvme_rdma_stop_queue(queue);
 		dev_info(ctrl->ctrl.device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
