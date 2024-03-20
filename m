Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF1C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/LSeLa9msPk6YgUHSiQAqxbLhMEBSebFzQQueUy+h5U=; b=J9JuCfGm4AFbJTUnsVnOorvOqJ
	ivsvkEz6IunztdO1PJMFB37WEXhA9ejptu/bzNx8gkNGr0/N+CCAG+lWRch+5Lpewe1UVJ7xZ08cC
	GQTk98hDMSQyS7XSj02CbRwJ6dITG/byt/AeoQUqzixUde5k6zeHcOuoaVrzt2BjadkzIHyj93oNT
	8IuMFX8VvtKGx+qTtYjX/Yu1tfAL3g/K7IenFCtVprOAItZk2DCiq2rdjvSyBBb3JjIZP0w2s8Tjj
	GitOQE+9cZmLNYmARANwCmlv0V6KWxslU0OikFUUSqlVeAKJTJXmMUcRH8tJEOonRSdtK0QGqGX/z
	1I7u2bdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7G-0000000HTmG-3fwl;
	Wed, 20 Mar 2024 14:40:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7D-0000000HTl7-3I7R
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C4F8ACE1152;
	Wed, 20 Mar 2024 14:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F30FC433C7;
	Wed, 20 Mar 2024 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945625;
	bh=V9c7GjSFg7K4o/PxFSlLC4y0qTNvtOw7NQ9PQspaZ50=;
	h=From:To:Cc:Subject:Date:From;
	b=R2jWDlt7VFI3ZOdeY5hXHdU+JVgY8V35RajkBzJgBlZsC/BvSFb9c1jC9HPO9xSP/
	 8WV1ehaGNbiZ2Xvw9d4gYnkbU1vf93pNOjZWxUUc8zWbbZWnneKlpPBkRxP+YOujGV
	 /ib/r6icmOp18jcVGo+XBIcUIiCSAjXPbDhysxLRWP9LFaN5qd4ba9S52z/R681XVg
	 9fOjjEl6f4kiSisRQ+YmXlOmUzBT2JDy/vZRg30LJpFpoheTkLtf5qIZhnpwALMPlK
	 Lu/7pxj//+CgPb7R1KQBTHCn+/VVrdwpUXJzytmV/ItV3RnQvZkA2t1+74H8DfWUV+
	 RhMY3way6S/Rg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/7] nvmet: debugfs support
Date: Wed, 20 Mar 2024 15:40:10 +0100
Message-Id: <20240320144017.106283-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074028_021824_2CCEA916 
X-CRM114-Status: GOOD (  11.88  )
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
      queue<qnum>
        host_traddr
	sqsize
	sqhead

The 'state' attribute is the value of the
CSTS register; one can trigger a controller reset
by writing 'fatal' into it (to set CSTS.CFS).

As usual, comments and reviews are welcome.

Hannes Reinecke (7):
  nvmet: add debugfs support
  nvmet: add debugfs support for queues
  nvmet-tcp: implement queue_peer_traddr()
  nvmet-rdma: implement queue_peer_traddr()
  nvmet-fc: implement queue_peer_traddr()
  nvme-fcloop: implement 'host_traddr'
  lpfc_nvmet: implement 'host_traddr'

 drivers/nvme/target/Kconfig    |   9 ++
 drivers/nvme/target/Makefile   |   1 +
 drivers/nvme/target/core.c     |  32 ++++-
 drivers/nvme/target/debugfs.c  | 250 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h  |  50 +++++++
 drivers/nvme/target/fc.c       |  25 ++++
 drivers/nvme/target/fcloop.c   |  12 ++
 drivers/nvme/target/nvmet.h    |  15 +-
 drivers/nvme/target/rdma.c     |  11 ++
 drivers/nvme/target/tcp.c      |  13 ++
 drivers/scsi/lpfc/lpfc_nvmet.c |  12 ++
 include/linux/nvme-fc-driver.h |   1 +
 12 files changed, 428 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h

-- 
2.35.3


