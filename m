Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE9EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JHZBqEAB8H08PSyrB3IoJH1Z7COxDkzxFEoRfpivNrY=; b=L2BBHFm64kqdWbI3KvjNi79L0u
	LrsrJGaKJLRduMtbK0AYZuzWJPwe9ceXYumKLw/JC6es5FoEZKFdKuERuCwd/9xciCNCJ/gTobw7h
	fdopTVBinB96t6kiim/+9CCzKuDkbsWnudqIgGYdYngeVOi6J75qemhuYz7hh9dBAngB+oUabNzP0
	qIt0vT6vMbtEs7/pCV36BoNmLKlJRrLkFkDAZDYMS8J4VZxqaoG3cCHiDRBAeEwJt6k2KGSOnuMHv
	erLP+ocsdWIm20KcJO24ZA4Oq/Wj4EmEDINMSJOVWQYQ/bYbdLEPc5MTwrp33NxfdmW/sv5FkDUpA
	LCM/kLZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfMpP-00AIOp-Iq; Fri, 15 Apr 2022 14:21:39 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfMov-00AIEK-MT; Fri, 15 Apr 2022 14:21:12 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 199275C01E5;
 Fri, 15 Apr 2022 10:21:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 15 Apr 2022 10:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=cc:cc:content-transfer-encoding:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1650032464; x=1650118864; bh=JHZBqEAB8H
 08PSyrB3IoJH1Z7COxDkzxFEoRfpivNrY=; b=HBlTMSxcVlMC/09d83ixI1sFcV
 DOCY/fGTJVZ0YBdVL41HvnTjjPTKybjFFCYoyBgpkPXxD1U2eNBdYmrj3HZq//P4
 KtD5O82pyqHjbDXV2/9JyYAi/vhSjKNu3DTnAGyFlpqMFxXSFdkLWEVxVDg8UBDt
 ugRxVCBsR20f38m4Ddng8AobsrbEDm/+9H4k1yNhDcKGxI+KC7X0JQjcs/QAqnMz
 e6AhyH3+Uc5+0t+xBV3UWHaKDG3Ivok+A79XOyA9Qucy6+2AY7UdKefRYUQ3g0sz
 8kImHfQm5Y5XY1Pp0QV7ysrPvuDc9A0zWG9C9kEA1TdQecOMi1J+ZUh2gZwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1650032464; x=1650118864; bh=J
 HZBqEAB8H08PSyrB3IoJH1Z7COxDkzxFEoRfpivNrY=; b=rkywgsyQv/DF0BAC3
 +hCTETy4feeVY29Ch8DeZRdwbbV8OK9YadhwQNBl2mSasZLAnEcLaYWGVAqeXrM+
 u+4EWenxq1JRk4lB6ssbw2KMu58X1uoWYUsQ+qMgZWDumh2iOOqMv2whs8ufZ1uJ
 f1CXqcn1DUV+aEdRd523YW1ehp/JB9Di6VpPCt/cAj6lNQkSUPV+/oErs1qrRZr1
 MEaLKTl3aqvzSXDm9vwefSFicRv7oeTUpTSqr8lng555TQ5TFOQU3R1NRd6nqMd5
 VKZvDT9kd9JQ6+x3QA3rno5nuAID4FTGx0azkdvKFXgNljpvoeql56lQJC2e8gyU
 cZZ5Q==
X-ME-Sender: <xms:T39ZYpRi_gJpWK4M6nOrBizifmQEEvhwZcijOA2GFPiwdA182xCXPQ>
 <xme:T39ZYiwNR1OH6XlYOFxUb0S2SkZ3rh-IBG4ObJD3puPG-32aufHOX3-l-V28z66hG
 woh1nYekHbbj7xWxHw>
X-ME-Received: <xmr:T39ZYu17Bo_aAWcz7zRCaSQ7VfEH8BoVfZffEuYWlKlWbLv1ZHQa4_2qQP1H7Exfoz3-8pIS1QVDUTYmkOzSyJuZS4IopLc1ON1ZF4hrZF983P2bry5A2QUe71lJaO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelhedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
 necujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurf
 gvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghr
 nhepfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgne
 cuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:T39ZYhAeecKKItmXLnNBA93ZLhArPEvW2ubnUYgaquc6Q5jR_z8brg>
 <xmx:T39ZYijxl3HJXNZdzTumiPWVU0hP2cICUo3hQjk9nVj3LaKWPQKqfw>
 <xmx:T39ZYlo6ImJBfRJhnE_roB5pdTSgtQ_Il2puD9Lkq9B9TuRsRelyHg>
 <xmx:UH9ZYpQStle2DoAUpYT9fyMms_Gg-QC-xy1UVziPOk9u1V9lgfzqaA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Apr 2022 10:21:01 -0400 (EDT)
From: Sven Peter <sven@svenpeter.dev>
To: 
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/6] Apple M1 (Pro/Max) NVMe driver
Date: Fri, 15 Apr 2022 16:20:49 +0200
Message-Id: <20220415142055.30873-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_072109_847447_FC4E3F15 
X-CRM114-Status: GOOD (  25.03  )
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

v1: https://lore.kernel.org/linux-nvme/20220321165049.35985-1-sven@svenpeter.dev/T/

Thanks everyone for the reviews of v1! I've listed the changes in the
individual commits to keep better track of them.


And here's the v1 cover letter as a reference as well:

This series includes everything[*] required to get NVMe up and running on
Apple's M1, M1 Pro and M1 Max SoCs.

The NVMe controller on these machines is not attached to a PCI bus and
this driver originally started out when Arnd added platform support to
pci.c and I added the required Apple quirks. Christoph Hellwig stumbled
upon an early version and suggested to instead rewrite it as a
stand-alone driver since some of these quirks are rather awkward to
implement and would affect the hot path otherwise [1].

Here's the first version that creates apple.c to handle these weird NVMe
controllers. The following parts are included:

  - Device tree bindings: Since this is the first and probably only
    SoC that has NVMe outside of a PCIe bus I've put them into
    soc/apple. The same bindings are also used by u-boot and OpenBSD
    already.

  - SART address filter: Some of the buffers required by the NVMe
    controller sit behind a simple DMA address filter Apple calls
    SART. It allows to specify up to 16 physical address ranges
    that are allowed and will reject access to anything else.
    Unlike a real IOMMU there's no way to setup pagetables and
    also not all buffers are subject to this filtering. Most
    buffers used by the NVMe commands themselves use an integrated
    IOMMU instead.

  - RTKit IPC protocol: The NVMe controller is running a proprietary
    RTOS Apple calls RTKit and we need to communicate with it in order
    to bring up and use the NVMe controller. This communication happens
    over a mailbox interface that is already upstream. This protocol
    is also used for various other drivers present on these SoCs
    (SMC, display controller, Thunderbolt/USB4).

  - And finally the NVMe driver itself: The driver registers a platform
    device and is mainly based on pci.c with a few special Apple quirks.
    The biggest difference to normal NVMe (except for the missing PCI
    bus) is that command submission works differently: The SQ is
    replaced with a simple array and a command is triggered by writing
    its tag to a MMIO register. Additionally, the command must also be
    setup in the proprietary NVMMU before it can be submitted.
    There is some code duplication with pci.c for the setup of the PRPs.
    Depending on what you prefer this could be moved to a common file
    shared between pci.c and apple.c.

The hardware here is the same hardware that's already used in T2 Macs.
The only difference is that the T2 chip itself initializes the
controller, disable some quirks (the NVMMU and the weird submission
array) and then exposes it over a PCIe interface.

The driver itself has been successfully used by multiple people as
their daily driver for weeks at this point and no major issues have
been reported.
A smaller issue is that flushes on the devices take *much* longer than
expected. Jens Axboe has a workaround where the flushes are delayed but
that one isn't ready for submission yet.

Best,

Sven

[1] https://lore.kernel.org/linux-nvme/YRE7vCyn9d1ClhRm@infradead.org/
[*] The only missing part in this series are the device tree updates
    but since these will go through arm-soc anyway I haven't included
    them here but will instead submit them once this series is in a shape
    where it can be merged.

Sven Peter (6):
  dt-bindings: iommu: Add Apple SART DMA address filter
  dt-bindings: nvme: Add Apple ANS NVMe
  soc: apple: Always include Makefile
  soc: apple: Add SART driver
  soc: apple: Add RTKit IPC library
  nvme-apple: Add initial Apple SoC NVMe driver

 .../devicetree/bindings/iommu/apple,sart.yaml |   52 +
 .../bindings/nvme/apple,nvme-ans.yaml         |  111 ++
 MAINTAINERS                                   |    4 +
 drivers/nvme/host/Kconfig                     |   13 +
 drivers/nvme/host/Makefile                    |    3 +
 drivers/nvme/host/apple.c                     | 1597 +++++++++++++++++
 drivers/soc/Makefile                          |    2 +-
 drivers/soc/apple/Kconfig                     |   24 +
 drivers/soc/apple/Makefile                    |    6 +
 drivers/soc/apple/rtkit-crashlog.c            |  154 ++
 drivers/soc/apple/rtkit-internal.h            |   62 +
 drivers/soc/apple/rtkit.c                     |  958 ++++++++++
 drivers/soc/apple/sart.c                      |  327 ++++
 include/linux/soc/apple/rtkit.h               |  159 ++
 include/linux/soc/apple/sart.h                |   57 +
 15 files changed, 3528 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,sart.yaml
 create mode 100644 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 create mode 100644 drivers/nvme/host/apple.c
 create mode 100644 drivers/soc/apple/rtkit-crashlog.c
 create mode 100644 drivers/soc/apple/rtkit-internal.h
 create mode 100644 drivers/soc/apple/rtkit.c
 create mode 100644 drivers/soc/apple/sart.c
 create mode 100644 include/linux/soc/apple/rtkit.h
 create mode 100644 include/linux/soc/apple/sart.h

-- 
2.25.1

