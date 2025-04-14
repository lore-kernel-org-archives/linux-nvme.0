Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2088EC369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8sJ3P+2cyDfauPVccYIMLu4sGuv54uwvqFFCL8dsw4A=; b=TI5JLUZblFm2ymXXJN1msBwnJc
	G+2m+56nkdHB8jSAzfUK9fn1s9wX/6XvKl/27EGklGhBxxoNDnE0fprX0PSWjaBJtr91nh5KgKnKi
	yJVR4fwGlzl4ysaGA38L2vNNPhlgXnUXvG5chU3eadvDu+iLOV3EYGWu0HyjIq++D6Y8cGXfpMf/e
	9FeHzTu4bYYdISku67cJzx9xLcM70fdE6GoxVdxCViY4zw0ag1R1j0rzyl8sikHMPnkidlrBNr74B
	yNDQnlY78w8DeEvfDrGGX8CeF4oJftALGGd1kVeb0Xz9SYjFeAiZHv70EeAbPdGg5M9/9RqKPPX5J
	6aPdtzmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IeP-00000001tgp-0N7u;
	Mon, 14 Apr 2025 12:10:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4IZ2-00000001sY7-0BeI
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 12:05:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AF46244C24;
	Mon, 14 Apr 2025 12:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19282C4CEE2;
	Mon, 14 Apr 2025 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744632323;
	bh=Ug0oztsqHi2EZ/QaPItjaFphJHLq2tHbYokDFEmD2CY=;
	h=From:To:Cc:Subject:Date:From;
	b=DHrZ9CMc1Ifx/C4tziXtmvY+t0y6IPJo59dZYsEAZvFWLsevaH/wXxoE2kprG1D0q
	 ZK+E1SEjambVk0o3jdPa3hG9gIhabsOvgrTVYtx7oHvNNxVV/ku6xxsH0ZwHPsGrrN
	 1fHLiw9D3VF7kbno5jfyPRGwxhmflILYTIEKkzP5a1V4MnXHKJjfEYNw+y6P085znH
	 DAIk7+kAB87WZJ02lFLcon8HxCryIj2MIfZiSVt7OyECPVYX/Wj0R+LAWg+0F72Wos
	 W5EGW/u8Ws7UB98vT99c5aEToDoElFPvaihQvrG1nkGc8FxbJOUQrQ4tXMTlV4Vpmn
	 6PxEbQEthVqPg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Srikanth Aithal <sraithal@amd.com>
Subject: [PATCH] nvme: fixup boot failure on nvme-pci
Date: Mon, 14 Apr 2025 14:05:09 +0200
Message-Id: <20250414120509.49638-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_050524_106178_CD26F3F1 
X-CRM114-Status: GOOD (  11.52  )
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

Commit 62baf70c3274 caused the ANA log page to be re-read, even on systems
where the ANA is not supported.

Fixes: 62baf70c3274 ("nvme: re-read ANA log page after ns scan completes")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Srikanth Aithal <sraithal@amd.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b502ac07483b..eb6ea8acb3cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4300,7 +4300,7 @@ static void nvme_scan_work(struct work_struct *work)
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
 #ifdef CONFIG_NVME_MULTIPATH
-	else
+	else if (ctrl->ana_log_buf)
 		/* Re-read the ANA log page to not miss updates */
 		queue_work(nvme_wq, &ctrl->ana_work);
 #endif
-- 
2.35.3


