Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFD4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kT9CLYmTQoLdWj+ezqw0vR6lgOk0ZCJn4nWbIhiUmg8=; b=20UjrcpdRNbo71AfGyxFDe0iFC
	/cgT82wdrzqpxX0s05khWKJ7F1N4X9ALFrr1Qy9MzqOHM6Azg2cnXIH2jbpAbaFAAJBWXqn46sR2q
	TXY1f+/rCDfp7JdWm9scYkFWx+lNX85PnhOhVoeNRADOrm9rld5mkFzGgqtgHGuNdsmPgaqo69uHD
	MDNOTk6KvYwf3fG2iCtNJkGcf7XtMqYlPvUPmx9XaBSsD9vTzcajYtWVE8RWYuJfa3AbmxMF64mMo
	IQc1J7fwqy3mQAF528kKjEMj5Rrx+gFqe/q+gUZFrAGTzMnzneuGWb01JVhgyyS1JhBp5GIlTI9Wu
	uXnXh97g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndn2b-006qWp-D8; Mon, 11 Apr 2022 05:56:45 +0000
Received: from mail-m118205.qiye.163.com ([115.236.118.205])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndn2W-006qWI-MC
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 05:56:44 +0000
Received: from [10.22.39.80] (unknown [218.106.117.242])
 by mail-m118205.qiye.163.com (HMail) with ESMTPA id 41CF42C1809;
 Mon, 11 Apr 2022 13:56:34 +0800 (CST)
Message-ID: <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
Date: Mon, 11 Apr 2022 13:56:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me, kingtous <kingtous@qq.com>
References: <20220408051915.GA31955@lst.de>
 <ABwAxgCYBwe5Iq2fM1-8qqrc.3.1649398333597.Hmail.me@kingtous.cn>
 <20220408062210.GA410@lst.de>
 <7b59552e-196e-d06a-f057-aaa3e9432841@kingtous.cn>
 <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
From: =?UTF-8?B?6YeR6Z+s?= <me@kingtous.cn>
In-Reply-To: <20220411054945.GA14311@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQh9DTFZCHRhDQ0MYGEIfSh
 hVAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6UTo*KTlNCk4UQwgIFQEJ
 Dx9PFCFVSlVKTU9CTU5NTkJPTEJLVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUpDVUpL
 TVVKSkxVSU9JWVdZCAFZQUpNT0JMNwY+
X-HM-Tid: 0a80173200152d27kusn41cf42c1809
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_225642_365644_820320B6 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

Yes. To ensure all outputs are shown, I ran "lspci -v" with sudo priviledge.

"sudo lspci -v" shows below:
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
Root Complex
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
	Flags: fast devsel

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
	Flags: fast devsel, IRQ -2147483648
	Capabilities: [40] Secure device <?>
	Capabilities: [64] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
	Flags: fast devsel, IOMMU group 0

00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
PCIe GPP Bridge (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 26, IOMMU group 1
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: fd600000-fd6fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 
1453
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] Secondary PCI Express
	Capabilities: [2a0] Access Control Services
	Capabilities: [370] L1 PM Substates
	Kernel driver in use: pcieport

00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
PCIe GPP Bridge (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 27, IOMMU group 2
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: fd500000-fd5fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 
1453
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] Secondary PCI Express
	Capabilities: [2a0] Access Control Services
	Capabilities: [370] L1 PM Substates
	Kernel driver in use: pcieport

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
	Flags: fast devsel, IOMMU group 3

00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne 
PCIe GPP Bridge (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 28, IOMMU group 4
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: [disabled]
	Memory behind bridge: fd400000-fd4fffff [size=1M]
	Prefetchable memory behind bridge: [disabled]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device 
1453
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] Secondary PCI Express
	Capabilities: [2a0] Access Control Services
	Capabilities: [370] L1 PM Substates
	Kernel driver in use: pcieport

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
	Flags: fast devsel, IOMMU group 5

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal 
PCIe GPP Bridge to Bus (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0, IRQ 29, IOMMU group 5
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00001000-00001fff [size=4K]
	Memory behind bridge: fd000000-fd3fffff [size=4M]
	Prefetchable memory behind bridge: 0000000860000000-000000ffffffffff 
[size=1014272M]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot-), MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir 
Internal PCIe GPP Bridge to Bus
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] Secondary PCI Express
	Capabilities: [400] Data Link Feature <?>
	Capabilities: [410] Physical Layer 16.0 GT/s <?>
	Capabilities: [440] Lane Margining at the Receiver <?>
	Kernel driver in use: pcieport

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller 
(rev 51)
	Subsystem: Lenovo Device 3846
	Flags: 66MHz, medium devsel, IOMMU group 6
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge 
(rev 51)
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
	Flags: bus master, 66MHz, medium devsel, latency 0, IOMMU group 6

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 0
	Flags: fast devsel, IOMMU group 7

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 1
	Flags: fast devsel, IOMMU group 7

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 2
	Flags: fast devsel, IOMMU group 7

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 3
	Flags: fast devsel, IOMMU group 7
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 4
	Flags: fast devsel, IOMMU group 7

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 5
	Flags: fast devsel, IOMMU group 7

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 6
	Flags: fast devsel, IOMMU group 7

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data 
Fabric; Function 7
	Flags: fast devsel, IOMMU group 7

01:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
	Subsystem: Intel Corporation Wi-Fi 6 AX200NGW
	Flags: bus master, fast devsel, latency 0, IRQ 76, IOMMU group 8
	Memory at fd600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [40] Express Endpoint, MSI 00
	Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [14c] Latency Tolerance Reporting
	Capabilities: [154] L1 PM Substates
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

02:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller 
(rev 01) (prog-if 01)
	Subsystem: O2 Micro, Inc. Device 0002
	Flags: bus master, fast devsel, latency 0, IRQ 58, IOMMU group 9
	Memory at fd501000 (32-bit, non-prefetchable) [size=4K]
	Memory at fd500000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [6c] Power Management version 3
	Capabilities: [48] MSI: Enable+ Count=1/1 Maskable+ 64bit+
	Capabilities: [80] Express Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [200] Advanced Error Reporting
	Capabilities: [230] Latency Tolerance Reporting
	Capabilities: [240] L1 PM Substates
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci_pci

03:00.0 Non-Volatile memory controller: MAXIO Technology (Hangzhou) Ltd. 
NVMe SSD Controller MAP1202 (rev 01) (prog-if 02 [NVM Express])
	Subsystem: MAXIO Technology (Hangzhou) Ltd. NVMe SSD Controller MAP1202
	Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0, IOMMU 
group 10
	Memory at fd400000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable+ 64bit+
	Capabilities: [70] Express Endpoint, MSI 1f
	Capabilities: [b0] MSI-X: Enable+ Count=20 Masked-
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [158] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [168] Secondary PCI Express
	Capabilities: [1d4] Latency Tolerance Reporting
	Capabilities: [1dc] L1 PM Substates
	Capabilities: [1ec] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
	Capabilities: [2ec] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
	Kernel driver in use: nvme

04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Cezanne (rev c5) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 3807
	Flags: bus master, fast devsel, latency 0, IRQ 49, IOMMU group 5
	Memory at 860000000 (64-bit, prefetchable) [size=256M]
	Memory at 870000000 (64-bit, prefetchable) [size=2M]
	I/O ports at 1000 [size=256]
	Memory at fd300000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
	Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270] Secondary PCI Express
	Capabilities: [2b0] Address Translation Service (ATS)
	Capabilities: [2c0] Page Request Interface (PRI)
	Capabilities: [2d0] Process Address Space ID (PASID)
	Capabilities: [400] Data Link Feature <?>
	Capabilities: [410] Physical Layer 16.0 GT/s <?>
	Capabilities: [440] Lane Margining at the Receiver <?>
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu

04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir 
Radeon High Definition Audio Controller
	Subsystem: Lenovo Device 3814
	Flags: bus master, fast devsel, latency 0, IRQ 75, IOMMU group 5
	Memory at fd3c8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 
17h (Models 10h-1fh) Platform Security Processor
	Subsystem: Lenovo Device 3831
	Flags: bus master, fast devsel, latency 0, IRQ 70, IOMMU group 5
	Memory at fd200000 (32-bit, non-prefetchable) [size=1M]
	Memory at fd3cc000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/2 Maskable- 64bit+
	Capabilities: [c0] MSI-X: Enable+ Count=2 Masked-
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: ccp
	Kernel modules: ccp

04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] 
Renoir/Cezanne USB 3.1 (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 3839
	Flags: bus master, fast devsel, latency 0, IRQ 40, IOMMU group 5
	Memory at fd000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] 
Renoir/Cezanne USB 3.1 (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 3838
	Flags: bus master, fast devsel, latency 0, IRQ 49, IOMMU group 5
	Memory at fd100000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] 
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
	Subsystem: Lenovo Device 3832
	Flags: fast devsel, IRQ 73, IOMMU group 5
	Memory at fd380000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x

04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h 
HD Audio Controller
	Subsystem: Lenovo Device 3833
	Flags: bus master, fast devsel, latency 0, IRQ 31, IOMMU group 5
	Memory at fd3c0000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
	Capabilities: [64] Express Endpoint, MSI 00
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel



在 2022/4/11 13:49, Christoph Hellwig 写道:
> So I couldn't really come up with a good heuristic for checking for
> a valid EUI64 that would work here given that in one of the cases
> the only bit set is in the OUI.  We'll need to a blunt quirk to disable
> identifiers for this controllers.  Can you send the output of "lscpi -v"
> that contains the vendor and device id?
> 

