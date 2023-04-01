Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CB2C761A6
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Apr 2023 01:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ztdmTdHSoW1FDZQNeXX3fyIeW3KH6hApPLMOsEBHFro=; b=Xu9XkhG0p1BxpCb/JeJziSyfbP
	rdvg26piyWMH7Db0eqeZOHTQ00eUyFDr2Xm+/FLwTGlsJK+eH6rJ6KRN5HOBkJ5ZJQjsFwA8CJI5Z
	5qPwOCDdl3P6pB1lag/aSeElM/fPkq1Rr5xqkHXYFoOeSwWN4duHeteoaOjaBHpHE/8qPKdZByNO6
	OTQIyYG6ZCeC5rgtTal+6itoSwunMjJXc0pLAdw+21VGumwB06BCbUbT4DTVUhwi3J8kaZkS1y6S/
	FIuXeGddOL7JZDOqPat29XTvwbZoiMLRIxkmv6FM1GmaouR5vAMkKZ22dYJC96U70hbZIt/jcXFUZ
	zmQpUq1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piQFl-009Ti4-1e;
	Sat, 01 Apr 2023 01:42:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piQFj-009TgV-0a
	for linux-nvme@lists.infradead.org;
	Sat, 01 Apr 2023 01:42:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BCEC962CE5;
	Sat,  1 Apr 2023 01:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC49C4339C;
	Sat,  1 Apr 2023 01:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680313318;
	bh=xJod11SsprX4EwkdikpQC51szxq+xH/GFQps0769JuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8xULYOWaQYJUZ+lV11B1P57CZFRaJtS2g63xIUFd69ogdHqt0wMZyOeBemktDIXM
	 cbNk/w+iBfyUD9lFJrM5jgBccsSPwQwi0yReavbEVgtOtiroI4mvfi340RlFvU8S/y
	 pe1U3xCr8fpSaD9F48Ww8xAStSMu3PPKNG4mfwZ/8Hxn6o3brLxMEvAiqBnXoRAQ+F
	 +66SQpZHMsaWlYXcCk2xkiUlqCf5YHV7WRCZnz5o02P62cA0nTJWrSeJ/4i/FBZIlf
	 qT5fB9D0vIzLZKbUcnw/6tSTGlhAxkks0xSHLDNbobFI0RDqlUQ5AbFQL5QB8fcs33
	 mIcbtKKCnTbew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin George <martinus.gpy@gmail.com>,
	Martin George <marting@netapp.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.2 19/25] nvme: send Identify with CNS 06h only to I/O controllers
Date: Fri, 31 Mar 2023 21:41:17 -0400
Message-Id: <20230401014126.3356410-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401014126.3356410-1-sashal@kernel.org>
References: <20230401014126.3356410-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_184159_271386_D9DB447F 
X-CRM114-Status: GOOD (  12.23  )
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

From: Martin George <martinus.gpy@gmail.com>

[ Upstream commit def84ab600b71ea3fcc422a876d5d0d0daa7d4f3 ]

Identify CNS 06h (I/O Command Set Specific Identify Controller data
structure) is supported only on i/o controllers.

But nvme_init_non_mdts_limits() currently invokes this on all
controllers.  Correct this by ensuring this is sent to I/O
controllers only.

Signed-off-by: Martin George <marting@netapp.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 70b5e891f6b3b..a8ad9c9fd2323 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3106,7 +3106,8 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (nvme_ctrl_limited_cns(ctrl))
+	if (ctrl->subsys->subtype != NVME_NQN_NVME ||
+	    nvme_ctrl_limited_cns(ctrl))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-- 
2.39.2


