Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997A4C76196
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Apr 2023 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PFb4Plo3qb9+fkTGNyRqxeD12rQEZ1x0aJUzNDo0i2c=; b=r4wil2JZ5q3o4XfTlwkvx+fZrN
	dWoWxTXNXF+msfNSs6AVvrRyQzTtKxipSCyw1O++F77NqLf89+qQXgM1k23dM+byWpGTc/abvGqon
	xU0ThemP89+WcKLwwTQZp3OEMT+3onSi2CZzi32/kd0fIb2afqqmQbBE6VeW+1iPjXjBCTvq6PqaH
	bMymP8mgHMs0DG2zPzDIAAlDIHmX7Dm7Z0Qo+cdqIuopNU9ymz/3EPWCnB+JSB4A2DB42Df05s93S
	87VtT7hh5TYofuaOXiuFiSVMO+wto83tllazlrao3j1IDx1aB2a3AWCYFws+RiNlbQp1m/s9E6NWQ
	sk0F/+1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piQGw-009UB2-18;
	Sat, 01 Apr 2023 01:43:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piQGt-009U8p-15
	for linux-nvme@lists.infradead.org;
	Sat, 01 Apr 2023 01:43:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DC1E562D0C;
	Sat,  1 Apr 2023 01:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA1EC4339B;
	Sat,  1 Apr 2023 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680313390;
	bh=zYVrXWEQFmTPkTJitl1+07F2lBqNIRNx4Xz4bW6f8MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIVIJNjIHpNnncHSK2GgInot15ZnI0hADrqXtqv9UIcLOpJCBnfkXs/Jkl5O4FeOF
	 Tsz1Am6HKlKJdUj23iJVFD2Anub/a3C0iW0rooAbFqg9lHZNQXHAZJkdfYNO/ZAbG5
	 VMefwSBbzptnk/DYVQzCbk4W9I67Cxwim8jH5yAANgffzc2GXm4XK0F2MBudTre0v1
	 RuIrYQPcfYWE+cGDqSUUxnt2VEevpeTZ5plKdYrp4ilZnA8ASIsKXvXZdwMiXqeZVz
	 GrT/MWDkklCVxP5GtS2b8SDF72g1wAEPC7ghEFAqLFMwScnWwu+qvCkN8DZWmDBIT9
	 G8xmGOcbH6Dzg==
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
Subject: [PATCH AUTOSEL 6.1 18/24] nvme: send Identify with CNS 06h only to I/O controllers
Date: Fri, 31 Mar 2023 21:42:34 -0400
Message-Id: <20230401014242.3356780-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401014242.3356780-1-sashal@kernel.org>
References: <20230401014242.3356780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_184311_630443_86D7F795 
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
index a95e48b51da66..82f3c7231a0a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3074,7 +3074,8 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (nvme_ctrl_limited_cns(ctrl))
+	if (ctrl->subsys->subtype != NVME_NQN_NVME ||
+	    nvme_ctrl_limited_cns(ctrl))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-- 
2.39.2


