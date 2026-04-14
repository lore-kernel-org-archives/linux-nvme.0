Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C01F9D0D3
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oSVtwVpvs8xpfnuK6ioYNzj6zdVRZ/agRdWr7r+I7Ug=; b=nLoj4ofWxZH0kzw8h2ZnZN7gs9
	Va2oDS8vAo91bYCJ21qTkLi/8sQAay1BHfHWUo+FRPh+jVbvO72PDggcPqiz+LDcC6nnbkBNB/tie
	mgYyNORI0xWCLy+fkSGmcs5ZQjE7w3RfZ85U/RNofGisB6Y/OIkr/z8EUanB8H4SzSfeFPfr5iCdy
	Y/4EHL8SRpeUyf7JJlJnqQEY5gXz0gTF76XL/Si17l294i6ZXl3LwGuLjucCbqI59LPpRpSjypqia
	CN9cZ8CUksDoI/hkpL/z8uFa7P4QTGeQ9+6/v+giyXxIJ1+x05+YzvJXbFlXYWbwPNG0bHfnUsLFb
	vYVH68+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBW-0000000HZRm-0KHa;
	Tue, 14 Apr 2026 16:00:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBR-0000000HZQu-1BAb
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 16:00:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 71C1560120;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C7EC2BCB5;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776182412;
	bh=mOftxv4/QKcA+8oXdsFGy1MXnS+r1vrmhCE64/287oA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TqH71j0/LoJs10baVrq1uZnrmVSPYdnsCcFntJQ636feSA2JB4kmogOxTpKAvKm9c
	 Ew7cSLkFVOHO9eX1t+BH4dlGLnCzUKJ9MAVQ/KeRvblYZe3xjMRk+F6GgR8AT2cL0d
	 nmTo4wlE2mNqwfZpv7Rp0P69iRrkq9FVHSOQMvzc7PN3Hl5MzG/gISHFe3v9XHI4YK
	 Jza+ge2v1l89jzXABC4nmEXpNBLHFV6QEhIYghFcu6OknQao4JQ9ThZIkWZKjwhkBi
	 h/utXD/XVxFOB7uZxTA+4q2bmyc8aMb7qv2ulu20+7eC0D6ctNo3ekUb/8hDdTxJxR
	 NkUrti3dEXjnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03311F9D0DC;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/4] PCI: Introduce pci_dev_suspend_retention_supported()
 API
Date: Tue, 14 Apr 2026 21:29:38 +0530
Message-Id: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpk3mkC/yXMUQ5AMBAE0KvIfmuizWpSVxEf1GJFkC4iEXdXf
 L7JzFwgFJgEiuSCQAcLL3OEThPwQz33pLiNBpMZm6FGNWkR1fGprHe+M5hrhwixvgaK8XdVVr9
 lb0by27uH+34ArYB/vmwAAAA=
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
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mOftxv4/QKcA+8oXdsFGy1MXnS+r1vrmhCE64/287oA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp3mSCyXV3Bi9/QyZ2BKGNKf8az8Qg5jIALqpAr
 37Al+bepYCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCad5kggAKCRBVnxHm/pHO
 9UOWCACTMvxVhal6glC4+LLw74EQF4QbGQYJKc2iXxMBxiiBZFMwC4nz03KqdEOzFNTgG1JfQky
 FVqfbXCHJ5xvOpTxpGyXYZBm1fDCrmT1WwLZrRx8MEUlakwYpGAOSwHs9MUnktXcDg/5h/Sjwvz
 6HcpI/67pkL17T8zLYz7qOmpIJYkBRp5gLKjl9xt/DGsekVNNLmaVKLghytRdRw4VisjsRFKgDA
 EHsUPnKYE8MO61DvsrQCaHeTgEaUBEqsD/ADJAnSrOf5DdDUWWBUOSU5pDO/K67f9mf8vc3xbu8
 pUahEkJ7QRqQp/0RPvaXEyuxZNcLcSDjrbEejPPB6Bg9iRPX
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

This series introduces a new PCI API pci_dev_suspend_retention_supported() to
let the client drivers know whether they can expect context retention across
suspend/resume or not and uses it in the NVMe PCI host driver.

This new API is targeted to abstract the PCI power management details away from
the client drivers. This is needed because client drivers like NVMe make use of
APIs such as pm_suspend_via_firmware() and decide to keep the device in low
power mode if this API returns 'false'. But some platforms may have other
limitations like in the case of Qcom, where if the RC driver removes the
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
Manivannan Sadhasivam (4):
      PCI: Introduce an API to check if RC/platform can retain device context during suspend
      PCI: Indicate context lost if L1ss exit is broken during resume from system suspend
      PCI: qcom: Indicate broken L1ss exit during resume from system suspend
      nvme-pci: Use pci_dev_suspend_retention_supported() API during suspend

 drivers/nvme/host/pci.c                |  3 ++-
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
 drivers/pci/pci.c                      | 34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h                    |  9 +++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)
---
base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
change-id: 20260414-l1ss-fix-6c9cf2451944

Best regards,
--  
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



