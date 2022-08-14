Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB5AC3F6B0
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Aug 2022 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vGrt4brLYBCON2IhYcSAc6aQKYeWuxWN9RUzC1VEWTk=; b=mWJRfn8UHOxrAiwab0V9dD6clH
	nIocxlF/KD+chsb99dkyaQTR23t+HIXEth56wyQT46dU6hHE2IrEL7FvkqQjntXvtM6Hdk2n9NUKZ
	oWGJ//MgObGRfuY4aOUed/BP9n0JJfn3kF3o1ln5InCQhDCL7dwenxjR2/LYdLlTM4YyBoyGf1T3s
	yX4gx3T2YDuO1KluUDBD5k8tRztCjkW4y7wgyO19EEfwdikO1skv3A7C7wmnr+QiNhFCFnebgGcKe
	WonhVU2jVY35CewGL/j3ntWUO/kHZvhbWwNHpdVrR+l4qG2D4X+Q/DxJk1Z6TWg/6BC2ydHVPwFs2
	2hOnC9IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNFvU-007dOc-NJ; Sun, 14 Aug 2022 15:53:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNFep-007SrT-9U
	for linux-nvme@lists.infradead.org; Sun, 14 Aug 2022 15:36:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BE6AB60DBC;
	Sun, 14 Aug 2022 15:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF86C433D6;
	Sun, 14 Aug 2022 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660491366;
	bh=EYVjw1q+dpeO/mjOC3orZPoHYiNWoXIRtQLqP1kf+8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNyntqWI66MfgeZVFJydEtXQepMMTk9BsjJPeMRNt5P1IV8RIR54D/ljs8D95yJCU
	 cbh8+OTQPqma0Wn0a+fDULTRZzxKRyo/fRptFMWoNWdj040ujGtnbTVpvOA20HwfOJ
	 KXD0tlQmn6uAt5/CJIOmL8f6yrwkDBXzMkApoNLVisKH40KmgT4PpopA9Dv8sj8H69
	 IkEJdUMHNh/zKekUv15026e+exfN52sGi68G0pWOVhouYGrlQ3zZeGIfELAz+d9t1E
	 gBGjg8H0ocM+MIMV0+lyDqKwAfqbR0JNwNAacR5nBPeaeogpL+zkLjOQGeQc37oKBT
	 BSMkZInBrUfAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 18/21] nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
Date: Sun, 14 Aug 2022 11:35:28 -0400
Message-Id: <20220814153531.2379705-18-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814153531.2379705-1-sashal@kernel.org>
References: <20220814153531.2379705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_083607_458426_73DBDBB5 
X-CRM114-Status: GOOD (  12.97  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 533d2e8b4d5e4c89772a0adce913525fb86cbbee ]

We probably need nvmet_tcp_wq to have MEM_RECLAIM as we are
sending/receiving for the socket from works on this workqueue.
Also this eliminates lockdep complaints:
--
[ 6174.010200] workqueue: WQ_MEM_RECLAIM
nvmet-wq:nvmet_tcp_release_queue_work [nvmet_tcp] is flushing
!WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp]
[ 6174.010216] WARNING: CPU: 20 PID: 14456 at kernel/workqueue.c:2628
check_flush_dependency+0x110/0x14c

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4341c7244662..e9512d077b8a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1762,7 +1762,8 @@ static int __init nvmet_tcp_init(void)
 {
 	int ret;
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
+				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.35.1


