Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B4AC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Cuh8rIbSKB+R09DQzgPLnE2esUg6/ZxkC00J0SWcDpU=; b=sC5J3oCe0LPTiDrZmseari/UhQ
	jHnWauxTmnL+c2FUOGOvIfiexQRCRgnBif0oVTxZXJzfmaSNL1GHBlz2ORD+Gdu/2TSl3i9unPbYq
	loKuVghcsYyScablZQbs4ieiYPLrIeWRlCCoAmXYzf6kYflee5wHpnSrFboP/McxA18u6EAwKtxRS
	m9xuXWn1jFnY0WQg+YdB25OKX27g+psbjvj97+txnGbeeYE6b9ckvn0K2QgsXjB7+ErioR58uI/wn
	PKd+JgzyTBUKBm853sDS0hqq72TlbFBwTt6OUJYRHx6GjMwNoVj2X/E/C8cCxYZsvgzC0WheZ8VpQ
	XJuAG3og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQlr-004DXz-2c;
	Thu, 21 Dec 2023 21:39:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQlo-004DWp-2e
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:39:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0841361AB2;
	Thu, 21 Dec 2023 21:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D06CC433C7;
	Thu, 21 Dec 2023 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703194795;
	bh=Zi1MgUbmtfPMwH9SoEsqOz0+k75CaTcrOo8xd0fGAHQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ft3H5KLEo8pZy1517yAakzSrCQCSOCPTzH8VCFnulqea8OyXjRMIujljPRtHS/sQl
	 p2M/m6xQbzuUSxe8kdiWH1qnxRwidVXnjyvz7le4Ui2VEqlXj9OEXxCoOrotCQX2ev
	 BUfwTuJG3zrH4gP2r17g9P9MFJFqhu+WKyHtUx0FRxE2U5ar82iYbGQDSUe8zaMdQx
	 lbWm/7wuw9X0iP5KcNBm+NZb+z2Gt9kaV9k+p7PFd05+G1D+kZrrp9wWY41UkU/Quz
	 sPpPAvfY2Fm+4Ff8J/oowFboMOVFqZBMBnVfkX6aqjNLXibXsEYgTaeqrUTqkqoPSt
	 8ER5TTPF+GAPg==
Date: Thu, 21 Dec 2023 14:39:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@gimberg.me
Subject: [GIT PULL] nvme updates for Linux 6.8
Message-ID: <ZYSwqV6e_iTw8jgV@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_133956_916461_E6C40A38 
X-CRM114-Status: UNSURE (   9.42  )
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

This is the first nvme pull request for the upcoming Linux 6.8 merge
window. There is a minor merge conflict when merging into Linus' master
branch, and I've provided a reference resolution here:

  https://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-6.8-merge

The following changes since commit 847c5bcdfb41704e52930783b028302f415a3209:

  block: skip QUEUE_FLAG_STATS and rq-qos for passthrough io (2023-12-01 18:29:18 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.8-2023-12-21

for you to fetch changes up to 5d51dc8db10190661232741c93a141bdfc05f5ee:

  nvme-fc: set numa_node after nvme_init_ctrl (2023-12-21 09:19:01 -0800)

----------------------------------------------------------------
nvme udpates for Linux 6.8

 - nvme fabrics spec updates (Guixin, Max)
 - nvme target udpates (Guixin, Evan)
 - nvme attribute refactoring (Daniel)
 - nvme-fc numa fix (Keith)

----------------------------------------------------------------
Daniel Wagner (6):
      nvme: move ns id info to struct nvme_ns_head
      nvme: refactor ns info helpers
      nvme: refactor ns info setup function
      nvme: rename ns attribute group
      nvme: add csi, ms and nuse to sysfs
      nvme: repack struct nvme_ns_head

Evan Burgess (1):
      nvmet: configfs: use ctrl->instance to track passthru subsystems

Guixin Liu (4):
      nvme: introduce nvme_check_ctrl_fabric_info helper
      nvme-fabrics: check ioccsz and iorcsz
      nvmet: allow identical cntlid_min and cntlid_max settings
      nvmet: remove cntlid_min and cntlid_max check in nvmet_alloc_ctrl

Keith Busch (1):
      nvme-fc: set numa_node after nvme_init_ctrl

Max Gurtovoy (1):
      nvme-fabrics: don't check discovery ioccsz/iorcsz

 drivers/nvme/host/core.c       | 224 +++++++++++++++++++++++------------------
 drivers/nvme/host/fc.c         |   6 +-
 drivers/nvme/host/ioctl.c      |   8 +-
 drivers/nvme/host/multipath.c  |   2 +-
 drivers/nvme/host/nvme.h       |  44 ++++----
 drivers/nvme/host/rdma.c       |   4 +-
 drivers/nvme/host/sysfs.c      |  99 ++++++++++++++++--
 drivers/nvme/host/zns.c        |  35 ++++---
 drivers/nvme/target/configfs.c |   4 +-
 drivers/nvme/target/core.c     |   3 -
 drivers/nvme/target/passthru.c |   4 +-
 11 files changed, 277 insertions(+), 156 deletions(-)

