Return-Path: <SRS0=8cAR=IF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A6C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 13:59:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2D065100
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 13:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2D065100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XUm2anlTSbEUOs2UhdpQ4wKqqs2sZA7AegJJXvKF8oc=; b=CPZOvMIT5Vw+t13JDNdkd4k68
	AQt5Wb4K1OMa5wcU3yhSmRYH13KqoJhc9MLQd5QsPbkBLpY5g62A2M24VFOcbJqgmWKimcidvO515
	6aUy5XToZH7EU9NAECoyVS/NUAG7iSy6mYI28PoLLL+fNsdhUQzUzrPqw2BLxpDTGuZ22KmTE6tUc
	aC0JrSmpmTGSe3l5WOBuxC6yhwp1V4Wo0+T58rk6HN+wD2HulvnzAlrUg4B6hvBnVdDbLgLXU3qvk
	YAjwUIHkG5q5e/sq3jRsQnero0FCRApVQBzG4WtMxmL4d9Pic4JjORQxsqq8YAzV3zY/MS5G0nG+L
	5XmqFjUmg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lItvq-00AJLo-0v; Sun, 07 Mar 2021 13:58:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lItv7-00AJ6M-M2
 for linux-nvme@lists.infradead.org; Sun, 07 Mar 2021 13:58:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DDBE65100;
 Sun,  7 Mar 2021 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615125487;
 bh=HJNKL1EYo4IJZ8VAiCIfbvbPj8/kxKsluBcKcXvclXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XCuLItC+QWatNJuIJHwf9bc0DMD4KCSpd1uY6TcLsyJka+IgQp+7GYRrn885UZVlG
 3uYCZuHFUyhAOsElOsXBrDTAWVqwDV0h13q6troP9w5vQoJUIeve6jQASGxZAOUFtr
 JKYMYs1exCH9o+VQXi/ieXPyjpKEZo91Auh3OiEVi/H5U9VA177rdw6EhGosJxp3bu
 sKMTIOrMYCjcPnlnWYUqkPOd1nziOlGmuVDA+LhYdgFaztqoeZwNHI/yFOFI/2F6w7
 jLlunUKRtAXQRu3kuUnrS+gm/kL5bl6qy983de6AaRhUo3z/3OT/TLVcAqf+rw30q8
 v9/RY+69OhhOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julian Einwag <jeinwag-nvme@marcapo.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 5/8] nvme-pci: mark Seagate Nytro XM1440 as
 QUIRK_NO_NS_DESC_LIST.
Date: Sun,  7 Mar 2021 08:57:58 -0500
Message-Id: <20210307135801.967583-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307135801.967583-1-sashal@kernel.org>
References: <20210307135801.967583-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210307_135810_164308_5E16905E 
X-CRM114-Status: GOOD (  11.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Julian Einwag <jeinwag-nvme@marcapo.com>

[ Upstream commit 5e112d3fb89703a4981ded60561b5647db3693bf ]

The kernel fails to fully detect these SSDs, only the character devices
are present:

[   10.785605] nvme nvme0: pci function 0000:04:00.0
[   10.876787] nvme nvme1: pci function 0000:81:00.0
[   13.198614] nvme nvme0: missing or invalid SUBNQN field.
[   13.198658] nvme nvme1: missing or invalid SUBNQN field.
[   13.206896] nvme nvme0: Shutdown timeout set to 20 seconds
[   13.215035] nvme nvme1: Shutdown timeout set to 20 seconds
[   13.225407] nvme nvme0: 16/0/0 default/read/poll queues
[   13.233602] nvme nvme1: 16/0/0 default/read/poll queues
[   13.239627] nvme nvme0: Identify Descriptors failed (8194)
[   13.246315] nvme nvme1: Identify Descriptors failed (8194)

Adding the NVME_QUIRK_NO_NS_DESC_LIST fixes this problem.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205679
Signed-off-by: Julian Einwag <jeinwag-nvme@marcapo.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4a33287371bd..2aed3b066b85 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3235,7 +3235,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+				NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0023),	/* WDC SN200 adapter */
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
