Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8CDC4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2rSQn4Uj41wd1pP3/dYb08xBtiLOs5f7z6cD8zcpjPE=; b=4N+aksPeXMtKlMYa6R0ElEwxXk
	m3ZFvU6flr+OGXtAxFW2DEtrPUWhUNBVer7U3N21ez1v189eFQ0bMBsNCPHLxlMD0zlgccD17+e/B
	95t6k1euiTSGV3kf3Gm8qETciYCDHw5oCw9EK0qyFdOZL6rieHg8h2vTiGAE4yuOWdHNMhGKCsj5u
	8yifBm0sI/rL0eeDeaZE3c3scLRgQFYBSktOJv7FzaM0fajPUHRLP7L+lhLQjx0+tUhVYdh7rUBnj
	pKlBHdwer9babotCZcGut2wnI0RST+G7es4vWNmL5F8ZUu/BdGdQXnBeNS2atyTTe7TD173PScLqr
	4bYolT2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2W39-0000000CjBz-15HS;
	Thu, 02 May 2024 13:00:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2W36-0000000CjBa-1WLI
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 13:00:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7196D61A6A;
	Thu,  2 May 2024 13:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F91C113CC;
	Thu,  2 May 2024 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714654830;
	bh=m4nW+Fa2/vwtcopmebtT3lPaTQYx9zaAbEUrCevFmng=;
	h=Date:From:To:Cc:Subject:From;
	b=Zeg+Cd+Ek2NIqQLs5MtxwCIY38xR7vKwgoSI/+Q0o/lBX8YTLeRHZwSMClRbyiEUo
	 55YLEOmu4nIQIGF5tMnDDHzf6pW+mUtDmWWLuyyPQ9i6NSOmcuGj+7eBQVGxWnf6ij
	 N2vgtGxVnXrU25ShSPe4bqCoVqkPtUEH8JCNw7OXPGBVRAuVDHnL46JSY8bFPegWiD
	 mFl1tF6ms93vxgDdakIa0zwgZoAP6uUTel+DvCt1Uscvh6/kwUEEujKzZozc8LhfjJ
	 +OmEg65v7VfmJyBvnBIjYdO2i62M8pMOxSSb+0tsWk4JemA8o3GqlRXoFnuHeM2+RF
	 41UDLthVqOxMQ==
Date: Thu, 2 May 2024 14:00:27 +0100
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.9
Message-ID: <ZjOOa7KiIGnOjlDM@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_060032_466792_DB0895DE 
X-CRM114-Status: GOOD (  10.17  )
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

Jens:

I am on travel right now, and I've lost communication with my remote
server with my signing and push keys; therefore this does not have a
tag, much less a signed one. Since nvme is a bit behind on our pull
requests, I would like to get this out before the next rc. You can ping
me on back channel if you want to verify the legitimacy of the pull.

The following changes since commit 013ee5a6234d4c574dedd60c4887a4bcc9ecc749:

  Merge tag 'md-6.9-20240408' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.9 (2024-04-08 21:49:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git 50abcc179e0c9ca667feb223b26ea406d5c4c556

for you to fetch changes up to 50abcc179e0c9ca667feb223b26ea406d5c4c556:

  nvme-tcp: strict pdu pacing to avoid send stalls on TLS (2024-05-01 02:58:43 -0700)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvme-tcp: strict pdu pacing to avoid send stalls on TLS

Maurizio Lombardi (2):
      nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
      nvmet-auth: replace pr_debug() with pr_err() to report an error.

Nilay Shroff (2):
      nvme: find numa distance only if controller has valid numa id
      nvme: cancel pending I/O if nvme controller is in terminal state

Sagi Grimberg (2):
      nvmet-tcp: fix possible memory leak when tearing down a controller
      nvmet: fix nvme status code when namespace is disabled

Yi Zhang (1):
      nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH

 drivers/nvme/host/core.c       | 23 +----------------------
 drivers/nvme/host/multipath.c  |  3 ++-
 drivers/nvme/host/nvme.h       | 21 +++++++++++++++++++++
 drivers/nvme/host/pci.c        |  8 +++++++-
 drivers/nvme/host/tcp.c        | 10 ++++++++--
 drivers/nvme/target/auth.c     |  8 ++++----
 drivers/nvme/target/configfs.c | 13 +++++++++++++
 drivers/nvme/target/core.c     |  5 ++++-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/tcp.c      | 11 ++++-------
 10 files changed, 65 insertions(+), 38 deletions(-)


