Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AA9C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zC4LX06nC4zgnps499oPcNtACYI46glYt6dg2nJqyK0=; b=zK8Tg3zjg1C0rwNbIwK8dXMA4q
	SuViELt7vCL0JBONLzv+08kSadu19ssdjUbgwxPrKOjsuS9pENxjrZks0KruakDQH/ATJzsOtIuzF
	iSpzIUD6cxFyvHmbCZ/IztKXV/+DnUvcHJXsgpVPT7GrJnJOux2V6mO6qxlt7fDAr8ck0fQdjUom+
	OBVQK8B13fCWjUFHTt94Y4opclv9+FGIfxiSJH/0AMs4YzO76QN7x3KJEKsILDmu3InBymnEZ1x2W
	Eqi3d7w1WvpLuW/3Wd4qXMeXYWvVu/LPGijfCGQ5dx4nTnnd+Wcl+Z7OlTnVhG+N/zdeZCkGNLUIr
	igOjuD0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEXn-00000008vAl-2TL7;
	Mon, 18 Mar 2024 15:04:55 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWv-00000008uYG-3ka4
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:04:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EB8CFCE0A5F;
	Mon, 18 Mar 2024 15:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD600C433F1;
	Mon, 18 Mar 2024 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774239;
	bh=gBDvvt5vnVoBst4TBKZXICyR2Vp6AS43SrdnOsIFATA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ba1Xja1FpXBjVeQ4C9Ywo1UXpC/Ub0PMjrqY1cJdJJrqu1OECgVk7IgoTrYhxmxSX
	 rhsLmYTdk6Ec4buywIFqIEvI0QCXswMt2rijkoDeGG8rSOYPXZ0Edc520hhMKYkBAR
	 K4h1cWoGtf6jUQaum4A0XmPMw6ofdyvac9zsuKTD+wsVxZ8QgTdULdv1Z5WPINq20W
	 AvgQAILAiD7p/IwQlk344C+P7tShwearazSbYkC08jnRdAPtPd3sIYLoqRIP2X25ci
	 urH1aUo+SEwnorGieVE/kFIe6WvICeZuyTdR2BHb3GfIbkklcrACMeE2E+1JQyTIEN
	 WLaz1mSYlbTsQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/17] nvme-target: do not check authentication status for I/O commands twice
Date: Mon, 18 Mar 2024 16:03:15 +0100
Message-Id: <20240318150316.138501-17-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080402_584897_85AB3838 
X-CRM114-Status: GOOD (  10.16  )
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

nvmet_check_ctrl_status() checks the authentication status, so
we don't need to do that prior to calling it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6bbe4df0166c..1d1a7026e817 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -891,9 +891,6 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_io_cmd(req);
 
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
-
 	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
-- 
2.35.3


