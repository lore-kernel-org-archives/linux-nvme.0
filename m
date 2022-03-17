Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEE1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lQ3egY4aIxLGH+D0H1ibKTPYVnLPBH+PAR5tYmFKY7s=; b=C0iNSFzShW2zfJixyWhbcLxIeX
	S+EluWue3il4QkEpRzOxajnSDcZK55EVsDjxOK42IBpZsJtbzTReSLGJgifJGW+37zZO51qTF1Cti
	Xd8fgvE67Z6SUT36z5yMwxe7qtO86yeBnjgm5rigl5ejoWz7N8GGD1sr/DaoMGjj6zqM13iQfgNi9
	svbjaacRdp5/+s0CxSNvrb/bpybPiA0OHDlDBbF2sJan1ixaS6iSNCGw7nkDBhKTZgqLYADlcCFe7
	K2bmwbWDr7e7t3Ofste5MSLRyJJI1tsOWekscwXNV4m3QoeUZg6moyqhP0dRCu/8DJrsJ+HHPc7oA
	KuQkqYWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUtbq-00Gsfr-GQ; Thu, 17 Mar 2022 17:08:22 +0000
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUtbo-00Gsfc-Ps; Thu, 17 Mar 2022 17:08:21 +0000
Date: Thu, 17 Mar 2022 18:08:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.18
Message-ID: <YjNrAsjvdSd+abfu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 85d9abcd7331566781b93ff46e4bccd4806ef2b2:

  xen/blkfront: speed up purge_persistent_grants() (2022-03-11 05:15:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-17

for you to fetch changes up to ce8d78616a6b637d1b763eb18e32045687a84305:

  nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH (2022-03-16 16:48:00 +0100)

----------------------------------------------------------------
second round of nvme updates for Linux 5.18

 - add lockdep annotations for in-kernel sockets (Chris Leech)
 - use vmalloc for ANA log buffer (Hannes Reinecke)
 - kerneldoc fixes (Chaitanya Kulkarni)
 - cleanups (Guoqing Jiang, Chaitanya Kulkarni, me)
 - warn about shared namespaces without multipathing (me)

----------------------------------------------------------------
Chaitanya Kulkarni (7):
      nvme-tcp: don't initialize ret variable
      nvme-tcp: don't fold the line
      nvmet-fc: fix kernel-doc warning for nvmet_fc_register_targetport
      nvmet-fc: fix kernel-doc warning for nvmet_fc_unregister_targetport
      nvmet-rdma: fix kernel-doc warning for nvmet_rdma_device_removal
      nvmet: don't fold lines
      nvmet: use snprintf() with PAGE_SIZE in configfs

Chris Leech (1):
      nvme-tcp: lockdep: annotate in-kernel sockets

Christoph Hellwig (4):
      nvmet: move the call to nvmet_ns_changed out of nvmet_ns_revalidate
      nvme: cleanup how disk->disk_name is assigned
      nvme: remove nvme_alloc_request and nvme_alloc_request_qid
      nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH

Guoqing Jiang (1):
      nvme-multipath: call bio_io_error in nvme_ns_head_submit_bio

Hannes Reinecke (1):
      nvme-multipath: use vmalloc for ANA log buffer

 drivers/block/loop.c            |  1 +
 drivers/nvme/host/core.c        | 76 ++++++++++++++++++++---------------------
 drivers/nvme/host/ioctl.c       |  3 +-
 drivers/nvme/host/multipath.c   | 32 +++--------------
 drivers/nvme/host/nvme.h        | 16 ++++-----
 drivers/nvme/host/pci.c         | 17 +++++----
 drivers/nvme/host/tcp.c         | 45 ++++++++++++++++++++++--
 drivers/nvme/target/admin-cmd.c |  6 +++-
 drivers/nvme/target/configfs.c  | 30 ++++++++--------
 drivers/nvme/target/core.c      |  5 ++-
 drivers/nvme/target/fc.c        |  4 +--
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/passthru.c  |  3 +-
 drivers/nvme/target/rdma.c      |  2 +-
 drivers/nvme/target/zns.c       |  6 +++-
 15 files changed, 138 insertions(+), 110 deletions(-)

