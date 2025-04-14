Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E12C369B8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=842GcbvcSzeMEwo7E+ZIqM1xy2u3vV5wOvSQUAandxM=; b=SVKqUNrQ/n/nBKn4g2++ND2J92
	bNndz6eE8J2p7oWRPl0Pe+8wsPMv5RMkPkpXKg4i5jgrC5dOfSw5hGviHUTZhhc54IxGTTcCxjQos
	V0jVfFdZLZJZkVr78OopKtFpODD9CzwkSilPK2LlGA4Q956s1rjRYzjYeZCupF6I+nVkecvrspAC6
	JdtIYJShOC8NaI2Y1196t8HluaZsh+yD3hNmSewaqPI7nOLa5VaIiHHFEh6Sz27V2Xs13HwHe6VG1
	Nhw1PB3JwFC8AvgB4eETRdUCUIqtkiJzfeaFvWPo9kyNq+d4l8+jt4tUc+/VAiieouKh3YN1GAt79
	GEuTFaNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtI-000000028pv-34qs;
	Mon, 14 Apr 2025 13:30:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jt8-000000028h3-0VTY
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:30:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D5D784A54B;
	Mon, 14 Apr 2025 13:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7E8C4CEE2;
	Mon, 14 Apr 2025 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637413;
	bh=+W9WbnTJ5R0nzHALR/B2SpleiwIu9eSewvN7yX8mA24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDPI70l//D3yb/wIW1pkRTILTO9wzC9KSfSXIgcdX0IICaDDDTgSm/7C6I6AS6YPm
	 qY5Ppi1UlZhMwFjD95haW9NRHlj+5AZ7NzqGAhsGqF23Ef6eLJBw1WeXDQBv2OotoJ
	 6urXoeaeiV+AnKFc377OsoCx3TpLl7A+D7nDwmbPUYeM4tKc9kz0hp6r04pah5PVNN
	 F+Zl8u4qmpxstyrN6HuoOWBu43H/PHTNPqxcHu35bd/Dl3hJ2M6obuiKeLNYb1MijH
	 LCI7btbCCW1XaxD2iftn9X2j+0ueN5rbsWKOX+btfNslY85gz5wKD+xi4JnrzzmoCP
	 uvp/jvHLqBiUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 07/24] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:29:40 -0400
Message-Id: <20250414132957.680250-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_063014_189762_3FEAD95D 
X-CRM114-Status: GOOD (  11.97  )
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

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f00665ad0c11a..e36c6fcab1eed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3972,6 +3972,10 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5


