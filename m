Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BE6C3ABCB
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7CU1nzrKa2FmGWv4/rzkR5UNKxwOPYV0rkgLEm4cA8I=; b=EQ5JWBDh10ycvtE/7cfbd+eQeC
	fFpywRKajA6tSLcMMMuRvX0qFsglWWvUeN56tYZT5EK908WoHHT0/Br1QonGM5CXkeA8hRZSp0usE
	56xOTObq9rEr1FmSxsp8s5Wmj19AhP1mlx3+OXqpSR4LNM3bcI2GumOJTj62jPnnzmiELH2+M8Ldc
	LtlgEdlHL2ptSRLxL+wHgf7fFTvzw5sHqU45cYNX04f4kqZ0XgJYo3Izh0QM0HiUwoXPtJ1BXlnx9
	OsfiqKV233+BX1n8rl290K6lUJiAgrW1mjz6RMUbBs8OmOJfWDCIAXm+o5QafF9SSUO44rM4vVR74
	nXVUkQuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdA-00000001ynx-2bEY;
	Thu, 08 May 2025 23:26:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAd6-00000001ymj-3MC6
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:26:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0330C5C5F1F;
	Thu,  8 May 2025 23:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F415C4CEE7;
	Thu,  8 May 2025 23:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746775;
	bh=qGheE2iJtaSApTKAZAEMHGoG5fUNKtBHiqeIhCv4Naw=;
	h=From:To:Subject:Date:From;
	b=ePwvL8H5T53Y4rkPgJKxy3tXeWoEXU4Ep5f3uEekOTh59m5ZgDDWrWWXep4RYj2vr
	 Fo3GBIIpgPjwUNdfAYNZ7NwT3LnsNHLJkpbjd2jL+PA6E3G4IiWhV0tB/y22+wV8dY
	 LN40OAMdPShN2FXNTUgRRQUl+VS3/GiI4trT2bzPFBFwX/P6j3+4NUgc25CX2mmIBz
	 xDV5kKrr8lcv3ipNASIDoV2pjVx6pBW3FoZRjUOwrdcJh/PFZNlihyDxrsgI8b8lXv
	 jSLQqSzadNSuLLSDKyAuGDIR65A42by21JX4+RFIJkDVLVBmlfGRR7AlqFCm2Jhy8Y
	 CvwXykoW0NYwA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 0/5] nvmet pci-epf fixes
Date: Fri,  9 May 2025 08:24:59 +0900
Message-ID: <20250508232504.437470-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_162616_878919_ADE35678 
X-CRM114-Status: UNSURE (   9.37  )
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

Five patches to fix and improve IRQ handling in the PCI endpoint target
driver. The issues fixed by the first 2 patches where discovered with
testing with polling queues set on the host side. The following 2
patches are small improvements/cleanup in the same IRQ handling area.
The last patch removes dead code.

Changes from v1:
 - Fixed typos in patch 1 and 2
 - Removed Fixes tag from patch 2 as a backport to 6.14 would lead to
   compilation errors
 - Added Review tags to patch 3 and 4
 - Added patch 5

Damien Le Moal (5):
  nvmet: pci-epf: Clear completion queue IRQ flag on delete
  nvmet: pci-epf: Do not fall back to using INTX if not supported
  nvmet: pci-epf: Cleanup nvmet_pci_epf_raise_irq()
  nvmet: pci-epf: Improve debug message
  nvmet: pci-epf: Remove NVMET_PCI_EPF_Q_IS_SQ

 drivers/nvme/target/pci-epf.c | 39 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

-- 
2.49.0


