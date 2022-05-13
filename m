Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D09C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PNdOq8t7JPWMUm+zuKo42J05VFvuGcXIEWGUnieUQq8=; b=0aA8u8zTfgXSihYm/R5YSKIvc9
	QllY1ATCV/qYzGb0S8wAENrQd91sorVJntjjowdi+dukOFFwvnNm3HyFFTufaRld2eATPri7rmvO3
	o31W38R/OfbfviqavbfG+qW8KPVT1pjUfspNNckZpyAxP7hk8cQEj3aws45XdcUXtljMDrJLFwKQ/
	fO35hQSlYaNYRXwHbI81+TBcSHfwC+FJVfe8Z2luIvJGoRs0kVniFiSRbwIuJd34wML5qdxnPW+Ig
	a2vdSpHS8yX07PvCwGYLrk7vpwvOX1gbgyFk20Xei14o+yFG/krSrEv5IeQv08UMFlXPkhg4ZH40X
	SAK/WqZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npT2Y-00FgT5-Qx; Fri, 13 May 2022 11:00:58 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npT2S-00FgPe-Ly
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 11:00:54 +0000
Received: by mail-pj1-x1029.google.com with SMTP id
 j10-20020a17090a94ca00b001dd2131159aso10529521pjw.0
 for <linux-nvme@lists.infradead.org>; Fri, 13 May 2022 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PNdOq8t7JPWMUm+zuKo42J05VFvuGcXIEWGUnieUQq8=;
 b=Aby8aznXD9r0cpduz4gPRNbEOwt3jnfmn1L1cpN5i+xaJnDLAKGpkNeSk/S+x0nHvA
 DtDAoalZtiCQUrNS6T/clwmhq1EARzkAX5hrLUaf4H6Js4uPhGkCNkdVWiHG4SEil1Ij
 SKB3qCz/woLhiCRxQ6q0NY9Ka6SiCGvPkqGXUvbJn4jSInXfNspfJ+wBICwF4igTAZFx
 uZ9pcc2cSPVuoo2jFRQrvseyy83Y3wrD/0YXISPrOM1gHtgosGY1e+v4sWLVfg5sdolw
 O7Jv2cao2Q4qvkCUoKOtLJxtr9bpqedg6fOwuzilqlRMi8t3Meg/lPFVODGOzUQ+E2R+
 vMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PNdOq8t7JPWMUm+zuKo42J05VFvuGcXIEWGUnieUQq8=;
 b=oOBfjH6tmRIbT2IF8gIcbCgHAh6LttSforvcbwRBCQNfGw1G/gLRNXJg2i7nc++Td/
 PG6o+tXwfbQLyPcsqywychvRgfWY3JW+QC62Km1uh0GsgeDDdNtKjp6YBQaisUBBKPJr
 /PCJGEnWieXwlG7WETUuuPcxggvNiYPYDvTr9xG3ANNeweqfady0tbvfPe0hCWE6X7Vz
 +rLI7QG3cksj/uw8NZowRiGoEo/n/EY6DrHjzX8dtIRMR203PXDIoe4aDjPQSJvm+2u5
 1gOtVboZ+FwcxPwEwj16L34Awpi2hP5uYP2xdJNmDrrZ0MiewEnQ+7CBalI8BcktwaJv
 j5vw==
X-Gm-Message-State: AOAM5335dy05CuUJ6EJihpoC4EDM9UXvsJWUn6Qu793zHk05c4uV/1K6
 3gPQRfTSHLXL7z1QRN56XOjS
X-Google-Smtp-Source: ABdhPJx/lj+9GtKbU69bsELbuMcfzZNECYpmx52MJZ5Pm+xKR/MzE5L/DF1hY44DChJqj90mR3eIwA==
X-Received: by 2002:a17:903:11c7:b0:151:7290:ccc with SMTP id
 q7-20020a17090311c700b0015172900cccmr4386684plh.95.1652439648056; 
 Fri, 13 May 2022 04:00:48 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
 by smtp.gmail.com with ESMTPSA id
 u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 04:00:47 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] PCI: Notify PCI drivers about powerdown during suspend
Date: Fri, 13 May 2022 16:30:24 +0530
Message-Id: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_040052_739536_A737FBFB 
X-CRM114-Status: GOOD (  18.28  )
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

On Qcom SC7280 based Chrome platforms, the OS will turn off the power to all
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

Testing
-------

This series has been tested on SC7280 IDP board connected to a NVMe PCI device.

Thanks,
Mani

Manivannan Sadhasivam (3):
  PCI: Add a flag to notify PCI drivers about powerdown during suspend
  PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
  nvme-pci: Make use of "suspend_poweroff" flag during system suspend

 drivers/nvme/host/pci.c                | 3 ++-
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 include/linux/pci.h                    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1


