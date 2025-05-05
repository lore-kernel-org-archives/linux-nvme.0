Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BF7C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 03:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5FMQ+4XCUXvB2/wLMiuy7tlCfZi/8QSr+8//5mTeks=; b=wVMcrhClYG7+z8108pTmbIyK+T
	zv3m2WBnDUXfXIZG4ChXaGeRX6vrbjnVlkvZZ5ggiKf3bl/JSjLhRTBGg23x7Qg1xvGKj0+OIA6gV
	HhHjFlvA/iydo9Pomp8YgtiUOW5WBxMejbNlo8AvYnxN77lmHcnf6eh4461Y41yPYzUpDDShLi6mo
	dzHW5n9kCAsu/bsikTW7fICpT0Rwnvgp4gYwiBC2pYi8rrjiyF5UUpOAaa1bhigjcF8N5bVMQsIE0
	lndg/fYrIM6BAe+3FNeJ4Kgn/ypIgiqY6yiBDpgZND7azzqeRwv5jqEGeaWVh1Cqt4kcy78JZ/Dil
	djiA7hhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC8Y3-00000009sut-0zpA;
	Tue, 06 May 2025 03:00:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4oG-00000008vsO-3bMv
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 23:01:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 69C91629D2;
	Mon,  5 May 2025 23:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D643AC4CEE4;
	Mon,  5 May 2025 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486076;
	bh=VUG9QuunpnT/Cw2Hq0jcFjdmziSDloJ7N9vAzyTbyfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRnxKyNU70XYMjMWZ1En+Ih5ZMax72PM/nH0fvRx2JOsrbZu38k+MWrPF6phe0lFb
	 UjhdljU9g8duVKAl49NF8RBMifiZOmzBX5OTYiShQQxMD7oUKmPdwxHfNd1fHuZ30R
	 8v8c1Dmpp6483d0UNFNUPsAnRAUau0p4CIam3g/mhux2fpcin44rSM9gnkklkRpZlO
	 fUHpA11R3AHWlXCFDi6Qprf2LfQ3CU1ced+jVvUeft6qUYlwJkD+r+Q3fXt7QavcIR
	 bJdhj6l6IQb7P64csHP9pGCi7Nux8QfjD2HwK3DjI3ZAbGE0x1uVHBs/a8mZDRtosV
	 XGNJ5sew8m4TQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 142/294] nvme: map uring_cmd data even if address is 0
Date: Mon,  5 May 2025 18:54:02 -0400
Message-Id: <20250505225634.2688578-142-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit
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

From: Xinyu Zhang <xizhang@purestorage.com>

[ Upstream commit 99fde895ff56ac2241e7b7b4566731d72f2fdaa7 ]

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.

We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.

With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20250227223916.143006-4-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 4ce31f9f06947..83908f2dd07fe 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -618,7 +618,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, &meta, ioucmd, vec);
-- 
2.39.5


