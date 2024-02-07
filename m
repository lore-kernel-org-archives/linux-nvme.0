Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F308FC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huQPf4lNYMrqeuQE2QV6OYHGExKpYhmvMYr4xZttrr4=; b=Epgp1F9TapIOAjToCukCSbsiK2
	icRcSbPBDt6Uz74TaQCps8cNJ+PzbK/9uOmcB7J7RcfVw+R2MHJ5UfjmScpo1/5mqR/EaXHGQr3Je
	xuQ3kaPOwK1j7gAXxx0NA7Yf7fR7/zInHNGjDl7ujBqsU7vXSzIM2QGxfm6l6lurU5yXR4fl6Dh+C
	HpwV7gv+2o51O6L4CxIOHSZWro/Au2IG6ffG7F5OFwD5RB7xZX3YqdWBUVKyqd1DR0eU55lynji24
	oR/292uSUvTW9du5Fsh/APgm5bnxm7iVGPt13JeEJI5NZvSoRO52FeSs1Vm39sU2X3VNkrQ9GUTBq
	GGqWQLxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQk-0000000BsfK-0aTa;
	Wed, 07 Feb 2024 21:26:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQh-0000000BscZ-0Vw1
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=huQPf4lNYMrqeuQE2QV6OYHGExKpYhmvMYr4xZttrr4=; b=g92fvfj03rI2Tt8gkpRCfSU1kA
	Mf1H4koHEoFSJ9XE5qeGqTvuchVbtHXy8fPOCwCxlVl5xN4m5Rwd8RUUbpg1FMzp98H+NEVfOHFJ8
	IvWkVJ/hpaXBGzj+XHSubvcYXrv32MiOZNeDldiCLFEu7WeOZQYZXsiIFnsRBYnTvCM32z8Rm/Xd/
	nvpGMOtojaLBY6GVNLGZ7kMmBbSuNv6p5KKyCoDum+4d/7NWwUX1MiI94YUBq+zwuAy4Gm1sLGxtQ
	5VmOfUGgVcPEwkaIGGM2dGwwC1SKSvIeEZqA7xgUzCpjPE4n/dC2S4e09hDx9uPdyBhJ5oaSwyOkr
	hAijujQg==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpQa-0000000D83I-2k5p
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 88C51CE1B22;
	Wed,  7 Feb 2024 21:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D17C433C7;
	Wed,  7 Feb 2024 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341153;
	bh=0m736HT5x3zxAJ7MsSNWQ+HMziYNADUNf1eL8O+UpdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwX9Yfg44symYasP93e11GMzd8qkxwiyThAmewD5u/yDkoyT6SCn/8WqV1fw5jdm2
	 Kwua22/7dBnKPNd55fugb9hpO7HpOeKWyBziw5pcJ3j+UIF/6LrbEFRnsO1liZJxOW
	 fC+GdahMOzuZMWR0tkwh9sJLoMpji0gm+PSgdlws1bZ8daFXmD+VwCCTnw5zzFNi/v
	 zGxpI0tHUwBUBHU/iHqOIm8oA2XA/vIRmrguB1Thf7Qgfx2B+UL8cpjGFK/0WVdecH
	 0Ix0CaLOih6az3Ro+RDbMOwK5kXdE1Xne1+P7WiMlGykQoFfE14Prkg784CySEvqdY
	 MZdhvMEMtA0MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 23/29] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:24:48 -0500
Message-ID: <20240207212505.3169-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212558_501859_E5953F7D 
X-CRM114-Status: GOOD (  10.81  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit ca121a0f7515591dba0eb5532bfa7ace4dc153ce ]

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c9ef642313c8..64c26b703860 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1069,8 +1069,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


