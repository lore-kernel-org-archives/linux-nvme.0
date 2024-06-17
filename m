Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2BAC27C7B
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H13hbIMnkzVKEKHbOVtYOL7tzhfkFjyyQeqNMLM6By0=; b=ET9T3YH9ZMlFgdS/CtdUJ6qYry
	wTMb2SXejfCffHN3pJjLXZJxlQ0ExNrPCUPWjiTSmOchCojl8RV8gDKob+ctNjchCKnZG9RN5CuHp
	l6SG7Lb2WPBJQkWWcOyE+0Jr82OH3S5G14D6WXmEEwYo7AwJEoTvDFlVwLSYjJUrRQFK72QW25ZUM
	Rf2E788tiXNxaHypRG4Eow37gVQNp3GJLsL9uojE18f9+L1Ak4k9zANwGU6/NihXrQ2v1s6MVJ4KB
	TRTn/lzmfnfawtyRRJGCOnAdUyw/Xf2EUHYT81Lqyzg/Gofj3YClqbprZZxInn9zQ2HizlgyNp+FA
	PH5Cc9XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mK-00000009e3W-2HkW;
	Mon, 17 Jun 2024 07:27:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mG-00000009e1P-1uji
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 07:27:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 01B6660E74;
	Mon, 17 Jun 2024 07:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A32C2BD10;
	Mon, 17 Jun 2024 07:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718609262;
	bh=yZoG6eTWILAzqeffnT0C0zWB7g1IOWpMgWsDclFkM7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HN5itteExY4D/MWpycH5WPuDHzQ3XkqeA5XVd3fxK2dKMolpn8May/LH8J4qMmeAR
	 4vbvokoNknSDrFXDp2L/5LLY4HdgS4FzZFRkiNFgg5xkra0CT3YiZwOucj1hrDKEpP
	 L+GSHBq/QKTZQ7H6c5okd4fxnXJG4uqwroqAk8eWDNBaei+EHe8prZC7FVbvVLIRMs
	 LNbzSzku/XdJFDdGMxKSUAfv6YDel2V4OE9gvEonvLfHl4rTFi5r478O6UmHh5pnrI
	 eX7SQfIqgoMmcE6MNNVC9065giyc6NG/32i7GlW1JxZZM/HiNtlliS63UXUBjd5JZ7
	 SqdyDPVmZw7qQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/3] nvme: fixup comment for nvme RDMA Provider Type
Date: Mon, 17 Jun 2024 09:27:27 +0200
Message-Id: <20240617072728.134728-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617072728.134728-1-hare@kernel.org>
References: <20240617072728.134728-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_002744_602365_CFDAAAAF 
X-CRM114-Status: UNSURE (   9.94  )
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

From: Hannes Reinecke <hare@suse.de>

PRTYPE is the provider type, not the QP service type.

Fixes: eb793e2c9286 ("nvme.h: add NVMe over Fabrics definitions")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 27faae34245d..0993703f6617 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -87,8 +87,8 @@ enum {
 	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
 };
 
-/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
- * RDMA_QPTYPE field
+/* RDMA Provider Type codes for Discovery Log Page entry TSAS
+ * RDMA_PRTYPE field
  */
 enum {
 	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
-- 
2.35.3


