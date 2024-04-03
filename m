Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA1CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfxVgiyHPQ0iSVipvn6m8x1udU2VrRAezUzIzVdNlJ4=; b=mtCBuYgMST+yel+FpG/5XL52Gd
	xXoogHGC7y+jA/Nd+1z8VEUoqrEzmPfqoZYpVCRnghTXtj3zgsnJOpO9SaV8tMc7Sx/Nq++xHK6BS
	fQRTma4Ckmu7vRaCrmaRv5dQJs5w6FuZw6IXE8amf81nizUTmJ3aOKss+AYE4JWat+0Kycb3fAjS1
	htG1vNTJlo+u+cVRs8+KC1MP4hLTGPjnNqKY/qX9rmwlXh4cfs1o7XQjTr1xW2oNFbBZTaTFcX5Ee
	QyVdNqb5LQ4e74FZCLXRT+ZWmwOU2J3kfZdgnp5HxlZYe9duE/ojxsMpz0wKjIXYIu8/eHODG4J2F
	L4MER/Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4GA-0000000H9CB-2w5F;
	Wed, 03 Apr 2024 17:18:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4G7-0000000H9Ae-381z
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 17:18:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4170161463;
	Wed,  3 Apr 2024 17:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A2C43143;
	Wed,  3 Apr 2024 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164726;
	bh=1/r2T1+lH3xh1cw8Hf+XNHbZmRnlMRWWJGmhtTvCMNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8Tbkdf5GIfbY7PIKFZFKMMgGTQrHC5Kx4IDb54gfUvpi88YqmmtZ5Pz38Rm6CbxS
	 PfgFNUpKDu/Yi+sus6zYf8nBOUiNgxZZDlpLEzbtHjNHV2US/BoHrPaVPxoOLF6hK4
	 dx3nSN8DtlS5lgYzczjxvLgFiANmzihAH02HE5kUCjOX3iOqckVnTef57HimY8AjS7
	 4X/MWuWQUFN9sCyO/7w4+sAvUXi5ENvudbe2RIMhmS1DEgs6tSRs4wp5Pq8LS1WlVA
	 k+VdlAE5VLr+fiM7zquY/GhZ30vCfasBNbXycKaQOCQgKweVwgr3jkWn6LbTmeJ996
	 Qqc4zdKcOxKXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiawei Fu (iBug)" <i@ibugone.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 17/20] drivers/nvme: Add quirks for device 126f:2262
Date: Wed,  3 Apr 2024 13:17:58 -0400
Message-ID: <20240403171815.342668-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_101847_858404_3F5A0A3F 
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
index f8e92404a6591..b985142fb84b9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3361,6 +3361,9 @@ static const struct pci_device_id nvme_id_table[] = {
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


