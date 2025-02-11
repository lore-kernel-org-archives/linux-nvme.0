Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E0CC0219B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1AiaIP//M8WqD4dxy7fDutkXfjVTrFqsAP5JrCGoW9k=; b=0K3OH7lgDs5PwU
	7mPMwBxpBqi+5xrEHV9AGRj3uqoc1oPvXkRZkCd+WlAldoOGX60NhQryFU+G/DUHOGtixiM/aHCez
	MSh0/qptzoDFLckSOJaA2lzsj0xcS2rLB2nBXSfwKrtpEz/pCWyadpAMCfSVjzPnGEDx44tVKj+jj
	XeNxRMFyhHnbsnC2E4cjaOaWtJ1juuEYPEhmAYcUvt5EmaitmoXixZzAs1ifu5eoRYiqKGsnYWOMi
	EdPtzMhqbcWsFMGmTG9aU6IzpBNpQkqaHqhbMxSnw6p3fqPrbEQ6ah8RvXUY1JzMfKs9Ov6FQMnKK
	Js+2k6xnTKRYNme2vO0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thv8x-00000004rrK-111M;
	Tue, 11 Feb 2025 18:37:59 +0000
Received: from out-184.mta0.migadu.com ([91.218.175.184])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thuxZ-00000004q53-2JbU
	for linux-nvme@lists.infradead.org;
	Tue, 11 Feb 2025 18:26:14 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739298361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1AiaIP//M8WqD4dxy7fDutkXfjVTrFqsAP5JrCGoW9k=;
	b=l2XwgcrEvmmJ1ZWNybXTH+EtietGpZihBPDDaeJW6YKeYZ3JyEg8suYzPDWXcB4L2Z1LOb
	s/gA+VpQli2gp7Yxt2QZksOdvOcBFjbTb2fvya4l+Vv+aQOjjr+9+k5cPtOiavou98L2Mq
	piVTocwwAuwxjpG3Sz6/Ug/1TXVWer0WqfIogn4tt10LjoAoEenwOc8FBm6utEYEeaANBs
	R8A+3K0JY7BTtnwgMHkdRozYirf6SFU0lAbrDKBHnbDqpDny2T1cMZnD+DUp2K9MHnvBpG
	mOnnZiV4Mz1F6AsZrv53EGlhygBUZr5wlAuv7iblugB0OV6zWscMLi5wZ+fctA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 0/3] apple-nvme: bug and perf fixes
Date: Tue, 11 Feb 2025 13:25:56 -0500
Message-Id: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSWq2cC/x2LQQqAIBAAvyJ7bkG3PNhXokPYWnvIQkEC8e9Jx
 2FmKmROwhlmVSFxkSx37GAGBf7c4sEoe2cgTVaTMRjLxRjk5Yzk/KSdJ2vHAH14Ev+i98va2gc
 xJRZhXAAAAA==
X-Change-ID: 20250211-nvme-fixes-29c409c2553f
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=0gCZGHfdGU8//8Avd545jbaLhxjsJY7QoZdswjXKd9U=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq5Y3Bvk569yv+q2HP9FrS/HTrAyd5yOIbC2m8
 F8dvl+ikM+JAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uWNwAKCRD+/lBaCvVY
 DXtVEACHXlU9HvWPNeRFrQx56yTXHAmyS65cSe9sGDD2aZ3id4sg4mUfVrMCIADNXrniTC9ikhU
 DPx6dGns77YE8Jbp/EGsfju+3smsarCaaBHKgqZrKZNe0ZqMa3J+3hVp70sSL2TSwlZayl0uA8U
 joelBYnFTtsJy/0RXRFQpHXl66ipJEXnUg4EA6eb4yfrHuwNL4Ujcd1cs8kKxKdU9ZgiNIWgp2F
 eZXHv/MViEAG6/Ev7StkmVeKq09GcK1VQ7dDGd014s8t48L2ib3OQIomsk1UP8IJOkP0KtxtzDh
 +SEs9dmlee4rdwd076gLlLqDgdrPeA9vLyfPWKVs9ewUCM9zse6cxMYL2gCiMYEmrZBMPNPjjp0
 54r9mwDgaQK43Ws1ecjdivftoKBPqHcY6K7Y5dloDdQy7eIKp98dKmUbhrrfOgPloBVwY+6uySB
 QHJhCLvzaks9Rhiw3jPV422KnJUjo3PY6kkTFjdtyqByoZfRd6J+Mrf92MAAHrQSoLlIMJa3HwV
 RZRe1SXYDKQhb73L++J4dxU62ZsydgXJApThOaZm6UGJLHeadjT5iN8eI7LJcWuUOi6CtiaFRhU
 D41qjUFBPzw12RGREkoKYpx41lm7a0YeNmD4bBT/k1BzK2PjCp+Q3jiB9OcBxe9bV8s2dsRalpP
 U5mfwOU7wFHSn8Q==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_102613_724792_3D8E28D5 
X-CRM114-Status: UNSURE (   9.15  )
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

This small series fixes three unrelated issues with the Apple NVMe
driver.

* fix NVMe on firmware/machine
* fix a power domain leak
* fix pathological driver performance with random writes

The first two are strict bug fixes, the last is technically an
optimization but given the measured 200x performance difference I do
consider to be a fix ;-)

Given the early stage of mainlining for these SoCs, none of this needs
to be backported.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
Hector Martin (2):
      apple-nvme: Support coprocessors left idle
      apple-nvme: Release power domains when probe fails

Jens Axboe (1):
      apple-nvme: defer cache flushes by a specified amount

 drivers/nvme/host/apple.c | 124 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 17 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-nvme-fixes-29c409c2553f

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


