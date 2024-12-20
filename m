Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58BAE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g88WSairfU7bvCcvW22a2ed9sDtNHGLom2D7ARKeGKM=; b=DvrFVqcDu2k9woxSFOiL0k2ajo
	vO/PbZ5RfzO1E7i21aTNTYdcxZuJACqiulZZL8CtD6G13MyHDgCctZuIbSh9tb7qB9/NSdqbq8aHO
	hd47hjYS6MiSPsL9Gv/M+lPdsUdBHDWB+2fEHrN8XiofTxjOLVbIprejQGZ+fJAOYdpkIkaMYpa8m
	1Unh1MxetkCUXGTn3uxeObBfOd3GADO3EkvM0tGua/c25727yohDoxY+1oa6yeNB6EobGQ18fZNhf
	eRPY4/WAgq8i7bQP6KEyFRT+z9K7Tjwm0plUzDpHxw6wJpZg3Xx9gokZ2NkpE+zq7cq57beZ28v58
	y/RP2TyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZeg-00000004T7J-0OI5;
	Fri, 20 Dec 2024 09:50:46 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOZed-00000004T6e-1ri9
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 09:50:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E10F3A40496;
	Fri, 20 Dec 2024 09:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8FBC4CECD;
	Fri, 20 Dec 2024 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688242;
	bh=+AcctufWP2IqX10xnwdS8OfGcZA1o4W9paD5B3nzZf0=;
	h=From:To:Cc:Subject:Date:From;
	b=HVN3Cl5bXcpbsLah4y1rz7vWlvwgz1FwhMQASaQg+gGRcheT34lP/AcfoR0CXdNsX
	 5I95LJ1R4Pd7PNZL7xe+UCZXMKW1rHZvzv1MuH8vN1iXs0ErLKM7HsfMKeIts5etJp
	 PPPXhKSkO1i/QNnEAZkyo4fjFuzw2sbcsVVvf5rFS+b+V15Th0jBy2fwtv8P9NsHvF
	 RJ9DUaRj2XEK7CJVvdQO0mku4DcptRLc2H0gNGubQJobKxZOiOjfXTnkOI1W/VU/Px
	 k2Srgz6nX3vjHaApwmtsw47t2Qsqnct28vZP+bEU4xj5c185hWPDSdddQJSpAzXOhP
	 CAd2PZhEm/w4A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v7 00/18] NVMe PCI endpoint target driver
Date: Fri, 20 Dec 2024 18:50:50 +0900
Message-ID: <20241220095108.601914-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_015043_622115_F480DF94 
X-CRM114-Status: GOOD (  28.47  )
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

This patch series implements an NVMe target driver for the PCI transport
using the PCI endpoint framework.

The first 5 patches of this series move and cleanup some nvme code that
will be reused in following patches.

Patch 6 introduces the PCI transport type to allow setting up ports for
the new PCI target controller driver. Patch 7 to 10 are improvements of
the target core code to allow creating the PCI controller and processing
its nvme commands without the need to rely on fabrics commands like the
connect command to create the admin and I/O queues.

Patch 11 relaxes the SGL check in nvmet_req_init() to allow for PCI
admin commands (which must use PRPs).

Patches 12 to 16 improve the set/get feature support of the target code
to get closer to achieving NVMe specification compliance. These patches
though do not implement support for some mandatory features.

Patch 17 is the main patch which introduces the NVMe PCI endpoint target
driver. This patch commit message provides and overview of the driver
design and operation.

Finally, patch 18 documents the NVMe PCI endpoint target driver and
provides a user guide explaning how to setup an NVMe PCI endpoint
device.

The patches are base on Linus 6.13-rc3 tree.

This driver has been extensively tested using a Radxa Rock5B board
(RK3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
board. However, this board does not support DMA channels for the PCI
endpoint controller, leading to very poor performance.

Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
with a null-blk block device loop target, performance was measured using
fio as follows:

 +----------------------------------+------------------------+
 | Workload                         | IOPS (BW)              |
 +----------------------------------+------------------------+
 | Rand read, 4KB, QD=1, 1 job      | 14.3k IOPS             |
 | Rand read, 4KB, QD=32, 1 job     | 80.8k IOPS             |
 | Rand read, 4KB, QD=32, 4 jobs    | 131k IOPS              |
 | Rand read, 128KB, QD=32, 1 job   | 16.7k IOPS (2.18 GB/s) |
 | Rand read, 128KB, QD=32, 4 jobs  | 17.4k IOPS (2.27 GB/s) |
 | Rand read, 512KB, QD=32, 1 job   | 5380 IOPS (2.82 GB/s)  |
 | Rand read, 512KB, QD=32, 4 jobs  | 5206 IOPS (2.27 GB/s)  |
 | Rand write, 128KB, QD=32, 1 job  | 9617 IOPS (1.26 GB/s)  |
 | Rand write, 128KB, QD=32, 4 jobs | 8405 IOPS (1.10 GB/s)  |
 +----------------------------------+------------------------+

These results use the default MDTS of the NVMe enpoint driver of 512 KB.

This driver is not intended for production use but rather to be a
playground for learning NVMe and exploring/testing new NVMe features
while providing reasonably good performance.

Changes from v6:
 - Fixed incorrect bar cleanup in patch 17 causing a NULL pointer
   dereference when PERST# is asserted
 - Added Mani's review tag to path 18

Changes from v5:
 - Rebased on 6.13-rc3
 - Addressed most of Mani's comment on patch 17:
   - Renaming of functions and data structures
   - Error messages format
   - Removed dma_enable configfs knob and simplified DMA initialization
     and cleanup.
   - Simplified some error path
   - Fixed up handling of icontrollers with a fixed bar 0 size
   Of note is that I did not define macros for the bits of the CAP
   register as that would be too much for now since we want to do this
   correctly in include/linux/nvme.h by defining all of them, and by
   using these definitions in the nvme host and target code. This can be
   done in a followup patch series once this is applied.
 - Fixed the command examples in patch 18

Changes from v4:
 - Fixed typos in patch 13 and 17 commit message
 - Addressed Bjorn's comments (typos and text clarity) in patch 18.
 - Added Bjorn's Acked-by tag to patch 18

Changes from v3:
 - Added patch 1 which was missing from v3 and caused the 0day build
   failure
 - Corrected a few typos in the documentation (patch 18)
 - Added Christoph's review tag and Rick's tested tag

Changes from v2:
 - Changed all preparatory patches before patch 16 to move more NVMe
   generic code out of the PCI endpoint target driver and into the
   target core.
 - Changed patch 16 to use directly a target controller instead of a
   host controller. Many aspects of the command management and DMA
   transfer management have also been simplified, leading to higher
   performance.
 - Change the documentation patch to match the above changes

Changes from v1:
 - Added review tag to patch 1
 - Modified patch 4 to:
   - Add Rick's copyright notice
   - Improve admin command handling (set_features command) to handle the
     number of queues feature (among others) to enable Windows host
   - Improved SQ and CQ work items handling

Damien Le Moal (18):
  nvme: Move opcode string helper functions declarations
  nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
  nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
  nvmet: Introduce nvmet_get_cmd_effects_admin()
  nvmet: Add drvdata field to struct nvmet_ctrl
  nvme: Add PCI transport type
  nvmet: Improve nvmet_alloc_ctrl() interface and implementation
  nvmet: Introduce nvmet_req_transfer_len()
  nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
  nvmet: Add support for I/O queue management admin commands
  nvmet: Do not require SGL for PCI target controller commands
  nvmet: Introduce get/set_feature controller operations
  nvmet: Implement host identifier set feature support
  nvmet: Implement interrupt coalescing feature support
  nvmet: Implement interrupt config feature support
  nvmet: Implement arbitration feature support
  nvmet: New NVMe PCI endpoint function target driver
  Documentation: Document the NVMe PCI endpoint target driver

 Documentation/PCI/endpoint/index.rst          |    1 +
 .../PCI/endpoint/pci-nvme-function.rst        |   13 +
 Documentation/nvme/index.rst                  |   12 +
 .../nvme/nvme-pci-endpoint-target.rst         |  368 +++
 Documentation/subsystem-apis.rst              |    1 +
 drivers/nvme/host/nvme.h                      |   39 -
 drivers/nvme/target/Kconfig                   |   10 +
 drivers/nvme/target/Makefile                  |    2 +
 drivers/nvme/target/admin-cmd.c               |  388 ++-
 drivers/nvme/target/configfs.c                |   49 +
 drivers/nvme/target/core.c                    |  266 +-
 drivers/nvme/target/discovery.c               |   17 +
 drivers/nvme/target/fabrics-cmd-auth.c        |   14 +-
 drivers/nvme/target/fabrics-cmd.c             |  101 +-
 drivers/nvme/target/nvmet.h                   |  110 +-
 drivers/nvme/target/pci-epf.c                 | 2610 +++++++++++++++++
 include/linux/nvme.h                          |   42 +
 17 files changed, 3883 insertions(+), 160 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/nvme/index.rst
 create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
 create mode 100644 drivers/nvme/target/pci-epf.c


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.1


