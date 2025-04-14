Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799DCC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlBTBz0Kp9q/Msu+3WnedAgYtQjlEMHpqhp3IJuBgq0=; b=G6DXZaIwfyneXCLRILGwj3zqHD
	hZSxHbS8g0L7l1UjqsHmo0XI4uirY2U4M/tag5PC3zTvj7Bh4lkUi6PFQq4nADM2I6A1ebENR88Fk
	dPGkIdbrZE+jsQSpP68eflcv2dt+vKjVt93Y6SluuA5e8g+44CFRX81MkEIHjZMNLdfJXKNU2hzlp
	Fupv8jvNaJkGk/iHiglMdkoSaMGCXUrzwdJrBUe91qzrS2aGkxxM0nJdevr1J2x4KK7AQ7fRt7ww6
	3yEN91zK3hBbGt1WulcLBdKanXaVrQCib+0UAFs3nU5oUP6OvwJTM6MPOz9/0j1kc+anDtiWjSAju
	oW/aL2OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtF-000000028lg-3gKa;
	Mon, 14 Apr 2025 13:30:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JsK-000000028U6-1dry
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:29:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C5E8E5C540D;
	Mon, 14 Apr 2025 13:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6EDC4CEE2;
	Mon, 14 Apr 2025 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637363;
	bh=I+36j+CyOb8kFmQbUR4LMjxknVZjHJKc44tiTRjQpeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U30UE/KdpnCp0qxdlc8Ex2NNsJdaUqECM1x7QG5Ux11Y6qd9udy4yhip7na92p+wK
	 1WIWs9VyBg8aJshMrXwEujLFHpbRqxsFVccaqx1qs7z1iGIPUoAMlMVpoFqfUJQfPR
	 laCcHVbAw/9+GnRw9MQ0CoDnBIyte6A2Eysr1pnG+UTv9/iUy1hwz1bQ6kKCrE/iYP
	 yMx5ZSDViFJsK/Q0wkNvaB60Nji/ABvznztpm3tf1Nt+a1urz4g7s5bqWI3CORORRT
	 1RDnuOYSrW3z0IIQJBf5o/KSFVokpbEwZ8g/BNF7ljeO7a1IVSOghLXGV53vCJy2zs
	 CezPTpKe8lLhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 14/30] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:28:31 -0400
Message-Id: <20250414132848.679855-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_062924_486241_95EB5454 
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
index f25582e4d88bb..561dd08022c06 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


