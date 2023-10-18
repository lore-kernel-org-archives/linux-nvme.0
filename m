Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AF5CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6YXqOb1zY07hDvvQgwONxW9hxHgVwpE3v2zhUUmy0Zs=; b=G0NeYWYEsEZPr3uTBd6zttrvCr
	Jdt0WTjijP7uQXNLXyTq3hMKrbXTCu/s+cBG6sA17j9CVxJH2zz3wFkqDoFrVnHr+lHs+1hVsp7bI
	o8fVs0Lkh3Q6y4nPOCFUDWdmHAd/O3oeeZepDL6ALsYnLm70z+ZQOknRORhe1X7jaqNj68DdHcUcc
	kIsj9oDc9/+VdE+iYalBvOt0DaSFg8mBZF0YORacWz4m22ngFpB1B7LpV3sE/IzDsmemb13HvbjuP
	eyXhhhMi9EUcQ4Aws0d2FKA/DTZ0eoC2RcMzlaa7uE8jlZElIp8upujK8ZXQbheCWR8AG2I/YtJeH
	wKiTTYPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtDtu-00FieE-0q;
	Wed, 18 Oct 2023 21:16:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtDtq-00Fidj-1a
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 21:16:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 68F1D61943;
	Wed, 18 Oct 2023 21:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE7C433C7;
	Wed, 18 Oct 2023 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697663770;
	bh=9d06M5r+AWcDheYpXUOJ90FoOEaxhrP0eJp+r2E9Zlk=;
	h=Date:From:To:Cc:Subject:From;
	b=ue/Ey43SgUG7DJhnLV52zSRlgiMT5Z6UhUuFZk2j1RDgXUCdWWwyonIZXIFk8we9K
	 ha4LlOZS4QGb3qg1B2IkNe2+oHifXYLTjD99ii9K+Ll1VWlOH1OJausRodWUzFaPNB
	 FuUQAvlFwn07TnYNpOnhIGISWSMAQh5c33Rfr07M2bwbaBJy1xLhkz64KjzySwyCsl
	 7OaI3DCzkFeQfSiHadJ7qjAKQdbOf9s1oI3Z0LWngVng/zlQiDimksRGFy3w+v5Cnn
	 SQ+InQY5UfRBtN/s2/4/lA9i2tr4IJGPydETZMKsD1i2joSHk7WMk4oAncbLG06Mb3
	 +v9xcMe0pwe4A==
Date: Wed, 18 Oct 2023 15:16:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: [GIT PULL REDO] nvme fixes for Linux 6.6
Message-ID: <ZTBLFYbo8iuhF9kZ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_141619_387955_38A019EA 
X-CRM114-Status: UNSURE (   8.12  )
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

The previous contained a patch that needs additional consideration. This
pull request is the same as before, minus the non-root passthrough
revert.

The following changes since commit 07a1141ff170ff5d4f9c4fbb0453727ab48096e5:

  nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl (2023-10-03 18:27:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.6-2023-10-18

for you to fetch changes up to 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7:

  nvme-pci: add BOGUS_NID for Intel 0a54 device (2023-10-18 14:08:39 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.6

 - nvme-rdma queue fix (Maurizio)
 - nvmet-auth double free fix (Maurizio)
 - nvme-tcp use-after-free fix (Sagi)
 - nvme-auth data direction fix (Martin)
 - nvme passthrough metadata sanitization (Keith)
 - nvme bogus identifiers for multi-controller ssd (Keith)

----------------------------------------------------------------
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

 drivers/nvme/host/auth.c               |  4 ++--
 drivers/nvme/host/ioctl.c              | 10 +++++++---
 drivers/nvme/host/pci.c                |  3 ++-
 drivers/nvme/host/rdma.c               |  3 +++
 drivers/nvme/target/fabrics-cmd-auth.c |  9 ++++++---
 drivers/nvme/target/tcp.c              |  7 ++-----
 6 files changed, 22 insertions(+), 14 deletions(-)

