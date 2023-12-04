Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A074C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iw0AHWMoK+o/4UNYZfyzhcV6doIIOPEHyZTUESaAJh4=; b=LINojFKelCazYrDKiVB8/iZtd5
	HAgA5Q+fjRFaaIFgplMjDfpa3ov8mNGxn3U11oziaetIpcmhjKjwunoLLL98O0E5EKktjxFr9CqjN
	hA0V5wsJn+CpyJQE6TL8XVgAo0hy2ZGSswwD3jqvk+j7donL8dQquOqVG2uQZJuy7qSKjwgUMUuXZ
	qBc94YjxOVtn54Q5GNG8msGNDnLyVjXOPmzUnKxveZhTLMxIqRDdrlw41WaXdn1hyYAeyYpZIJnSU
	HfQU78kryVRqPcjZjeNirwj17JIod1Q5V2JjFwoEtnQm9ikRFSyQ1SDrOPzQpADkf56HpP2vs5IPD
	LJI1/doA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFek-005ZEX-32;
	Mon, 04 Dec 2023 20:35:06 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFeg-005ZBm-0t
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 20:35:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id F112EB81218;
	Mon,  4 Dec 2023 20:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FDDC433CC;
	Mon,  4 Dec 2023 20:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722100;
	bh=eGm+sBvt0gdj+0zTu3T2RywpCFcezynjcVTWXyJLyW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVXk2owoS/1lAMxzsrTb8Vvzoc0KNIez8bAtw79bv0ZhaDpsgFVg1Hwkas8lCZP0I
	 ZEN3vYcWvKktIOtDbZ8UCeKDBfO1FJzBMK8OBtiIkn03By01jKLclQUHKXo883KqgI
	 ZpHvVC1Vo5nrlnkHwcoAMl2T2WGaYyiRmHpM/wPi5uvGZzI5t8RwzChlU09iFIhSGO
	 aZMpk0WRRPyZQtvcAl6iVazG5f8vdUxXg8If317wIA142M47puQPZwO5K/+YkbH0Vy
	 k8wWp1+Nrt6c2SZkUBCxoKPG7YKTr6Id3DQQ+dH3C0EuJBr7s+Xhqx7nPI9FtD1t2m
	 8pN70Gfbw1BeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 32/32] nvme-core: check for too small lba shift
Date: Mon,  4 Dec 2023 15:32:52 -0500
Message-ID: <20231204203317.2092321-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_123502_582130_ECECF3F2 
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
index b4521deb1c716..dfc0e02150911 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1890,9 +1890,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
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


