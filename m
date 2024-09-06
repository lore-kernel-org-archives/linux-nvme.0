Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5FCE7AE0
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hePdCLwGnpQKtvu3JE5TQUuD7qEXw8QN0rQZe6thuYE=; b=S7dW37dfCDOrKlC1UmY1jadPR1
	gaeKkIHKLxfyNg/ve19+xAIfEFo7baz2RiRBalFcuCiTxWrQXpjts6+Dyvz/PqrV59XRsLUunSRWU
	2QmKmpXLEJovbB7s2TB6U/ZPgA6or1IW4TFDSQF/I5D9Ie9cXhUUZmHvj6Rpr5Ut+uN9na1Rvm/zh
	NMsJ81YuEHfbsMEPdXzbGTtoxbWAQjls/pwfy2aQIIUAalx3QxJCiNYOz8PtKWtcJx30lBSOs4Gur
	Vdx44ArEeMcn336NlJ2RdC+HZRq6bo1BLUoMaAC1QLnFJVCeBpCyhfsqS1yiJgerrdl2Evcvhk00S
	CN22RKbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTPG-0000000B5GT-0PE4;
	Fri, 06 Sep 2024 07:29:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTF0-0000000B3VG-3DDk
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:18:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 884B25C107D;
	Fri,  6 Sep 2024 07:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEF2C4CECB;
	Fri,  6 Sep 2024 07:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607125;
	bh=OOPYqbMoScn9qJrlX7tZCfy3Rc7JXEYmfKLRAyA4or0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dIr68UFD6NFHLi34ANoPVLaDi3V+fygH1NP8sdmKxbwCSGhKGV2IsqF7yU91tHh3p
	 NqjLMDd10pl4/OKnyWKgn6WCgrF/JNTtQvaq9tbZBt1fzoFzN7sGtNlOnvgtvNbysP
	 iJEeXiGS1j7C64SqXMeKMGDIoWvobs36mwJEXLw6KBTB8mss2V4Zc/BUonzsCPZ3a/
	 RMdsZhNxfeyh06ZmkJnnKJgieKVqGL274YFq6IfNssMx7j1MnfXFE22d3IZuiv859o
	 qdfYClQi54upMzzTktzPrHmSbsr/GAN3yTUjW+z3uBhq7U9n/ZxW1RrzWseaQkynk3
	 vRl6nBjT9DtmQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/4] nvme: set 'failfast_expired' in nvme_remove_namespaces()
Date: Fri,  6 Sep 2024 09:18:28 +0200
Message-Id: <20240906071828.125614-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240906071828.125614-1-hare@kernel.org>
References: <20240906071828.125614-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_001846_875535_A409A929 
X-CRM114-Status: GOOD (  12.87  )
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

nvme_remove_namespaces() is only called when the controller is
being removed. If there is a scan process still pending and
the I/O from that process cannot make progress (eg if all paths
are in ANA state 'inaccessible') we cannot disconnect the
controller as the 'nvme disconnect' process will hang in
flush_work(&ctrl->scan_work).

This patch sets the 'failfast_expired' bit for the controller
to cause all pending I/O to be failed, and the disconnect process
to complete.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 651073280f6f..b968b672dcf8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4222,6 +4222,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/*
+	 * Mark the controller as 'failfast' to ensure all pending I/O
+	 * is killed.
+	 */
+	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	nvme_kick_requeue_lists(ctrl);
+
 	/*
 	 * Unquiesce io queues so any pending IO won't hang, especially
 	 * those submitted from scan work
-- 
2.35.3


