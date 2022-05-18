Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262E4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lKZB/6RoNEosL1ZhhmdbCbJfaDZXTaYhcWk4wRoTqMQ=; b=UTsmjIIqJDfesQLQd3eE35uGx9
	6JnD6W8SbC64q1JNqNcUHJ1h+aUJEiI4Dvz2f2NoTZZ25fSVHX8jOPHZwH2ZocfzzLhQb4miOfmzA
	zq8JBanVaQhVM4/9hX+r09G271dqvZufjArAUMGZDxO1yqxErPsz0PArL/L1/01wTNYoggzsw/iM2
	u/7DZLj/a0zcmqrfnvLPlLaJCj2jaknLUhuevR+22VVAQwMM1+Rwze/cwZo1F2WcmuOk9+SIldOuP
	OSmb+TQsaMqRIPDRgmh7WZ73neQlZ0THwblKEpk+j015uNtGrQlwYVuqs2F/hHfiq/IZrTVNxMpdj
	ti0eGqjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrJaU-002GEb-S7; Wed, 18 May 2022 13:19:38 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrJaQ-002GDI-SY
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 13:19:36 +0000
Received: by mail-pg1-x52f.google.com with SMTP id a9so97992pgv.12
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lKZB/6RoNEosL1ZhhmdbCbJfaDZXTaYhcWk4wRoTqMQ=;
 b=TiZdooj/E3kGV+m+IxCHD//i1RFktljM4yI8thLxPLyttdCBD2pBRVy7gdWTxNfkdY
 MIjn5bmaUDce3ZkI4A8aN4Pdl+3MRqua4jF5FHfFXsiofGpZwDYiLJyNSNsdqMKrLAVm
 /qYtqby/etpEIQQub4ftdleYWh+d3048sBGe63NY9+ficUbuADiprl137BLlintNcq2v
 A802YuD/nvdQCEodGIgt2Lxdd6aAO90Penhum1XMmJXCCci0/hwAK1evFeqpxOh1mky1
 3We60ppHBCx+SUjtjg30CX6iBDLw3IwowCK+TuqDKyOR9GjLaPqG8eIZHAjHkbVmW5D/
 PhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lKZB/6RoNEosL1ZhhmdbCbJfaDZXTaYhcWk4wRoTqMQ=;
 b=y3G3gG3N81lpg8yuJQ+4gAN38GG+4EPwKyzytK2kJUcMTJHZLwr+/cxS4KhAu/1eu8
 Fwas8/6A8QI5H04ujVQRWg+hOqfTtTyydekFGbmafQPV6T5fwVEoCGj08tFvU4+ptQwj
 go7C4L8MjcF1kWpLGufZ2wnX/gpBdgpVn4ANODQuLFXv4GVEJ/dh5fRER6X/zSdnwbNf
 qZjm146Ma/418B7JZLJFtaStoADbeQ6sujfzNsBJNUVg1Ni1JES5SdAMEkR93h1yw7Rc
 wEqK85yf1tmhBpQznT21kcizv3A1HQPOSsxOUB52i9afXs/tvxnoROswbDVsJIk/Zb5t
 O2XA==
X-Gm-Message-State: AOAM532NgcF9GlV0DF/p6VmFZ0Tq9zmyCkZgfJJHCM9zhTu0Zrxl9ljs
 t5BvMea+Al1rh+uxskD1bTSh
X-Google-Smtp-Source: ABdhPJzzQNNyHE5cV8P7ycPwOWKLxudFG57eELbtV3RDyDz7x8L67cxSujGCQ0pczbQTtKmXHHLCpg==
X-Received: by 2002:a05:6a00:f8b:b0:518:137a:112c with SMTP id
 ct11-20020a056a000f8b00b00518137a112cmr5629794pfb.8.1652879971672; 
 Wed, 18 May 2022 06:19:31 -0700 (PDT)
Received: from localhost.localdomain ([117.217.181.192])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170903228500b0015e8d4eb27esm1663908plh.200.2022.05.18.06.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 06:19:31 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 linux-pm@vger.kernel.org, rafael@kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] PCI: Notify PCI drivers about powerdown during suspend
Date: Wed, 18 May 2022 18:49:10 +0530
Message-Id: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_061934_965113_B35C3F99 
X-CRM114-Status: GOOD (  20.43  )
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

Hi,

This series adds support for notifying the PCI drivers like NVMe about the
transition of PCI devices into powerdown mode during system suspend.

Background
----------

On Qcom SC7280 based Chrome platforms, the RPMh will turn off the power to all
PCIe devices during system suspend for aggressive powersaving. Currently, there
is no way for the PCI device drivers to learn about this situation. Some of the
drivers assume that the power will be retained and some others assume that the
power may be taken down.

We faced the issue with NVMe PCI driver, where the driver expects the NVMe
device to be in APST (Autonomous Power State Transition) state for power saving
during system suspend. So when the power goes down, the NVMe driver fails to
bringup the device during resume.

Previous work
-------------

We tried to fix this issue in a couple of ways:

1. The NVMe PCI driver checks for the existence of "StorageD3Enable" ACPI
property in the suspend path. If the property is found, the driver assumes that
the device may go to poweroff state and shutdowns the device accordingly.

As like the ACPI based systems, we also tried to get the support in place for
DT based systems. But that didn't get accepted:
https://lore.kernel.org/all/Yl+6V3pWuyRYuVV8@infradead.org/T/

2. Keith Busch proposed a module params based approach. The parameter when set,
will allow the driver to support APST during suspend. Absence of that parameter
will let the driver shutdown the device.

This also did not get accepted:
https://lore.kernel.org/linux-nvme/20220201165006.3074615-1-kbusch@kernel.org/

Proposal
--------

Christoph suggested to add a notification in the PCI/PM core to let the NVMe
driver know that the device will go into powerdown state during suspend.
https://lore.kernel.org/all/Yg0wklcJ3ed76Jbk@infradead.org/

Hence in this series, a "suspend_poweroff" flag is introduced in the host bridge
struct. When this flag is set by the PCI RC drivers, the PCI device driver like
NVMe can shutdown the device during suspend.

In the coming days, the usage of this flag could be extended to other PCI
drivers as well.

In this series, the system suspend/resume support is also added to the Qcom
PCIe RC driver for SC7280. During the suspend time, the RC driver will put the
device into D3cold and recover it during resume. So even though RPMh is cutting
off the power to PCIe domain, it is necessary to put the device in D3cold by
the PCIe RC driver for proper working.

Testing
-------

This series has been tested on SC7280 IDP board connected to a NVMe PCI device.

Thanks,
Mani

Manivannan Sadhasivam (2):
  PCI: Add a flag to notify PCI drivers about powerdown during suspend
  nvme-pci: Make use of "suspend_poweroff" flag during system suspend

Prasad Malisetty (1):
  PCI: qcom: Add system PM support

 drivers/nvme/host/pci.c                |   3 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 108 +++++++++++++++++++++++++
 include/linux/pci.h                    |   2 +
 3 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.25.1


