Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4AEC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUKJ4QITQK0+Ockq+bNlExXz52uNqriHQgsdz/nP7xI=; b=HolA41n1FShBaDsESe05/AtWJq
	GwzJeuSmIjnunTWCwzPRAPGMYaL8713Ix8pqiBIRWFzC6CNzVTuzFJ+8+k1CH/7HD+2Aa1WN/Esgy
	KHS0RCQl8u97CJP3jpfydLayo0jgneCL4ASf0C2iVz6M5H9zzsbdK7oypPKQNBdP96CEeffY+fgdJ
	a7CIjiPoed/iZiogj7XpbEpEg1mBHOeB6tsRqBBY9pPBQ69tr/nO0Ujf4bwTZPnO+T1I2nxMFkHix
	YxxJoP8QUAmVReFsGVPOMgoL4EVF1tKYyvuXV0V+MdXZXrz9m+ICut7FqMNPXPkOwwpS5KWYUzLJq
	VNHWfNSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFgx-005a2K-0r;
	Mon, 04 Dec 2023 20:37:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFgu-005a1T-1V
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 20:37:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D674F61333;
	Mon,  4 Dec 2023 20:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB99C433C8;
	Mon,  4 Dec 2023 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722239;
	bh=oUvZMfuvpl0PchWDdzWfTrAueZEia6/2lB6MnguuzqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URXhzCAIm7nfCp4ivBMQ+JPw1KsYOyqo3wXBwmT1qW8V7cNU0orEJwIIXBOxGhdLh
	 flOtnJZHWlFkyoEseN+n7Qzkshdvpkz5lTjPM2mlpc7K4M7eB/qGPBMICZgUWD6ify
	 oB2A0CTND6cbiQRf2I29L86Jsd0t265S3dCCfM/nE7sIKIrMtxGLk7waKWPgiJzsXt
	 Ghj71G662QS1gAzL2bQUUmKpykRdmY5Vf9L+az4o+PzMyPmynNrxiCyP2ztds9oU7W
	 ciDUz4Qr581WvISX8Z3puTwnHqZ4PGhHpGMXkAjTErJgEO09tR1zux6FIlsoIiCecA
	 g0U7Wd0T3fMGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/7] nvme-core: check for too small lba shift
Date: Mon,  4 Dec 2023 15:36:50 -0500
Message-ID: <20231204203656.2094777-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203656.2094777-1-sashal@kernel.org>
References: <20231204203656.2094777-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.202
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_123720_549832_DA4E8476 
X-CRM114-Status: GOOD (  13.52  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 74fbc88e161424b3b96a22b23a8e3e1edab9d05c ]

The block layer doesn't support logical block sizes smaller than 512
bytes. The nvme spec doesn't support that small either, but the driver
isn't checking to make sure the device responded with usable data.
Failing to catch this will result in a kernel bug, either from a
division by zero when stacking, or a zero length bio.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07c41a149328a..30a642c8f5374 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2071,9 +2071,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
-- 
2.42.0


