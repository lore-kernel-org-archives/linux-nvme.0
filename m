Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D07CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1jQvqmTqiaQFOL4EqTH9KdJuG5gqKsg4osHG/D6dsRs=; b=TB2Q/oXcGBFq8T7wlNmhOFcWrb
	90i8RLTD+gDAl+USPSFggnGQORtDVjFnyK6y1KpPJIMiuH35JRGTSSnKwWtVnQaC16URjVzD+oyWW
	na/GvjYYoocsDo9mjB5QOAuXczkHuBbWsvYrYXJxbxhviKg/vhJkUl02q5rYOXeUEelkaD1vUs8Bk
	Qkv5GYmtFMkPOrkOHFCdwC7M3IpR6BwceJFxLDNYj3LstJWDL5Ps0dQkM3wRQjVpeMNyYMrJQKObh
	LAMtAiw5mRA5EUmekRqlhjBTrqPBPbOKyP+qZ1Z1j7uYUhmfMDrRs+vSVIYwTRrpIK4KENn/w2130
	/J9i6llQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4FB-0000000H8sY-46x1;
	Wed, 03 Apr 2024 17:17:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4F9-0000000H8qa-1Fc4
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 17:17:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9AF3CCE2BDE;
	Wed,  3 Apr 2024 17:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61571C43399;
	Wed,  3 Apr 2024 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164665;
	bh=Z+CjyIiSiNIC/ll8IEs+anXiypUFG9KsSsPWhmHVHYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayItmMYVgxC4PPZuBEPTCvWJc5yWdgMsfHuO84QX083lMsubeYBWPwNK5WOKo+t5r
	 1Fh2tdxsHCiIjpLSDdK6TFaBMLVhX2BGPtbfeZzkhwQmpkyTMHEdOplNln0EtZPqVW
	 kik9D6LFgoREBLFE4pZtmoWtUws/w4151COP3UiyLGkoubEIrncIjxCJraOYuYTN7Y
	 Nj3elQJQx+j0aBzq7Gq5FxnCBJyogH70mCoQ6kXl/OgZIywenfkqVThR+iNmVg2SRw
	 YdOV5eRdRlC51NfGtNacmgIUNd2Aff/fKKHXWIVpVKqV36pl0fKkqs1zZInBMaghl1
	 TT3XiQx3SHBcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiawei Fu (iBug)" <i@ibugone.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 24/28] drivers/nvme: Add quirks for device 126f:2262
Date: Wed,  3 Apr 2024 13:16:26 -0400
Message-ID: <20240403171656.335224-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_101747_537182_C60972AA 
X-CRM114-Status: GOOD (  11.64  )
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

From: "Jiawei Fu (iBug)" <i@ibugone.com>

[ Upstream commit e89086c43f0500bc7c4ce225495b73b8ce234c1f ]

This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
device [126f:2262], which appears to be a generic VID:PID pair used for
many SSDs based on the Silicon Motion SM2262/SM2262EN controller.

Two of my SSDs with this VID:PID pair exhibit the same behavior:

  * They frequently have trouble exiting the deepest power state (5),
    resulting in the entire disk unresponsive.
    Verified by setting nvme_core.default_ps_max_latency_us=10000 and
    observing them behaving normally.
  * They produce all-zero nguid and eui64 with `nvme id-ns` command.

The offending products are:

  * HP SSD EX950 1TB
  * HIKVISION C2000Pro 2TB

Signed-off-by: Jiawei Fu <i@ibugone.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa3801..8e0bb9692685d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3363,6 +3363,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_BOGUS_NID, },
-- 
2.43.0


