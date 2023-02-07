Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6E4C636CD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=in7O/nJOIhRgUXf4SpB0/wLFU0yehYjKtq5D0aZFnzc=; b=kKJzEBi+e3uvaPkUokz/YkYhzE
	a7via7mbsIcmCJqKfRv3Ked4zfmAbpKpuMs/7DJXAH86jFueCGJcd92r160Y8wDds5r0RCoTcEUde
	tLiDUPuam6fEO7Ln/Nf/zTA3Gk9AYHlRWIwHsxr1mSWhoVyYxR2IQz6EO2pGWgfhp3z33PM2Jm+IP
	DTfI94UDiY6cAmLjN14eeW5FLKy50eIGimAbXXI7GSmjRUqAPi9798UE2Q10mSALKq3HgDUYUCRMo
	EMjYsTDovts4/1EBJA/XNevkmAKEO6bi4LgnLVcXL9WEWuCl44Qu2ITvMkvNJfyzHkmBrbZMWInsS
	JMSsz9UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPHGk-00AxEj-AU; Tue, 07 Feb 2023 06:15:54 +0000
Received: from [2001:4bb8:182:9f5b:f9be:8d78:f28f:18a1] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPHGf-00AxDX-DZ; Tue, 07 Feb 2023 06:15:49 +0000
Date: Tue, 7 Feb 2023 07:15:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.3
Message-ID: <Y+Hsk7eOObSafEkz@infradead.org>
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

The following changes since commit 2d97930d74b12467fd5f48d8560e48c1cf5edcb1:

  block: Remove mm.h from bvec.h (2023-01-31 09:21:50 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-07

for you to fetch changes up to baff6491448b487e920faaa117e432989cbafa89:

  nvme: mask CSE effects for security receive (2023-02-01 16:10:10 +0100)

----------------------------------------------------------------
nvme updates for Linux 6.3

 - small improvements to the logging functionality (Amit Engel)
 - authentication cleanups (Hannes Reinecke)
 - cleanup and optimize the DMA mapping cod in the PCIe driver
   (Keith Busch)
 - work around the command effects for Format NVM (Keith Busch)
 - misc cleanups (Keith Busch, Christoph Hellwig)

----------------------------------------------------------------
Amit Engel (3):
      nvme: add nvme_opcode_str function for all nvme cmd types
      nvme-tcp: add additional info for nvme_tcp_timeout log
      nvmet: for nvme admin set_features cmd, call nvmet_check_data_len_lte()

Christoph Hellwig (1):
      nvme: remove nvme_execute_passthru_rq

Hannes Reinecke (2):
      nvme-fabrics: clarify AUTHREQ result handling
      nvme-auth: don't use NVMe status codes

Keith Busch (5):
      nvme-pci: remove SGL segment descriptors
      nvme-pci: use mapped entries for sgl decision
      nvme-pci: place descriptor addresses in iod
      nvme: always initialize known command effects
      nvme: mask CSE effects for security receive

 drivers/nvme/host/auth.c        |  30 +++++-----
 drivers/nvme/host/constants.c   |  16 ++++++
 drivers/nvme/host/core.c        | 119 ++++++++++++++++++++++------------------
 drivers/nvme/host/fabrics.c     |  19 ++++++-
 drivers/nvme/host/ioctl.c       |   5 +-
 drivers/nvme/host/nvme.h        |  16 +++++-
 drivers/nvme/host/pci.c         | 100 +++++++++------------------------
 drivers/nvme/host/tcp.c         |   7 ++-
 drivers/nvme/target/admin-cmd.c |   2 +-
 drivers/nvme/target/passthru.c  |   5 +-
 10 files changed, 166 insertions(+), 153 deletions(-)

