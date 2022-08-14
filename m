Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BA9C25B06
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Aug 2022 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m8drF7oZ59tKuvJXuKhImnxaTT1zMM4Md5PYicK99Q8=; b=A67wz0x/sj9n/NtD9IrslSCjoV
	OP+WP8QiSmsAv6zVu38yw1OALcfoIFtNmm1mu5uYSQL1sROfh59W6OMfq1CbtkyCBC6hm6eE5QhYH
	qKjswMGpvjrlBtTyADy1YXLmbivqQW8nfJjOayIB1VMGSrDX9sM4OoA1jp2JHIvCGfY35f8JBtE5K
	GUOSJv47V64wGpO5adlhuFJGuIVtRSbqpOOoCPiTKrkdxvmUhwU/Gm3ZwYlLPrcRXg8OQRwmSCRNB
	a1/sNIcUJyQHpmO1Y2hxjRw+fTGJHl0iJ6ayrY14rrl4JFdXd3SHP090t1SbiPqix5bc8yvPHiC3p
	BL/YU7xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNFha-007UfX-Rx; Sun, 14 Aug 2022 15:38:58 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNFbX-007Qes-6T
	for linux-nvme@lists.infradead.org; Sun, 14 Aug 2022 15:32:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DAAF4B80B86;
	Sun, 14 Aug 2022 15:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB35CC433D7;
	Sun, 14 Aug 2022 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660491161;
	bh=BK6B3gdawsyew22CcsT952m5T51Qwd2OmaLNJ6Zjx3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx6XK7yFW7d/6oRJbGylnDtvysQ0NkQh3X30uA3FQj5P1JKzcJ9JGppLu6oPX0mob
	 39XLNsJyD7co1+bRQ/blwaUkRGnrws2iZ+ztu7D3gndpD4l2eIbtWD5ja+emblBtAy
	 oDj5QxwCcZwkcvFV14pHEjZsReTwOw67PtOFnpFlRUi2de6gl6yOF//dJz4GnRjGOa
	 YeS13+4JoJq44SY2tt5Fzomr1UQ3Cw+L/7D5hk6mkfD713AM/bUoXYTvsewoU3xE2w
	 z8Q2nLjFu9YbF/ZI065qZy5NGHd66d4FO8mHLSKsUewh4n1s+6ycJsgywo3/O+W9yd
	 HMTHHrYZFlkcg==
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
Subject: [PATCH AUTOSEL 5.18 52/56] nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
Date: Sun, 14 Aug 2022 11:30:22 -0400
Message-Id: <20220814153026.2377377-52-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814153026.2377377-1-sashal@kernel.org>
References: <20220814153026.2377377-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_083243_466192_C98EDAF4 
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
index 0a9542599ad1..dc3b4dc8fe08 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1839,7 +1839,8 @@ static int __init nvmet_tcp_init(void)
 {
 	int ret;
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
+				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.35.1


