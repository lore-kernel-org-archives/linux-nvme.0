Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D10C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 01:27:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD09760F45
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 01:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD09760F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0hItf4Szc5uWJQ10QInIwjRIMtqTvaTAJjAfsQp4sM=; b=YXVs/PFWq5PS0S
	asqYQHzOrlMea8tkafYLBsSnCSI/imzP1EZLgTv2QSWdxycBNVm2+ry7X41Tkku55RY78CfByitmt
	zdmyE5D++dqLxr7IZwjTF40hJu3QofRnz1rHt0G0/tGyNlqhlze/8+cN7qJ09PkpX8ldvISzFK8ba
	1xmCLaeRR1AaCFPFDejh4R57pW1kLXt655nt1MNKaesNfakFagPq6QtzFBksaIWe5duNkX2/aqMQu
	zUfO4sJc1+R+U4UWzYSx/dESg+tY4xdJ4pNzsD7b7GS1zbIsKMqmxxsNOY6tdQFtMxy/oRLO1hY8J
	rfX0+G8JCy7LivLbtNdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN3PY-00Gw6y-Cb; Mon, 06 Sep 2021 01:27:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN3Lk-00GucO-6R
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 01:23:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30A4E61166;
 Mon,  6 Sep 2021 01:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630891383;
 bh=qpjiSVmAa/GUpIbdu/bOfFsVIDF2f69PRQ7Vm/j8hNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bJw9o4iPFVb57aCGBQGPkb11O7K/3L9dwU03LpxrU6MdpLpRuVEcl4AN3MEkzu1gs
 uLTTi7wkUJd1cR3cuwTJZBE/h1m1yUqzd5Yrfu2ee2wiPfuB9FDLNhSkjJtprW9bYw
 CrEoI9CGKjPLGBckJyEwpVzYTcMg+taPhoUanMJqq9iVCnKr/jhQRaChEIPJLGVsZj
 BecGkaxnK65aVJny0qpL2f5hxcwXqh2sdeq5odHzYByRGa1ciozrlbNTwJQUKT/+cX
 p7yTAABi6Xjs6ZoOYeNs/6iM887q3FbYJPnRKI7VUyowi3bul4j3bL3asO2eKKKUmc
 rANG0LMsuHVrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruozhu Li <liruozhu@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 16/30] nvme-tcp: don't update queue count when
 failing to set io queues
Date: Sun,  5 Sep 2021 21:22:29 -0400
Message-Id: <20210906012244.930338-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012244.930338-1-sashal@kernel.org>
References: <20210906012244.930338-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_182304_283409_1F14BD83 
X-CRM114-Status: GOOD (  13.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ruozhu Li <liruozhu@huawei.com>

[ Upstream commit 664227fde63844d69e9ec9e90a8a7801e6ff072d ]

We update ctrl->queue_count and schedule another reconnect when io queue
count is zero.But we will never try to create any io queue in next reco-
nnection, because ctrl->queue_count already set to zero.We will end up
having an admin-only session in Live state, which is exactly what we try
to avoid in the original patch.
Update ctrl->queue_count after queue_count zero checking to fix it.

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 718152adc625..f6427a10a990 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1649,13 +1649,13 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ctrl->queue_count = nr_io_queues + 1;
-	if (ctrl->queue_count < 2) {
+	if (nr_io_queues == 0) {
 		dev_err(ctrl->device,
 			"unable to set any I/O queues\n");
 		return -ENOMEM;
 	}
 
+	ctrl->queue_count = nr_io_queues + 1;
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
