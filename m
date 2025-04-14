Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98D8C369BA
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8OF3wipm3dAQT4/aeKZLVCLHBLHCB4zZqzRgZLTO6I=; b=VrnXY1PX6jNwFLu86YMezB7FTl
	qRabn3MLzn0u2Df9hLk5Dxv5AocI9Q6nr85rdtlxNcdxQ1aQpcNQLwngs7IWhBoSkFEuBjNaPtKmz
	3OkbSTQd3626WYNfrt0+YvBKQKuaI9yVSdWCc4sZ4qYnSGkGawb1tkb2o36ng+bHtdfZf6phceRQD
	Tr73TrQHyXdS+9Zmp3E3BHUcE7uASrsYcPgYUQmXuPtlwq6LaAKmptgyfN0BGNh4Eaq+c5/KSwYIS
	wMHGLoUvlxfX+zIDBtvEeygzAGNaNEuhSrZyazEDSi218knzuivuM7YRpH68aiYCc+1SIeSblvt+a
	1d+FJztQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtL-000000028uH-0snX;
	Mon, 14 Apr 2025 13:30:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtF-000000028kT-0OBj
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:30:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 715725C559C;
	Mon, 14 Apr 2025 13:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F58C4CEEC;
	Mon, 14 Apr 2025 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637420;
	bh=NAmXP6hkqc7M65jevgVkQZLlEo8nyQbY85BB8DmywSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sncKg9e3w5Trt0nMWNC/jUH1KS7+WvLOEhAU/WXitGGrrbdbYoPeZmFvGqnuHd7K6
	 X3+PmLBVUri8WIaNWjaD64QAkv5l1JLuP0HmtIV9IoHoEP5MgY28TEg594j7GC4TsV
	 t0SZB5sWd5m/NDkNhcyt86gg0V7+wwmoOU08R2k5QaiRBPh4z8Ui+6TiQTzjDHuoQ3
	 GUmEJJWeNdt3xcWkkoPBIxO9Gp+ClkTQ5OdHEmhx2aH9tczM+hNLm4mJ3sJBaXE1tg
	 TL0Tg3PNGT+d4ilceaNJt2UXkTOCp/FljR0aqWN6bLhtDERkXjt8bYxIw9P8kMx7q8
	 t2eVfl2HfgRHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/24] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:29:44 -0400
Message-Id: <20250414132957.680250-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_063021_215447_17E1E4D8 
X-CRM114-Status: GOOD (  10.91  )
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit e3105f54a51554fb1bbf19dcaf93c4411d2d6c8a ]

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 32283301199f0..119afdfe4b91e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -426,7 +426,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


