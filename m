Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A328CD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XpP36Xge70YgZhUMj3rmT1c2CoYf3PScNbZeqTIcI28=; b=oPL7yaVpAEr4ihdy3DdiztxRE7
	WHyzWxs8CslLVTTt8iuEawHLrFQQCNbxy598Wbzjsw0fI5zEtMDdhxXrWA2tgi2rH2xI7pZWKczol
	MDy2MktZnwJBmVIwvpr4IlqEjSvonWR60Bz2esg5TlrCe7dPPoEqqluHCh9/eG9w2td8JInsf1N30
	/c9MSX7gjwVxFdo1IxTYKHyh+06QOwIPTJbqLC35QWQ2TAoL85yarOn6Bkzc6nVGVnd5chVDPq34N
	LYtxVLsysOfrN8nKxddINSl4tT9057Xp7Ifj2g52jYWX030aBCrNXcC5HvvrW7fMkO5Oe1no50wNX
	kSmKyOXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X4-00000004NTo-0o7d;
	Tue, 26 Mar 2024 12:03:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X1-00000004NT9-3uNS
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:03:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E594CE20B2;
	Tue, 26 Mar 2024 12:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87469C433C7;
	Tue, 26 Mar 2024 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454631;
	bh=LQAqriEV6sw8uFQMM0J39A4LTm6xoSm4hTMkH8xNBj4=;
	h=From:To:Cc:Subject:Date:From;
	b=l+j703IkqANRjr1m05uh8hm7LK6uI5JBSW1GomZl7ptvCsF9vdWYz8syF89sfhc4G
	 RGa2sWhm+noyghmN6cDRJnpqrm2PTz5NmJooXuBGn1P7Ih69hGRR9Vn1hgZ5dBc9Yn
	 yWmdqYz9iLj4VWNsokIepi+LWANoI3qKK3jYCGPW0KdXsmjwLkYPlT0tGTaQNhXZ1w
	 8fZSdEmTAcf3Vikcmq2d+JRJmFmLUL+f5nkaCWkmYljf05P2E6P/TWIB5cjF+NhyyM
	 mIFAea8ElR3+ZQpjhMN5WgomIcO1Ow+/YjtwnoAwElerD6whSKW/BnNTojozhj/fis
	 x2vYlf0YFyB1A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv4 0/7] nvmet: debugfs support
Date: Tue, 26 Mar 2024 13:03:35 +0100
Message-Id: <20240326120342.105740-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050356_197399_59753075 
X-CRM114-Status: GOOD (  12.85  )
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

Hi all,

taking up the original patchset for nvmet debugfs
I've improved upon that submission by modifying
the layout:

/dev/kernel/debug/nvmet
  <subsysnqn>
    ctrl<cntlid>
      port
      state
      hostnqn
      kato
      host_traddr

The 'state' attribute is the value of the
CSTS register; one can trigger a controller reset
by writing 'fatal' into it (to set CSTS.CFS).

As usual, comments and reviews are welcome.

Changes to v3:
- drop patch to add queue entries
- Reviews from Sagi

Changes to v2:
- Move the 'host_traddr' attribute to the
  controller directory
- Rename callback to 'host_traddr'

Hannes Reinecke (7):
  nvmet: add debugfs support
  nvmet: add 'host_traddr' callback for debugfs
  nvmet-tcp: implement host_traddr()
  nvmet-rdma: implement host_traddr()
  nvmet-fc: implement host_traddr()
  nvme-fcloop: implement 'host_traddr'
  lpfc_nvmet: implement 'host_traddr'

 drivers/nvme/target/Kconfig    |   9 ++
 drivers/nvme/target/Makefile   |   1 +
 drivers/nvme/target/core.c     |  30 ++++-
 drivers/nvme/target/debugfs.c  | 202 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h  |  42 +++++++
 drivers/nvme/target/fc.c       |  33 ++++++
 drivers/nvme/target/fcloop.c   |  11 ++
 drivers/nvme/target/nvmet.h    |  12 +-
 drivers/nvme/target/rdma.c     |  12 ++
 drivers/nvme/target/tcp.c      |  14 +++
 drivers/scsi/lpfc/lpfc_nvmet.c |  11 ++
 include/linux/nvme-fc-driver.h |   4 +
 12 files changed, 378 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h

-- 
2.35.3


