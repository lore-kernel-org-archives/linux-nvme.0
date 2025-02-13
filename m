Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B1DC021A0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5zz5Vi8NhvlgxdDqN1j9JvIx+D1f7qsFmUg14o5VcyM=; b=v5WoCfapj1b6wR
	BOHQdwNofE801isOLGfVkHOjlyRsKuiB2RMduH1unbRHTJ3nomAXhwOfTyb5lIcX/62eJxG1zDWee
	lUgLd2zn6C8N4C6EHAl0+6i4u9ShtS7QADUTim5baynngnITgQK61LV9orVGynLKasTP3azZfOxq8
	V6+L7iFgdyGaeC7hwlsBFTgxueisfZQiOfQNEcfbryQuvxbGMIlutU0IOSSuBLmkQxnl39JH5GcDJ
	e5QRvTyR/iIUH3dB2pcGPesXkFiB11+lGFTYf8eDjysGTqyA3X6JQgDEx/PHyxZPMzcwVWXjQbzU1
	gLJqSJS65E/oy3ogfUsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ticGy-0000000Bob4-2xOC;
	Thu, 13 Feb 2025 16:41:08 +0000
Received: from out-184.mta1.migadu.com ([95.215.58.184])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tibq5-0000000Bhwq-34uo
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 16:13:23 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739463199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5zz5Vi8NhvlgxdDqN1j9JvIx+D1f7qsFmUg14o5VcyM=;
	b=xmqFW3S73yV9k2hXBaz1jmd9GR8C0I4u1XcUWYZacyueuKPlh6lzQiJLSqcoQyBFUIrIlh
	Dm2UkeUANOSsgqpKgNdyiiq0mzeO4bhtO2jDTLADJeGAuFlQkQ2Km/h0jpnTzrsvUTGc9E
	0oJgXuI01Fyyrj3G7Opeyod9DqTwKabbMWegx2Sle41WZ1GJ0t9OaV9v1OrnYDCxq6KGx7
	FXyt4HXCvZWq80buyE9nE8LrCW8mNy47FQiVjFRkYPErQovSgOJRcywkX1sqiNtZpWdN8L
	CkflSm2uCM7gU70LQW1D8DSI0pX7XLnIcpzPHE2T0Sz2Z5+lQkbLtN4BwVsvxw==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH v2 0/2] apple-nvme: bug fixes
Date: Thu, 13 Feb 2025 11:12:57 -0500
Message-Id: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkarmcC/22Myw7CIBBFf6WZtRiYFiOu+h+mC8ShnYVgwOCj4
 d/Frl2e+zgrZEpMGU7dCokKZ46hAe46cIsNMwm+NgaUqCUqJUK5kfD8oizQuEEah1r3Htrhnmg
 r2v48NV44P2J6b+6ifulfTVFCioPRx0tv7WA8jSlmCp8n8bznCFOt9QuVA4HtqAAAAA==
X-Change-ID: 20250211-nvme-fixes-29c409c2553f
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=yNLB3sgdS87xHQMciWaz3AVPMGZxT3oXuB08JT+8bcs=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnrhoclU9zE6FzM7a6MNsHsid/IfbNcuWpFSzXs
 h/awtBNEIKJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ64aHAAKCRD+/lBaCvVY
 DXb3D/9MW2bY18CKt3Ns5/u+IgnetmV4ng9f3b1f2s/abaXSeEJ3uCVlvCax/9sY65OjIX2rUkO
 845pl5rXfS6UjInZ9jkzq8IM59rg/eEVoo5xz+lUIiYNSXX5nknE2SjlqkIlO1N8D/O8Q2t9drW
 qGqHLPXCiNihPp15THNsL9d7h36Dc5yCjWFgg2FxqzF/pTlcMWEkL79nhL39FEYn/BvR4HrYQw4
 XMKL9yQKJjYExb+vFys243AAUXSb7vDHrOnBVjB5k2/cKvO/1zExdbY+Nt1uiTG3ttjOjqw7pjO
 PmtkxY9cb7WCJukbmrajUonkD5Gx7heo4Uc/OMWccZVKOzVxT1eFia9UYNrVgAaiTURa4a4XAtQ
 AfCaWpwjdjkIxzg1Ku0M4OP4jFMEvsRPeWSIiiUD5T/ljG8uCO91ih8LMRiLO5iW1AizeiiXbrr
 rypP8WdNoERXJGlcQL35TtieDwReYSqzdn7rbI5+4mnujEaGOuqZNdPgkfk3jqDgcs2ZWAZC1A+
 bt0zxfqlvYXR38IFt5FJ9wGEPVmsF/oAWSGmNxfwGTLOzPL6MneP6F7rMBJgMN76BsKdmQSBEDj
 oN1Izd42t3/XUiGLe8bxgTL7SAR/dKc87j1OZzk7eO8rJSMM7JAF1+HrgznXIRNrpnybM8k+QSy
 5wmEGez3GvpeN6A==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_081321_927459_47338DA1 
X-CRM114-Status: UNSURE (   8.19  )
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

This small series fixes two unrelated issues with the Apple NVMe driver.

* fix NVMe on certain combinations of firmware + machine
* fix a power domain leak

Although these are strict bug fixes, given the early stage of mainlining
for these SoCs, none of this needs to be backported.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
Changes in v2:
- Add Neal's review
- Drop cache flush change.
- Link to v1: https://lore.kernel.org/r/20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io

---
Hector Martin (2):
      apple-nvme: Support coprocessors left idle
      apple-nvme: Release power domains when probe fails

 drivers/nvme/host/apple.c | 55 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-nvme-fixes-29c409c2553f

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


