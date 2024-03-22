Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C9DC47DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RFRGpQyspgtQCZmpywCdm/v1YtUVHiumsq8ec9bYV+s=; b=0FG89JFZmz7Rtc6Y68facQJGu8
	8mGadQ0ZST/oQutokyWFAJJzw4CbX1rJfLWvsk2r5EIdIMxa28Twng0DNXqQ1kki0iVR+3vie+IPh
	AfFgfUOTN73P+F9gCIE8F5ZdTh7/L/kMCEQdkEIU5dbEJQgXt+oNYX/aP1nSpQi9yvtejcJFsdqt3
	c/1Q7sD0wbcN7xoD+axvUkVuJAZlEfd2YDvs19ZZ6h8+fMpo2bdT0hTjUxlBE7Y0jlYq75xdfOr1d
	Qt1zwjywGZcGk2n3wFyByWhO33h/uXYxaypuSTrM58esK7lArpBoqLfgND9mVscmbuPGZebDhe+j8
	d71vohug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwK-000000067Mq-1FL9;
	Fri, 22 Mar 2024 07:03:44 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwH-000000067KI-4BHW
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3CCB6CE16D2;
	Fri, 22 Mar 2024 07:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F35C433C7;
	Fri, 22 Mar 2024 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091018;
	bh=qLGEjFUTqm7ie5rtH4ssD9EuA3uPyYl8g5jeiPhGZtA=;
	h=From:To:Cc:Subject:Date:From;
	b=s8cnidSaizfyKP4YuygwwXjKoQuijWLWy3bmbRHDnP/627+rWQAm3rw32e65essgI
	 ytzuz7u0b9eoN62JYeH5RSq0jvJC9xVmYtms1VGjEhMfKIFS3pMlqdgo5XsJ1l2pL6
	 yeAETlenTdojWio2b+ceYqYken6mEPMpTC+egik3zACxa6neKFJ1VlJ7LJbkLTapBQ
	 eVNwjYinQc42SC5C8EmRLj7/N4dBBlGZJbIq8gFjdobH0YWmQNhHfpNdQjSWbGsPsi
	 auWDpHPPtUkeOMwLPyWoLjfGnyKmIq6Wvhccrk/GSGs6XsPZveQTtLG6qw2jK61aRh
	 yplOJXc2S800A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/8] nvmet: debugfs support
Date: Fri, 22 Mar 2024 08:03:25 +0100
Message-Id: <20240322070333.3820-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000342_275312_CF56A461 
X-CRM114-Status: GOOD (  12.88  )
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
      queue<qnum>
	sqsize
	sqhead

The 'state' attribute is the value of the
CSTS register; one can trigger a controller reset
by writing 'fatal' into it (to set CSTS.CFS).

As usual, comments and reviews are welcome.

Changes to v2:
- Move the 'host_traddr' attribute to the
  controller directory
- Rename callback to 'host_traddr'

Hannes Reinecke (8):
  nvmet: add debugfs support
  nvmet: add 'host_traddr' callback for debugfs
  nvmet-tcp: implement host_traddr()
  nvmet-rdma: implement host_traddr()
  nvmet-fc: implement host_traddr()
  nvme-fcloop: implement 'host_traddr'
  lpfc_nvmet: implement 'host_traddr'
  nvmet: add debugfs support for queues

 drivers/nvme/target/Kconfig    |   9 ++
 drivers/nvme/target/Makefile   |   1 +
 drivers/nvme/target/core.c     |  32 ++++-
 drivers/nvme/target/debugfs.c  | 250 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h  |  50 +++++++
 drivers/nvme/target/fc.c       |  33 +++++
 drivers/nvme/target/fcloop.c   |  11 ++
 drivers/nvme/target/nvmet.h    |  15 +-
 drivers/nvme/target/rdma.c     |  12 ++
 drivers/nvme/target/tcp.c      |  14 ++
 drivers/scsi/lpfc/lpfc_nvmet.c |  11 ++
 include/linux/nvme-fc-driver.h |   4 +
 12 files changed, 439 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h

-- 
2.35.3


