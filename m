Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F0BC021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9CoS5efnNhs2HIJLsLL5qOupZo4J7abKpW0xblWXuM=; b=T4q6kjQcnMcHuIWrLIU+AhxCaJ
	zcGodfk2nDf+B7fgFR2gi7Ipo0lV+coUywW7AGm6LVrF1KtEAMu4fjjYHTGCeKqdJwQ4WoxHRMAIL
	U2cr3zQUdWn9QzZFgVagfiYz3N7A0ClC1ENOdRwCLezlNG+F6EqvxVEZiBvpflmusTC0JBD67z0rb
	jGcKJIB1wZs49103NlEV81PEE4Vc6YJmhn7VR0Slyg70zdNsGA4CXj+ZUitTqewPxRMArEiLm6oob
	wRCNvilaNE+x/pSnxehsj371K0Vtfu7LoJ3C+UUDOMfHZUF5MpD6x9OVlyP/mzDzH5ptzcEkZH/tz
	6ytn7wCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ticH1-0000000Boen-3MNU;
	Thu, 13 Feb 2025 16:41:11 +0000
Received: from out-184.mta1.migadu.com ([2001:41d0:203:375::b8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tibq9-0000000Bhzt-2G9Z
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 16:13:26 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739463203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9CoS5efnNhs2HIJLsLL5qOupZo4J7abKpW0xblWXuM=;
	b=gGpvePThmOrXYKJAbCRDx3qCBrj4gqVY8GJCPsuAzYZRuO2FxMLi8uf6PfuYjZh/p0hB8w
	d/2tNLl1p75oWWUfTWvEY9xVGo6xUlz0zxXhPwLlWqAb8bOG1atqBBVgnlSDol1ZPCdZPy
	5u8LoQbevgUXTUydAUn+4y4kXMmhbb9j5zCVgh7DQ4I8Jt9YKxIOQW+orgpC8wHsr/T8YC
	IDWeGUz2MfJ5PXvP22N4Rpys1uJh0r75fOi2aHGeDsSM/t+2pweXeunjpgHpNUpQm3iQM9
	vXpQvB+0ZCVa46JfErURVZcu1cnuuS6cIwkhRhx6AvkhiFFU7wLPZ/XNv/0eCA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Thu, 13 Feb 2025 11:12:59 -0500
Subject: [PATCH v2 2/2] apple-nvme: Release power domains when probe fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-nvme-fixes-v2-2-a20032d13e38@rosenzweig.io>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=Cw3j5ZwF0ZpXtZjtAYoiFOLvFEyNrVEWrLNZJYk08lA=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnrhocGrC88sbMtudltmIRFFMhJDEYdLnbqgA1c
 B2attrG8DyJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ64aHAAKCRD+/lBaCvVY
 DcFHD/9HNGYW9xjWXZ9DMBfT4a7mVIYsL65qQMmrdbU/r6jbvPTceMAEFdvhzS4ctH/rfYJ5D1C
 v4roY6Q8CMsuo440S9NtnOQzj9z5RI8gy36qRvhwvKSlWedO/WoVmpibf8YFMPRSvHou3UEK+E3
 VRIQdYkwXXeYNeIfVegD4RcTzZ9D9CEUAF/32UShMSG1zLI433NGESgptfoNZL9Jn/lmgnmiKqZ
 +VMkL4AXhhzmjtdFp8HBTWOFAOSnR7ntWVgO4fv4jwVTRr4ffrM2O7rJos0773rG1lUgnv0llSz
 8yj3Rv5Ja5HAYpoJrtLKr9jnnb0vp4wH0jGytf57fhPiXnxpl+DzzFishxMPjr4CNmZ8XE/1mtm
 PzJm2AXI6HZyXRNwSGfnmN3ekgHkA5k4LWDIxo619yXqj7CbnzHMz8r5ranJeN6gwjNpYRjaYQM
 cxs8ii91su9Fpoj998qGLUmx0coUMuWkxzPpHyjRQd+u1cbIZ3M5so9on6Ta5HjiG5fXYLlF1pV
 ucy1ZNszllRF9RX0gWGsWlDs+f2ctZ6rd0G5Sv0ufOhriJcAe3hV2bVJWWPFuz96SbCGsr5JbMd
 UjemxVBWfWIy+oDu5qO9b6ocCf2dkNHWUmklDgFj5uQ9qorqH4mdpXQ+bYYNr5V47VqJgYAxy0s
 DScqoDigzuEODDg==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_081325_730562_7CB55D71 
X-CRM114-Status: UNSURE (   8.85  )
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

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/nvme/host/apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5e1c01a67ee81a36faa3da2f86a3a24fefcdfd6f..a060f69558e76970bfba046cca5127243e8a51b7 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1528,6 +1528,7 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 
 	return anv;
 put_dev:
+	apple_nvme_detach_genpd(anv);
 	put_device(anv->dev);
 	return ERR_PTR(ret);
 }
@@ -1561,6 +1562,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	nvme_uninit_ctrl(&anv->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&anv->ctrl);
+	apple_nvme_detach_genpd(anv);
 	return ret;
 }
 

-- 
2.48.1


