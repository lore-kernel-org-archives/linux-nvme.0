Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E9ECFB43C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 04:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2hHJWtrCsy6dE9ConpqRHdp9ztV+ROmZ9uWS2+/KJD4=; b=xMdaquRWU7nD1wj/Kna5aZ8oO+
	gvSlzvrsEpH54raR9rGTyvJIS3Vzbpc4oWf29ipLkKrEh6GHbuCYGVQZ/PXk872JEzEpjwlAl1Syk
	/UhFeIQFYEhhdhQY66ms0OmGMH0RFiL6FSSGzDASdPo3bW6HVr9leeg155D95BSpv/0xLqxboPo3k
	+h8ODFIS2viixxfmN7C1w6ZJoSP/cU2t4fhegftOlxPQuCyDwgUd2Fk0Ixg8kuPBsCBaOJ+Ws4xqR
	U7Z00Sx9a8rH5AIqXAYKchLyP9Rav+1e4tlASgtH8zaajvfjsn+u37zfnHlayFVHGnnwrf535/kwV
	hmwpMICA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxfbF-00000001Fjb-3V9o;
	Mon, 07 Oct 2024 04:44:01 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxfbA-00000001Fiz-02oN
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 04:43:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 338B65C5B8F;
	Mon,  7 Oct 2024 04:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D290C4CEC6;
	Mon,  7 Oct 2024 04:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728276233;
	bh=im53CFKZy+1GrlC7y6uTbBfBbSyVogmlK6TyUwF1ayg=;
	h=From:To:Cc:Subject:Date:From;
	b=Obbg0SkjwsjEZaujqBx3DZivatLpS0BY+faGjSFll0MSr/ga5gbaU7iTXm57MQuRX
	 oMM4cuIXzhw2HUko5mV1Jg0YDHxQly+wYwosT/+d8Czshxc1KFo2BbJPRSR/SdKdwo
	 YjvTcsLjMG6kjVctk3Kenu9Ce0IrbKgfDoa2OKz9vTbTtHkIYTLiJe5MF89YImwJQe
	 XJIQYsBqaFozehsjhl2nAIUX3mMNFDpTiC+egCHNMDy96SSqGuOSK1hgJplpWFg84P
	 h/ADLD9Kmtp6GekRCvMaVuHp8TbLCI0x5+zyQs06BL6xdKZM/8j2oNKu6mmFYNtfjU
	 7YSIOFRYHomOA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v1 0/5] NVMe PCI endpoint function driver
Date: Mon,  7 Oct 2024 13:43:46 +0900
Message-ID: <20241007044351.157912-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_214356_162683_D5DF5E39 
X-CRM114-Status: GOOD (  17.23  )
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

This patch series implements an NVMe PCI endpoint driver that implements
a PCIe NVMe controller for a local NVMe fabrics host controller.
This series is based on the improved PCI endpoint API patches "Improve
PCI memory mapping API" (see [1]).

The first 3 patches of this series are changes to the NVMe target and
fabrics code to facilitate reusing the NVMe code and an NVMe host
controller from other (non NVMe) drivers.

Patch 4 is the main patch which introduces the NVMe PCI endpoint driver.
This patch commit message provides and overview of the driver design and
operation.

Finally, patch 5 adds documentation files to document the NVMe PCI
endpoint function driver internals, provide a user guide explaning how
to setup an NVMe PCI endpoint device and describe the NVMe endpoint
function driver binding attributes.

This driver has been extensively tested using a Radxa Rock5B board
(rk3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
board (however, this board does not support PCI DMA, leading to very
poor performance).

Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
with a null-blk block device loop target, performance was measured
using fio as follows:                                      

 +----------------------------------+------------------------+
 | Workload                         | IOPS (BW)              |
 +----------------------------------+------------------------+
 | Rand read, 4KB, QD=1, 1 job      | 7382 IOPS              |
 | Rand read, 4KB, QD=32, 1 job     | 45.5k IOPS             |
 | Rand read, 4KB, QD=32, 4 jobs    | 49.7k IOPS             |
 | Rand read, 128KB, QD=32, 1 job   | 10.0k IOPS (1.31 GB/s) |
 | Rand read, 128KB, QD=32, 4 jobs  | 10.2k IOPS (1.33 GB/s) |
 | Seq read, 128KB, QD=32, 1 job    | 1.28 GB/s              |
 | Seq read, 512KB, QD=32, 1 job    | 1.28 GB/s              |
 | Rand write, 128KB, QD=32, 1 job  | 8713 IOPS (1.14 GB/s)  |
 | Rand write, 128KB, QD=32, 4 jobs | 8103 IOPS (1.06 GB/s)  |
 | Seq write, 128KB, QD=32, 1 job   | 8557 IOPS (1.12 GB/s)  |
 | Seq write, 512KB, QD=32, 1 job   | 2069 IOPS (1.08 GB/s)  |
 +----------------------------------+------------------------+

These results use the default MDTS of the NVMe enpoint driver of 128 KB.
Setting the NVMe endpoint device with a larger MDTS of 512 KB leads to
improved maximum throughput of up to 2.4 GB/s (e.g. for the 512K random
read workloads and sequential read workloads). The maximum IOPS achieved
with this larger MDTS does not change significantly.

This driver is not intended for production use but rather to be a
playground for learning NVMe and NVMe over fabrics and exploring/testing
new NVMe features while providing reasonably good performance.

[1] https://lore.kernel.org/linux-pci/20241007040319.157412-1-dlemoal@kernel.org/T/#t

Damien Le Moal (5):
  nvmet: rename and move nvmet_get_log_page_len()
  nvmef: export nvmef_create_ctrl()
  nvmef: Introduce the NVME_OPT_HIDDEN_NS option
  PCI: endpoint: Add NVMe endpoint function driver
  PCI: endpoint: Document the NVMe endpoint function driver

 .../endpoint/function/binding/pci-nvme.rst    |   34 +
 Documentation/PCI/endpoint/index.rst          |    3 +
 .../PCI/endpoint/pci-nvme-function.rst        |  151 +
 Documentation/PCI/endpoint/pci-nvme-howto.rst |  190 ++
 MAINTAINERS                                   |    9 +
 drivers/nvme/host/core.c                      |   17 +-
 drivers/nvme/host/fabrics.c                   |   11 +-
 drivers/nvme/host/fabrics.h                   |    5 +
 drivers/nvme/target/admin-cmd.c               |   20 +-
 drivers/nvme/target/discovery.c               |    4 +-
 drivers/nvme/target/nvmet.h                   |    3 -
 drivers/pci/endpoint/functions/Kconfig        |    9 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
 include/linux/nvme.h                          |   19 +
 15 files changed, 2935 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/function/binding/pci-nvme.rst
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c

-- 
2.46.2


