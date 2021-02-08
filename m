Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F16AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 17:59:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE3464E28
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 17:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE3464E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nzfs1e5URqx5dtJFUJ8H7qZx4c4/qpuTnsVADdQGJ3o=; b=VXvk1Ug8WRMfOtJGlD4MlYp65
	WsJ9Ct5JS+twEoHpuo8W0KA75c7z3bkGhqJcAeqKIlUlUkeLV360+2kBh0AXm6SsENN024z66hqwW
	P6pDoExz2mQZMpMcjwVwnu59C00mzbqq4u6WfhArzIFJGwPup/xz+31vyWNwCvyIWawGKJH3vnaoh
	faX431mj5iJE2hG0ud9NQ1ivsIYdFsOLY3rWzL1i4YSUhzAsVF6hGKAPvhTslNsQYcQCOlmv/nkz1
	Dj1gzHl1C1vsnvBvtH8hkHx34rx29uNquZcp3O8QObM37NXEP4jnBE9V3oPGB4UvzYCxaYHcbaXeU
	treLsds9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9AoK-0006vz-TV; Mon, 08 Feb 2021 17:58:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Anx-0006iG-BF
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 17:58:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9D0764EB4;
 Mon,  8 Feb 2021 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612807112;
 bh=ZFoiftedcPW1T0wT4Qk0AvrsqyH9fxnYyCmPDwIS3gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hCCiDPcOft7KbepV++xCnu5o2o/CLzX7j7OsT+1BBonFDotnVv7EKpPrqZxSijXDP
 PvBJD6mXZluHCTw0okQM6+Mt3hh6QMJ+T670K54HCBrNVOqr3cZ4rQ4AMjpQIaAg4z
 DI6wK6/+lSMoDLOtfDOg7pdkF5xrhj28Q4ING04CYczTASpCC5l00DmKMorXFFr81s
 PgLWXGzHvE7InsvxEreQhmyWFue8qKdM9Qh2qZXyLdR2ohA3dI55LlQmF7Cne7ttYY
 kpJkxxfCuQDAKP7flAQJKC3euFlawbawOv0/0z5jRnsFdByqnv5GdcmizXpBY6i8T3
 j1FgrogcuyyHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 19/36] nvme-pci: ignore the subsysem NQN on
 Phison E16
Date: Mon,  8 Feb 2021 12:57:49 -0500
Message-Id: <20210208175806.2091668-19-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210208175806.2091668-1-sashal@kernel.org>
References: <20210208175806.2091668-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_125833_537301_0FF98B37 
X-CRM114-Status: GOOD (  12.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>,
 Claus Stovgaard <claus.stovgaard@gmail.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Claus Stovgaard <claus.stovgaard@gmail.com>

[ Upstream commit c9e95c39280530200cdd0bbd2670e6334a81970b ]

Tested both with Corsairs firmware 11.3 and 13.0 for the Corsairs MP600
and both have the issue as reported by the kernel.

nvme nvme0: missing or invalid SUBNQN field.

Signed-off-by: Claus Stovgaard <claus.stovgaard@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a3486c1c27f0c..59c4e124f5482 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3247,6 +3247,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1d1d, 0x1f1f),	/* LighNVM qemu device */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
