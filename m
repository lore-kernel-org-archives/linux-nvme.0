Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC1CE8E9A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LLxGi3hZN8P/a6bzXK+oxBK9n+XIL+xAysjBiVbRF2M=; b=crUDUy1rbuNlqW4MficrfWP6rD
	tfI8JDCWCfl881bNQaH8xkdG9d2tNU6OA0adT4R5bv7L4uCaIVG9OecOCYuCt/s47Q3zCdxO+ttvV
	I+ODiDKn6BecXnImxVeGaqCiOhRA5AbxMSMh5JymXD9LEH4EnUuBFRTvkmg+YIOsTpNY6tjX2g8iL
	beaWEf1bOSzISkKW5585U1WZo8j6cdp27GaCn/MR7rx66JyIzmxrknArWfn/8y+ojijCSpsFdp3b7
	/XHT02cmHvgA9nHgw9szmiZxqHsRYFMPBeHAWvVPCW6tASqVLOgEpdjLR6ZhGeA4OGF1REy6SNk9P
	/nUFtXAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t425A-00000001NK8-1FBm;
	Thu, 24 Oct 2024 17:57:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t41jZ-00000001Isq-0r6T
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 17:34:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 09A195C4912;
	Thu, 24 Oct 2024 17:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD6C4CEC7;
	Thu, 24 Oct 2024 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729791291;
	bh=H+iEc2RxYP+7aT5fPGyflx/19MbUQptYWZMoH5FKxlY=;
	h=From:Date:Subject:To:Cc:From;
	b=j/uM+gsKkpVE4YpcJt9ze+h8cYWqUt4881GxAfQ04paMi9PCMLfj7J90dPvISK1EH
	 v4AYU64jKzW7zMNGm98jhsZ7Fs01kB2iQ4cMcKtv94oXjZBTueNar0W1ZpM/Plxd1w
	 3R6HuCeGoRtikyQxOEmpmSXd3Lp/yZEyPLs78sfSL68nDVFU01xe06MvVb5FxKonsP
	 nX8dVplDkJDIVpjwdRwekrlz6qyOVpXZf5kVprkJbH37iX8QAycVLgtaX91ZJpyMaJ
	 GjEEmQV3xdz8YuPrFTMlVmMhmTU5rpy86GEDCyP6LoszO9jpUSlgYB+JrJYJAwSulp
	 qkEMIARqqDhtg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Thu, 24 Oct 2024 19:33:07 +0200
Subject: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANKEGmcC/x2MQQ5AMBAAvyJ7tkmLkPiKOCiLjWirpZGIv9s4z
 GEOMw9ECkwR2uyBQIkjOyui8wzGdbALIU/iUKii0gKezvOINu10XBw21IoaRbXRpRlAKh9o5vs
 /dv37fsNT6EthAAAA
X-Change-ID: 20241024-topic-nvmequirk-10e70e6b13ba
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729791288; l=1918;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Vo/r6/bSWAK8A6+AEU3IEBIjDMn/12uUNGfpjEqGMJ4=;
 b=+0Uss2EOp/Krb4dQS/+UAdVZAMvPtqoWqNnnVWBMS5++C7Ojxagn1+61IEQOF/k01j8CFl4cd
 AwigjGbzmfiAI8Sm7cYhvTjRaSs9U8Y9urkoi2Gr3gvELZqtYuPlatZ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_103453_366603_A8E656A3 
X-CRM114-Status: GOOD (  12.77  )
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
before the platform can reach S3-like sleep states. This is very much
similar in nature to the issue described in [1].

Other Qualcomm platforms we support upstream require more complex code
additions across both the PCIe RC driver and other platform-specific
ones, before the link can be sustained in suspend. Hence, they
effectively need the same treatment for now.

Force NVME_QUIRK_SIMPLE_SUSPEND on all Qualcomm platforms (as
identified by the upstream bridge having a Qualcomm VID) to address
that. Once the aforementioned issues on non-SC8280XP platforms are
addressed, the condition will be made more specific, with a PID check
limiting it to only the platform(s) that require it due to HW design.

[1] Commit df4f9bc4fb9c ("nvme-pci: add support for ACPI StorageD3Enable property")

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a33af4d7030b72532835b205e9cbb..007b28a03cf2c7b3a90f7b7faa1c4c1950e25b6e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2999,6 +2999,14 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
 		return NVME_QUIRK_NO_APST;
 
+	/*
+	 * Qualcomm SC8280XP must shut down the PCIe host to enter S3.
+	 * Other Qualcomm platforms require more driver changes to restore the
+	 * link state after wakeup.
+	 */
+	if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_QCOM)
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+
 	return 0;
 }
 

---
base-commit: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
change-id: 20241024-topic-nvmequirk-10e70e6b13ba

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


