Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64E8C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 05:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qtOn3SQ3RmFsMdqFKAQ8GoSFt3DpS+Q6acuvpeBVcME=; b=3R6TUT8k9IjOqIAO/nV2fnoo5H
	1+PVQCzYfWaKEG4eeiUe92anHgJY7XiT+Z8Lli6z+kVE7w+5jgTZo9mSTHwdLryJrrjRWB7wJFu7W
	G3Om91n1pKCAu6L8WQm0jjMFgIGsCFviuBbOuIGa81BbAhQz6sQsOeKXeO6frWoP3eV9r5lvrmL24
	FBnpOyg0jTNdb8RiRhN0qTJtqPX7RqWU5qZ0pr0vpAmLu9+KBpiYhlFch7jyKl8NYNdM649//n9lD
	Am9/YLfHQkPfQ+Zj7Gxb1q73qIDhfOQXOBR3pMs8Ax/3Vt9byuMccHPTRRJdjeQefTHpokH591nnY
	Mx1k7GtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2QyR-001fMT-39; Tue, 06 Dec 2022 05:58:35 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2QyL-001fJj-Pw
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 05:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670306309; x=1701842309;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nLZI0skm1dszqhAO48j8Bg824jpCNH+WDBB/e0YlLoE=;
  b=IZfljVk5hN8iFC6U5IN3LxsFbyAuRLb+WJ1Lmp84jeBRKHKQAHC6VN5J
   3EhaRRx4n4GWDRHAlee5WD1+N9OslBD+WN7ysrG9l+yrfWwol++Gfw0Oz
   hDeo19hLZhBLkQCCVAmN/KvKRccPBQm2m1/HgwscxDx2mmMleneSndLsn
   LLKuYldDMHWJirAY10jyJlm6YI2qSlc6f6vX6MKgKQc8M9Y07v/d4EGdJ
   IcTL8MrrpLoBpoHrK+Yto82UuRw5vsZXyfRQnyJx0YyHqsezmOc3qulL8
   bpbdYGNTHX2sLYQ8+iYjkMNPtwrGj1UmcXQ4KmdneN6ssX28pLPCAIOu7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378706582"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="378706582"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 21:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="648211171"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="648211171"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2022 21:58:23 -0800
From: Lei Rao <lei.rao@intel.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	kch@nvidia.com,
	hch@lst.de,
	sagi@grimberg.me,
	alex.williamson@redhat.com,
	cohuck@redhat.com,
	jgg@ziepe.ca,
	yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com,
	kevin.tian@intel.com,
	mjrosato@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org
Cc: eddie.dong@intel.com,
	yadong.li@intel.com,
	yi.l.liu@intel.com,
	Konrad.wilk@oracle.com,
	stephen@eideticom.com,
	hang.yuan@intel.com,
	Lei Rao <lei.rao@intel.com>
Subject: [RFC PATCH 0/5] Add new VFIO PCI driver for NVMe devices
Date: Tue,  6 Dec 2022 13:58:11 +0800
Message-Id: <20221206055816.292304-1-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_215830_015019_7666F317 
X-CRM114-Status: GOOD (  12.21  )
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

Some devices, such as Infrastructure Processing Units (IPUs) and Data
Processing Units (DPUs), expose SR-IOV capable NVMe devices to the host.
Its VF devices support live migration via specific NVMe commands issued
through the PF's device's admin queue.

One of the problems is there are no standardized NVMe live migration
commands to make our patches spec compliant, which prevents us from
creating a spec-compliant implementation. So we've created a reference
implantation based on the Vendor-specific command fields of the protocol.
We want these commands to be standardized so that the implementation will
be spec compliant in future versions and use this RFC as a basis for the
same.

More importantly, we provide our work to help the community and start the
discussion, so everyone can participate and benefit from our work in
NVMe Live Migration implementation and help drive on standardization
efforts.

This series implements the specific vfio-pci driver to support live
migration of NVMe devices. Adds a new interface in the general
NVMe driver to receive the VF device's commands submission to the PF
device's admin queue. And also documents the details of NVMe device
live migration commands.

Any feedback and comments are greatly appreciated.

Lei Rao (5):
  nvme-pci: add function nvme_submit_vf_cmd to issue admin commands for
    VF driver.
  nvme-vfio: add new vfio-pci driver for NVMe device
  nvme-vfio: enable the function of VFIO live migration.
  nvme-vfio: check if the hardware supports live migration
  nvme-vfio: Add a document for the NVMe device

 drivers/nvme/host/pci.c        |  18 +
 drivers/vfio/pci/Kconfig       |   2 +
 drivers/vfio/pci/Makefile      |   2 +
 drivers/vfio/pci/nvme/Kconfig  |  10 +
 drivers/vfio/pci/nvme/Makefile |   3 +
 drivers/vfio/pci/nvme/nvme.c   | 636 +++++++++++++++++++++++++++++++++
 drivers/vfio/pci/nvme/nvme.h   | 111 ++++++
 drivers/vfio/pci/nvme/nvme.txt | 278 ++++++++++++++
 8 files changed, 1060 insertions(+)
 create mode 100644 drivers/vfio/pci/nvme/Kconfig
 create mode 100644 drivers/vfio/pci/nvme/Makefile
 create mode 100644 drivers/vfio/pci/nvme/nvme.c
 create mode 100644 drivers/vfio/pci/nvme/nvme.h
 create mode 100644 drivers/vfio/pci/nvme/nvme.txt

-- 
2.34.1


