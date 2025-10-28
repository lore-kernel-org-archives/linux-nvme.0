Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E276CCCD1BF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DIliWmr3IL7J0LyaCdi9lNYLpUVcraGRSL9pRbJBd9Q=; b=1NfxCfTE6+knzb
	kYf3wmK6zr81AXTY07vImzkjbDiecR/mgqXPT9Z+wVbcblE+7Sqf+vZCd4p3DHqHAzrpyuIYntNFr
	PT44gMS/LifjYXlf1WUYIV3mLZoAtmHNHKXriFn6cxYY210DMrPtSgwScWB0Qz0MhlwvgwRohKXYd
	HZ5xvWdVlG+a8L7+bAg8zl6zVW9e044WZDdAr0lDyMJEbgy3epqwBs/XS/3nrLggmnI75YI3F0LqQ
	eywOxHeSRh/hTYtJe8CMe/C6kCZqJ82JvTIuzs3elXBSj+rtqgLRvLlxE2AIM1BE81B5NyBDwbMa9
	9Zd0euxwjj3YUhSSOTVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlai-0000000GAaE-1dXT;
	Tue, 28 Oct 2025 15:26:32 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDlag-0000000GAZn-0XDN
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 15:26:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B78048F27;
	Tue, 28 Oct 2025 15:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DAFC4CEF7;
	Tue, 28 Oct 2025 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761665189;
	bh=3r7v1bznx5QjNt6k3+3hxpxHKtkAoMs7IeUHquPgrJ8=;
	h=From:Subject:Date:To:Cc:From;
	b=jbvCKjM7+D6EenQEeDFueRf0kmFHtWySvcbbTi+LdSvSheekTm4YGFGsQ0tVaT/Mq
	 wlezMIs11aul/0ay30vIuVgBJMQOAlH5MWrhuiAxkmxZ7CYfKUzIHNXvDs8RbF4P2m
	 OS4u67Pl3FKa6h05OS0KGNOM0BmSPfuTcSWMVk4Ku3hZiGQjl7qjumEsOMegKRHo3e
	 LZBoymmvw46m4M8vcZ+qJP+5x5OKQ4r6+91R9jcMx3YYAXiNiaRueioq450i0Bepsv
	 w5W171ye4AZ3aNvbFhsHTc4RPrX5ORf2aYEYkhaOW08DStBiD0UnLvKrBFBMooWWOA
	 vWh6iUWXTe+fw==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/5] nvme-fc: misc small improvents
Date: Tue, 28 Oct 2025 16:26:19 +0100
Message-Id: <20251028-nvmet-fcloop-fixes-v1-0-765427148613@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvgAGkC/x3LQQqAIBBG4avErBtQSZKuEi2ifmugNDQiiO6et
 Px4vIcykiBTVz2UcEmWGAp0XdG0jmEBy1xMRhmrlXEcrh0n+2mL8WAvNzI3sC2c8dprS2U8Ev5
 Qvn543w/0/SDwZAAAAA==
X-Change-ID: 20251028-nvmet-fcloop-fixes-4e57e82f1f15
To: Justin Tee <justin.tee@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_082630_189772_93D22704 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

I've collected a bunch of patches from the last debugging session. I think it's
worth documenting which conditions are expected in the cleanup path by adding a
bunch of WARNs.

Also found a deadlock in the nvme-fc code, so this one should definitly go in.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (5):
      nvme-fc: don't hold rport lock when putting ctrl
      nvme-fc: check all request and response have been processed
      nvmet-fcloop: check all request and response have been processed
      nvmet-fcloop: remove unused lsdir member.
      nvmet-fc: use pr_* print macros instead of dev_*

 drivers/nvme/host/fc.c       |  4 ++++
 drivers/nvme/target/fc.c     | 48 +++++++++++++++++++-------------------------
 drivers/nvme/target/fcloop.c |  9 ++++++---
 3 files changed, 31 insertions(+), 30 deletions(-)
---
base-commit: 77a4fe6a06e265bd94d2b3cdc87fb3cde877a05b
change-id: 20251028-nvmet-fcloop-fixes-4e57e82f1f15

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


