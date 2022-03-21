Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62262C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5nQpEZL6uoaGwoqyCOgh7yCZkXCs5xzAO7/dEUKTT+0=; b=tMrLxaxFk630C1qk/skQ6vsows
	aJsAd8bvzIWYwvoJKounvf7jSGwfziQ8Gid7bbb2AZr/K8leF5b34IA3hDJWiJ5jn7AaIm6rqTEo8
	vjmVYX8gwk88dxRb8jNHD8D32g/klg4I/jNa5qHEqEIfjbreeAfQ9VVP9i/+rQoFq//6jQk9hHeco
	IKc9CShdc+D9dF/q60olCT5GGU8bo7tiFn2D01sa5UzIRY6B8tTqmr9VkewNcVkYBKBXW+W5Tr2Vh
	Hw+3tHiok2grNheY3QPFSCnXNQ4MCh0hk/JmJCreqo1Uf4NbBnBUlkbzmKU5w3PzdR+buGcmIoi/K
	kI2Q9QuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWLNR-008TqL-Eg; Mon, 21 Mar 2022 16:59:29 +0000
Received: from wout3-smtp.messagingengine.com ([64.147.123.19])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWLGZ-008RAt-5H; Mon, 21 Mar 2022 16:52:24 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id 8343E3201DA2;
 Mon, 21 Mar 2022 12:52:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 21 Mar 2022 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; bh=5nQpEZL6uoaGwo
 qyCOgh7yCZkXCs5xzAO7/dEUKTT+0=; b=CAtQijKbAa1HWvg5Tpk7zi2d5FkuFF
 aLTNGI76WDQ22B00KJKLI34LbvcaU1EIdqWbga6GcEcquNCAtkIuNQnX1gkJ0CfS
 qeynsyLAicgu0w6mh4UFOfN4I+UhwfFJ6fQ/dGF4xV1lCG2CeB8L3oXexxLX3MTu
 cFsXC7a+o3WyWjek76mwkgfXU4lLpPkcRT3U4zEk+V+aYop+0oDBoyXy6oXm5Jx8
 CN75O1hNTC0zvOKD+4Gn/4VmVnzKoa+5X+2lNikK/I/AQutTfItUqs3hTJF6LRo9
 zvrtvBug2La3VEmVJbGH2BYeE0yKN2OvU+augQNt/FhqElCdFoxaAL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5nQpEZ
 L6uoaGwoqyCOgh7yCZkXCs5xzAO7/dEUKTT+0=; b=E9MPCUh24viES5QQonaStG
 Emdx3GaIzqVI3u1pDCc4LgmYtxl6uSuFQVewDbo4g96i/1oEtGVwFHToqzhEXq5d
 pB/oaaimaAOP6G80vau2wYTzqllX1aS2GOzf+KvyJJ+MH6EBMAy/WcSLEbgjcQyG
 KQwCWEI9v0vLJAHDRN5Xmt8yjxyttI0VX1ZRMwdKQc5loImHSCA3h3jFsQU8jyt5
 GZXH4ofkItVZUff2bF34rt21WcQheTlId9TDDPKi5GR/Z22LmeiqSEdKErISxFSk
 xmunL5eQz6XaZNcMv+1hhlXEsBa61MwIxsOKhRUfnx5OIL9ekpR6CrEMuFYIfHdQ
 ==
X-ME-Sender: <xms:RK04YiJxzI8qj4NwnBdZ-Y2IHsr8Vdot6DC_JM-rzbnaT7ugDzxC6w>
 <xme:RK04YqLT_vYLuKHsiVURFTfTRGGv7uHXKe63__Voq0yFXYMqIVN7IcNgs5pAfRyzk
 AHlCRdsGC2sjLlVJas>
X-ME-Received: <xmr:RK04YisAXKkNkTXFZe8x2mIXjr2kBGRWWWGd9FgdgGCYWtTVgF_yS_BWpL_cVmzjpAdZCuGIGiV0yl4vR7IJ_GJ5Y4GhDJtCcRnRKdDIZbWlI6oj2nj7BWaSpGPpDJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:RK04YnYg2nr1hJNOWlPXTMUks-2H0efnzclxBsnIalOBIBQA_1qTmg>
 <xmx:RK04YpaaFcV7Of1hkB4lnLh9-nBO1iQJgu8Lgs8zvp5rt0OQMZzJ8Q>
 <xmx:RK04YjAyRGr2z10e97ukpIcBxnEyiNVKUE9o1xMWj0j_sAYE78mztg>
 <xmx:Ra04YtpSkRzBiptfuiK9vZ2u97Ex7a9999tVQBOgLCsaivNN49o85g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:18 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/9] nvme-apple: Serialize command issue
Date: Mon, 21 Mar 2022 17:50:47 +0100
Message-Id: <20220321165049.35985-8-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_095223_272756_29B56452 
X-CRM114-Status: GOOD (  14.42  )
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

From: Jens Axboe <axboe@kernel.dk>

This controller shouldn't need serialization of command issue since
the SQ is replaced by a simple array and commands are issued by writing
the array index to a MMIO register.
Without serialization however sometimes commands are still executed
correctly and appear in the CQ but never trigger an interrupt.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[sven: added our best guess why this needs to be done]
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/nvme/host/apple.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 587d6c7014a0..a4193429564e 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -292,6 +292,7 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
 static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
+	struct apple_nvme *anv = queue_to_apple_nvme(q);
 	u32 tag = nvme_tag_from_cid(cmd->common.command_id);
 	struct apple_nvmmu_tcb *tcb = &q->tcbs[tag];
 
@@ -308,7 +309,18 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 		tcb->dma_flags |= APPLE_ANS_TCB_DMA_FROM_DEVICE;
 
 	memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+
+	/*
+	 * This lock here doesn't make much sense at a first glace but
+	 * removing it will result in occasional missed completetion
+	 * interrupts even though the commands still appear on the CQ.
+	 * It's unclear why this happens but our best guess is that
+	 * there is a bug in the firmware triggered when a write to the
+	 * CQ and the SQ happen simultaneously.
+	 */
+	spin_lock_irq(&anv->lock);
 	writel(tag, q->sq_db);
+	spin_unlock_irq(&anv->lock);
 }
 
 /*
-- 
2.25.1


