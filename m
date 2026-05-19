Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DFDCD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3zpWOG9lMQwfXHHV1cEC/PTCZPFin/PWRhVcggyfud8=; b=cNmDNILysynAxSJfeM15CAFeOA
	79WzsjP53AmqCXkDNG0p8E0xXvJ704kppuVNPC+OBGJmlOib1e4hf6UrEdugjPMtNZ0x6P/NhXFqG
	rW8ZdEKycIFm45XOXzqWx+LPDf84VLuPPR43jIxFyJncTYO8LxZmMp9yZo8w8fDab7mRZrXGQf9+/
	el3cCDvtIiwEJu8cZiIVWTJHEPJ866j/VELFobZkTEbBh6JE2dXMhPdxo2F+uQo+D6KuaEP9KCGau
	zbhgALwrSA9eypRMXOzB+gLU13DxWc5BY6awjis9Fcdh9VfntLpqj4XQOL6wSn2YltxHZG+bpUmzU
	wkRy1RDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFY4-00000000cZx-3u6n;
	Tue, 19 May 2026 08:11:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFY2-00000000cXw-40aM
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:11:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 07563601FD;
	Tue, 19 May 2026 08:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA094C2BCB3;
	Tue, 19 May 2026 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779178289;
	bh=5xjo82f3ie4CuJPJXkiVNG3j7U7ZB0tOBqMF+qD1aFs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VwiqMkK3ygOVcmD05/x3EcrJzM/opiB1d5fPx6XXiPkHAU6K6L4xS4eVI33gUN3n8
	 GndEmo4TcaZnSE6xiJEa2VAumzbOxrkd0Vsd5w27CaMpVfD7831MSUajt22kDWmjFd
	 MccW6Dwvo8YAQuRGVtA/EfjLWG93UPayNIC0VnsPqDIS07b9ZFwLTQku7SFf1ZJmqW
	 DzZQ91H4k68WS0dIWUeWD6so1ZLNzH2bYoAvF6uFQSDpzEpu3YmRkZodnxQRwCLZsA
	 Qgzvq3D6e5pQs0rPIXdTOi/6BM9t9D2Mgb360h3QVE321/dYebIBlUZ1+lqAnYw0nt
	 vblUf/q993qZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAE6CD4F57;
	Tue, 19 May 2026 08:11:29 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API
Date: Tue, 19 May 2026 13:41:19 +0530
Message-Id: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcbDGoC/yXMUQ5AMBAE0KvIfmuizWpSVxEf1GJFkC4iEXdXf
 L7JzFwgFJgEiuSCQAcLL3OESRPwQz33pLiNBpMZm6FGNWkR1fGprHe+M5hrhwixvgaK8XdVVr9
 lb0by27uH+34A/GF7UGwAAAA=
X-Change-ID: 20260414-l1ss-fix-6c9cf2451944
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=5xjo82f3ie4CuJPJXkiVNG3j7U7ZB0tOBqMF+qD1aFs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqDBst/hoKrDTpdPRjYYJTCX+++TyvGSE6NanlW
 am4jXQ1szSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCagwbLQAKCRBVnxHm/pHO
 9eNGCACK2TWsgGvWcO0DSokv8etGLWLJwfMz66K1J0+8xc+cXK6Hfcx6lIBquWAnY2If3N3FtPj
 HUHTew/QYyZEZSKRV6PKMmVkYll6OGW2zbtFy+11qfr8ACFPQPF/bjtGoYwsTLtIR7CrIIFCfB4
 bexAzn9xOMAK9AsIdxrXNWKC3VR0/LsiIU8mXQxG+UqmVktjQv3LZZsd2zMBDuIsU2zVPdnxRbX
 5osUT2sxTvC1OVweFzzuQqRFIwol9Fs9htH2Uo7xxDM+duLEEXSjMZa0bnTFlPBl5dsFrH1oTAK
 gj7MNU/SHHucR5B6oNbyuZ8Yzlm+UwsMhpG5OfD4PbbdV7u2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
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
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

This series introduces a new PCI API, pci_suspend_retains_context() to
let the client drivers know whether they can expect context retention across
suspend/resume or not and uses it in the NVMe PCI host driver.

This new API is targeted to abstract the PCI power management details away from
the client drivers. This is needed because client drivers like NVMe make use of
APIs such as pm_suspend_via_firmware() and decide to keep the device in low
power mode if this API returns 'false'. But some platforms may have other
limitations like in the case of Qcom, where if the RC driver removes the PCIe RC
resource vote to allow the SoC to enter low power mode, it cannot reliably exit
the L1ss state when the endpoint asserts CLKREQ#. So in this case also, the
client drivers cannot keep the device in low power state during suspend and
expect context retention.

And these limitations may just keep adding in the future. Without a unified
API, the client drivers have to implement their own logic which may cause code
duplication and may also lead to drivers missing some of the platform
limitations.

Once this series gets merged, we can extend this API usage to other client
drivers as well.

Testing
=======

This series is tested on Qualcomm Hamoa based Lenovo Thinkpad T14s latop with
NVMe drive.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Renamed the API to pci_suspend_retains_context()
- Reworded the commit messages to include L10_REFCLK_ON + T_COMMONMODE as the
  L1ss exit latency
- Rebased on top of v7.1-rc1

---
Manivannan Sadhasivam (4):
      PCI: Introduce an API to check if RC/platform can retain device context during suspend
      PCI: Indicate context lost if L1ss exit is broken during resume from system suspend
      PCI: qcom: Indicate broken L1ss exit during resume from system suspend
      nvme-pci: Use pci_suspend_retains_context() API during suspend

 drivers/nvme/host/pci.c                |  3 ++-
 drivers/pci/controller/dwc/pcie-qcom.c | 12 ++++++++++++
 drivers/pci/pci.c                      | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h                    |  9 +++++++++
 4 files changed, 57 insertions(+), 1 deletion(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260414-l1ss-fix-6c9cf2451944

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



