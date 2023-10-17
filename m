Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539F7CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 21:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xcU1Y/b7wQ+Q+U9Y++jxI9j1aCMx/rjAvO1txZaqVHY=; b=UXnFCCpSjqSS14mJEjKqCsbiVb
	m98OOGYkskJZG1/SrO8vcTa7qnPjJjp8ORCOGRp2Fz+Z7hn3vX0cDgy+YZIuWo8zy/FNMB3dEkigy
	NWpp9jKJ9EUn8yv8z99q7eLDetIB1Nx7RpOugqQyVcl+x+M3xmVCv4kDaLdId5Ph+IywhS8LrWfkR
	9aXUv4yyDutK8aOGxTpojWN9TTEWqgkQkYB6ew6EpwDcxITLHdNc5UPT1dkyX1Er9r14ZEHzsGF6d
	/7sZZ1++oC0fPhU2hfbkniFaOge5JIh2slBGgY6w72y+eiLhKCvQtMvTRskTByv4QLeNtvw/rbWaH
	fZSpj4pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrH0-00DGcY-04;
	Tue, 17 Oct 2023 21:06:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrGx-00DGcD-1J
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 21:06:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 690CE61626;
	Tue, 17 Oct 2023 21:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4193C433C8;
	Tue, 17 Oct 2023 21:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697576795;
	bh=Cpe0cEPzKxf/KUNb8bPHPZwgQygXO3D2qJAcPo8+FJM=;
	h=Date:From:To:Cc:Subject:From;
	b=thh3Sp1xeOOm7w1RQOUFOwGLtFPIh0O/CqIYQFc2UHL/7Vm8W2dM/lByx+O8+jlkT
	 FuQwJfCGFOiK48SfOee3Y0Cq/V2Q5Hb4mOXvq0Qbapv3f3LOBecFYkpAxCDKt4yeZ6
	 rO8hGWc8nDj/SIaXs7MSxlVGtw8y62WrqYKyeRYWUl/CBoGLWlOJMksBs02ewBOiWI
	 XRdasy6+ILS5DyQD0YY/rtatDgaam3kW0+gPzLC+JHUABGRCXrYPTHO1ciAOE8nU3J
	 9rhA2U9M6EbWsKUR/G4ncEDTUK0YtqBXoeOhlNSVY34b/9RtyYejEBKYvQy6WWY1gT
	 rPDniaG7cxhpg==
Date: Tue, 17 Oct 2023 15:06:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.6
Message-ID: <ZS73WKIh0TnckwK6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_140639_488318_C800EC09 
X-CRM114-Status: UNSURE (   7.90  )
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

The following changes since commit 07a1141ff170ff5d4f9c4fbb0453727ab48096e5:

  nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl (2023-10-03 18:27:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.6-2023-10-17

for you to fetch changes up to 1ca5b644f79b0d357c6df148c634940db685f471:

  nvme-pci: add BOGUS_NID for Intel 0a54 device (2023-10-17 13:50:28 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.6

 - nvme-rdma queue fix (Maurizio)
 - nvmet-auth double free fix (Maurizio)
 - nvme-tcp use-after-free fix (Sagi)
 - nvme-auth data direction fix (Martin)
 - nvme passthrough priviledge restriction reinstated (Kanchan)
 - nvme passthrough metadata sanitization (Keith)
 - nvme bogus identifiers for multi-controller ssd (Keith)

----------------------------------------------------------------
Kanchan Joshi (1):
      nvme: remove unprivileged passthrough support

Keith Busch (2):
      nvme: sanitize metadata bounce buffer for reads
      nvme-pci: add BOGUS_NID for Intel 0a54 device

Martin Wilck (1):
      nvme-auth: use chap->s2 to indicate bidirectional authentication

Maurizio Lombardi (2):
      nvme-rdma: do not try to stop unallocated queues
      nvmet-auth: complete a request only after freeing the dhchap pointers

Sagi Grimberg (1):
      nvmet-tcp: Fix a possible UAF in queue intialization setup

 drivers/nvme/host/auth.c               |   4 ++--
 drivers/nvme/host/ioctl.c              | 169 +++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------
 drivers/nvme/host/pci.c                |   3 ++-
 drivers/nvme/host/rdma.c               |   3 +++
 drivers/nvme/target/fabrics-cmd-auth.c |   9 ++++++---
 drivers/nvme/target/tcp.c              |   7 ++-----
 include/linux/nvme.h                   |   2 --
 7 files changed, 56 insertions(+), 141 deletions(-)

