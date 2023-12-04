Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7480C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PM27PAfG7N3tq3PvZPp3AmMgg9FnExVz6vqiMb9KbAQ=; b=crh1//V3V/uYoj9bL6B8K5ypsm
	fS9/uhHHYS+DO/N7X5wuUTSfzRh1evYY1dpvwnFG3OXFhfMqdYp91nrqqk5vsXrtHQsxDJ9FLyVTj
	tCh5hlIDxGlB/qHwjDoihUwlr02rqd4HCiHrHQLxfJ22XNlyYzuk/ugZlsMkwakpN5dFqHCpowjhn
	vnFP3N3xT0nSFC0eEhPm+bCzIlBJfzNSQpB0ZmF+vWh4D5A6vtob2C1fyYftQYRXAEwctXyS1aCu8
	d+8nsYVBzSJQsQxPkT7dKzVyJAYAJrmioh9exUP8V+zH2qrS6EUCvMtTHctopI95tO5PRKGSwF3Zp
	SDRB1L7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFgU-005Zt6-1p;
	Mon, 04 Dec 2023 20:36:54 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFgR-005Zrd-2V
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 20:36:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 21195CE0FAE;
	Mon,  4 Dec 2023 20:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1256FC433C7;
	Mon,  4 Dec 2023 20:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722209;
	bh=0Uw/zavGDB+yqmgm6cBofHy/Obvi54hCkp2nOZFDehI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk/hZW9czKxT9As29akHpjgSKvj9cUL9EqaV+L5/PMXLVpzB2VP6mGItIrcmBkj49
	 4+m5fodcD+Wcdw9cRLOVB7iG+KuI9GFnK8gbqgEoh5K57EPIsCgvsythDP3LLuc/1z
	 PlyMZOYhe/Jgscluu7RCXuLlkAgl0dCBF5/sONnQSHDvB6ZMR2OZgmMPFrVhG3Fmb9
	 QspuU2CbyP+InE1fO349/Zz0D3sF03jRHmT9Kw6ZcR+Z6I6DVWnkQGhp9V1FXoWVj7
	 jvlcx/Iy5LpVfaTsEF6wfhgvnCKmndBzF6Mtbugd4c0/xScF2qsqu/TsfjB4IZtcl8
	 uzcUeTgHr4X7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 10/10] nvme-core: check for too small lba shift
Date: Mon,  4 Dec 2023 15:36:07 -0500
Message-ID: <20231204203616.2094529-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_123651_992383_C09903FF 
X-CRM114-Status: GOOD (  13.82  )
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
index 98a7649a0f061..8f06e5c1706ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1846,9 +1846,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
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


