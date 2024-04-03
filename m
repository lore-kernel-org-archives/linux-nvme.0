Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5C9CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 17:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHMhxNDWGZuiNkrm8sGAUMFzn8TZs+aSYthwEq9Ovu8=; b=Jf9+GL1x0oK8wSb/4G3aqLS8Dy
	cfxwU+JHqT0avMoYwXyo382d0sVcZVdPJoKHhHhWXKLF1NRCfXDxwMnRE0IpsAEjE4nfLnyhHO9bQ
	tBxqn6rrZlg/HBWltnP7SiBZ7xjQHBnNvWCEPe7iwbxeHq3FjIcjxQnrNkeGvMcN5Q71BWUgU40DI
	3J5lG1BC847Y39vrXDl2S4D3ldQwUUvEDL0Db8ZvitVLO5TIttjsDoJrVl2i2Cbet5E+nuuOOOQBJ
	CeNIzSfiJzaunEiM6d5VZLEolIhoXKIWH6eWvEvwu95S7+8RzudKPhUdPh+gC6EzxMMrbrhBoscsn
	UvrQ+G3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4Gz-0000000H9a7-3LeY;
	Wed, 03 Apr 2024 17:19:41 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4Gw-0000000H9XO-3jH6
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 17:19:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 48587CE2B08;
	Wed,  3 Apr 2024 17:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A504BC433F1;
	Wed,  3 Apr 2024 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164776;
	bh=mz4McjuT2qlYoiEkicjh9v8R7sroxYM+U54rgIlhYMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqJPqQfBS+X0lpIunFesSxKqiiuBt0JjrxyZNc9oU+QVNdY1ae1H0pixH69ANKJak
	 cQj4g4Yvun4ikTGMpdsomuwan2LCm9k1CCHfDVNAY5J6NgsrsRZ1YMk4HhI6Uu3Yq2
	 WM5bv5HJv/Y7jvJcflAIt2/i7THW08LpAEpf4rZ7c7qIdzgLPSN0rVQO5OVyYIZEPw
	 /i58Zt+HIg5op4FRcJoetwpM5bNuJOiKG9xi0LroMHhiK4SGa44nzEaA1p7AYz75Fn
	 z6rc+Facrbv3PihIQRT4PRGOA0az1qHqxzQG/fm9AkgvAM30rEQgGfbxR3Trb9dUGD
	 9hXvNkuSgeDlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Jiawei Fu (iBug)" <i@ibugone.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 14/15] drivers/nvme: Add quirks for device 126f:2262
Date: Wed,  3 Apr 2024 13:18:58 -0400
Message-ID: <20240403171909.345570-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_101939_120871_E5A03413 
X-CRM114-Status: GOOD (  11.62  )
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
index 3d01290994d89..5ff09f2cacab7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3471,6 +3471,9 @@ static const struct pci_device_id nvme_id_table[] = {
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


