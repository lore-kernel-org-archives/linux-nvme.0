Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8CC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 18:16:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A9A61220
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 18:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89A9A61220
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w8SXwluvnftokouhNusEDuQ9l965fakiYdRXEaqZ+LA=; b=pMIa6XkCgN+KBEM//JH900C3P6
	Nomq+BJdZnxL10Koc3KLCX86POw2CVeAVy5RKqND56ivt3F3e/+61nx+POTNVDH3yIgFy3eh3NKuA
	oMrmKgwNsAWGZBZN8vgloTnreRQ+GAqHiBnNKQHFG1f8qi5arYtbgwZJinRrhm1bWgWo+BiK2yqut
	dSGCrzue/rfoSGiBAjUokMIcKwd1I0Tgy5ocT5dmA9cemL+vQpXRVoOq9dvfikZIWGS4iJLc1J56R
	wup5FnnVaaeNLn0aYKBShRpTmHKnq0jGLYtWmlAGI/434IjDrXhKX3L2dw3oZHXkbCTNTlq/osa66
	cHXrtfVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mihHq-009lnd-EX; Thu, 04 Nov 2021 18:16:30 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mihHn-009lmD-Lr
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 18:16:29 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 97B505C0189;
 Thu,  4 Nov 2021 14:16:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 04 Nov 2021 14:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=w8SXwluvnftokouhNusEDuQ9l9
 65fakiYdRXEaqZ+LA=; b=U28rfx9+l9/4rOT0qSHPgOSkSlloPz1exkNbkEOuQl
 WXImsCRHuJS9utWAJBIYFn3TmJ5PBYfd1PZ3EatlbR1/BD2EFEIiBBGM4gI0uBkt
 OvA/E2L92OvBnyxf3oUK87FTmnE/U0yOi/Z0X2XXv5HqpkyonnBFqJEThqNbuCmS
 yXK7QxU59PGq6NCnUiV2Ef14/NOXFPR4tiqxCSBSbAfCHBS/LTPlPGg32VKJ94su
 pfcpIR4UdJnRuy/aK7ydB0jp07iPRJ2VkNvHJ/zJsZBWl+C3uW9VQWGQAetqkoSi
 HSKz5KeS0YNgbXVHnXC2zo4MUh8yF7Egpul9YespX5RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=w8SXwluvnftokouhN
 usEDuQ9l965fakiYdRXEaqZ+LA=; b=MU+jO1rqTbu0uKtQgR9/YhVZeC6qL2tqd
 421R5c+BygvoF/gm/3tSKU+Y545x23pL86IOlUKYcwSvGsOC0C7uIJ1QtObhsII7
 Y2781RvsgSg0bP0NESX36pQUOT61mqfktaISM+slacOC1kiukSgYPNrUz9+MHmIU
 evGe0HUF/mdmLsl7yHEs84WzUPJ4CysnZ/SNNZppJOmcum77PxxsxCxTcV9zlCS+
 OnX4mPOdpToVbYdF2tmXJMvQWCXtBBFc/VL/zxT/6FmLfEJRQ2yVbnP16qwTsUQi
 F1ZUwubs3Mgf/8F/QCmgNddCgk4rE0usOqgld/uKBmfv8GFrVlB7g==
X-ME-Sender: <xms:dSOEYfzZrHeL-8cu4X8Qz8jnADdUiKjc5k9pZ7kp6vhH-_7POKHg8A>
 <xme:dSOEYXRUtwR_6ga4sa7gW07R5Uwtwx7DREttvHeuNBP5RMsF0AjaLok2CuvmMfIfD
 kT4c7yKiImeZb36plU>
X-ME-Received: <xmr:dSOEYZWFPyJEXdDTQM-tgFVEGunip8-4j1-QFAFa3QneGNElFrrPjCWNJu7-D8Pq9DexFSItsigY3wWOFntIl3Gmf1viVVDX-dolNNqGsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeefveelvdeikeduueffteeggeefhedvffffjeeuueeludehvdegjeevjefhtdetheen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:dSOEYZgqT0d0BNH_x_Mhs0DApjGzczegnFGy7D6XW7uZcYlfjsWEsg>
 <xmx:dSOEYRB3Xc31TxZ3I9Aq8f71xKcZZnGb2n-qrf5eGg8_S0oFviLZsg>
 <xmx:dSOEYSKuao2SOSO0uxzZIixb4e0__BJgjOjgfSbHh0RsZyLnGkCXoQ>
 <xmx:diOEYU4YmoNg58WLRhb3hHRrdRVCz7zBHK5ClkAdbhP7Y3MLJU0GAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 14:16:20 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH] nvme: fix write zeroes pi
Date: Thu,  4 Nov 2021 19:16:18 +0100
Message-Id: <20211104181618.864157-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_111628_015326_F01897D1 
X-CRM114-Status: GOOD (  11.59  )
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

From: Klaus Jensen <k.jensen@samsung.com>

Write Zeroes sets PRACT when block integrity is enabled (as it should),
but neglects to also set the reftag which is expected by reads. This
causes protection errors on reads.

Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
not check the reftag).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3825b596ca16..532bad4de025 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -914,10 +914,15 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	if (nvme_ns_has_pi(ns))
+
+	switch (ns->pi_type) {
+	case NVME_NS_DPS_PI_TYPE1:
+	case NVME_NS_DPS_PI_TYPE2:
 		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
-	else
-		cmnd->write_zeroes.control = 0;
+		cmnd->write_zeroes.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+		break;
+	}
+
 	return BLK_STS_OK;
 }
 
-- 
2.33.1


