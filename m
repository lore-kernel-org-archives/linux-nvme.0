Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAFEC7EE23
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kfxc1mV9lLHeGjjnzU47dlOiU+dbJhsczLFSCzW5ht4=; b=oJqKmGH7+6khBACFLxwOTKl6Ov
	6mREo74Il8V7epvbOG1I8zUG4Nf1X6PAUc4ebi6kSPY0yXqTA2MRGZ6F1quF4r+cvsocrALankph+
	rUQL5xwKtExpkL4XJ0FkHA78wLg2HLH1zix3XVfQOe3tlt3agx+9xMQLgpHrqzflh1aNDUrZpBHEB
	IuCp1Ad19xmraFJ8mM7pj6V6G1mW+qkJNRlNvsU8CUzPng960nlcnhX3OJ4oXuvL0ahk8BOjOxhQr
	iIT/GzVFIF5zpHryBh7PW9aMJpZjWC6UfD/tlhafzeEJxC8Ey7QpTEEt5Wa90aW9eZMC1tiqoWvUz
	rEmlcWeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4M6j-00HamA-2B;
	Wed, 31 May 2023 13:43:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4M6h-00Hal4-0R
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 13:43:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A4E7C636C2;
	Wed, 31 May 2023 13:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3998EC4339B;
	Wed, 31 May 2023 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685540598;
	bh=rVl5YN8HctLHpwt+2MAsfaiN1Pxb5g4t7xVXbVmESsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOpciVO6hX0geLqTx0/uz2HrJCweTBQCBkg/8KyFwNgYor3NAYnkoX0IQYx0XS43N
	 ohwMS+VHe7x50jEE6iFRSYm4/dNuiBYVqknPKty/pY2q/2cKpU0CDstvbBTtpjz+u0
	 dGazEGxpL/3SxLKOr7S5cvQgyRlmFncyfYWHdhHTYUHOPARiPjJ0AOigFX+5n9dUDB
	 hAeGIscfZp2gNXUkipocz0MZOvHuZQmWIHVQpr60SU56r27iCaqU/HlLUpCSqWQcmQ
	 6k29vNMoZGrLXcc+JfXQ1LFy9D/iyV9OEYZ2kabLrnF2joBMtJWLKrs7ZcKDbqwh0i
	 WpfmNQDaSmhhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tatsuki Sugiura <sugi@nemui.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 33/33] NVMe: Add MAXIO 1602 to bogus nid list.
Date: Wed, 31 May 2023 09:41:59 -0400
Message-Id: <20230531134159.3383703-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_064319_213809_AB8E8670 
X-CRM114-Status: GOOD (  13.42  )
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

From: Tatsuki Sugiura <sugi@nemui.org>

[ Upstream commit a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a ]

HIKSEMI FUTURE M.2 SSD uses the same dummy nguid and eui64.
I confirmed it with my two devices.

This patch marks the controller as NVME_QUIRK_BOGUS_NID.

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x1e4b
ssvid     : 0x1e4b
sn        : 30096022612
mn        : HS-SSD-FUTURE 2048G
fr        : SN10542
rab       : 0
ieee      : 000000
cmic      : 0
mdts      : 7
cntlid    : 0
ver       : 0x10400
rtd3r     : 0x7a120
rtd3e     : 0x1e8480
oaes      : 0x200
ctratt    : 0x2
rrls      : 0
cntrltype : 1
fguid     : 00000000-0000-0000-0000-000000000000
<snip...>
---------------------------------------------------------

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ns /dev/nvme0n1
NVME Identify Namespace 1:
<snip...>
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000002
lbaf  0 : ms:0   lbads:9  rp:0 (in use)
---------------------------------------------------------

Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 581bf94416e6d..30b5362e3b26f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3535,6 +3535,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-- 
2.39.2


